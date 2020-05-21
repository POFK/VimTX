#!/bin/bash
set -e

# Change uid and gid of node user so it matches ownership of current dir
if [ "$MAP_NODE_UID" != "no" ]; then
    if [ ! -d "$MAP_NODE_UID" ]; then
        MAP_NODE_UID=$PWD
    fi

    uid=$(stat -c '%u' "$MAP_NODE_UID")
    gid=$(stat -c '%g' "$MAP_NODE_UID")

    echo "dev ---> UID = $uid / GID = $gid"

    export USER=dev

    usermod -u $uid dev 2> /dev/null && {
      groupmod -g $gid dev 2> /dev/null || usermod -a -G $gid dev
    }

    echo "**** Fix Permission... "
    chgrp -R dev /opt/ && chmod 770 -R /opt
    chown -R dev /home/dev && chgrp -R dev /home/dev 
    echo "**** Fix Permission finished... "
    exec gosu dev bash -l -c "cd ~/.vim/plugged/YouCompleteMe && python install.py"
fi

echo "**** GOSU dev $@ ..."

exec gosu dev "$@"

