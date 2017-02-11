---
layout: post
title: "Mac OS X : how to burn ISO disk image ?"
#tagline: "Supporting tagline"
category : notes
tags : [howto, Mac OS X, util]
---


## ext4 file system with options

    mke2fs -v -j -t ext4 -m3 \
      -O dir_index,extents,filetype \
      -U '09022016-0924-1909-2411-2709cade0da3' \
      -L "ArchNux_a3" -M "/"  \
        /dev/sda3


## Swap partition

    mkswap -c -L ArchSwap16GB /dev/sda2

    0 bad pages
    mkswap: /dev/sda2: warning: wiping old ext4 signature.
    Setting up swapspace version 1, size = 16 GiB (17179865088 bytes)
    LABEL=ArchSwap16GB, UUID=b09ea959-d8f7-400c-a829-91445640746c

    real  2m41.813s
    user  0m0.587s
    sys 0m34.467s

### `/etc/fstab`

    cat >> /etc/fstab <<EOF
    UUID=b09ea959-d8f7-400c-a829-91445640746c none swap defaults 0 0
    EOF

_**End Of Transmission**_

