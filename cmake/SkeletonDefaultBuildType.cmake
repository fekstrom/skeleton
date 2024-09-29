if(NOT PROJECT_IS_TOP_LEVEL)
  return()
endif()

if(NOT GENERATOR_IS_MULTI_CONFIG
    AND NOT CMAKE_GENERATOR STREQUAL "Ninja Multi-Config"
    AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
  message(STATUS
    "No build type specified. "
    "Defaulting to CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}.")
endif()
if(CMAKE_GENERATOR STREQUAL "Ninja Multi-Config"
    AND NOT CMAKE_DEFAULT_BUILD_TYPE)
  set(CMAKE_DEFAULT_BUILD_TYPE Release CACHE STRING "" FORCE)
  message(STATUS
    "No default build type specified. "
    "Defaulting to CMAKE_DEFAULT_BUILD_TYPE=${CMAKE_DEFAULT_BUILD_TYPE}.")
endif()
