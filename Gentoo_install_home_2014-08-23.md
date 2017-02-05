---
layout: page
title: "Gentoo installation notes (home)"
description: "Some notes about /me re-re-installing my Gentoo boxes from scratch."
---


**fabic.2014-08-23**

Re-installing a new Gentoo system, as my current one won't upgrade after about a
year without doing so.

* [Gentoo amd64 handbook](http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1)
* [Wiki : Systemd wiki page](https://wiki.gentoo.org/wiki/Systemd)
* [Wiki : Systemd/Installing_Gnome3_from_scratch](https://wiki.gentoo.org/wiki/Systemd/Installing_Gnome3_from_scratch)
* [Wiki : LXDE desktop](http://wiki.gentoo.org/wiki/LXDE)
* [Wiki : Xfce desktop](https://wiki.gentoo.org/wiki/Xfce/HOWTO)

## Partitions

* /dev/sda2 : root filesystem ;
* /dev/sda3 : swap 9 GB.

### mke2fs

* See <http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1#filesystems> ;
* `man mke2fs` ;

#### Output:

    winterfell ~ # mke2fs -v -j -t ext4 -m2 \
        -O dir_index,extents,filetype \
        -U '23082014-07fe-1909-2411-2709cade0da2' -L "Gentoo_sda2" -M /mnt/g /dev/sda2

    mke2fs 1.42.7 (21-Jan-2013)
    fs_types for mke2fs.conf resolution: 'ext4'
    Filesystem label=Gentoo_sda2
    OS type: Linux
    Block size=4096 (log=2)
    Fragment size=4096 (log=2)
    Stride=0 blocks, Stripe width=0 blocks
    4268032 inodes, 17040128 blocks
    340802 blocks (2.00%) reserved for the super user
    First data block=0
    Maximum filesystem blocks=4294967296
    521 block groups
    32768 blocks per group, 32768 fragments per group
    8192 inodes per group
    Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (32768 blocks): done
    Writing superblocks and filesystem accounting information: done

### Swap

    winterfell ~ # mkswap -L "Gento_swap_sda3" \
        -U '9fd5155c-df3a-415e-91ba-0509198100a3' \
        /dev/sda3

    mkswap -L "Gento_swap_sda3" -U '23082014-07fe-1909-2411-2709cade0da3' /dev/sda3
    mkswap: /dev/sda3: warning: wiping old swap signature.
    Setting up swapspace version 1, size = 9437908 KiB
    LABEL=Gento_swap_sda3, UUID=23082014-07fe-1909-2411-2709cade0da3

#### `swapon`

    winterfell ~ # swapon -v /dev/sda3
    swapon /dev/sda3
    swapon: /dev/sda3: found swap signature: version 1, page-size 4, same byte order
    swapon: /dev/sda3: pagesize=4096, swapsize=9664421888, devsize=9664421888

### `/etc/fstab`

_**About the swap entry:** This is not needed, probably even problematic in case
 I dual boot both of my Gentoos, with hibernation (`resume=/dev/sdaX` at kernel boot)._

    winterfell ~ # mkdir /mnt/g

    winterfell ~ # cat >> /etc/fstab <<EOF

    # /dev/sda2 : NEW GENTOO SYS. 2014-08-23
    UUID=23082014-07fe-1909-2411-2709cade0da2 /mnt/g    ext4    noatime         0 0
    UUID=23082014-07fe-1909-2411-2709cade0da3 none      swap    sw              0 0
    EOF

    winterfell ~ # mount -a

## Stage3 tarball

* Book @ <http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1#book_part1_chap5>
* Got it from <http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/>
* Checkint integrity :

    `openssl dgst -r -sha512 stage3-amd64-20140821.tar.bz2`

    `sha512sum stage3-amd64-20140821.tar.bz2`

* Unpacked it : **`tar -xjpf ~/stage3-amd64-20140821.tar.bz2 -C /mnt/g`**
* Moved stage3 files there: `mv ~/stage3-amd64-20140821.tar.bz2* /mnt/g/root/`

## Chroot-ing

### Preps

    winterfell ~ # cp -Liv /etc/resolv.conf /mnt/g/etc/
    ‘/etc/resolv.conf’ -> ‘/mnt/g/etc/resolv.conf’

    winterfell ~ # mount -t proc proc /mnt/g/proc || echo "Oups /proc ; ret. status : $?"
    winterfell ~ # mount --rbind /sys /mnt/g/sys || echo "Oups /sys ; ret. status : $?"
    winterfell ~ # mount --rbind /dev /mnt/g/dev || echo "Oups /dev ; ret. status : $?"

### `chroot ...`

    winterfell ~ # chroot /mnt/g /bin/bash

    winterfell / # source /etc/profile
    winterfell / # export PS1="(chroot) $PS1"
    (chroot) winterfell / #

    (chroot) winterfell / # cd
    (chroot) winterfell ~ #

    (chroot) winterfell ~ # passwd
    New password:
    Retype new password:


## `emerge --sync`

    (chroot) winterfell ~ # emerge-webrsync
    !!! Section 'gentoo' in repos.conf has location attribute set to nonexistent directory: '/usr/portage'
    !!! Section 'x-portage' in repos.conf has location attribute set to nonexistent directory: '/usr/portage'
    !!! Invalid Repository Location (not a dir): '/usr/portage'
    Fetching most recent snapshot ...
    Trying to retrieve 20140822 snapshot from http://distfiles.gentoo.org ...
    Fetching file portage-20140822.tar.xz.md5sum ...
    Fetching file portage-20140822.tar.xz.gpgsig ...
    Fetching file portage-20140822.tar.xz ...
    Checking digest ...
    Getting snapshot timestamp ...
    Syncing local tree ...

    Number of files: 180599
    Number of files transferred: 154646
    Total file size: 330.38M bytes
    Total transferred file size: 330.38M bytes
    Literal data: 330.38M bytes
    Matched data: 0 bytes
    File list size: 4.56M
    File list generation time: 0.001 seconds
    File list transfer time: 0.000 seconds
    Total bytes sent: 151.41M
    Total bytes received: 3.04M

    sent 151.41M bytes  received 3.04M bytes  7.18M bytes/sec
    total size is 330.38M  speedup is 2.14
    Cleaning up ...

     * IMPORTANT: 5 news items need reading for repository 'gentoo'.
     * Use eselect news to read news items.

    (chroot) winterfell ~ # emerge --sync

## Reading tha news :

Just in case something...

    (chroot) winterfell ~ # eselect news list
    News items:
      [1]   N  2012-05-21  Portage config-protect-if-modified default
      [2]   N  2012-11-06  PYTHON_TARGETS deployment
      [3]   N  2013-06-07  Portage preserve-libs default
      [4]   N  2013-08-23  Language of messages in emerge logs and output
      [5]   N  2013-09-27  Separate /usr on Linux requires initramfs

## System logger : `syslog-ng`

    (chroot) winterfell ~ # emerge -avt syslog-ng

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild  N     ] app-admin/syslog-ng-3.4.8  USE="ipv6 pcre ssl systemd tcpd -amqp -caps -dbi -geoip -json -mongodb -pacct -smtp -spoof-source" 3,096 kB
    [ebuild  N     ]  dev-libs/eventlog-0.2.12  USE="-static-libs" 297 kB

    Total: 2 packages (2 new), Size of downloads: 3,392 kB

    Would you like to merge these packages? [Yes/No] y
    ...
    ...

    (chroot) winterfell ~ # rc-update add syslog-ng default
     * service syslog-ng added to runlevel default

## Cron : `dcron`

    (chroot) winterfell ~ # rc-update add dcron default
     * service dcron added to runlevel default

    (chroot) winterfell ~ # cat /etc/crontab
    ...
    ...

    (chroot) winterfell ~ # crontab /etc/crontab

    (chroot) winterfell ~ # rc-update add dcron default
     * service dcron added to runlevel default

## `mlocate`

    (chroot) winterfell ~ # emerge mlocate

    (chroot) winterfell ~ # equery f mlocate |grep cron
    /etc/cron.daily
    /etc/cron.daily/mlocate
    /etc/mlocate-cron.conf

    (chroot) winterfell ~ # time updatedb

    real    0m10.634s
    user    0m0.570s
    sys 0m3.033s

## `sudo`

    (chroot) winterfell ~ # cat >> /etc/portage/package.use
    app-admin/sudo offensive
    (chroot) winterfell ~ # emerge -avt app-admin/sudo

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild  N     ] app-admin/sudo-1.8.6_p7  USE="ldap nls offensive pam sendmail (-selinux) -skey" 1,815 kB
    [ebuild  N     ]  virtual/mta-1  0 kB
    [ebuild  N     ]   mail-mta/nullmailer-1.13-r4  USE="ssl" 209 kB
    [ebuild  N     ]    virtual/logger-0  0 kB
    [ebuild  N     ]  dev-libs/cyrus-sasl-2.1.26-r3:2  USE="berkdb gdbm pam ssl -authdaemond -java -kerberos -ldapdb -mysql -openldap -postgres -sample -sqlite -srp -static-libs -urandom" 5,098 kB
    [ebuild  NS    ]   sys-devel/automake-1.12.6:1.12 [1.13.4:1.13] 1,368 kB
    [nomerge       ] mail-mta/nullmailer-1.13-r4  USE="ssl"
    [ebuild  N     ]  net-libs/gnutls-2.12.23-r6  USE="bindist cxx nettle nls zlib -doc -examples -guile -lzo -pkcs11 -static-libs {-test}" 7,109 kB
    [nomerge       ] dev-libs/cyrus-sasl-2.1.26-r3:2  USE="berkdb gdbm pam ssl -authdaemond -java -kerberos -ldapdb -mysql -openldap -postgres -sample -sqlite -srp -static-libs -urandom"
    [ebuild  N     ]  net-mail/mailbase-1.1  USE="pam" 0 kB
    [nomerge       ] net-libs/gnutls-2.12.23-r6  USE="bindist cxx nettle nls zlib -doc -examples -guile -lzo -pkcs11 -static-libs {-test}"
    [ebuild  N     ]  dev-libs/nettle-2.7.1:0/4  USE="gmp -doc (-neon) -static-libs {-test}" 1,523 kB

    Total: 9 packages (8 new, 1 in new slot), Size of downloads: 17,121 kB

    Would you like to merge these packages? [Yes/No] y

## Misc.

    (chroot) winterfell ~ # rc-update add sshd default
    * service sshd added to runlevel default

## New user `fabi`

    (chroot) winterfell ~ # useradd -m -s/bin/bash -G users,wheel,audio,cdrom,portage,usb,video fabi

    (chroot) winterfell ~ # passwd fabi
    New password:
    Retype new password:
    passwd: password updated successfully

## Portage profile : Systemd

**NOTE (a posteriori):** Before switching profile you really should have :

* Built a few more stuff, which you didn't, hence found yourself unable to
  even build a simple `genkernel-next` or **`vim`**;
* Performed a system upgrade, just in case a few interresting stuff like could
    be rebuilt to newer versions, like e.g. gcc.

.

    (chroot) winterfell ~ # eselect profile list
    Available profile symlink targets:
      [1]   default/linux/amd64/13.0 *
      [2]   default/linux/amd64/13.0/selinux
      [3]   default/linux/amd64/13.0/desktop
      [4]   default/linux/amd64/13.0/desktop/gnome
      [5]   default/linux/amd64/13.0/desktop/gnome/systemd
      [6]   default/linux/amd64/13.0/desktop/kde
      [7]   default/linux/amd64/13.0/desktop/kde/systemd
      [8]   default/linux/amd64/13.0/developer
      [9]   default/linux/amd64/13.0/no-multilib
      [10]  default/linux/amd64/13.0/x32
      [11]  hardened/linux/amd64
      [12]  hardened/linux/amd64/selinux
      [13]  hardened/linux/amd64/no-multilib
      [14]  hardened/linux/amd64/no-multilib/selinux
      [15]  hardened/linux/amd64/x32
      [16]  hardened/linux/musl/amd64
      [17]  default/linux/uclibc/amd64
      [18]  hardened/linux/uclibc/amd64

    (chroot) winterfell ~ # eselect profile set 5

## `/etc/make.conf` : Compilation settings

### Running `gcc -march=native` for guessing actual processor type

Searching for `-march=` from the output of :

    (chroot) winterfell ~ # ( echo 'int main(){return 0;}' > test.c &&
        gcc -v -Q -march=native -O2 test.c -o test &&
        rm -v test.c test ) 2>&1 |
            grep 'march='

    (chroot) winterfell ~ # cat /proc/cpuinfo |grep '^processor\s:'
    processor   : 0
    processor   : 1

    (chroot) winterfell ~ # nano /etc/portage/make.conf

    # /etc/portage/make.conf
    CFLAGS="-march=amdfam10 -O2 -pipe"
    MAKEOPTS="-j3"

    # For elogv & elogviewer :
    PORTAGE_ELOG_SYSTEM="save echo"
    PORTAGE_ELOG_CLASSES="warn error info log qa"


## Timezone

    (chroot) winterfell ~ # ls /usr/share/zoneinfo/Europe/Paris
    /usr/share/zoneinfo/Europe/Paris

    (chroot) winterfell ~ # echo "Europe/Paris" > /etc/timezone

    (chroot) winterfell ~ # emerge --config sys-libs/timezone-data

    Configuring pkg...

     * Updating /etc/localtime with /usr/share/zoneinfo/Europe/Paris


## Locales

    (chroot) winterfell ~ # grep -E 'en_US|fr_FR' /usr/share/i18n/SUPPORTED >> /etc/locale.gen
    (chroot) winterfell ~ # nano -w /etc/locale.gen

    (chroot) winterfell ~ # locale-gen
     * Generating 5 locales (this might take a while) with 1 jobs
     *  (1/5) Generating en_US.UTF-8 ... [ ok ]
     *  (2/5) Generating en_US.ISO-8859-1 ... [ ok ]
     *  (3/5) Generating fr_FR.UTF-8 ... [ ok ]
     *  (4/5) Generating fr_FR.ISO-8859-1 ... [ ok ]
     *  (5/5) Generating fr_FR.ISO-8859-15@euro ... [ ok ]
     * Generation complete

    (chroot) winterfell ~ # locale -a
    C
    POSIX
    en_US
    en_US.iso88591
    en_US.utf8
    fr_FR
    fr_FR.iso88591
    fr_FR.iso885915@euro
    fr_FR.utf8
    fr_FR@euro
    fran�ais
    french

    (chroot) winterfell ~ # eselect locale list
    Available targets for the LANG variable:
      [1]   C
      [2]   POSIX
      [3]   en_US
      [4]   en_US.iso88591
      [5]   en_US.utf8
      [6]   fr_FR
      [7]   fr_FR.iso88591
      [8]   fr_FR.iso885915@euro
      [9]   fr_FR.utf8
      [10]  fr_FR@euro
      [11]  fran�ais
      [12]  french
      [ ]   (free form)
    (chroot) winterfell ~ # eselect locale set en_US.utf8
    Setting LANG to en_US.utf8 ...
    Run ". /etc/profile" to update the variable in your shell.

    (chroot) winterfell ~ # cat  /etc/env.d/02locale
    # Configuration file for eselect
    # This file has been automatically generated.
    LANG="en_US.utf8"

    (chroot) winterfell ~ # cat >> /etc/env.d/02locale << EOF
    > #LC_COLLATE="C"
    > # ^ fabic: for remembrance...
    > EOF

    (chroot) winterfell ~ # env-update && source /etc/profile
    (chroot) winterfell ~ # export PS1="(chroot) $PS1"

## `/etc/mtab` symlink

    (chroot) winterfell ~ # ln -siv /proc/self/mounts /etc/mtab
    ‘/etc/mtab’ -> ‘/proc/self/mounts’

## Networking (OpenRC)

**NOTE:** Upon reboot, your network interface `eth0` may be renamed, for ex. to `enp2s0`.

    (chroot) winterfell ~ # vim /etc/conf.d/hostname

    (chroot) winterfell ~ # cat /etc/conf.d/hostname
    # Set to the hostname of this machine
    hostname="winterfell"


    (chroot) winterfell ~ # cat >> /etc/conf.d/net << EOF

    dns_domain_lo="westeros.net"

    config_eth0="192.168.0.2/24"
    routes_eth0="default gw 192.168.0.1"
    dns_servers_eth0="89.2.0.1 89.2.0.2"
    dns_domain_eth0="fabic.net"

    #config_eth0="dhcp"
    EOF

### Adding it to default runlevel

    (chroot) winterfell ~ # cd /etc/init.d
    (chroot) winterfell init.d # ln -s net.lo net.eth0
    (chroot) winterfell init.d # rc-update add net.eth0 default
     * service net.eth0 added to runlevel default

### `/etc/hosts`

Adding local network names for my test web stuff (blog & jekyll github thing).

    (chroot) winterfell init.d # cat >> /etc/hosts << EOF
    >
    > 127.0.0.1 fabicnet fabichub
    > EOF

### `dhcpcd`

    (chroot) winterfell ~ # emerge -avt dhcpcd

## Emerge-ing gentoolkit & elogv

    (chroot) winterfell ~ # emerge -avt gentoolkit elogv

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild  N     ] app-portage/elogv-0.7.6.1-r1  LINGUAS="-de -es -it -pl" PYTHON_TARGETS="python2_7" 18 kB
    [ebuild  N     ] app-portage/gentoolkit-0.3.0.8-r2  PYTHON_TARGETS="python2_7 python3_3 -python3_2" 3,118 kB
    [ebuild  N     ]  dev-lang/python-exec-2.0.1-r1:2  PYTHON_TARGETS="(jython2_5) (jython2_7) (pypy) (python2_7) (python3_2) (python3_3) (-python3_4)" 80 kB

    Total: 3 packages (3 new), Size of downloads: 3,215 kB

    Would you like to merge these packages? [Yes/No] y
    ...
    ...

