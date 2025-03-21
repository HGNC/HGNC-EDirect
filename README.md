# edirect-scripts
 
 A collection of scripts to automate tasks related to the Entrez Direct E-utilities.
 
## Usage
 To use the HGNC written script, `ncbi-fetch-seq-by-sym.sh`

```bash
docker run -v $(pwd)/input/sample.txt:/app/sample.txt ghcr.io/hgnc/hgnc-edirect:latest /app/bin/ncbi-fetch-seq-by-sym.sh /app/sample.txt horse > out.fa
```

To use EDirect itself, view the below example

```bash
docker run ghcr.io/hgnc/hgnc-edirect:latest /root/edirect/einfo -db gene
```

## Installation

```bash
docker pull ghcr.io/hgnc/hgnc-edirect:latest
```

## Scripts available

All the EDirect scripts are available from the path `/root/edirect`.

HGNC scripts are available within `/app/bin`. A list of scripts can be seen below.
 - `ncbi-fetch-seq-by-sym.sh`
   - Provide a file containing gene symbols and the species you want to search by to get a RefSeq mRNA sequence (NM or XM). See above for example.
