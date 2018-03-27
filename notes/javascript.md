---
layout: page
title: "JavaScript - notes"
tagline: "About Electron, NW.js"
category : notes
tags : [draft, wide]
published: false
---

* [Electron - electronjs.org](https://electronjs.org/)
* [NW.js - nwjs.io](https://nwjs.io/)
    - [gitter.im](https://gitter.im) has a [Gitter desktop client](https://gitlab.com/gitlab-org/gitter/desktop/)
        - [Github (old repo.)](https://github.com/gitterHQ/desktop])
        - [Arch (AUR)](https://aur.archlinux.org/packages/gitter/)

* [Practical Node.js (online book)](https://github.com/azat-co/practicalnode)
* [What the f\*ck JavaScript? (denysdovhan/wtfjs)](https://github.com/denysdovhan/wtfjs)
* <https://github.com/ragmha/practical-js>

## Language notes

* `Array.prototype.push.apply(dest, [1,2,3])...` : For appending elements to an
existing array.  See also `concat()`.  Or use the new spread op. `dest.push(...src)`

* `Array.from(iterator, (x) => x+1))`

* `new Map( Array.from(iter, (e) => [ e.foo, e.bar ]) )`. It's not "easy" though
  to obtain an object from a map, have to to sthg like :

    ```javascript
    const obj = {}
    map.forEach((v,k) => { obj[k] = v })
    ```

### Promises

##### async-await lambda IIFE


```javascript
(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://example.com');
  await page.screenshot({path: 'example.png'});
  await browser.close();
})();
```

#### Promise.all([])

...

## Client-side

* `document.querySelectorAll("a.nav[rel=next][href^='http://example.com/abc/']")`

## Node.js

* <https://nodejs.org/api/modules.html>
* <https://github.com/babel/example-node-server> (must-read)

## ExpressJS

* [expressjs.com](https://expressjs.com)
* <http://forbeslindesay.github.io/express-route-tester/>

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
* <https://github.com/vuejs/vue-devtools> [Chrome ext.](https://chrome.google.com/webstore/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd)
* <https://github.com/vuejs/vuex/tree/dev/examples>

* [vue-cli](https://github.com/vuejs/vue-cli)
* [webpack template](https://vuejs-templates.github.io/webpack/)
* [Demistifying Vue's Webpack Config](https://alligator.io/vuejs/demistifying-vue-webpack/) (__must read__).

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

* __TODO:__ <https://github.com/vuejs/vue-cli#customizing-webpack-config>

[Lifecycle diagram
![](https://vuejs.org/images/lifecycle.png "COPY: /assets/vuejs-instance-lifecycle.png")
](https://vuejs.org/v2/guide/instance.html#Lifecycle-Diagram)


### Compilers & static types.

* <https://babeljs.io/>

#### Static (compile-time) type checking

* <https://flow.org> (facebook's)
* <https://www.typescriptlang.org/> (microsoft)

### Webpack

* [2017: Setting Up Webpack for Bootstrap 4 and Font Awesome](https://medium.com/@estherfalayi/setting-up-webpack-for-bootstrap-4-and-font-awesome-eb276e04aaeb)

#### Setup

* <https://github.com/postcss/autoprefixer>

### Other (todo)

* webpack, browserify
* <https://github.com/chimurai/http-proxy-middleware>

## Node.js packages

* <https://www.npmjs.com/package/bin-wrapper>

### Other

* <https://github.com/devongovett/node-wkhtmltopdf>

## Deployment

* [Process managers for Express apps @ Expressjs.com](https://expressjs.com/en/advanced/pm.html)

[install-nodejs-latest.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/setup/install-nodejs-latest.sh)

todo: setup paths

Install GCC/G++ so that NPM can build stuff :

```bash
sudo apt-get install g++
```

Using [StrongLoop's Process Manager](http://strong-pm.io/) :

```bash
npm install -g strongloop
```

* todo: [trust proxy ?](https://expressjs.com/en/guide/behind-proxies.html)

## Articles

* <https://www.html5rocks.com/en/tutorials/developertools/sourcemaps/>

__EOF__
