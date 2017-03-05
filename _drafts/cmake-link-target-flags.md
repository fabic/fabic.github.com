---
layout: post
title: "Draft - CMake, Ah! CMake -_-"
tagline: "Supporting tagline"
category : notes
tags : [draft]
---

CMake has no `target\_link\_options(...)`, resort to :

    add_library( tutu SHARED tutu.cpp tutu-impl.cpp )

    target_compile_options( nstd PUBLIC -nostdinc -nostdinc++ )

    set_target_properties( nstd PROPERTIES LINK_FLAGS -nostdlib)



* <https://cmake.org/cmake/help/v3.0/command/set_target_properties.html>

__EOF__
