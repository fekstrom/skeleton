option(SKELETON_USE_SANITIZERS "Use address and UB sanitizers (if available)" OFF)

if(NOT SKELETON_USE_SANITIZERS)
  return()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "^(AppleClang|Clang|GNU)$")
  add_compile_options(
    -fsanitize=address,undefined
    -O2
    -g
    -fno-omit-frame-pointer
  )
  add_link_options(
    -fsanitize=address,undefined
  )
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  add_compile_options(
    /fsanitize=address
    /O2
    /Zi
    /Oy-
  )
  add_link_options(
    /fsanitize=address
    /DEBUG
  )
  message(STATUS "The UB sanitizer is not available for MSVC.")
endif()
