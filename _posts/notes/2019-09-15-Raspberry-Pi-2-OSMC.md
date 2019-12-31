---
layout: note
title: "RPi2 + OSMC"
tagline: ""
published: true
category : notes
tags : [note, RPi]
---

Installing [OSMC &ndash; Open Source Media Center][OSMC] on that Raspberry Pi 2.

```bash
$ wget http://download.osmc.tv/installers/diskimages/OSMC_TGT_rbp2_20190808.img.gz
```

```bash
$ time ( gunzip --stdout OSMC_TGT_rbp2_20190808.img.gz \
         | sudo dd of=/dev/mmcblk0 bs=1M oflag=direct iflag=fullblock status=progress )
```

```bash
sudo partprobe
sudo fdisk -l /dev/mmcblk0
```

[OSMC]: https://osmc.tv/
