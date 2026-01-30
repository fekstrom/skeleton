option(
    SKELETON_USE_SANITIZERS
    "Use address and UB sanitizers (requires GCC or Clang)"
    OFF
)

if(NOT SKELETON_USE_SANITIZERS)
    return()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "^(AppleClang|Clang|GNU)$")
    add_compile_options(-fsanitize=address,undefined -fno-omit-frame-pointer)
    add_link_options(-fsanitize=address,undefined)
else()
    message(
        FATAL
        "FLY_USE_SANITIZERS is ON but compiler '${CMAKE_CXX_COMPILER_ID}' is not supported."
    )
endif()
