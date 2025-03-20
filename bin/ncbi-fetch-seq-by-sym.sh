#!/usr/bin/bash

# Check for required EDirect tools
for cmd in esearch elink efilter esummary xtract efetch; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' not found." >&2
        echo "----------------------------------------" >&2
        echo "Install NCBI EDirect: Follow the instructions at"
        echo "https://www.ncbi.nlm.nih.gov/books/NBK179288/"
        exit 1
    fi
done

# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <species>" >&2
    exit 1
fi

input_file="$1"
organism="$2"

if [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' not found or not readable." >&2
    exit 1
fi

# Function to retrieve candidate Accessions
get_candidates() {
    esearch -db gene -query "${line}[Gene Symbol] AND ${organism}[Organism]" <<< "" |
    elink -target nuccore |
    efilter -molecule mrna -source refseq |
    esummary |
    xtract -pattern DocumentSummary -element AccessionVersion,Slen |
    sort -k2,2nr  # Sort by sequence length descending
}

# Function to fetch sequence
get_seq() {
    candidates="$1"
    accType="$2"

    # Escape regex special characters in accession type
    accType_escaped=$(printf '%s\n' "$accType" | sed 's/[][\.*^$]/\\&/g')

    # Find the first candidate matching accession type
    match=$(printf '%s\n' "$candidates" | awk -F'\t' -v acc="$accType_escaped" \
        '$1 ~ "^" acc "_" {print $1; exit}')

    if [ -n "$match" ]; then
        # Fetch sequence and annotate header with gene symbol
        efetch -db nuccore -id "$match" -format fasta |
        sed "s|^>|>${line}_|"
    fi
}

# Process each gene symbol
while IFS= read -r line || [ -n "$line" ]; do
    # Clean input and skip empty lines
    line=$(echo "$line" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
    if [ -z "$line" ]; then
        echo "Skipping empty line." >&2
        continue
    fi

    echo "Processing gene: $line" >&2

    # Get candidate sequences
    candidates=$(get_candidates)
    if [ -z "$candidates" ]; then
        echo "  No RefSeq mRNAs found for $line" >&2
        continue
    fi

    # Try NM then XM accessions
    seq=$(get_seq "$candidates" "NM")
    if [ -z "$seq" ]; then
        seq=$(get_seq "$candidates" "XM")
    fi

    if [ -n "$seq" ]; then
        echo "$seq"
    else
        echo "  No NM/XM RefSeq sequence found for $line" >&2
    fi
    echo "----------------------------------------" >&2
done < "$input_file"
