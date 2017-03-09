---
layout: page
title: "Draft - dumbster – the dumb parser"
tagline: "Dumbster: very simple source code parser with no semantical analysis."
category : notes
tags : [draft, build, tool, parser]
---

## Brainstorming

It takes about 20 seconds to read all sources files of the LLVM/Clang project and
dump these into a single file :

    time \
      bin/findsources.sh \
        llvm-clang/{clang,llvm,lld,lldb,libcxx,libcxxabi,compiler-rt,clang-tools-extra,test-suite} -- -print0 \
          | xargs -0 cat > tutu.txt

And the result weights ~200 MB :

    $ ls -lh tutu.txt
    -rw-rw-r-- 1 fabi fabi 204M Mar  1 13:08 tutu.txt

So it's okey to proceed with this “simple build tool” idea, probably...

For my whole [llvm-clang playground](https://github.com/fabic/llvm-clang)
with many (58) checked-out Git submodules it takes about ~5 minutes :

    ~/dev/llvm-clang $ time bin/findsources.sh . -- -print0 | xargs -0 cat > tutu.txt

    real    4m48.116s
    user    0m13.597s
    sys     0m43.977s

Generating a 2.4 GB file :

    ~/dev/llvm-clang $ lh tutu.txt
    -rw-rw-r-- 1 fabi fabi 2.4G Mar  2 13:12 tutu.txt

The Gentoo Portage tree has about 500 packages under `dev-libs`.

A checked-out tree of Musl-libc occupies ~12 MB on disk, stripping it down to
just the sources (concattenating all the files) yields a ~3 MB plain-text file
– 0.6 MB compressed.

So we may expect that 500 packages would take at the very least 1.5 GB,
and up to possibly ~5 GB with their Git history and all the rest of it.

### Server thing

* The Gentoo Portage tree has roughly 27 000 packages.
* Something similar _already exists_ :
    - <https://github.com/woboq/woboq_codebrowser/> – for C++, uses Clang, advertises
      only a couple of libs – open-source.
    - <https://sourcegraph.com/pricing> – paid service, free for open-source, only
      supports a few "web" languages at the moment.
    - <http://lxr.linux.no/> – hasn't been updated since 2013 ? – targets at the
      Linux kernel.
    - <http://lxr.free-electrons.com/> – Linux Cross-Reference thing – kernel only.
    - <http://rprichard.github.io/sourceweb/>
    - <https://github.com/mozilla/dxr>
* See [Funtoo Containers hosting](http://www.funtoo.org/Funtoo_Containers)
* Well, they did it @ [CodeSynthesis](http://www.codesynthesis.com/) :
    - The build tool [build2.org](https://build2.org/)
    - The online repository [cppget.org](https://cppget.org/)
      [Git repo.](https://git.build2.org/cgit/)

## Thinking...

* Given a source tree, let's consider that _“everything is a library, to some extent”_ :
    - a single translation unit, ex. `$CXX -c src/lexer/main.cc -o lexer.o`
    - multiple translation units that are composed together so as to produce
      a _single_ object file, ex.
      `$CXX  -c src/lexer/lexer-core.cc src/lexer/lexer-tokens.c  -o lexer.o`
    - or multiple object files from a given subdir. `src/lexer/` that _conceptually_
      form a sub-library fragment, and end-up being linked later on as part of
      a shared or static library, ex. `libdumbster-parser.so/a`.
      This is the common approach until today where we do lose some information
      about how _sub-systems_ are built and composed together to form a library :
      we can't easily tell precisely what depends on what.  For example a `src/parser/`
      sub-system depends upon a `src/lexer` sub-system, _but_ the later one _may_
      be freestanding, at least conceptually.


## Have to...

* Locate all source files from a given directory.
* For each file :
    - Read the whole file into memory (or `mmap()`) ;
    - Parse the code ⇒ have an abstract syntax tree (AST) ;
    - Walk the AST in search for comments left upon artifacts of interests :
        - top-level file comment (and footer [?])
        - comments at global “anonymous” scope
        - comments at namespace scopes
        - comments _of_ a given namespace
        - comments found on "free functions" (those that aren't attached to structs/classes),
        - comments found on classes/structs (but _not_ the inner classes,
          nor ad-hoc structs one would find into function definitions).
    - For each comment :
        - Extract the textual content (removing leadin `*` and adhering to `\`
          line continuations).
        - Find out if the comment provides `! ...` prefixed ~~compilation~~
          __build directives__, like ex. `! executable dumbster`

### Examples / use cases

{% highlight c++ %}
/**
! executable: dumbster PIE W:no-main
! may library: libdumbster
! needs header : boostcpp/..
! link against library/ies: libnstd libstdc++ (or libc++)
! link prepend object : crti.o  !first!
! link prepend object : crtbegin.o  !if c++ filetype!
! link prepend object : crtend.o    !if c++ filetype!
! link append object  : crti.o  !last!
*/
int main(int argc, const char *argv[], const char *envp[])
{
  // ...
}
{% endhighlight %}

## Have... (ideas / features)

* /me needs a text mode documentation browser, /me no wants no web stuff.
    - have “man page”-like text mode rendering of all sorts of documentations
      out there, e.g. Boost C++, cppreference.






__EOF__
