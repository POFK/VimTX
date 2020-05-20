FROM ubuntu:focal

RUN addgroup --gid 1000 workflow \
  && adduser --disabled-password --home /home/workspace --system -q --uid 1000 --ingroup workflow workflow

WORKDIR /sourcespace/

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
    apt-get install -y axel wget git make gcc curl fontconfig vim && \
    rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && chgrp -R workflow /opt/miniconda \
    && chmod 770 -R /opt/miniconda


#RUN git clone https://github.com/POFK/VimTX.git

ADD . .
#ADD entrypoint.sh /sourcespace

#USER workflow

RUN /opt/miniconda/bin/conda init

RUN TAR=/opt/vimtx \
    && echo "export PATH=$TAR/local/bin:\$PATH" >> ~/.bashrc \
    && echo "export LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc

RUN ./install_docker.sh

WORKDIR /home/workspace/




#ENTRYPOINT ["./install_docker.sh"]
#ENTRYPOINT ["./entrypoint.sh"]
