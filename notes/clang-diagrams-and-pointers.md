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

<table class="fs-smaller pre">
  <thead>
    <tr>
      <th>ASTContext</th>
      <th>Decl</th>
      <th>Type</th>
      <th>&ndash;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>QualType getTagDeclType (const TagDecl *Decl) const</td>
      <td>TagDecl</td>
      <td>TagDecl * getAsTagDecl () const</td>
      <td></td>
    </tr>
    <tr>
      <td>QualType getTypeDeclType (
      const TypeDecl *Decl,
      const TypeDecl *PrevDecl=nullptr) const</td>
      <td>TypeDecl</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>
        template&lt; typename T &gt;<br>const T * Type::getAs&lt;T&gt;() const
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>CXXRecordDecl * getAsCXXRecordDecl () const</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>const CXXRecordDecl * getPointeeCXXRecordDecl () const</td>
      <td></td>
    </tr>
    <!--
    <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    -->
  </tbody>
</table>


## Pointers

### [ASTContext](http://clang.llvm.org/doxygen/classclang_1_1ASTContext.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1ASTContext__coll__graph.png" />

### [Type](http://clang.llvm.org/doxygen/classclang_1_1Type.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1Type__inherit__graph.png" />

See also [TypeSourceInfo][TSI] that we typically obtain from __[Decl/s][Decl]__

### [Decl][Decl]

  <img src="http://clang.llvm.org/doxygen/classclang_1_1Decl__inherit__graph.png" />

### [NamedDecl][NamedDecl]

  <img src="http://clang.llvm.org/doxygen/classclang_1_1NamedDecl.html" />

### [TypeDecl][TypeDecl]

  <img src="http://clang.llvm.org/doxygen/classclang_1_1TypeDecl__inherit__graph.png" />

### [ValueDecl][ValueDecl]

  <img src="http://clang.llvm.org/doxygen/classclang_1_1ValueDecl__inherit__graph.png" />

#### [DeclContext](http://clang.llvm.org/doxygen/classclang_1_1DeclContext.html)

  <img src="http://clang.llvm.org/doxygen/classclang_1_1DeclContext__inherit__graph.png" />

##### [FunctionDecl](http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl.html)


  <img src="http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl__inherit__graph.png" />

* <tt>[QualType](http://clang.llvm.org/doxygen/classclang_1_1QualType.html) [getReturnType()](http://clang.llvm.org/doxygen/classclang_1_1FunctionDecl.html#a2935d37297596c57aa383de101a55030)</tt>
* `SourceRange  getReturnTypeSourceRange () const`


[TSI]: http://clang.llvm.org/doxygen/classclang_1_1TypeSourceInfo.html "TypeSourceInfo [Decl.h]"
[Decl]: http://clang.llvm.org/doxygen/classclang_1_1Decl.html "Decl"
[NamedDecl]: http://clang.llvm.org/doxygen/classclang_1_1NamedDecl.html "NamedDecl < Decl"
[TypeDecl]: http://clang.llvm.org/doxygen/classclang_1_1TypeDecl.html "TypeDecl < NamedDecl < Decl"
[ValueDecl]: http://clang.llvm.org/doxygen/classclang_1_1ValueDecl.html "ValueDecl < NamedDecl < Decl"
