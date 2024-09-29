cmake_minimum_required(VERSION 3.30)

project(Skeleton VERSION 0.0.1)

if(PROJECT_IS_TOP_LEVEL)
  enable_testing()
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(SkeletonCxxStandard)

include(SkeletonCompilerWarnings)
include(SkeletonDefaultBuildType)
include(SkeletonForceEnableAsserts)
include(SkeletonOutputDirectories)

option(SKELETON_BUILD_EXAMPLES "Build examples" OFF)
option(SKELETON_BUILD_DOCUMENTATION "Build documentation" OFF)
option(SKELETON_BUILD_UNIT_TESTS "Build unit tests" OFF)
option(SKELETON_ENABLE_INSTALL "Enable CMake install for Skeleton" ON)

if(SKELETON_BUILD_DOCUMENTATION)
  add_subdirectory(docs)
endif()

if(SKELETON_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

add_subdirectory(src)
add_subdirectory(tests)

if(SKELETON_ENABLE_INSTALL)
  install(EXPORT SkeletonTargets
    NAMESPACE Skeleton::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
  )

  include(GNUInstallDirs)
  include(CMakePackageConfigHelpers)

  configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/SkeletonConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
    NO_SET_AND_CHECK_MACRO
  )
  write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfigVersion.cmake
    VERSION ${Skeleton_VERSION}
    COMPATIBILITY ExactVersion # No promises about compatibility while major version is 0.
  )
  install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
  )
endif()
