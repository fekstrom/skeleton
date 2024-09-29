option(SKELETON_ENABLE_COMPILER_WARNINGS "Enable compiler warnings for the Skeleton build" OFF)
option(SKELETON_WARNINGS_AS_ERRORS "Treat compiler warnings as errors in the Skeleton build" OFF)

add_library(Skeleton_CompilerWarnings INTERFACE)
add_library(Skeleton::CompilerWarnings ALIAS Skeleton_CompilerWarnings)

if(SKELETON_ENABLE_COMPILER_WARNINGS)
  target_compile_options(Skeleton_CompilerWarnings INTERFACE
    $<$<CXX_COMPILER_ID:AppleClang,Clang,GNU>:
      -Wall
      -Wextra
      -Wpedantic
      -Wconversion
    >
    $<$<CXX_COMPILER_ID:MSVC>:
      /W4
    >
  )
endif()

if(SKELETON_WARNINGS_AS_ERRORS)
  target_compile_options(Skeleton_CompilerWarnings INTERFACE
    $<$<CXX_COMPILER_ID:AppleClang,Clang,GNU>:-Werror>
    $<$<CXX_COMPILER_ID:MSVC>:/WX>
  )
endif()
