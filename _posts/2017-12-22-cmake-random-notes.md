---
layout: post
title: "CMake: Some notes as I discover how to deal with it."
tagline: "CMake... oh my!"
category : notes
published: true
tags : [C++, CMake, howto]
---

_Some notes about how to setup CMake projects._

* **2017-12 :** I'm rediscovering all this, again; please consider the information here with skepticism.

### Running CMake

The simplest usage would be something like :

    $ mkdir build/ &&
      cd build/ &&
      cmake ../ &&
      cmake --build build/ --target simplest-example

Big one-liner where we also wipe out the `build/` sub-directory :

    $ ( [ -d build ] && rm -r build || true ) &&
        ( mkdir build && cd build &&
          CC=clang CXX=clang++ \
            cmake -G Ninja \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DCMAKE_INSTALL_PREFIX=~/local ../
        ) &&
             cmake --build build --target simplest-example


### Dump all CMake variables

    function(dude_please_dump_cmake_variables)

      get_cmake_property(_variableNames VARIABLES)

      foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName} = ${${_variableName}}")
      endforeach()

    endfunction()

Found that at [SO](http://stackoverflow.com/questions/9298278/cmake-print-out-all-accessible-variables-in-a-script).

#### Dump all variables that match a regular expression

    function(dump_cmake_variables_matching regex)
      get_cmake_property(varnames VARIABLES)
      foreach (vname ${varnames})
        if ("${vname}" MATCHES "${regex}")
          message(STATUS "${vname} = ${${vname}}")
        endif()
      endforeach()
    endfunction()

##### Example: finding out variables of interest produced by pkg_check_modules().

    ## CMakeLists.txt

    # Postgresql libpqxx
    find_package( PkgConfig )
    pkg_check_modules( LIBPQXX libpqxx )
    if (NOT LIBPQXX_FOUND)
      message( WARNING "Dude: Couldn't Postgresql libpqxx." )
    endif()

    dump_cmake_variables_matching(".*PQXX.*")

Would dump those variables that were set by `pkg_check_modules(...)`, of which :

    LIBPQXX_CFLAGS =
    LIBPQXX_FOUND = 1
    LIBPQXX_INCLUDE_DIRS =
    LIBPQXX_LDFLAGS = -lpqxx
    LIBPQXX_LIBDIR = /usr/lib
    LIBPQXX_LIBRARIES = pqxx

And configuring a CMake target :

    if (NOT LIBPQXX_FOUND)
      message( WARNING "Dude: Couldn't find Postgresql libpqxx." )
    else()
      message( STATUS "Dude: Found Postgresql libpqxx." )
      target_compile_options(     pimplio PUBLIC ${LIBPQXX_CFLAGS} )
      target_include_directories( pimplio PUBLIC ${LIBPQXX_INCLUDE_DIRS} )
      target_link_libraries(      pimplio        ${LIBPQXX_LIBRARIES} )
    endif()

### add_executable()

    add_executable(soci-mysql-example-01 soci-mysql-example-01.cpp)


### Test if a file or directory exists

    if (NOT EXISTS ...)
    endif()

    if (NOT IS_DIRECTORY ${SOCI_SOURCES_DIR}/src)
      message( WARNING "Dude: Could not find SOCI sources at ${SOCI_SOURCES_DIR}" )
    endif()


### How to add a new sub-directory ?

__In short,__ just create the subdirectory and :

* drop an empty `CMakeLists.txt` file in it ;
* __either__ append a `add_subdirectory( src/new-subdir )` to the top-level project's `CMakeLists.txt` ;
* __or__, if applicable, edit the "_parent"_ `CMakeLists.txt` file one directory up,
for ex. `src/`.
* __Done:__ that's all it takes.
* Then you may proceed with the usual directives :
    - __add_executable()__
    - etc...

Copy-paste "one-liner" (remove the trailing blankees `_`):

    cat <<EOF  >>  CMakeLists.txt__

    add_executable( exe-bin-name
      exe-bin-main.cpp
      exe-bin-util.cpp
      )

    target_compile_options( exe-bin-name
      PUBLIC
        -std=c++1z
        -Wall -pedantic
        -Wmissing-field-initializers -Wnon-virtual-dtor
        -Wdelete-non-virtual-dtor    -Woverloaded-virtual
      )

    target_include_directories( exe-bin-name
      PUBLIC
        ${XCB_INCLUDE_DIRS}
        ${XCB_AUX_INCLUDE_DIRS}
        ${CAIRO_XCB_INCLUDE_DIRS}
      )

    target_link_libraries( exe-bin-name
        ${Boost_LIBRARIES}
        ${XCB_LIBRARIES}
        ${XCB_AUX_LIBRARIES}
        ${CAIRO_XCB_LIBRARIES}
      )

    option( DUDE_TURN_ME_ON
      "Dude, please turn this option ON for Knuth's sake (!)" OFF )

    if (DUDE_TURN_ME_ON)
      message( WARNING "Dude: You should not have enabled this feature, really." )
      add_executable( magic-bin magic-bin.cpp )
    endif()

    if (NOT DUDE_TURN_ME_ON)
      add_subdirectory( tests )
    fi

    # EOF message.
    message(STATUS "Dude: This is a communication from ${CMAKE_CURRENT_LIST_FILE}")
  EOF

### List sub-directories (loop over these and do stuff)

__Or:__ how to list "direct" sub-directories for automated addition to CMake project ([via](https://stackoverflow.com/a/7788165/643087)).

Basically we have `file(GLOB files_list ... RELATIVE ... )` which output value (here `files_list`) we'll filter out files from dirs
([file()](https://cmake.org/cmake/help/latest/command/file.html)])

    file(GLOB files_list
      RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
               ${CMAKE_CURRENT_SOURCE_DIR}/*)

We may want to collect sub-directory names in a variable `subdirs_list` :

    set(subdirs_list "")

Loop over the `files_list`, acting upon directories which contain a `CMakeLists.txt` file :

    foreach(subdir ${files_list})
      if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${subdir}/CMakeLists.txt)

        add_subdirectory( ${subdir} )
        message(STATUS "Dude: Added experiment ${subdir}")
        list(APPEND subdirs_list "${subdir}")

      elseif(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${subdir})

        message(STATUS "Dude: Skipping ${subdir}/ as it contains no CMakeLists.txt (FYI)")

      endif()
    endforeach()

The `subdirs_list` was indeed set :

    message(STATUS "Dude: Experiments list: ${subdirs_list}")

Futile :

    unset(files_list)
    unset(subdirs_list)


#### Adding a CMake-based third-party code as a sub-project

Say we'll manage a few of our project dependencies by means of Git submodule, for ex. :

    git submodule add git@... vendor/sub-project

Then if the sub-project is "properly" configured, a simple
`add_subdirectory( vendor/sub-project )` may be enough.

__But (!)__ ... stating dependencies ? (TODO)


### find_library() & find_file() : Manual library search & setup

* `CMAKE_INCLUDE_PATH` is searched by __[find_file()]()__ ;
* `CMAKE_LIBRARY_PATH` is searched by __[find_library()]()__ ;

Given we install stuff into a `./local/` sub-directory (for ex. `./configure --prefix=$PWD/local` or `cmake -DCMAKE_INSTALL_PREFIX=$PWD/local`),
then we end up with an [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)-like sub-directory structure where we are interested
in the `local/include/` headers directory and `local/lib/` for static/shared
libraries (and maybe also `lib32/` and/or `lib64/`).

    # CMakeLists.txt
    if ( IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/local/include )
      message( STATUS "Dude: Found ./local/ FHS-like sub-directory." )

      list(APPEND CMAKE_INCLUDE_PATH "${CMAKE_SOURCE_DIR}/local/include")
      list(APPEND CMAKE_LIBRARY_PATH "${CMAKE_SOURCE_DIR}/local/lib")

      message( STATUS "Updated CMAKE_INCLUDE_PATH = ${CMAKE_INCLUDE_PATH}" )
      message( STATUS "Updated CMAKE_LIBRARY_PATH = ${CMAKE_LIBRARY_PATH}" )
    endif()

Then we may resort to `find_library()` and `find_file()`
for configuring our stuff :

      find_library( LibSociCore  libsoci_core.so
        HINTS
          ${CMAKE_CURRENT_SOURCE_DIR}/build/some/other/lib/dir
          ${CMAKE_SOURCE_DIR}/build/lib/wtf
        )

And for header files :

    find_file( LibSociMainHeaderFile soci/soci.h )

    # ^ this will effectivelly find a `soci.h` file
    #   into `./local/include/soci/soci.h`

* The optional __HINTS__ (or __PATHS__) may be followed by a list of additional
directories to search into.
* __Note that__ neither __find_library()__ nor __find_file()__ will traverse the search paths recursively (!) &ndash; which is often quite annoying, since the alternative is typically to resort to __[file()](https://cmake.org/cmake/help/latest/command/file.html)'s__ `GLOB` or `GLOB_RECURSE`.

Checking that something was found is also a bit awkward to say the least : if the file you're looking for could not be found, then __CMake__ will have the return variable (ex. `LibSociCore` have its value set to `"LibSociCore-NOTFOUND"` -\_-

Hence we end up doing tests like `if (LibSociCore MATCHES "-NOTFOUND$")` :

      if ( LibSociCore MATCHES "-NOTFOUND$" )
        message( ERROR "Dude: Could not find a couple of SOCI's shared libraries.")
        message( ERROR "      ` we won't build some stuff.")
      else()
        message( STATUS "Dude: Found `libsoci_core.so` at ${LibSociCore}")
        message( STATUS "Dude: Found `libsoci_mysql.so` at ${LibSociMysql}")

        # Remove the file base-name from the path
        get_filename_component( LibSociInclude "${LibSociMainHeaderFile}" DIRECTORY)

        include_directories(
            ${LibSociInclude}
            ${LibSociInclude}/mysql
          )

        add_executable( some-example-exe some-example-exe.cpp)
      endif()
    endif()

### "Importing" / linking against objects (\*.o)

It is possible to define targets that produce `.o` object files, and later on reference these from other targets definitions (e.g. libraries, executables) with `$<TARGET_OBJECTS:foo>`.

(__That is to say:__ your intent is to <u>not</u> have _“yet another small library target just for sharing binary code”_ ; and at the same time be able to speed up build-time by avoiding that several targets depend on the same __.cpp__ implementations).

The following would have `src/util/foo.cpp` be built twice, one for target __buzz__, the other for target __booz__ :

    add_library(buzz src/buzz_main.cpp src/util/foo.cpp)
    add_library(booz src/booz.cpp      src/util/foo.cpp)

One possible solution (_out of (?)_) is then to have __foo.cpp__ produce only one __foo.o__ object file during the whole build in this way &ndash; __(1) first__ define the __OBJECT__ targets :

    add_library( foo  OBJECT src/util/foo.cpp )
    add_library( bar  OBJECT src/other/bar.cpp )

__(2) Then__ one may have for ex. a library target named __buzz__ (that would produce a `libbuzz.so` shared library) import (depend up on) objects of our target `foo`, by resorting to the obscur idiom `$<TARGET_OBJECTS:foo>` :

    add_library( buzz
      SHARED
        src/buzz_main.cpp
        src/buzz_extra.cpp
        src/buzz_util.cpp

        $<TARGET_OBJECTS:foo>

        ${LIBXXX_LIBRARIES}
        ...
        ...
      )

Likewise for an executable `another-exec` which would depend upon objects from target `bar` :

    add_executable( another-exec
        buzz
        $<TARGET_OBJECTS:bar>
      )

### set_source_files_properties()

Or, for ex. "how does one have specific compiler flags for a given source code file ?"

Say we want a given source `yeah.cpp` that require some bleeding edge feature from C++1z :

    set_source_files_properties( yeah.cpp
      PROPERTIES
        COMPILE_FLAGS -std=c++1z -Wall -Weverything -pedantic )

### Setting the default build type (CMAKE_BUILD_TYPE)

The build type/variant is generally left for the user to specify, typically through the command line argument `-DCMAKE_BUILD_TYPE=Release`.  It is possible though to have a different default for this.

Via [cmake.org/Wiki/CMake_FAQ](https://cmake.org/Wiki/CMake_FAQ#How_can_I_change_the_default_build_mode_and_see_it_reflected_in_the_GUI.3F) :

    IF(NOT CMAKE_BUILD_TYPE)
      #SET(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      SET(CMAKE_BUILD_TYPE MinSizeDeb CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel MinSizeDeb."
          FORCE)
    ENDIF(NOT CMAKE_BUILD_TYPE)


### CCACHE

Found this solution :
[crascit.com/2016/04/09/using-ccache-with-cmake/](https://crascit.com/2016/04/09/using-ccache-with-cmake/)

    find_program(CCACHE_PROGRAM ccache)

    if (true)
      if (CCACHE_PROGRAM)
        set_property( GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}" )
        message(STATUS "Dude! Found ccache, so we're setting CMake global property RULE_LAUNCH_COMPILE to '${CCACHE_PROGRAM}'.")
      endif()
    endif()

### Custom targets for running arbitrary commands

Here's an example using [__add_custom_target()__](https://cmake.org/cmake/help/latest/command/add_custom_target.html) for listing executable files in the build directory :

    add_custom_target( list-binaries
      ALL
      DEPENDS our-final-program
        COMMAND find ${CMAKE_CURRENT_BINARY_DIR} -type d -name CMakeFiles -prune -o -type f -perm -a+x -ls
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "-- List os executable files (+x) that were built : --"
      VERBATIM USES_TERMINAL
      )

The trick here is to have it __depend__ upon some final target (here `our-final-program`) that would end up built last.  Option __ALL__ would have that command be run at each build (else one would have to explicitely ask for it, for ex. `cmake --build build/ --target list-binaries`).

Note that it is possible to have several commands be run for a custom target :

    COMMAND echo -e "\\e[32;1;7m  Here's your static stuff :  \\e[0m"
    COMMAND find ${CMAKE_BINARY_DIR} -type f -name '*.a' -ls
    COMMAND echo -e "\\e[2m  PS: have a break away from computer at times!  \\e[0m"
    COMMAND echo -e "\\e[32;1;7m  DONE  \\e[0m"

* [Colors and formatting (ANSI/VT100 Control sequences) @ misc.flogisoft.com](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

#### Custom targets for having two pre-configured Debug / Release builds

One example usage I've seen for [__add_custom_target()__](https://cmake.org/cmake/help/latest/command/add_custom_target.html) is having two custom `debug` and `release` targets that are “maintainer pre-configured” with some intent of having common defaults by turning some options ON/OFF.

This may be useful at least in situations were one has several of those options that configure fragments of code, and you can't always easily tell which combinations of options would, in the best case, break the build ; or worse: not break the build and introduce some pesky bugs &ndash; hence this idea of having pre-configured, say “maintainer likes” builds, for chasing bugs.

    # Run with: `cmake --build build --target debug`
    add_custom_target( debug
      COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Debug ${CMAKE_SOURCE_DIR}
      COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
      COMMENT "Run CMake for a Debug build."
      )

    # Run with: `cmake --build build --target release`
    add_custom_target(release
      COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release ${CMAKE_SOURCE_DIR}
      COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
      COMMENT "Run CMake for a Release build."
      )


## Pointers

* [CMAKE_INCLUDE_PATH](https://cmake.org/cmake/help/latest/variable/CMAKE_INCLUDE_PATH.html)
* [CMAKE_LIBRARY_PATH](https://cmake.org/cmake/help/latest/variable/CMAKE_LIBRARY_PATH.html#variable:CMAKE_LIBRARY_PATH)
* [if, elseif, else, endif](https://cmake.org/cmake/help/latest/command/if.html)
* [CMake regular expressions (`string()`)](https://cmake.org/cmake/help/latest/command/string.html#regex-specification)
* [get_filename_component()](https://cmake.org/cmake/help/latest/command/get_filename_component.html)

* [CMAKE_BUILD_TYPE](https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html)

* <https://github.com/cginternals/cmake-init>
  – “Template for reliable, cross-platform C++ project setup using cmake.”

* <http://foonathan.net/blog/2016/03/03/cmake-install.html>
* <https://cmake.org/Wiki/CMake/Tutorials/How_to_create_a_ProjectConfig.cmake_file>
* <https://cmake.org/Wiki/CMake:How_To_Write_Platform_Checks>

__EOF__
