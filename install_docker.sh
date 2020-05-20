#!/bin/bash

TAR=/opt/vimtx

echo "#add by VimTX" >> ~/.bashrc
echo "export PATH=$TAR/local/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$TAR/local/lib:$CONDA_PREFIX/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc

if which axel >/dev/null; then
    Downloader=`which axel`" -n 4"
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
    tar -zxf /tmp/ncurses-6.0.tar.gz -C /tmp/
    cd /tmp/ncurses-6.0
    make uninstall && make clean && make distclean
    ./configure --prefix=$TAR/local CPPFLAGS="-P"
    make -j4
    make install
    cd -
}


function install_prepare_software()
{
    compile_ncurses
}

function compile_vim_on_linux()
{
    echo 'pass'
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
    vim -c PlugInstall -c q -c q
}

# linux编译ycm插件
function compile_ycm_on_linux()
{
    cd ~/.vim/plugged/YouCompleteMe
    git submodule update --init --recursive
    python ./install.py --clang-completer
}

function print_logo()
{
    color="$(tput setaf 6)"
    normal="$(tput sgr0)"
    printf "${color}"
    echo "VimTX is now installed!"
    echo "Please add ${TAR}/local in ~/.bashrc!"
    printf "${normal}"
}


function settingforUltisnips()
{
    cp -r ${PWD}/my-snippets ~/.vim/plugged/
}


function begin_install_VimTX()
{
    copy_files
    install_fonts_on_linux
    install_vim_plugin
    compile_ycm_on_linux
    print_logo
}

function after_install_VimTX()
{
    echo 'setting... '
    rm -rf /tmp/*
    echo "colorscheme molokai" >> ${HOME}/.vimrc
    settingforUltisnips
}




function install_on_linux()
{
    type=`get_linux_platform_type`
    echo "linux platform type: "${type}
    install_prepare_software
    compile_vim_on_linux
    begin_install_VimTX
    after_install_VimTX
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

