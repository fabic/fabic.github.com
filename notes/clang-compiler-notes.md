---
layout: page
title: "LLVM/Clang playground"
description: "Scattered side-notes as I'm wandering through Clang internals."
published: false
---

<https://github.com/fabic/llvm-clang>

* 2017-02-11 ...

- - -

_**2014-09-23:**_ /me investigating _how things happen_ so as to obtain an AST.


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
