---
layout: page
title: "Git SCM : Scattered notes..."
description: ""
---

_Git, shake dreams from your hair my pretty tool..._

## Initial setup

    $ git config --global user.name "`id -un`"
    $ git config --global user.email "`id -un`@`hostname -f`"

    $ git config --global color.ui auto

    $ git config --global merge.tool vimdiff

    $ git config --global -l

## Basic day-to-day usage

    git init .

    git clone [--recursive]

    git branch [-a]

    git show-branch master origin/master

    git log --graph ...

    gl HEAD..FETCH_HEAD

    git submodule update --init --recursive

    git remote -v

    git remote set-head origin -a

    git reset

    git reset --hard

    git checkout <file>

    git push

    git push origin master

    git push -u origin my_branch
    git push -f origin my_branch

    git push origin :my_branch

## Misc.

    git config ...share group ???

## Documentation pointers

git-scm.org + the book.

