---
layout: page
title: "LLVM/Clang playground"
description: "Scattered side-notes as I'm wandering through Clang internals."
published: false
---

* __[clang.llvm.org/doxygen/](http://clang.llvm.org/doxygen/index.html)
  &ndash; API doc.__
* [clang.llvm.org/docs/ClangPlugins.html](https://clang.llvm.org/docs/ClangPlugins.html)
* [clang.llvm.org/docs/IntroductionToTheClangAST.html](https://clang.llvm.org/docs/IntroductionToTheClangAST.html)
* <https://github.com/fabic/llvm-clang>
* <https://railsware.com/blog/2014/02/28/creation-and-using-clang-plugin-with-xcode/>

* 2017-02-11 ...
* 2017-12-21 : `TypePrinter.cpp` has no `.h`, for the `TypePrinter` class I needed.

- - -

_**2014-09-23:**_ /me investigating _how things happen_ so as to obtain an AST.

### Some compile options

    add_compile_options(
      -std=c++1z
      -stdlib=libc++

      -Os
      -Oz # Clang "better" than -Os (?)

      -Wall
      -pedantic

      # -Weverything
      #   ^ http://clang.llvm.org/docs/UsersManual.html#enabling-all-diagnostics
      #   ^ too verbose: others code...

      -Wcovered-switch-default
      # ^ we get too many warnings from external headers.

      -Wmissing-field-initializers
      -Wnon-virtual-dtor
      -Wdelete-non-virtual-dtor
      -Woverloaded-virtual
      -Wno-nested-anon-types

      # -Wwrite-strings
      # -Wcast-qual

      # -fvisibility-inlines-hidden

      -fcolor-diagnostics
      -fdiagnostics-show-category=name
      -fdiagnostics-show-template-tree
      # ^ http://clang.llvm.org/docs/UsersManual.html#formatting-of-diagnostics

      # -fwhole-program-vtables
      #   ^ http://clang.llvm.org/docs/UsersManual.html#cmdoption-fwhole-program-vtables

      # So as to get better/meaninful stack traces in error messages :
      -fno-omit-frame-pointer

      # and disable tail call elimination
      -fno-optimize-sibling-calls

      Wl,-allow-shlib-undefined

      -nostdinc -nostdinc++

      #-Wdocumentation
      #-fparse-all-comments
      #-Wno-documentation-unknown-command
      # ^ http://clang.llvm.org/docs/UsersManual.html#comment-parsing-options
      )

Sanitizers :

    add_compile_options(
      # -fsanitize=address     # http://clang.llvm.org/docs/AddressSanitizer.html
      # ^ -fsanitize=memory
      # ^ -fsanitize=thread
      #   “ It is not possible to combine more than one of the
      #     -fsanitize=address, -fsanitize=thread, and -fsanitize=memory
      #     checkers in the same program. ”
      #     http://clang.llvm.org/docs/UsersManual.html#controlling-code-generation
      # -fsanitize=undefined   # http://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html
      # -fsanitize=dataflow    # http://clang.llvm.org/docs/DataFlowSanitizer.html
      # -fsanitize=cfi -flto   # http://clang.llvm.org/docs/ControlFlowIntegrity.html (requries -flto)
      # -fsanitize=safe-stack  # http://clang.llvm.org/docs/SafeStack.html
      )

Linker :

      -Wl,--warn-unresolved-symbols

### clang/include/clang/Sema/Sema.h

    1546
    2251 AddFunctionCandidates
    2453 Name lookup

### ParseDecl.cpp

    1401 bool Parser::MightBeDeclarator(unsigned Context) {

    2036 bool Parser::ParseImplicitInt(DeclSpec &DS, CXXScopeSpec *SS,
                                  const ParsedTemplateInfo &TemplateInfo,
                                  AccessSpecifier AS, DeclSpecContext DSC,
                                  ParsedAttributesWithRange &Attrs) {

### clang/include/clang/Sema/Lookup.h : class LookupResult


### clang/include/clang/AST/ASTContext.h

* L416 : IdentifierTable & Idents;
  [apidoc](http://clang.llvm.org/doxygen/classclang_1_1ASTContext.html#a4f95adb9958e22fbe55212ae6482feb4)
  [IntroductionToTheClangAST](http://clang.llvm.org/docs/IntroductionToTheClangAST.html#ast-context)


Sema.h
Parser.h  ParseDecl & ParceDeclCXX
Tooling.cpp
ExecuteCompilerInvocation
ASTContext
FrontendAction & FrontendActions
ParseAST.cpp
Parser.cpp
Lookup.h


* `main()` : clang/tools/driver/driver.cpp
  - `cc1_main()` : [cc1_main.cpp](clang/tools/driver/cc1_main.cpp)
  - `cc1as_main()` : [cc1as_main.cpp](clang/tools/driver/cc1as_main.cpp)

* [clang::driver::Driver][http://clang.llvm.org/doxygen/classclang_1_1driver_1_1Driver.html]
  - `Compilation *BuildCompilation(ArrayRef<const char *> Args);`
    * `^ clang::driver::Compilation` is built with a new `clang::driver::ToolChain`
