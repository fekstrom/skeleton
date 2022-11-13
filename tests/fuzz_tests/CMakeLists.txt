if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(HAVE_FUZZER_INSTRUMENTATION FALSE)
  string(REGEX MATCH "fsanitize=[^ ]*fuzzer" FUZZER_MATCH "${CMAKE_CXX_FLAGS}")
  if(FUZZER_MATCH)
    set(HAVE_FUZZER_INSTRUMENTATION TRUE)
  endif()
  if(NOT HAVE_FUZZER_INSTRUMENTATION)
    message(STATUS "Built without fuzzer instrumentation (-fsanitize=fuzzer-no-link)")
  endif()
endif()

function(add_fuzz_test source_cpp)
  cmake_path(GET source_cpp STEM TARGET_NAME)
  set(TARGET_NAME "fuzz_${TARGET_NAME}")
  add_executable(${TARGET_NAME} "")
  target_sources(${TARGET_NAME} PRIVATE
    ${source_cpp}
    $<$<NOT:$<CXX_COMPILER_ID:AppleClang,Clang>>:not_clang_main.cpp>
  )
  target_include_directories(${TARGET_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
  target_link_libraries(${TARGET_NAME} PRIVATE
    Skeleton::CompilerWarnings
    Skeleton::Skeleton
  )
  target_compile_options(${TARGET_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:AppleClang,Clang>:-fsanitize=fuzzer>
  )
  target_link_options(${TARGET_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:AppleClang,Clang>:-fsanitize=fuzzer>
  )
endfunction()

add_fuzz_test(build_information.cpp)
