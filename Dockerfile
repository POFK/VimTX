#docker build --network=host --build-arg GFW=true -t ycmd --target builder .
FROM continuumio/miniconda3:4.8.2 as builder

ARG GFW=false

ADD . /opt/vimtx
ENV TAR="/opt/vimtx"

RUN if [ "$GFW" = false  ] ; then echo "No GFW!"; \
        else sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
        && mkdir $HOME/.pip \
        && echo "[global] \nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> $HOME/.pip/pip.conf; fi

RUN apt-get update && \
    apt-get install -y \
      curl \
      git \
      cmake \
      golang \
      libclang-dev \
      nodejs \
      node-typescript \
      npm \
      vim-nox

RUN ln -s ${TAR}/vim $HOME/.vim \
    && perl -p -i -e 's/colorscheme\ molokai/\"colorscheme\ molokai/g' $TAR/vimrc \
    && vim -u $TAR/vimrc -c PlugInstall -c q -c q \
    && cd $HOME/.vim/plugged/YouCompleteMe \
    && git submodule update --init --recursive
#   && git submodule update --init --recursive \
#    && python ./install.py \
#            --clangd-completer \
#            --go-completer \
#            --ts-completer
#
#
#FROM ubuntu:focal
#
#COPY --from=builder /opt/conda  /opt/conda
#COPY --from=builder /opt/vimtx  /opt/vimtx
#
#ENV TAR="/opt/vimtx" \
#        UNAME="dev" \
#        SHELL="/bin/bash" \
#        HOME="/home/dev"
#
#RUN if [ "$GFW" = false  ] ; then echo "No GFW!"; \
#        else sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
#        && mkdir $HOME/.pip \
#        && echo "[global] \nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> $HOME/.pip/pip.conf; fi
#
## Add local user 'dev'
#RUN groupadd -r $UNAME --gid=1000 && \ 
#    useradd -m -s /bin/bash -r -g $UNAME --uid=1000 $UNAME
#
## Grant him sudo privileges
#RUN echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
#    chmod 0440 /etc/sudoers.d/dev
# 
#WORKDIR $HOME
#
#RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
#    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
#    && echo "conda activate base" >> ~/.bashrc
#
#
#RUN apt-get update && \
#    apt-get install -y \
#      curl \
#      git \
#      ctags \
#      libncurses5-dev \
#      libncursesw5-dev \
#      time \
#      cmake \
#      golang \
#      libclang-dev \
#      nodejs \
#      node-typescript \
#      fontconfig \
#      npm \
#      vim \
#    && apt-get clean \
#    && conda install pep8 yapf flake8 \
#    && ln -s ${TAR}/vimrc $HOME/.vimrc \
#    && ln -s ${TAR}/vimrc.local $HOME/.vimrc.local \
#    && ln -s ${TAR}/ycm_extra_conf.py $HOME/.ycm_extra_conf.py \
#    && ln -s ${TAR}/vim $HOME/.vim \
#    && ln -s ${TAR}/fonts $HOME/.fonts \
#    && fc-cache -vf $HOME/.fonts \
#    && cp -r ${TAR}/my-snippets $HOME/.vim/plugged/ \
#    && cd $HOME/.vim/plugged/YouCompleteMe \
#    && python ./install.py \
#            --clangd-completer \
#            --go-completer \
#            --ts-completer \
#    && chmod -R o+rwx /opt/vimtx \
#    && rm -rf /opt/conda \
#    && rm -rf /tmp/*
#
#WORKDIR /home/workspace/
#CMD ["/bin/bash"]
