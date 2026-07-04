#! /usr/bin/env -S cmake -P

include(FetchContent)

set(DRY_RUN ON)

if(DEFINED INCLUDE AND DEFINED EXCLUDE)
    message(FATAL_ERROR "INCLUDE and EXCLUDE can't both be specified.")
endif()

if(DEFINED INSTALL_DIR)
    cmake_path(ABSOLUTE_PATH INSTALL_DIR NORMALIZE)
    if(EXISTS ${INSTALL_DIR})
        message("${INSTALL_DIR} already exists. Aborting.")
        return()
    endif()
    set(STAGE_DIR ${INSTALL_DIR}/stage)
    set(DRY_RUN OFF)
else()
    get_filename_component(SCRIPT_NAME ${CMAKE_CURRENT_LIST_FILE} NAME)
    # gersemi: off
    message("Usage:")
    message("  cmake -D INSTALL_DIR=<install-dir> [...] -P ${SCRIPT_NAME}")
    message("")
    message("Arguments:")
    message("  -D INSTALL_DIR=<dir>          : Root directory for the installation.")
    message("  -D CMAKE_TOOLCHAIN_FILE=<file>: Toolchain file to use.")
    message("  -D CMAKE_SYSROOT=<dir>        : Sysroot (for cross compilation).")
    message("  -D INCLUDE=<list>             : Semicolon-separated list of dependencies to include.")
    message("  -D EXCLUDE=<list>             : Semicolon-separated list of dependencies to exclude.")
    message("")
    # gersemi: on

    # Don't return --- do a dry run to print the dependencies.
endif()

set(SYSROOT_CONFIG_OPTION "")
if(DEFINED CMAKE_SYSROOT)
    set(SYSROOT_CONFIG_OPTION "-D CMAKE_SYSROOT=${CMAKE_SYSROOT}")
endif()

set(TOOLCHAIN_CONFIG_OPTION "")
if(DEFINED CMAKE_TOOLCHAIN_FILE)
    set(TOOLCHAIN_CONFIG_OPTION "-D CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}")
endif()

function(install_dependency_from_source)
    cmake_parse_arguments(
        # Prefix for parsed variables:
        ARG
        # Boolean options:
        ""
        # Single-value arguments:
        "DEPENDENCY_NAME;GIT_REPOSITORY;GIT_COMMIT"
        # Multi-value arguments:
        "CONFIG_OPTIONS"
        #
        ${ARGN}
    )
    if(NOT DEFINED ARG_DEPENDENCY_NAME)
        message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}: DEPENDENCY_NAME is required.")
    endif()
    if(NOT DEFINED ARG_GIT_REPOSITORY)
        message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}: GIT_REPOSITORY is required.")
    endif()
    if(NOT DEFINED ARG_GIT_COMMIT)
        message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}: GIT_COMMIT is required.")
    endif()

    if(NOT DRY_RUN)
        message("")
    endif()

    set(SKIP OFF)
    if(DEFINED INCLUDE)
        if(NOT ARG_DEPENDENCY_NAME IN_LIST INCLUDE)
            set(SKIP ON)
        endif()
    elseif(DEFINED EXCLUDE)
        if(ARG_DEPENDENCY_NAME IN_LIST EXCLUDE)
            set(SKIP ON)
        endif()
    endif()

    if(SKIP)
        message("${ARG_DEPENDENCY_NAME} -- skip")
        return()
    endif()
    message(${ARG_DEPENDENCY_NAME})
    if(DRY_RUN)
        return()
    endif()

    set(DEPENDENCY_SOURCE_DIR ${STAGE_DIR}/${ARG_DEPENDENCY_NAME})
    set(DEPENDENCY_BUILD_DIR ${STAGE_DIR}/${ARG_DEPENDENCY_NAME}_build)

    FetchContent_Populate(
        ${ARG_DEPENDENCY_NAME}
        SOURCE_DIR ${DEPENDENCY_SOURCE_DIR}
        BINARY_DIR ${STAGE_DIR}/${ARG_DEPENDENCY_NAME}_fetch_content_build
        SUBBUILD_DIR ${STAGE_DIR}/${ARG_DEPENDENCY_NAME}_fetch_content_subbuild
        GIT_REPOSITORY ${ARG_GIT_REPOSITORY}
        GIT_TAG ${ARG_GIT_COMMIT}
        GIT_SHALLOW ON
    )

    execute_process(
        COMMAND
            ${CMAKE_COMMAND} #
            -S ${DEPENDENCY_SOURCE_DIR} #
            -B ${DEPENDENCY_BUILD_DIR} #
            -D CMAKE_BUILD_TYPE=Release #
            -D CMAKE_PREFIX_PATH=${INSTALL_DIR} #
            ${SYSROOT_CONFIG_OPTION} #
            ${TOOLCHAIN_CONFIG_OPTION} #
            ${ARG_CONFIG_OPTIONS} #
        RESULT_VARIABLE RESULT
    )
    if(NOT RESULT EQUAL 0)
        message(
            FATAL_ERROR
            "${CMAKE_CURRENT_FUNCTION}: CMake configure failed for ${ARG_DEPENDENCY_NAME}."
        )
    endif()

    execute_process(
        COMMAND
            ${CMAKE_COMMAND} #
            --build ${DEPENDENCY_BUILD_DIR} #
            --config Release #
        RESULT_VARIABLE RESULT
    )
    if(NOT RESULT EQUAL 0)
        message(
            FATAL_ERROR
            "${CMAKE_CURRENT_FUNCTION}: CMake build failed for ${ARG_DEPENDENCY_NAME}."
        )
    endif()

    execute_process(
        COMMAND
            ${CMAKE_COMMAND} #
            --install ${DEPENDENCY_BUILD_DIR} #
            --prefix ${INSTALL_DIR} #
        RESULT_VARIABLE RESULT
    )
    if(NOT RESULT EQUAL 0)
        message(
            FATAL_ERROR
            "${CMAKE_CURRENT_FUNCTION}: CMake install failed for ${ARG_DEPENDENCY_NAME}."
        )
    endif()
endfunction()

#### List of dependencies ####

install_dependency_from_source(
    DEPENDENCY_NAME Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_COMMIT b670de4fe12ac7c5e858b7de3a14fb4bd18c760e # v3.14.0
    CONFIG_OPTIONS #
        "-D CATCH_DEVELOPMENT_BUILD=OFF"
        "-D CATCH_INSTALL_DOCS=OFF"
        "-D CATCH_INSTALL_EXTRAS=OFF"
)

#### Postamble ####

if(NOT DRY_RUN)
    message("")
    message("${STAGE_DIR} may be removed.")
    message("Use with `-D CMAKE_PREFIX_PATH=${INSTALL_DIR}`.")
endif()
