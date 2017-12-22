---
layout: page
title: "LLVM/Clang API pointers"
description: "API documentation pointers, diagrams, notes."
tags: [wide, draft, C++, Clang]
published: false
---

* __[clang.llvm.org/doxygen/](http://clang.llvm.org/doxygen/index.html)
  &ndash; API doc.__
* [clang.llvm.org/docs/IntroductionToTheClangAST.html](https://clang.llvm.org/docs/IntroductionToTheClangAST.html)
* [clang.llvm.org/docs/ClangPlugins.html](https://clang.llvm.org/docs/ClangPlugins.html)
* ~~<https://github.com/fabic/llvm-clang>~~
* <https://railsware.com/blog/2014/02/28/creation-and-using-clang-plugin-with-xcode/>

## Pointers

### [ASTContext](http://clang.llvm.org/doxygen/classclang_1_1ASTContext.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1ASTContext__coll__graph.png" />

### [Type](http://clang.llvm.org/doxygen/classclang_1_1Type.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1Type__inherit__graph.png" />

See also [TypeSourceInfo][TSI] that we typically obtain from __[Decl/s][Decl]__

### [Decl][Decl]

  <img src="http://clang.llvm.org/doxygen/classclang_1_1Decl__inherit__graph.png" />

#### [DeclContext](http://clang.llvm.org/doxygen/classclang_1_1DeclContext.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1DeclContext__inherit__graph.png" />

##### [FunctionDecl](http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl.html)


  <img src="http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl__inherit__graph.png" />

* <tt>[QualType](http://clang.llvm.org/doxygen/classclang_1_1QualType.html) [getReturnType()](http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl.html#a2935d37297596c57aa383de101a55030)</tt>
* `SourceRange  getReturnTypeSourceRange () const`


[TSI]: http://clang.llvm.org/doxygen/classclang_1_1TypeSourceInfo.html "clang::TypeSourceInfo [Decl.h]"
[Decl]: http://clang.llvm.org/doxygen/classclang_1_1Decl.html "clang::Decl"
