#!/bin/bash
set -e

# Change uid and gid of node user so it matches ownership of current dir
if [ "$MAP_NODE_UID" != "no" ]; then
    if [ ! -d "$MAP_NODE_UID" ]; then
        MAP_NODE_UID=$PWD
    fi

    uid=$(stat -c '%u' "$MAP_NODE_UID")
    gid=$(stat -c '%g' "$MAP_NODE_UID")
    ouid=$(stat -c '%u' "/opt")
    ogid=$(stat -c '%g' "/opt")

    if [ $uid = $ouid -a $gid = $ogid ]; then
        echo "Good permission!"
    else
        echo "dev ---> UID = $uid / GID = $gid"
        export USER=dev
        usermod -u $uid dev 2> /dev/null && {
          groupmod -g $gid dev 2> /dev/null || usermod -a -G $gid dev
        }
        echo "**** Fix Permission... "
        chown -R dev /opt/ && chgrp -R dev /opt/
        chown -R dev /home/dev && chgrp -R dev /home/dev 
        echo "**** Fix Permission finished... "
    fi
fi

gosu dev bash -l -c "cd /home/dev/.vim/plugged/YouCompleteMe && git submodule update --init --recursive && python ./install.py --clang-completer"

echo "**** GOSU dev $@ ..."

exec gosu dev "$@"
