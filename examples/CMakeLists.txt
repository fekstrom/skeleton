cmake_minimum_required(VERSION 3.30)

project(SkeletonExamples VERSION 0.0.1)

if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)

  include(GNUInstallDirs)
  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${SkeletonExamples_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})
  endif()

  find_package(Skeleton)
endif()

add_subdirectory(src)
