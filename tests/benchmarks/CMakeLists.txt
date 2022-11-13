find_package(benchmark REQUIRED)

add_executable(benchmarks "")
target_sources(benchmarks PRIVATE
  build_information.cpp
  main.cpp
)
target_link_libraries(benchmarks PRIVATE
  Skeleton::Skeleton
  Skeleton::CompilerWarnings
  benchmark::benchmark
)
