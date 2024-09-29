add_library(Skeleton_Skeleton "")
add_library(Skeleton::Skeleton ALIAS Skeleton_Skeleton)
set_target_properties(Skeleton_Skeleton PROPERTIES
  OUTPUT_NAME SkeletonSkeleton
  EXPORT_NAME Skeleton
)

target_sources(Skeleton_Skeleton
  PRIVATE
    skeleton/build_information.cpp
  PUBLIC FILE_SET HEADERS FILES
    skeleton/build_information.hpp
    skeleton/version.hpp
)
target_link_libraries(Skeleton_Skeleton
  PRIVATE
    $<BUILD_INTERFACE:Skeleton::CompilerWarnings>
  PUBLIC
    Eigen3::Eigen
)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

configure_package_config_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/skeleton/SkeletonConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
  NO_SET_AND_CHECK_MACRO
)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfigVersion.cmake
  VERSION ${Skeleton_VERSION}
  COMPATIBILITY ExactVersion # No promises about compatibility while major version is 0.
)

install(TARGETS Skeleton_Skeleton
  EXPORT SkeletonExport
  FILE_SET HEADERS
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(EXPORT SkeletonExport
  NAMESPACE Skeleton::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
)
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/cmake/SkeletonConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Skeleton
)
