include(CMakeDependentOption)

option(
    SKELETON_ENABLE_COMPILER_WARNINGS
    "Enable compiler warnings for the Skeleton build"
    ${PROJECT_IS_TOP_LEVEL}
)
cmake_dependent_option(
    SKELETON_WARNINGS_AS_ERRORS
    "Treat compiler warnings as errors in the Skeleton build"
    OFF
    ${SKELETON_ENABLE_COMPILER_WARNINGS}
    OFF
)

add_library(Skeleton_CompilerWarnings INTERFACE)
add_library(Skeleton::CompilerWarnings ALIAS Skeleton_CompilerWarnings)

if(SKELETON_ENABLE_COMPILER_WARNINGS)
    if(CMAKE_CXX_COMPILER_ID MATCHES "^(AppleClang|Clang|GNU)$")
        target_compile_options(
            Skeleton_CompilerWarnings
            INTERFACE -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Wold-style-cast
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        target_compile_options(
            Skeleton_CompilerWarnings
            INTERFACE
                # Suppress warnings from headers included with <...>.
                /external:anglebrackets
                /external:W0
                # Apply the following warnings.
                /W4
        )
    endif()
endif()

if(SKELETON_WARNINGS_AS_ERRORS)
    if(CMAKE_CXX_COMPILER_ID MATCHES "^(AppleClang|Clang|GNU)$")
        target_compile_options(Skeleton_CompilerWarnings INTERFACE -Werror)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        target_compile_options(Skeleton_CompilerWarnings INTERFACE /WX)
    endif()
endif()
