# edirect-scripts
 
 A collection of scripts to automate tasks related to the Entrez Direct E-utilities.
 
## Usage
 
```bash
docker run -v $(pwd)/input/sample.txt:/app/sample.txt hgnc-edirect /app/bin/ncbi-fetch-seq-by-sym.sh /app/sample.txt horse > out.fa
```

## Installation
```bash
docker build --no-cache -t hgnc-edirect .
```

## Scripts available

All the EDirect scripts are available from the path `/root/edirect`.

HGNC scripts are available within `/app/bin`. A list of scripts can be seen below.
 - ncbi-fetch-seq-by-sym.sh - provide a file containing gene symbols and the species you want to search by to get a RefSeq mRNA sequence (NM or XM).