if(SKELETON_BUILD_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()

if(SKELETON_BUILD_FUZZ_TESTS)
  add_subdirectory(fuzz_tests)
endif()

if(SKELETON_BUILD_UNIT_TESTS)
  add_subdirectory(unit_tests)
endif()
