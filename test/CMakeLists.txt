cmake_minimum_required(VERSION 3.14)

project(world_of_blocksTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

function(test_bench_generator TEST_BENCH_NAME IS_TEST ADD_TO_TEST)
    if (IS_TEST)
        add_executable("${TEST_BENCH_NAME}" "source/test/${TEST_BENCH_NAME}.cpp")
    else()
        add_executable("${TEST_BENCH_NAME}" "source/benchmark/${TEST_BENCH_NAME}.cpp")
    endif()

    if (IS_TEST)
        target_link_libraries("${TEST_BENCH_NAME}" PRIVATE gtest)
    else()
        target_link_libraries("${TEST_BENCH_NAME}" PRIVATE benchmark::benchmark)
    endif()

    target_link_libraries("${TEST_BENCH_NAME}" PRIVATE GTA_SA_cheat_finder_lib)

    if (OpenMP_FOUND OR OpenMP_CXX_FOUND)
        target_link_libraries("${TEST_BENCH_NAME}" PRIVATE OpenMP::OpenMP_CXX OpenMP::OpenMP_C)
    endif()
  
    if (CUDAToolkit_FOUND)
        target_link_libraries("${TEST_BENCH_NAME}" PRIVATE cuda_lib)
    endif()

    if (OpenCL_FOUND)
        target_link_libraries("${TEST_BENCH_NAME}" PRIVATE opencl_lib)
    endif()

    set_target_properties("${TEST_BENCH_NAME}"
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
    target_compile_features("${TEST_BENCH_NAME}" PRIVATE cxx_std_17)

    #if(NOT CMAKE_BUILD_TYPE MATCHES Debug AND NOT CMAKE_BUILD_TYPE MATCHES Coverage)
    #  add_test(NAME "${TEST_BENCH_NAME}" COMMAND $<TARGET_FILE:${TEST_BENCH_NAME}>)
    #elseif()
    #  message(STATUS "Disable ${BENCH_NAME}, Performance benchmark test only run on Release/RelWithDebInfo/MinSizeRel")
    #endif()

    if (ADD_TO_TEST)
        add_test(NAME "${TEST_BENCH_NAME}" COMMAND $<TARGET_FILE:${TEST_BENCH_NAME}>)
    endif()
    
endfunction()

if(NOT WIN32)
  include(../cmake/lib/gtest.cmake)
  include(../cmake/lib/benchmark.cmake)
  include(../cmake/lib/openmp.cmake)
  include(../cmake/utile/ccache.cmake)

  # Add tests
  test_bench_generator(find_string_inv_test true true)
  test_bench_generator(jamcrc_test true true)
  test_bench_generator(gta_sa_test true true)

  # Add bench
  test_bench_generator(find_string_inv_bench false false)
  test_bench_generator(jamcrc_bench false false)
  
endif()

# ---- End-of-file commands ----

add_folders(Test)
