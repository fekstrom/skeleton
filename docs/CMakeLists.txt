find_package(Doxygen REQUIRED)

set(DOXYGEN_PROJECT_NAME "Skeleton")
set(DOXYGEN_QUIET Yes)
set(DOXYGEN_EXTRACT_ALL Yes)

doxygen_add_docs(Skeleton_Documentation
  main.dox
  ${Skeleton_SOURCE_DIR}/src/skeleton
  ALL
)

if(SKELETON_ENABLE_INSTALL)
  include(GNUInstallDirs)
  set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/${PROJECT_NAME})
  install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html DESTINATION ${CMAKE_INSTALL_DOCDIR})
endif()
