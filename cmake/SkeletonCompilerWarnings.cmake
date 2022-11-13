add_library(Skeleton_CompilerWarnings INTERFACE)
add_library(Skeleton::CompilerWarnings ALIAS Skeleton_CompilerWarnings)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  target_compile_options(Skeleton_CompilerWarnings INTERFACE
    -Wall
    -Wextra
    -Wpedantic
    -Wconversion
    -Wno-sign-conversion
  )
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  target_compile_options(Skeleton_CompilerWarnings INTERFACE
    /W4
  )
endif()
