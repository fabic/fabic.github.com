---
layout: post
title: "Mac OS X : how to burn ISO disk image ?"
#tagline: "Supporting tagline"
category : notes
tags : [howto, Mac OS X, util]
---


Found solution at <http://osxdaily.com/2015/11/22/burn-disc-images-os-x-finder/> :
just right-click the image file (.iso or .dmg) and “Burn disk image &hellip;”, or from a shell :

    hdiutil burn ~/Path/To/DiskImageFile.iso
