find_package(Catch2 3.6 REQUIRED)

add_executable(unit_tests "")
target_sources(unit_tests PRIVATE
  build_information.cpp
)
target_link_libraries(unit_tests PRIVATE
  Skeleton::CompilerWarnings
  Skeleton::Skeleton
  Catch2::Catch2WithMain
)

add_test(NAME "Unit tests" COMMAND unit_tests)