## Upgrading @world

* The system profile change (for a systemd one) pulled in various USE flags ;
* Plus we did retrieve an up-to-date portage tree.

### Wrapper script :

    (chroot) winterfell ~ # cat > bin/upgrade_gentoo_emerge_deep_bdeps.sh <<EOF
    #!/bin/sh
    # fabic.2014-08-23

    time \

    time emerge -av --update --deep --with-bdeps=y --newuse "\$@" @world

    RETV=\$?

    echo
    echo "INFO: Emerge ret. status: \$RETV"
    echo

    exit \$RETV
    EOF

### Running it

    (chroot) winterfell ~ # bin/upgrade_gentoo_emerge_deep_bdeps.sh
    ...
    ...

    Total: 173 packages (5 upgrades, 153 new, 3 in new slots, 12 reinstalls, 1 uninstall), Size of downloads: 567,272 kB
    Conflict: 3 blocks

    Would you like to merge these packages? [Yes/No] n

* Damn, that's way too much for now ;
* Tried disabling some USE flags such as -X -gtk -gnome, but it complains too
  much about dependency problems.
* **Proceeded with** having a kernel built just for the sake of packages in that
  list that may (very probably) need a configured kernel.
* ^ _I'm not rebooting though, remaining under chroot for a while, building things._
* **Then:** perfomed system upgrade.

