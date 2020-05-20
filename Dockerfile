FROM ubuntu:focal

RUN useradd -m workflow && echo "workflow:workflow" | chpasswd && adduser workflow sudo

WORKDIR /source/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
        echo "Asia/Shanghai" > /etc/timezone

#RUN echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
#    && echo "192.30.255.112	gist.github.com" >> /etc/hosts \
#    && echo "192.30.255.112	github.com" >> /etc/hosts \
#    && echo "151.101.56.133	gist.githubusercontent.com              " >> /etc/hosts \
#    && echo "151.101.56.133	raw.githubusercontent.com               " >> /etc/hosts \
#    && echo "151.101.56.133	repository-images.githubusercontent.com " >> /etc/hosts

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

ADD . /source/VimTX

WORKDIR /source/VimTX/

RUN mkdir /opt/vimtx \
    && chgrp workflow /opt/vimtx \
    && chown workflow /opt/vimtx

USER workflow

RUN /opt/miniconda/bin/conda init

RUN TAR=/opt/vimtx \
    && echo "#add by VimTX" >> ~/.bashrc \
    && echo "export PATH=$TAR/local/bin:\$PATH" >> ~/.bashrc \
    && echo "export LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc

RUN ./install_docker.sh

WORKDIR /home/workspace/

