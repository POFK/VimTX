FROM ubuntu:focal

RUN useradd -m workflow && echo "workflow:workflow" | chpasswd && adduser workflow sudo

WORKDIR /source/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
        echo "Asia/Shanghai" > /etc/timezone

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y axel wget git make cmake gcc g++ curl fontconfig vim  cmake time sudo && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN wget -q \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && chgrp -R workflow /opt/miniconda \
    && chmod 770 -R /opt/miniconda


RUN git clone https://github.com/POFK/VimTX.git

WORKDIR /source/VimTX/

USER workflow

RUN /opt/miniconda/bin/conda init

RUN cd /source/VimTX && \ 
    ./install_docker.sh

WORKDIR /home/workspace/