### Ended up upgrading... then :

    (chroot) winterfell ~ # emerge --depclean --ask

### Meanwhile, wandering through misc. setups

    (chroot) winterfell ~ # USE='-X' emerge -avt vim


## Kernel (right now -\_- ?)

* _**Let's do it later on, too time & brain consuming it is to wander through
 `--menuconfig`**_
* **Did it** manually ;
* Wanted to use [genkernel-next](http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1#genkernel)
  in the first place, but it had way too many deps, probably because of the `systemd`
  Gentoo profile.

### Kernel : A few prior checks & `emerge gentoo-sources`

    winterfell ~ # uname -a
    Linux winterfell 3.10.7-gentoo-f7 #1 SMP PREEMPT Sat Aug 31 13:57:35 CEST 2013 x86_64 AMD Athlon(tm) II X2 270 Processor AuthenticAMD GNU/Linux

    winterfell ~ # ls -l /proc/config.gz

    winterfell ~ # emerge -avt gentoo-sources

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild  N     ] sys-kernel/gentoo-sources-3.14.14:3.14.14  USE="-build -deblob -experimental -symlink" 76,945 kB
    [ebuild  N     ]  sys-devel/bc-1.06.95  USE="readline -libedit -static" 284 kB

    Total: 2 packages (2 new), Size of downloads: 77,229 kB

    Would you like to merge these packages? [Yes/No] y
    ...
    ...

    winterfell ~ #  ls -l /usr/src/
    total 4
    lrwxrwxrwx  1 root root   20 Aug 23 15:43 linux -> linux-3.14.14-gentoo
    drwxr-xr-x 24 root root 4096 Aug 23 15:43 linux-3.14.14-gentoo

