---
layout: note
title: "C/C++: dump includes dependency command"
tagline: ""
category : notes
published: true
tags : [note, C/C++, cli]
---

Nice command for dumping out the `#include <...>` dependency graph for a given
header; found at [building Neovim](https://github.com/neovim/neovim/wiki/Building-Neovim) :

```bash
echo '#include "./src/nvim/buffer.h"' \
  | clang -I.deps/usr/include -Isrc -std=c99 -P -E -H - 2>&1 >/dev/null \
  | grep -v /usr/
```

Wrapped up in that command of yours:
[dump-headers-include-depgraph.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/dump-headers-include-depgraph.sh)
