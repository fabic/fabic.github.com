---
#layout: default
layout: page
title: "Raspberry Pi 2/3 + Arch Linux (setup notes)"
tagline: "How ya setup that Raspberry Pi 2 with Arch Linux"
category : notes
tags : [draft, wide]
published: false
---

* <https://archlinuxarm.org/> ([forum](https://archlinuxarm.org/forum)) ([downloads](https://archlinuxarm.org/about/downloads))
* ARMv7 Raspberry Pi 2 <https://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2>
* ARMv8 Raspberry Pi 3 <https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3>
* <https://github.com/phortx/Raspberry-Pi-Setup-Guide>
* <https://elinux.org/ArchLinux_Install_Guide>

**Note :** As of August 2019 the Kodi package seems to be missing from the
ARMv8 Raspberry Pi 3 platform (pick the ARMv7 `ArchLinuxARM-rpi-2-latest.tar.gz`
image if you want Kodi on your RPi3).

Download the image :

```bash
$ wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
$ wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-3-latest.tar.gz
```

Setup the SD card file system partitions
([as per](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3#installation)),
eventually add a swap partition (or not):

```bash
$ sudo su -
$ fdisk /dev/mmcblk0
$ partprobe
$ mkfs.vfat -v -n "RPi_Boot" -i fab1cade /dev/mmcblk0p1
$ mkfs.ext4 -v -L RPi_ArchLinux -m2 -U time /dev/mmcblk0p2
```

Mount these :

```bash
$ mkdir -pv rpi-{boot,rewt}/ &&
    mount /dev/mmcblk0p1 rpi-boot/ &&
    mount /dev/mmcblk0p2 rpi-rewt/ &&
    echo OK
```

Untar the tarball and move the `boot/` stuff to the VFat boot partition :

```bash
time ( bsdtar -xpf ArchLinuxARM-rpi-2-latest.tar.gz -C rpi-rewt/ \
       && mv rpi-rewt/boot/* rpi-boot/ ) \
  && echo "-- OK --" || echo "-- WHOUPS --" \
  ; time sync
```

```bash
$ umount rpi-boot/ rpi-rewt/
```

Plug the SD card into the RPi.

### One shot

```bash
$ ( [[ -s ArchLinuxARM-rpi-2-latest.tar.gz ]] \
    || wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz ) \
  && ( mkfs.vfat -v -n "RPi2_Boot" -i fab1cade /dev/mmcblk0p1 \
       && mkfs.ext4 -v -L RPi2_ArchLinux -m2 -U time /dev/mmcblk0p2 \
       && echo "FS SETUP OK" ) \
  && ( mkdir -pv rpi-{boot,rewt}/ &&
       mount /dev/mmcblk0p1 rpi-boot/ &&
       mount /dev/mmcblk0p2 rpi-rewt/ &&
       echo "MOUNTED OK" ) \
  && ( bsdtar -xpf ArchLinuxARM-rpi-2-latest.tar.gz -C rpi-rewt/ \
       && mv rpi-rewt/boot/* rpi-boot/ ) \
  && echo "-- OK --" || echo "-- WHOUPS --" \
  && echo "SYNCING FS (patience)" \
  && time sync \
  && echo "UNMOUNTING FILE SYSTEMS" \
  && umount rpi-boot/ rpi-rewt/ \
  && echo "DONE"
```

## Setup...

* Hostname is `alarmpi`
* Default `alarm` user password: `alarm`
* Default `root` password: `root`

```bash
$ ssh alarm@alarmpi
$ su -
$ passwd root
```

```bash
$ pacman-key --init \
  && pacman-key --populate archlinuxarm \
  && pacman -Syu
$ reboot
```

```bash
$ time pacman -S git vim

$ git config --global user.email cadet.fabien@gmail.com \
  && git config --global user.name fabic

$ cd /etc/ \
  && git init .

$ cat >> .gitignore << EOF
# /etc/.gitignore (ArchLinux ARM Raspberry Pi 2 [2019-09])
/.*
/ca-certificates/extracted/
/ld.so.cache
/pacman.d/gnupg/
/ssh/moduli
/ssl/certs/
EOF

$ git add . \
  && git commit -m "INITIAL COMMIT RPi2 Arch Linux"
```

Misc. setups from the [installation guide](https://wiki.archlinux.org/index.php/Installation_guide),
([network conf.](https://wiki.archlinux.org/index.php/Network_configuration), etc) :

```bash
$ hostnamectl set-hostname rpi
$ localectl set-locale LANG=en_US.UTF-8
$ ln -sf /usr/share/zoneinfo/Indian/Reunion /etc/localtime

$ vim /etc/locale-gen

  en_US.UTF-8 UTF-8
  en_US ISO-8859-1
  es_ES.UTF-8 UTF-8
  es_ES ISO-8859-1
  es_ES@euro ISO-8859-15
  fr_FR.UTF-8 UTF-8
  fr_FR ISO-8859-1
  fr_FR@euro ISO-8859-15

$ time locale-gen

$ cat >> /etc/hosts <<EOF
127.0.0.1        localhost
::1              localhost
127.0.1.1        rpi.localdomain  rpi
EOF
```

Install misc. packages :

```bash
time pacman -S sudo tmux udisks2 smartmontools python python-pip \
  docker docker-compose retroarch retroarch-assets-xmb samba nfs-utils \
  lightdm lightdm-gtk-greeter ffmpeg smplayer
```

Setup the optional swap partition :

```bash
$ mkswap -L RPi2_Swap_Part -U 20190916-1200-0974-beef-b00b50000000 /dev/mmcblk0p3
$ swapon /dev/mmcblk0p3
$ cat >> /etc/fstab <<EOF
UUID=20190916-1200-0974-beef-b00b50000000 none swap defaults 0 0
$ reboot
EOF
```

Uncomment the line `%wheel ALL=(ALL) NOPASSWD: ALL` :

```bash
$ visudo
```

Create local user account :

```bash
$ useradd -m -G wheel,storage,games,network,video,audio,input,power,users,kvm,uucp -s/bin/bash fabi
$ passwd fabi
```

```bash
$ su - fabi
$ ssh-keygen -t rsa -b 4096
$ ssh-copy-id wall
```

NFS
SAMBA
Avahi/sysresolved ?

```bash
$ mkdir /media
```


#### Install the NAS Scripts

```bash
$ git clone git@github.com:maty974/nas-scripts.git
$ pip3 install --user -r requirements.txt
$ ./ananas
```

__EOF__