### Kernel : Quick building it (w/o thinking)

* Using my host's `/proc/config.gz` ;
* Enabling Gentoo's kernel meta-conf. about `systemd` init system ;

.


    winterfell ~ # cd /usr/src/linux

    winterfell linux # make clean   [mrproper]

    winterfell linux # zcat /proc/config.gz > .config


    (chroot) winterfell linux # make menuconfig

        Gentoo Linux --->
            Support for init systems, system and service managers --->
                    [*] OpenRC, runit and other script based systems and managers
                    [*] systemd

        General setup  --->
            (-f8) Local version - append to kernel release

        Processor type and features  --->
            Processor family (Opteron/Athlon64/Hammer/K8)  --->
                (X) Opteron/Athlon64/Hammer/K8
            (2) Maximum number of CPUs
        File systems  --->
            <M> Second extended fs support
            <M> Ext3 journalling file system support
            <*> The Extended 4 (ext4) filesystem


    (chroot) winterfell linux # time make -j3

### Kernel : Install

    (chroot) winterfell linux # make modules_install

    (chroot) winterfell linux # make install
    sh /usr/src/linux-3.14.14-gentoo/arch/x86/boot/install.sh 3.14.14-gentoo-f8 arch/x86/boot/bzImage \
        System.map "/boot"

    (chroot) winterfell linux # ls -ltrh /boot/ /lib/modules/
    /lib/modules/:
    total 4.0K
    drwxr-xr-x 3 root root 4.0K Aug 23 16:29 3.14.14-gentoo-f8

    /boot/:
    total 4.5M
    -rw-r--r-- 1 root root 2.6M Aug 23 16:30 vmlinuz-3.14.14-gentoo-f8
    -rw-r--r-- 1 root root 1.9M Aug 23 16:30 System.map-3.14.14-gentoo-f8
    -rw-r--r-- 1 root root  88K Aug 23 16:30 config-3.14.14-gentoo-f8

