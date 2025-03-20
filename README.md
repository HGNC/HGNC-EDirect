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