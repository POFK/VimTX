FROM ubuntu:focal

ADD . /opt/vimtx
ADD entrypoint.sh /entrypoint.sh

ENV TAR="/opt/vimtx" \
        UNAME="dev" \
        SHELL="/bin/bash" \
        HOME="/home/dev" \
        PATH=$TAR/local/bin:$PATH \
        LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
# change apt source
    && sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
# install dependencies
    && apt-get install -y \
        axel \
        wget \
        git \
        make \
        gcc \
        g++ \
        curl \
        fontconfig \
        cmake \
        time \
        vim \
        libncurses5-dev \
        libncursesw5-dev \
        ctags \
        sudo \
        gosu \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
# install conda
    && axel -n 4 -q -o /tmp/Miniconda3-latest-Linux-x86_64.sh \
        https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda \
    && /opt/miniconda/bin/conda init \
    && rm -rf /tmp/*


# Add local user 'dev'
RUN groupadd -r dev --gid=1001 && \ 
    useradd -m -s /bin/bash -r -g dev --uid=1001 dev

# Grant him sudo privileges
RUN echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev
 
WORKDIR $HOME

RUN ln -s ${TAR}/vimrc $HOME/.vimrc \
    && pip install pep8 yapf flake8 \
    && ln -s ${TAR}/vimrc.local $HOME/.vimrc.local \
    && ln -s ${TAR}/ycm_extra_conf.py $HOME/.ycm_extra_conf.py \
    && ln -s ${TAR}/vim $HOME/.vim \
    && ln -s ${TAR}/fonts $HOME/.fonts \
    && fc-cache -vf $HOME/.fonts \
    && cp -r ${TAR}/my-snippets $HOME/.vim/plugged/ \
    && perl -p -i -e 's/colorscheme\ molokai/\"colorscheme\ molokai/g' $HOME/.vimrc \
    && vim -c PlugInstall -c q -c q \
    && perl -p -i -e 's/\"colorscheme\ molokai/colorscheme\ molokai/g' $HOME/.vimrc \
    && cd /home/dev/.vim/plugged/YouCompleteMe \
    && git submodule update --init --recursive \
    && python ./install.py --clang-completer \
    && chown -R dev $HOME \
    && chgrp -R dev $HOME \
    && chown -R dev /opt/ && chgrp -R dev /opt/

WORKDIR /home/workspace/
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
CMD ["/bin/bash"]
