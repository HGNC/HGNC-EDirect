from ubuntu:latest

RUN sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"

RUN mkdir /app
WORKDIR /app

COPY bin/ /app/bin/