---
layout: note
title: "Raspberry Pi 2: Install that OSMC Linux distribution"
tagline: ""
published: true
category : notes
tags : [note]
---

Plug in tha microSD card.

Ensure your desktop env. has not mounted any previous FS there may be on you

```bash
$ mount
```

Download the latest appropriate OSMC image from [osmc.tv](https://osmc.tv/download) :

```bash
$ wget -S http://download.osmc.tv/installers/diskimages/OSMC_TGT_rbp2_20190623.img.gz
```

Find out what `/dev/...` block device is that microSD card :

```bash
$ sudo fdisk -l
```

Transfer the uncompressed OSMC disk image using **dd** :

```bash
$ time ( gunzip -dc OSMC_TGT_rbp2_20190623.img.gz | \
         sudo dd of=/dev/mmcblk0 bs=1M oflag=direct iflag=fullblock status=progress )
```

Trigger kernel re-read the partition tables (so that your desktop will present
the correct mount devices) :

```bash
$ sudo partprobe
```

Check that the device does have that 243 MB FAT partition :

```bash
$ sudo fdisk -l /dev/mmcblk0
```

Output :

```
Device         Boot Start    End Sectors  Size Id Type
/dev/mmcblk0p1       2048 499711  497664  243M  c W95 FAT32 (LBA)
```

**EOF**

