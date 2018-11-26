---
#layout: default
layout: page
title: "Wine, DOSBox, retroarch (libretro)"
tagline: "Playing on linux"
category : notes
tags : [draft, wide]
published: false
---

* <https://www.dosbox.com/wiki/Dosbox.conf>
* <https://wiki.archlinux.org/index.php/Wine>


```bash
sudo pacman -S wine-staging winetricks wine-mono wine_gecko

WINEARCH=win32 WINEPREFIX=~/win32 winecfg
WINEARCH=win32 WINEPREFIX=~/win32 winetricks ie8 corefonts vcrun2005 vcrun2008 vcrun2015
```

```bash
$ cat << EOF > ~/bin/wine32.sh
#!/bin/bash
export WINEARCH=win32 WINEPREFIX=~/win32
exec wine "$@"
```

```bash
$ wine32.sh /dream/Downloads/StarCraft-Setup.exe
```

# Pointers

* __<http://collectionchamber.blogspot.com>__
* [thread: StarCraft Remastered on Linux using WINE (2017-08)](https://us.battle.net/forums/en/starcraft/topic/20758557971#post-16)

__EOF__
