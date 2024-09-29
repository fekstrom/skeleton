# Skeleton::CompilerWarnings is only available in the Skeleton build.
set(COMPILER_WARNINGS "")
if(TARGET Skeleton::CompilerWarnings)
    set(COMPILER_WARNINGS Skeleton::CompilerWarnings)
endif()

add_executable(print_build_information print_build_information.cpp)
target_link_libraries(print_build_information Skeleton::Skeleton ${COMPILER_WARNINGS})
