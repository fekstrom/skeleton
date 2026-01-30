add_executable(print_build_information print_build_information.cpp)
target_link_libraries(
    print_build_information
    Skeleton::Skeleton
    # Skeleton::CompilerWarnings is only available in the Skeleton build.
    $<TARGET_NAME_IF_EXISTS:Skeleton::CompilerWarnings>
    ${COMPILER_WARNINGS}
)

add_test(NAME "Print build information" COMMAND print_build_information)
