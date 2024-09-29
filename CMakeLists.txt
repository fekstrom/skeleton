cmake_minimum_required(VERSION 3.30)

project(Skeleton VERSION 0.0.1)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

if(PROJECT_IS_TOP_LEVEL)
  enable_testing()
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(SkeletonCompilerWarnings)
include(SkeletonDefaultBuildType)
include(SkeletonForceEnableAsserts)
include(SkeletonOutputDirectories)

option(SKELETON_BUILD_BENCHMARKS "Build benchmarks" OFF)
option(SKELETON_BUILD_EXAMPLES "Build examples" OFF)
option(SKELETON_BUILD_DOCUMENTATION "Build documentation" OFF)
option(SKELETON_BUILD_FUZZ_TESTS "Build fuzz tests" OFF)
option(SKELETON_BUILD_UNIT_TESTS "Build unit tests" OFF)

if(SKELETON_BUILD_DOCUMENTATION)
  add_subdirectory(docs)
endif()

if(SKELETON_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

find_package(Eigen3 3.3 REQUIRED CONFIG)

add_subdirectory(src)
add_subdirectory(tests)
