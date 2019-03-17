---
#layout: default
layout: page
title: "Raspberry Pi 2 + Arch Linux (setup notes)"
tagline: "How ya setup that Raspberry Pi 2 with Arch Linux"
category : notes
tags : [draft, wide]
published: false
---

* <https://archlinuxarm.org/> ([forum](https://archlinuxarm.org/forum)) ([downloads](https://archlinuxarm.org/about/downloads))
* <https://github.com/phortx/Raspberry-Pi-Setup-Guide>
* <https://elinux.org/ArchLinux_Install_Guide>


```bash
fdisk /dev/mmcblk0
mkfs.vfat -v -n "RPi2ArchVFat" -i fab1cade /dev/mmcblk0p1
mkfs.ext4 -v -L RPiArchExt4 -m2 -U time /dev/mmcblk0p2
```

```bash
mkdir -pv /mnt/rpi-{boot,rewt}/ &&
mount /dev/mmcblk0p1 /mnt/rpi-boot/ &&
  mount /dev/mmcblk0p2 /mnt/rpi-rewt/ &&
    echo OK
```

```bash
tar -xpf ~fabi/Downloads/ArchLinuxARM-rpi-2-latest.tar.gz -C /mnt/rpi-rewt/  \
  && ls -lh /mnt/rpi-rewt/
```

```bash
# cp -aiv /mnt/rpi-rewt/boot/* /mnt/rpi-boot/
tar -xpvf ~fabi/Downloads/ArchLinuxARM-rpi-2-latest.tar.gz -C /mnt/rpi-boot/ --strip-components=2 ./boot/ &&
  ls /mnt/rpi-boot/
```

```bash
umount -f /mnt/rpi-boot /mnt/rpi-rewt/
sync
```

__EOF__
