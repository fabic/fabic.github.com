---
layout: post
title: "Draft - CMake notes"
tagline: "Supporting tagline"
category : notes
tags : [draft]
---

* [CMAKE_BUILD_TYPE](https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html)


* <https://github.com/cginternals/cmake-init>
  – “Template for reliable, cross-platform C++ project setup using cmake.”

## CMake “modules”

    mkdir -p cmake/modules

    # Add path for custom modules
    set(CMAKE_MODULE_PATH
        ${CMAKE_MODULE_PATH}
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules"
      )

    include(dude_please_dump_cmake_variables)

### Dump all CMake variables

    $  cat > cmake/modules/dude_please_dump_cmake_variables.cmake << EOF
    function(dude_please_dump_cmake_variables)
      get_cmake_property(_variableNames VARIABLES)
      foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName} = ${${_variableName}}")
      endforeach()
    endfunction()
    EOF

    include(dude_please_dump_cmake_variables)

__EOF__
