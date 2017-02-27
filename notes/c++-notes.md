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


## References

* [Containers library @ cppreference.com](http://en.cppreference.com/w/cpp/container)

  Includes a nice "member function table" for quick look-up of available methods
  per container -- as well as C++11 additions.


## e/Books

* [Optimizing C++ (Wikibooks.org)](https://en.wikibooks.org/wiki/Optimizing_C%2B%2B)

### Misc.

* <https://conan.io/> sort of a C/C++ package manager, free for open source.
#### Parsing C++

Is not a trivial task at all, many have tried.

* [Parsing C++ (March 2001, Andrew Birkett)](http://www.nobugs.org/developer/parsingcpp/)

__EOF__
