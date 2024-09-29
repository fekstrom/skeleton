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

if(SKELETON_ENABLE_INSTALL)
  install(TARGETS Skeleton_Skeleton
    EXPORT SkeletonTargets
    FILE_SET HEADERS
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  )
endif()
