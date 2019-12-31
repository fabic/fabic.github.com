---
layout: note
title: "RPi3 + Open Media Vault"
tagline: ""
published: true
category : notes
tags : [note, RPi, NAS]
---

Installing [Open Media Vault][OMV] on that Raspberry Pi 3 something.

[Download](https://www.openmediavault.org/download.html) the `OMV_4_Raspberry_Pi_2_3_3Plus.img.xz`
image from the [sourceforge.net](https://sourceforge.net/projects/openmediavault/files/Raspberry%20Pi%20images/)
`Raspberry Pi images/` sub-folder and :

```bash
$ time ( unxz --stdout OMV_4_Raspberry_Pi_2_3_3Plus.img.xz \
         | sudo dd of=/dev/mmcblk0 bs=1M oflag=direct iflag=fullblock status=progress )
```

And [read the manual][OMV-DOC]...

[OMV]: https://www.openmediavault.org/
[OMV-DOC]: https://openmediavault.readthedocs.io
