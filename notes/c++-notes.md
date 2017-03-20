---
layout: page
title: "C++ notes for self"
description: "Scattered notes about C/C++ stuff."
published: false
---

## Articles out there

* [2012: Why should I have written ZeroMQ in C, not C++ (part I) – Martin Sústrik](http://250bpm.com/blog:4)


## FYI

* [Removing Deprecated Exception Specifications from C++17 (2015-09-28)](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0003r0.html#1.0)
  — `throw(some_excetion_type)` may no longer appear as part of a function
  prototype. — it is "replaced" by `noexcept`
  – <http://stackoverflow.com/a/13841791/643087>
  – <http://en.cppreference.com/w/cpp/language/except_spec>

## Concepts thing

* [CopyConstructible](http://www.boost.org/doc/libs/1_63_0/doc/html/CopyConstructible.html)

## References

* [Containers library @ cppreference.com](http://en.cppreference.com/w/cpp/container)

  Includes a nice "member function table" for quick look-up of available methods
  per container -- as well as C++11 additions.

* [High Integrity C++ Coding Standard](http://www.codingstandard.com/)

### Exception handling

* <https://mentorembedded.github.io/cxx-abi/abi-eh.html>
* <https://itanium-cxx-abi.github.io/cxx-abi/>
* <http://llvm.org/docs/ExceptionHandling.html>
* [§10.6 Exception frames (§10 Object format – Core specification, Generic part – LSB 5.0.0)](http://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/ehframechpt.html)
* <http://mentorembedded.github.io/cxx-abi/exceptions.pdf>
* <https://monoinfinito.wordpress.com/series/exception-handling-in-c/>
* <http://stackoverflow.com/questions/490773/how-is-the-c-exception-handling-runtime-implemented>
* [2002: How a C++ compiler implements exception handling (by Vishal Kochhar)](https://www.codeproject.com/Articles/2126/How-a-C-compiler-implements-exception-handling)
* [GH: CPTI/Exception](https://github.com/CPTI/Exception)
* [Beware Of Exceptions In The Destructor (c2)](http://wiki.c2.com/?BewareOfExceptionsInTheDestructor)
* <http://www.logix.cz/michal/devel/gas-cfi/>
* [](http://softwareengineering.stackexchange.com/questions/113479/are-there-any-real-world-cases-for-c-without-exceptions)
* [2011: Why are exception specifications bad? – stackexchange](http://softwareengineering.stackexchange.com/questions/114338/why-are-exception-specifications-bad?rq=1)

## e/Books

* [Optimizing C++ (Wikibooks.org)](https://en.wikibooks.org/wiki/Optimizing_C%2B%2B)

### Misc.

* <https://conan.io/> sort of a C/C++ package manager, free for open source.
* [C! – cbang](https://github.com/CauldronDevelopmentLLC/cbang) utility lib.
* [paper – Exceptional Kernel – Using C++ exceptions in the Linux kernel (Halldór Ísak Gylfason, Gísli Hjálmtýsson)](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.100.7504&rep=rep1&type=pdf)
* [International Obfuscated C Code Contest ^^](https://en.wikipedia.org/wiki/International_Obfuscated_C_Code_Contest)

### ...

* Automatic storage duration ⇒ scoped stuff, typically constructed on the stack...

#### Parsing C++

Is not a trivial task at all, many have tried.

* [Parsing C++ (March 2001, Andrew Birkett)](http://www.nobugs.org/developer/parsingcpp/)

## Type info. – refection

* [GH: maxdebayser/SelfPortrait](https://github.com/maxdebayser/SelfPortrait)
  – uses Clang at some point, see [parser.cpp](https://github.com/maxdebayser/SelfPortrait/tree/master/src/parser)

## Personal notes, thougths, remarks

* The main problem that impairs programming is probably that I have to deal with
  types :
    - First I have to know that a type exists ⇒ so I have to search for it.
    - Then I have to know the usage semantics :
        * and specifically the _storage abilities_
          (ex. `enable_shared_from_this<>` sub-types shall be heap-allocated).
        * whether it is _embeddable_ without troubles ;
        * or if it may be handled by _containers_ (read copy/move semantics).
    - And the either the data structure members (for `struct`-s), or simply the public
  interface

## Quotes

* “Don't forget that C++ is an imperative language with state
   and explicit flow-control [...]”
  [stackoverflow](http://stackoverflow.com/a/490884/643087)

__EOF__
