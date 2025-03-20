FROM ubuntu:jammy

RUN apt-get update && apt-get install -y curl
RUN apt-get install -y libtime-hires-perl
RUN sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
# RUN echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.bash_profile
# RUN echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.bashrc
# RUN echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.profile
ENV PATH="/root/edirect:${PATH}"


RUN mkdir /app
WORKDIR /app

COPY bin/ /app/bin/
