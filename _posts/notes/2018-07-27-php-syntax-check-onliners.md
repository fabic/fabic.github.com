---
layout: note
title: "PHP: find \*.php run `php -l` syntax check"
tagline: "Another Git onliner..."
published: true
category : notes
tags : [note]
---

```bash
$ while read pp; do php -l $pp ; done < <( git ls-files \*.php )
```

```bash
$ while read pp; do php -l $pp ; done < \
    <( find -regextype egrep \
         \( -type d \( -regex './(.*/?\..+|vendor|node_modules|tmp|storage|public)$' \) -prune \) \
         -o -type f -not -name \*.blade.php -name \*.php )
```

__eof__
