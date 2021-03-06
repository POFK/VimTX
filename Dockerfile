FROM continuumio/miniconda3:4.8.2 as builder

FROM ubuntu:focal
COPY --from=builder /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

ADD . /opt/vimtx

ENV TAR="/opt/vimtx" \
        UNAME="dev" \
        SHELL="/bin/bash" \
        HOME="/home/dev"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apt-get update \
    && apt-get install -y sudo git \
    && apt-get clean
 

# Add local user 'dev'
RUN groupadd -r $UNAME --gid=1000 && \ 
    useradd -m -s /bin/bash -r -g $UNAME --uid=1000 $UNAME

ENV GOPROXY=https://goproxy.cn

# Grant him sudo privileges
RUN echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev

ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on

RUN apt-get update \
    && apt-get install -y \
        wget \
        curl \
        cmake \
        vim \
        time \
        libncurses5-dev \
        libncursesw5-dev \
        ctags \
        sudo \
        tmux \
        zathura \
        fontconfig \
        nodejs \
        npm \
        golang \
        latexmk \
        xdotool \
        astyle \
        python3 \
        python3-dev \
        python3-pip \
    && npm install -g js-beautify \
    && npm install -g remark-cli \
    && npm install -g instant-markdown-d \
    && go get -u mvdan.cc/sh/cmd/shfmt \
    && ln -s ${TAR}/vim $HOME/.vim \
    && ln -s ${TAR}/fonts $HOME/.fonts \
    && fc-cache -vf $HOME/.fonts \
    && vim -u ${TAR}/vimrc -c PlugInstall -c q -c q \
    && ln -s ${TAR}/my-snippets $HOME/.vim/plugged/ \
    && cd $HOME/.vim/plugged/YouCompleteMe \
    && pip3 install compiledb \
    && python3 ./install.py \   
                --clangd-completer \
                --clang-completer \
                --go-completer \
                --ts-completer \
    && chown -R dev $HOME && chgrp -R dev $HOME \
    && apt-get remove -y python3 python3-dev python3-pip\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /tmp/* \
    && echo ". /etc/profile.d/conda.sh" >> $HOME/.bashrc \
    && echo "conda activate base" >> $HOME/.bashrc \
    && echo "Set disable_coredump false" >> /etc/sudo.conf

ENV VIMDIR=/opt/vimtx

WORKDIR /home/workspace/
USER dev
