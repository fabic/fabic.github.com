---
#layout: default
layout: page
title: "Electron + Vue.js (notes)"
tagline: "Personal notes about setting up a desktop-ready app. with Electron & Vue.js"
category : notes
tags : [draft, wide, vuejs]
published: true
---

## Pointers

* Electron doc. index : <https://electronjs.org/docs>
* Must read :
    - [Electron Application Architecture](https://electronjs.org/docs/tutorial/application-architecture)
    - [Getting Started: Writing your 1st Electron App](https://electronjs.org/docs/tutorial/first-app)
* Electron bits :
    - [BrowserWindow](https://electronjs.org/docs/api/browser-window)
    - [`remote`](https://electronjs.org/docs/api/remote)
    - [webContents](https://electronjs.org/docs/api/web-contents)
      ([webContents instance methods](https://electronjs.org/docs/api/web-contents#instance-methods))
    - [FAQ: How to share data between web pages?](https://electronjs.org/docs/faq#how-to-share-data-between-web-pages)
    - [ipcMain](https://electronjs.org/docs/api/ipc-main)
      & [ipcRenderer](https://electronjs.org/docs/api/ipc-renderer)
    - [Multithreading](https://electronjs.org/docs/tutorial/multithreading) (warning notes: just don't multithread)

## Installation / Setting things up

* [simulatedgreg's electron-vue (Vue CLI preset)](https://simulatedgreg.gitbooks.io/electron-vue)

As per [cli.vuejs.org/guide/](https://cli.vuejs.org/guide/installation.html) :

```bash
$ yarn global add @vue/cli
$ yarn global add @vue/cli-service-global        # (optional)
```

```bash
$ vue --version
3.5.1
```

## Misc. pointers

* [sgdan's electron-background-processing example code](https://github.com/sgdan/electron-background-processing)

    Basic example of communication between the _main_ process and _renderer_ processes
    through events (by means of `ipcMain` &amp; `ipcRenderer`)

* [2018: How to Build an Electron Desktop App in JavaScript: Multithreading, SQLite, Native Modules, and other Common Pain Points (by Andrew Walsh)](https://medium.freecodecamp.org/how-to-build-an-electron-desktop-app-in-javascript-multithreading-sqlite-native-modules-and-1679d5ec0ac)

    Read section about the 3 strategies for concurrent processing ("multithreading"):
    - Web workers
    - Forking new processes
    - Running hidden renderer processes (that is: _windows_) for background work.

* [2018-12: Desktop Applications in Electron: Pro Tips and Tricks, by Paul Betts (Facebook dev., former lead dev. on Slack)](https://www.infoq.com/presentations/electron-pitfalls)

    Read the conference transcript, specifically about background processing gotchas:
    Main process is for orchestration, not for compute-intensive processing; and why
    renderer processes shall not perform long computations either.  Mentions the pitfalls
    of resorting to `remote`; mentions its [eletron-remote](https://github.com/electron-userland/electron-remote)
    library (heavily based on [rxjs.dev](https://rxjs.dev) though, which in my opinion makes
    their code quite difficult to grasp if one just want to steal a few bits).

* [2018: JavaScript on the Desktop, Fast and Slow, by Felix Rieseberg](https://medium.com/@felixrieseberg/javascript-on-the-desktop-fast-and-slow-2b744dfb8b55)

    On how to improve performance of desktop Node.js/Electron apps.

_**EOF**_
