#docker run -it -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --net=host --ipc=host -v $HOME/workspace:/home/workspace --name vimtx txmao/vimtx:latest
#FROM alpine:3.12
FROM python:3.8-alpine

LABEL maintainer "TX Mao<mtianxiang@gmail.com>"

ENV HOME /home/dev
ADD . /opt/vimtx
WORKDIR $HOME

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

#RUN echo "140.82.113.4 gist.github.com" >> /etc/hosts \
#    && echo "140.82.112.4 github.com" >> /etc/hosts \
#    && echo "151.101.0.133	gist.githubusercontent.com              " >> /etc/hosts \
#    && echo "199.232.36.133 raw.githubusercontent.com               " >> /etc/hosts \
#    && echo "151.101.0.133	repository-images.githubusercontent.com " >> /etc/hosts \
#    && mkdir -p $HOME/.vim/autoload && cp /opt/vimtx/plug.vim $HOME/.vim/autoload/ \
#    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk --no-cache add &&\
        axel wget git make gcc g++ curl fontconfig &&\
        vim cmake time sudo bash ncurses perl gosu &&\
        shadow bash-completion &&\
    pip install pep8 yapf

      
RUN addgroup -S -g 1000 dev && adduser --shell /bin/bash -S dev -u 1000 -G dev

# Grant him sudo privileges
RUN echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev
    
RUN TAR=/opt/vimtx \
    && fc-cache -vf $HOME/.fonts \
    && ln -s ${TAR}/vimrc $HOME/.vimrc \
    && ln -s ${TAR}/vimrc.local $HOME/.vimrc.local \
    && ln -s ${TAR}/ycm_extra_conf.py $HOME/.ycm_extra_conf.py \
    && ln -s ${TAR}/vim $HOME/.vim \
    && ln -s ${TAR}/fonts $HOME/.fonts \
    && cp -r ${TAR}/my-snippets $HOME/.vim/plugged/ \
    && perl -p -i -e 's/colorscheme\ molokai/\"colorscheme\ molokai/g' $HOME/.vimrc \
    && vim -c PlugInstall -c q -c q \
    && perl -p -i -e 's/\"colorscheme\ molokai/colorscheme\ molokai/g' $HOME/.vimrc \
    && cd $HOME/.vim/plugged/YouCompleteMe \
    && git submodule update --init --recursive \
    && python ./install.py --clang-completer \
    && chown -R dev $HOME \
    && chgrp -R dev $HOME \
    && chown -R dev /opt/ && chgrp -R dev /opt/ 

WORKDIR /home/workspace/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
CMD ["/bin/bash"]