## Grub bootloader

    (chroot) winterfell ~ # emerge -avt sys-boot/grub

### Host system : Ensuring grub is installed on the correct HDD

    winterfell ~ # grub-install --no-floppy /dev/sdd
    Installation finished. No error reported.
    This is the contents of the device map /boot/grub/device.map.
    Check if this is correct or not. If any of the lines is incorrect,
    fix it and re-run the script `grub-install'.

    (fd0)   /dev/fd0
    (hd0)   /dev/sda
    (hd1)   /dev/sdb
    (hd2)   /dev/sdc
    (hd3)   /dev/sdd

    winterfell ~ # vi /boot/grub/grub.conf

_**^** Not the case -\_-_

### Back into chroot env.:

#### Installing bootloader on `/dev/sda`

    (chroot) winterfell ~ # grub2-install /dev/sda
    Installation finished. No error reported.

#### Generating `/boot/grub/grub.cfg`

    (chroot) winterfell ~ # grub2-mkconfig -o /boot/grub/grub.cfg
    Generating grub.cfg ...
    Found linux image: /boot/vmlinuz-3.14.14-gentoo-f8
    done

    (chroot) winterfell ~ # ls -l /boot
    total 4552
    -rw-r--r-- 1 root root 1919953 Aug 23 16:30 System.map-3.14.14-gentoo-f8
    -rw-r--r-- 1 root root   89301 Aug 23 16:30 config-3.14.14-gentoo-f8
    drwxr-xr-x 6 root root    4096 Aug 23 19:23 grub
    -rw-r--r-- 1 root root 2643072 Aug 23 16:30 vmlinuz-3.14.14-gentoo-f8

## X, Gnome3, Xfce, LXDE, Mate

    (chroot) winterfell ~ # cat >> /etc/portage/make.conf << EOF

    #VIDEO_CARDS="fglrx radeon nvidia nouveau"
    VIDEO_CARDS="fglrx"
    INPUT_DEVICES="evdev wacom"
    EOF

    (chroot) winterfell ~ # time emerge -av x11-base/xorg-drivers xterm twm
    ...
    ...
    Total: 249 packages (248 new, 1 in new slot), Size of downloads: 467,206 kB
    Would you like to merge these packages? [Yes/No] y

* _249 packages to go, goin' out for a break..._
* _It ran for 3h35 minutes..._


### Emerging lots of stuff through the night

#### Had first to rebuild OpenSSH-OpenSSL w/o `bindist` USE flag

For Gnome3's empathy...

    (chroot) winterfell ~ # cat >> /etc/portage/package.use <<EOF

    dev-libs/openssl -bindist
    net-misc/openssh -bindist
    EOF

.

    (chroot) winterfell ~ # time emerge -avt net-misc/openssh

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild   R    ] net-misc/openssh-6.6_p1-r1  USE="X hpn ldap pam tcpd -X509 -bindist* -kerberos -ldns -libedit (-selinux) -skey -static" 0 kB
    [ebuild   R    ]  dev-libs/openssl-1.0.1i  USE="(sse2) tls-heartbeat zlib -bindist* -gmp -kerberos -rfc3779 -static-libs {-test} -vanilla" ABI_X86="(64) (-32) (-x32)" 4,323 kB

    Total: 2 packages (2 reinstalls), Size of downloads: 4,323 kB

    Would you like to merge these packages? [Yes/No] y

#### Oracle Java SE JDK & JRE

* Downloaded _Java SE JDK & JRE 7u65_ found online wandering through : <http://www.oracle.com/technetwork/java/javase/downloads/index.html> » Additional Resources » Previous Releases - Java Archive ;
* Moved files `jdk-7u65-linux-x64.tar.gz` & `jre-7u65-linux-x64.tar.gz` as
  requested by Emerge under `/usr/portage/distfiles/` ;

.

    (chroot) winterfell ~ # cat >> /etc/portage/package.license <<EOF

    dev-java/oracle-jdk-bin Oracle-BCLA-JavaSE
    dev-java/oracle-jre-bin Oracle-BCLA-JavaSE
    EOF

.

    (chroot) winterfell ~ # cat >> /etc/portage/package.use <<EOF

    dev-java/oracle-jre-bin nsplugin
    EOF

.

    (chroot) winterfell ~ # time emerge -avt dev-java/oracle-jdk-bin dev-java/oracle-jre-bin

    These are the packages that would be merged, in reverse order:

    Calculating dependencies... done!
    [ebuild  N f   ] dev-java/oracle-jre-bin-1.7.0.65:1.7  USE="X alsa nsplugin -fontconfig -jce -pax_kernel (-selinux)" 0 kB
    [ebuild  N f   ] dev-java/oracle-jdk-bin-1.7.0.65:1.7  USE="X alsa fontconfig (-aqua) -derby -doc -examples -jce -nsplugin -pax_kernel (-selinux) -source" 0 kB
    [nomerge       ] dev-java/oracle-jre-bin-1.7.0.65:1.7  USE="X alsa nsplugin -fontconfig -jce -pax_kernel (-selinux)"
    [nomerge       ]  app-admin/eselect-java-0.1.0
    [ebuild  N     ]   virtual/jre-1.6.0-r1:1.6  0 kB
    [ebuild  N     ]    virtual/jdk-1.6.0-r2:1.6  0 kB
    [ebuild  N     ]     dev-java/icedtea-bin-6.1.13.3-r3:6  USE="X alsa cups -cjk -doc -examples -nsplugin (-selinux) -source -webstart" 51,077 kB
    [ebuild  N     ]      app-admin/eselect-java-0.1.0  71 kB
    [ebuild  N     ]      dev-java/java-config-2.2.0:2  PYTHON_TARGETS="python2_7 python3_3 -python3_2" 51 kB
    [ebuild  NS    ]      virtual/jpeg-62:62 [0-r2:0] ABI_X86="(64) (-32) (-x32)" 0 kB
    [nomerge       ] dev-java/oracle-jre-bin-1.7.0.65:1.7  USE="X alsa nsplugin -fontconfig -jce -pax_kernel (-selinux)"
    [nomerge       ]  dev-java/java-config-2.2.0:2  PYTHON_TARGETS="python2_7 python3_3 -python3_2"
    [ebuild  N     ]   dev-java/java-config-wrapper-0.16  8 kB
    [ebuild  N     ]   sys-apps/baselayout-java-0.1.0  71 kB

    Total: 10 packages (9 new, 1 in new slot), Size of downloads: 51,276 kB
    Fetch Restriction: 2 packages

    Would you like to merge these packages? [Yes/No]


#### Emerge...

_Preparing for an attempt at running a huge emerge through the night,
 setting/guessing USE flags in `/etc/portage/package.use` right now..._

    (chroot) winterfell ~ # cat >> /etc/portage/package.use <<EOF

    app-office/abiword grammar map math thesaurus

    virtual/ffmpeg threads vdpau #vaapi
    media-video/libav 3dnow 3dnowext threads vdpau #vaapi
    media-video/mplayer2 3dnow 3dnowext bluray samba xinerama vdpau
    media-video/vlc avahi bluray fontconfig libass samba theora #vaapi #httpd

    EOF

.

    (chroot) winterfell ~ # time \
        emerge -avn --keep-going --complete-graph \
            xfce-base/xfce4-meta gnome-base/gnome \
            lxde-base/lxde-meta mate-base/mate  \
            dev-db/mysql dev-db/postgresql-server \
            app-office/libreoffice-bin app-office/abiword \
            sys-block/gparted
    ...
    ...
    Total: 374 packages (366 new, 8 in new slots), Size of downloads: 762,287 kB

    Would you like to merge these packages? [Yes/No] y

* *Had to discard* these ones :
    - www-client/chromium
    - media-video/vlc
    - media-video/smplayer
* 4 packages failled to build, Gnome3 stuff, re-emerging went just fine ;
* Running `emerge --depclean --ask`
* And `revdep-rebuild` :

.

    (chroot) winterfell ~ # revdep-rebuild -v
     * Configuring search environment for revdep-rebuild
     * Temporary cache files are located in /var/cache/revdep-rebuild

    revdep-rebuild environment:
    SEARCH_DIRS="/bin
    /lib
    /lib32
    /lib64
    ... ..."
    SEARCH_DIRS_MASK="/lib/modules
    /lib64/modules
    ... ..."
    LD_LIBRARY_MASK="libjava.so
    libjawt.so
    libjvm.so
    libodbc.so
    libodbcinst.so"
    PORTAGE_ROOT="/"
    EMERGE_OPTIONS=""
    ORDER_PKGS="1"
    FULL_LD_PATH="1"

     * Checking reverse dependencies
     * Packages containing binaries and libraries broken by a package update
     * will be emerged.

     * Collecting system binaries and libraries
     * Generated new 1_files.rr
     * Collecting complete LD_LIBRARY_PATH
     * Generated new 2_ldpath.rr
     * Checking dynamic linking consistency
    [ 100% ]

     * Dynamic linking on your system is consistent... All done.

#### `www-client/chromium`

Emerge-ing it separately (from the above "huge emerge list"), seems ok, but it
will rebuild `libxml[+icu]` and `zlib[+minizip]`.

    (chroot) winterfell ~ # time emerge -avn --complete-graph --keep-going www-client/chromium

    These are the packages that would be merged, in order:

    Calculating dependencies... done!
    [ebuild  N     ] dev-libs/re2-0_p20130115  998 kB
    [ebuild  N     ] dev-libs/jsoncpp-0.5.0-r1  USE="-doc" 105 kB
    [ebuild  N     ] media-sound/gsm-1.0.13-r1  ABI_X86="(64) (-32) (-x32)" 64 kB
    [ebuild  N     ] dev-util/re2c-0.13.5-r1  765 kB
    [ebuild  N     ] dev-libs/dotconf-1.3  326 kB
    [ebuild   R    ] sys-libs/zlib-1.2.8-r1  USE="minizip* -static-libs" ABI_X86="(64) (-32) (-x32)" 558 kB
    [ebuild  N     ] app-arch/snappy-1.1.1  USE="-static-libs" 1,737 kB
    [ebuild  N     ] dev-libs/libevent-2.0.21-r1  USE="ssl threads -static-libs {-test}" ABI_X86="(64) (-32) (-x32)" 831 kB
    [ebuild  N     ] dev-util/ninja-1.4.0  USE="-doc -emacs {-test} -vim-syntax -zsh-completion" 149 kB
    [ebuild   R    ] dev-libs/libxml2-2.9.1-r4:2  USE="icu* ipv6 python readline -debug -examples -lzma -static-libs {-test}" ABI_X86="(64) (-32) (-x32)" PYTHON_TARGETS="python2_7 python3_3 -python3_2 (-python3_4)" 0 kB
    [ebuild  N     ] dev-python/simplejson-3.3.0  PYTHON_TARGETS="python2_7 python3_3 (-pypy)" 66 kB
    [ebuild  N     ] media-sound/sox-14.4.1  USE="alsa encode flac mad ogg openmp png pulseaudio -amr -ao -debug -ffmpeg -id3tag -ladspa -oss -sndfile -static-libs -twolame -wavpack" 1,086 kB
    [ebuild  N     ] app-accessibility/espeak-1.47.11-r1  USE="pulseaudio -portaudio" 2,748 kB
    [ebuild  N     ] app-accessibility/speech-dispatcher-0.8-r2  USE="alsa espeak pulseaudio python -ao -flite -nas -static-libs" PYTHON_TARGETS="python3_3 -python3_2" 1,201 kB
    [ebuild  N     ] www-client/chromium-36.0.1985.143  USE="bindist cups gnome gnome-keyring pulseaudio tcmalloc -custom-cflags -kerberos (-neon) (-selinux) {-test}" LINGUAS="am ar bg bn ca cs da de el en_GB es es_LA et fa fi fil fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt_BR pt_PT ro ru sk sl sr sv sw ta te th tr uk vi zh_CN zh_TW" 200,642 kB

    Total: 15 packages (13 new, 2 reinstalls), Size of downloads: 211,271 kB

    Would you like to merge these packages? [Yes/No]

_This will take a damn while to complete, goin' out for a coffee..._

## (Re)-booting

### Before rebooting

Download the handbook and some wiki pages on disk in case you have no inet card
working...

    (chroot) winterfell ~ # wget 'http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1' \
        -O Gentoo_amd64_handbook_full_print.html

    (chroot) winterfell ~ # wget 'https://wiki.gentoo.org/wiki/Systemd' -O Gentoo_wiki_systemd.html

## Apache2/PHP

    (chroot) winterfell ~ # cat >> /etc/portage/make.conf <<EOF

    PHP_INI_VERSION='development'
    #PHP_TARGETS="php5-3 php5-4 php5-5"
    PHP_TARGETS="php5-5"
    EOF

## ...

_End of transmission._
