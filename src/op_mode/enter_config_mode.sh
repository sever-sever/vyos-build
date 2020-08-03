#!/bin/sh

if [ `id -u` == 0 ]; then
    echo "You are attempting to enter configuration mode as root."
    echo "It may have unintended consequences and render your system"
    echo "unusable until restart."
    echo "Please do it as an administrator level VyOS user instead."
else
    if grep -q -e '^overlay.*/filesystem.squashfs' /proc/mounts; then
        echo "WARNING: You are currently configuring a live-ISO environment, changes will not persist until installed"
    fi
    history -w
    export _OFR_CONFIGURE=ok
    newgrp vyattacfg
    unset _OFR_CONFIGURE
    _vyatta_op_do_key_bindings
    history -r
fi
