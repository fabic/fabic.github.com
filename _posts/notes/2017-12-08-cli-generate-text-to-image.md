---
layout: note
title: "ImageMagick gen. text to image file"
tagline: ""
published: true
category : notes
tags : [note, cli, graphics]
---

Generate an image with my email address, from the command line :

    $ convert -background 'rgba(0,0,0,0)' -font Source-Code-Pro-for-Powerline -pointsize 12 \
        label:"cadet.fabien@gmail.com" cadet.fabien@gmail.com.png

Likewise for my mobile phone number :

    $ convert -background 'rgba(0,0,0,0)' -font Source-Code-Pro-for-Powerline -pointsize 12 \
        label:"+33 (0) 651 07 26 05" cadet_fabien_mobile_phone_number.png
