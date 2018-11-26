---
layout: note
title: "Xrandr Linux multiple displays from cli"
tagline: ""
published: true
category : notes
tags : [note]
---

TL;DR:

```
$ less /var/log/Xorg.?.log
$ xrandr -v -q
$ xrandr -v --output HDMI-0 --off
$ xrandr -v --output HDMI-0 --left-of DP-0 --mode 1920x1200 --dpi 96
$ xrandr -v --output DP-0 --mode 1920x1080 --brightness .75 --gamma 1.0:0.98:0.95
```

* <https://wiki.archlinux.org/index.php/NVIDIA>
* <https://wiki.archlinux.org/index.php/Multihead>
* [maty's Gist “ASUS GL703VM tips & Workaround”](https://gist.github.com/maty974/a72eece781917e133514b3d322c08005)
* [Gist: Problems and Solutions for Ubuntu 16.04 LTS on ASUS ROG GL502VS Laptop (by GMMan)](https://gist.github.com/GMMan/def55b688289f52b8635f1a83c25b1b5)

