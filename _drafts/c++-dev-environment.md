---
layout: post
title: "Draft - C++ development environment '17"
tagline: "Supporting tagline"
category : notes
tags : [draft, c++]
---

_There you are, trying to get back to some C++ coding after many years..._

* JetBrains CLion
* Vim + Syntastic + CScope + Ctags
* YouCompleteMe ? Rtags ?
* CMake + example template + doc. pointers.
* GCC & Clang tips : dumping headers' include hierarchies.

## Documentation

* [cppreference.com](http://en.cppreference.com/)

## Libraries

* Boost C++
* GNU's libstdc++ & LLVM/Clang libcxx.

## Tools

* Ninja
* Doxygen
* [include-what-you-use.org](https://include-what-you-use.org/)
* [Rtags](https://github.com/Andersbakken/rtags)

### Vim Syntastic

* `:let g:syntastic_clang_check_config_file` ⇒ `.syntastic_clang_check_config`
* `:help syntastic-checkers`
* Open a C++ file and `:SyntasticInfo`

        Syntastic version: 3.8.0-26 (Vim 800, Linux, GUI)
        Info for filetype: cpp
        Global mode: active
        Filetype cpp is active
        The current file will be checked automatically
        Available checkers: clang_check clang_tidy gcc
        Currently enabled checker: gcc
        Press ENTER or type command to continue

## Debugging

* Voltron thing + LLDB / GDB
* Valgrind

__EOF__
