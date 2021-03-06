---
layout: note
title: "KODI : Install & Setup (Arch Linux box)"
tagline: "March 2019: Tried to install that Netflix Kodi addon, and failed."
published: true
category : notes
tags : [note, archlinux]
---

```bash
$ sudo pacman -S kodi kodi-addon-peripheral-joystick kodi-addon-screensaver-asteroids
$ sudo pacman -S kodi-addon-game-libretro kodi-addon-game-libretro-snes9x \
                 kodi-addon-game-libretro-nestopia
```

Follow log output :

```bash
$ tail -Fq -n1 ~kodi/.kodi/temp/kodi.log
```

```bash
$ yay -S kodi-addon-inputstream-adaptive-git
$ yay -S chromium-widevine
$ yay -S python2-pycryptodomex
```

```bash
$ ls -l /usr/lib/chromium/libwidevinecdm.so /usr/lib/kodi/addons/inputstream.adaptive/libssd_wv.so
$ sudo su - kodi
$ mkdir ~/.kodi/cdm/ && cd !$
```

```bash
$ ln -siv /usr/lib/kodi/addons/inputstream.adaptive/libssd_wv.so  ~/.kodi/cdm/ &&
  ln -siv /usr/lib/chromium/libwidevinecdm.so                     ~/.kodi/cdm/ &&
  ls -la ~/.kodi/cdm/
```

For the Netflix addon, download the most recent .zip build provided at
[CastagnaIT's plugin.video.netflix](https://github.com/CastagnaIT/plugin.video.netflix)
repository &ndash; then: Add-ons -> Install from Zip file.

**Note/2019-03:** failed to get that Netflix addon to work.

* <https://wiki.archlinux.org/index.php/Kodi>
* [Arch's kodi-addons](https://www.archlinux.org/groups/x86_64/kodi-addons/)
* [kodi-addon-inputstream-adaptive-git @ ArchLinux/AUR](https://aur.archlinux.org/packages/kodi-addon-inputstream-adaptive-git/)
* [chromium-widevine @ ArchLinux/AUR](https://aur.archlinux.org/packages/chromium-widevine/)
* <https://github.com/asciidisco/plugin.video.netflix> Original (now unmaintained) Git repository for the Kodi Netflix addon.
* <https://github.com/CastagnaIT/plugin.video.netflix> Maintained fork by CastagnaIT.
* <https://blog.fastestvpn.com/netflix-on-kodi-addon/>
* [/r/Addons4Kodi @ Reddit](https://www.reddit.com/r/Addons4Kodi/)
* [Koko.wiki](https://kodi.wiki)
* <http://fusion.tvaddons.co/> : Settings -> File Manager -> Add Source -> enter that URL.

Remote / Keyboard :

* Tablet/smartphone apps:
    - <https://kodi.wiki/view/Smartphone/tablet_remotes>
    - <https://kodi.wiki/view/Official_Kodi_Remote>

* <https://kodi.wiki/view/Keyboard_controls> : Kodi's default keyboard controls (keymap)
* [Flirc.tv remote controller presets](https://support.flirc.tv/hc/en-us/articles/202923419-Controller-presets-in-Flirc-GUI)
