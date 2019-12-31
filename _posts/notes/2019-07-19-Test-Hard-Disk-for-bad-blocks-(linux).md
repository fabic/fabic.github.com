---
layout: note
title: "Test Hard-Disk for bad blocks (linux)"
tagline: ""
published: true
category : notes
tags : [note]
---

```bash
$ time sudo \
    badblocks -o ~/ext-seagate-3tb-badblocks.log -w -s /dev/sdf
```

