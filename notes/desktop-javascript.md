---
layout: default
title: "JavaScript desktop - notes"
tagline: "About Electron, NW.js"
category : notes
tags : [draft]
published: false
---

* [Electron - electronjs.org](https://electronjs.org/)
* [NW.js - nwjs.io](https://nwjs.io/)
    - [gitter.im](https://gitter.im) has a [Gitter desktop client](https://gitlab.com/gitlab-org/gitter/desktop/)
        - [Github (old repo.)](https://github.com/gitterHQ/desktop])
        - [Arch (AUR)](https://aur.archlinux.org/packages/gitter/)

* [Practical Node.js (online book)](https://github.com/azat-co/practicalnode)
* [What the f\*ck JavaScript? (denysdovhan/wtfjs)](https://github.com/denysdovhan/wtfjs>
* <https://github.com/ragmha/practical-js>

## ExpressJS

* [expressjs.com](https://expressjs.com)

### Project setup

[From](https://expressjs.com/en/starter/installing.html) :

```bash
$ mkcd express-01
$ npm init
$ npm install express --save
```

#### Most basic hello world example

[From](https://expressjs.com/en/starter/hello-world.html) :

```bash
$ cat >> index.js <<EOF
const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(3000, () => console.log('Example app listening on port 3000!'))
EOF
```

#### Basic setup with React express view.

<https://github.com/reactjs/express-react-views>

```bash
$ express --view twig --css sass
```

todo...

#### Basic setup with Vue.js

<https://github.com/express-vue/express-vue>

#### React

* <https://github.com/Bogdan-Lyashenko/Under-the-hood-ReactJS>
* <https://github.com/react-boilerplate/react-boilerplate>

#### Feathers.js

* <https://github.com/feathersjs/awesome-feathersjs> resources.

#### Vue.js

* <https://madewithvuejs.com/>
* <https://madewithvuejs.com/express-vue>
    - <https://madewithvuejs.com/go/express-vue>
* <https://medium.com/@krunallathiya/vuejs-nodejs-tutorial-example-from-scratch-5a8ba947fa22>

```bash
$ npm install -g vue-cli
```

```bash
$ vue init webpack vuejs-01
```

```
? Project name vuejs-01
? Project description fabic.net Vue.js experiments (01)
? Author Fabien Cadet <fabi@winterfell.fabic.net>
? Vue build standalone
? Install vue-router? Yes
? Use ESLint to lint your code? Yes
? Pick an ESLint preset Standard
? Set up unit tests Yes
```


### Compilers & static types.

* <https://babeljs.io/>

#### Static (compile-time) type checking

* <https://flow.org> (facebook's)
* <https://www.typescriptlang.org/> (microsoft)

### Other (todo)

* webpack, browserify

__EOF__
