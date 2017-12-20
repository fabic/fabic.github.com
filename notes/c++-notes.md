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

### Idioms, tips'n'tricks

#### Assertions

    assert(1 == 2 && "Dude, this ain't no good, like not at all.");

##### static_assert()

* `decltype()` & `std::is_same<X, Y>`
    - Defensive programming in presence of `auto ...`, for ex. :

          for(const auto& row : rset) {
            static_assert( std::is_same<decltype(row), pqxx::row const&>::value,
              "PQXX: (!!) we're expecting pqxx::row& from result sets.");
              ...
              ...
          }

#### Compile-time polymorphism

LLVM/Clang has a nice example of compile-time polymorphism whereby no dynamic dispatch occurs at runtime.  The wiring is achieved upon compilation.

    class PimplIOVisitor :
            public RecursiveASTVisitor< PimplIOVisitor > {

      Derived &getDerived() { return *static_cast<Derived *>(this); }

      ...
      ...
    };

#### do { ... } while(false)

Seen that a few times: a `do { ... } while( false );` that wraps some code. What is it usefull for ?

* it does some sort of lexical scoping.
* names shadowing (e.g. defined variables at the parent lexical scope): one may redefine a variable with the same name (and any different type).
* automatic destruction of stuff ?

This one example is from LLVM/Clang's `RecursiveASTVisitor< Derived >` :

    // A helper macro to implement short-circuiting when recursing.  It
    // invokes CALL_EXPR, which must be a method call, on the derived
    // object (s.t. a user of RecursiveASTVisitor can override the method
    // in CALL_EXPR).
    #define TRY_TO(CALL_EXPR)       \
    do {                            \
      if (!getDerived().CALL_EXPR)  \
        return false;               \
    } while (false)
    // Note:       ^ No trailing ';'

#### Preprocessor

    // This macro makes available a variable D, the passed-in decl.
    #define DEF_TRAVERSE_DECL(DECL, CODE)                              \
      template <typename Derived>                                      \
      bool RecursiveASTVisitor<Derived>::Traverse##DECL(DECL *D) {     \
        bool ShouldVisitChildren = true;                               \
        bool ReturnValue = true;                                       \
        if (!getDerived().shouldTraversePostOrder())                   \
          TRY_TO(WalkUpFrom##DECL(D));                                 \
        { CODE; }                                                      \
        if (ReturnValue && ShouldVisitChildren)                        \
          TRY_TO(TraverseDeclContextHelper(dyn_cast<DeclContext>(D))); \
        if (ReturnValue && getDerived().shouldTraversePostOrder())     \
          TRY_TO(WalkUpFrom##DECL(D));                                 \
        return ReturnValue;                                            \
      }

    DEF_TRAVERSE_DECL(EmptyDecl, {})
    DEF_TRAVERSE_DECL(AnotherEmptyDecl, { /* No code here. */ })

    DEF_TRAVERSE_DECL(LabelDecl, {// There is no code in a LabelDecl.
                                 })

    DEF_TRAVERSE_DECL(StaticAssertDecl, {
      TRY_TO(TraverseStmt(D->getAssertExpr()));
      TRY_TO(TraverseStmt(D->getMessage()));
    })

    DEF_TRAVERSE_DECL(
        TranslationUnitDecl,
        {// Code in an unnamed namespace shows up automatically in
         // decls_begin()/decls_end().  Thus we don't need to recurse on
         // D->getAnonymousNamespace().
        })




#### Elements of taste and style

* Popular coding styles out there : Google, LLVM, LLDB, etc.
    - Clang-format ?

* Constness :
    - `pqxx::row const &` vs `const pqxx::row &` ?
    - `try {...} catch (const std::exception &e) { ... }`
    vs `try {...} catch (std::exception const &e) { ... }` ?

__EOF__
