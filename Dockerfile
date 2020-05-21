###########
# BUILDER #
###########

FROM ubuntu:focal as builder

WORKDIR /source/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

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
#    && echo "199.232.4.133 raw.githubusercontent.com               " >> /etc/hosts \
#    && echo "151.101.56.133	repository-images.githubusercontent.com " >> /etc/hosts

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y axel wget git make gcc g++ curl fontconfig vim  cmake time && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# install python env

RUN wget -q \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda

# install VimTX
ADD . /opt/vimtx
WORKDIR /opt/vimtx/
RUN /opt/miniconda/bin/conda init
RUN TAR=/opt/vimtx \
    && echo "export PATH=$TAR/local/bin:\$PATH" >> ~/.bashrc \
    && echo "export LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc \ 
    && ./install_docker.sh $TAR

#########
# FINAL #
#########

FROM ubuntu:focal

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

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
#    && echo "199.232.4.133 raw.githubusercontent.com               " >> /etc/hosts \
#    && echo "151.101.56.133	repository-images.githubusercontent.com " >> /etc/hosts

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y axel wget git make cmake gcc g++ curl fontconfig vim time sudo gosu && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN echo "Set disable_coredump false" >> /etc/sudo.conf


COPY --from=builder /opt /opt

# Add local user 'dev'
RUN groupadd -r dev --gid=9001 && \ 
    useradd -m -s /bin/bash -r -g dev --uid=9001 dev

# Grant him sudo privileges
RUN echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev
    
USER dev
ENV HOME /home/dev
WORKDIR $HOME
RUN TAR=/opt/vimtx \
    && /opt/miniconda/bin/conda init \ 
    && echo "export PATH=$TAR/local/bin:\$PATH" >> ~/.bashrc \ 
    && echo "export LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc \
    && ln -s ${TAR}/vimrc ~/.vimrc \
    && ln -s ${TAR}/ycm_extra_conf.py ~/.ycm_extra_conf.py \
    && ln -s ${TAR}/vim ~/.vim \
    && ln -s ${TAR}/fonts ~/.fonts \
    && fc-cache -vf ~/.fonts


USER root
WORKDIR /home/workspace/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]


