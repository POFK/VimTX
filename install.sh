#!/bin/bash
# no "sudo" version

echo "#add by VimTX" >> ~/.bashrc
echo "export PATH=\$HOME/local/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$HOME/local/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc

if which axel >/dev/null; then
    Downloader=`which axel`" -n 10"
    DownloadOPT="-o"
else
    Downloader=`which wget`
    DownloadOPT="-O"
fi

function get_platform_type()
{
    echo $(uname)
}

function get_linux_platform_type()
{
    if which apt-get > /dev/null ; then
        echo "ubuntu" # debian ubuntu系列
    elif which yum > /dev/null ; then
        echo "centos" # centos redhat系列
    elif which pacman > /dev/null; then
        echo "archlinux" # archlinux系列
    else
        echo "invaild"
    fi
}

function compile_ncurses()
{
    ${Downloader} http://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz ${DownloadOPT} /tmp/
    tar -zxvf /tmp/ncurses-6.0.tar.gz -C /tmp/
    cd /tmp/ncurses-6.0
    make uninstall && make clean && make distclean
    ./configure --prefix=$HOME/local CPPFLAGS="-P"
    make
    make install
    cd -
}


function install_prepare_software()
{
    compile_ncurses
    pip install  yapf --user
    #   npm install -g remark-cli
}

function compile_vim_on_linux()
{
    git clone https://github.com/vim/vim.git ~/vim

    cd ~/vim
    make uninstall && make clean && make distclean
    LDFLAGS=-L$HOME/local/lib ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-python3interp \
        --with-python3-config-dir=$CONDA_PREFIX/lib/python3.7/config-3.7m-x86_64-linux-gnu \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=$HOME/local
            make
            make install
            cd -
            rm -rf ~/vim
        }

# 拷贝文件
function copy_files()
{
    rm -rf ~/.vimrc
    ln -s ${PWD}/vimrc ~/.vimrc

    rm -rf ~/.vimrc.local
    cp ${PWD}/vimrc.local ~/.vimrc.local

    rm -rf ~/.ycm_extra_conf.py
    ln -s ${PWD}/ycm_extra_conf.py ~/.ycm_extra_conf.py
}

function install_fonts_on_linux()
{
    mkdir ~/.fonts
    rm -rf ~/.fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/.fonts

    fc-cache -vf ~/.fonts
}

function install_vim_plugin()
{
    vim -c "PlugInstall" -c "q" -c "q"
}

# linux编译ycm插件
function compile_ycm_on_linux()
{
    cd ~/.vim/plugged/YouCompleteMe
    python ./install.py --clang-completer
}

function print_logo()
{
    color="$(tput setaf 6)"
    normal="$(tput sgr0)"
    printf "${color}"
    echo "VimTX is now installed!"
    echo "Please add ${HOME}/local in ~/.bashrc!"
    printf "${normal}"
}


function settingforUltisnips()
{
    ln -s ${PWD}/my-snippets ~/.vim/plugged
}


function begin_install_VimTX()
{
    copy_files
    install_fonts_on_linux
    install_vim_plugin
    compile_ycm_on_linux
    settingforUltisnips
    print_logo
}


function install_on_linux()
{
    type=`get_linux_platform_type`
    echo "linux platform type: "${type}
    install_prepare_software
    compile_vim_on_linux
    begin_install_VimTX
}


function main()
{
    type=`get_platform_type`
    echo "platform type: "${type}

    if [ ${type} == "Linux" ]; then
        install_on_linux
    else
        echo "not support platform type: "${type}
    fi
}

main

