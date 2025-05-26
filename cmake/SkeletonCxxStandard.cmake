# Require C++23, but allow a later standard if set by a parent project.
if(DEFINED CMAKE_CXX_STANDARD)
  if(CMAKE_CXX_STANDARD EQUAL 98 OR CMAKE_CXX_STANDARD LESS 23)
    message(FATAL_ERROR "Skeleton requires C++23 or later.")
  endif()
else()
  set(CMAKE_CXX_STANDARD 23)
endif()

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Don't enable C++ extensions, but allow them if enabled by a parent project.
if(NOT DEFINED CMAKE_CXX_EXTENSIONS)
  set(CMAKE_CXX_EXTENSIONS OFF)
endif()
