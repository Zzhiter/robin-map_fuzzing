cmake_minimum_required(VERSION 3.19)
project(robin-map_fuzztest)

# Option to add coverage instrumentation
option(COVERAGE_INSTRUMENTATION "Add coverage instrumentation to generate coverage reports." OFF)
set(COVERAGE_FLAGS -fprofile-instr-generate -fcoverage-mapping)

# Export build flags
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# GoogleTest requires at least C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 这个命令CMake3.0之后被废除了
# include_directories(/robin_map/include)

# Load google/fuzztest
add_subdirectory(fuzztest)
enable_testing()
fuzztest_setup_fuzzing_flags()

# # Build lodepng
# add_library(lodepng STATIC lodepng/lodepng.cpp)
# target_include_directories(lodepng PUBLIC lodepng)

# Build the fuzztest
add_executable(fuzz_robinmap_range_insert fuzz_robinmap_range_insert.cpp)

# Link the tsl-robin-map headers to the fuzztest target
target_include_directories(fuzz_robinmap_range_insert PRIVATE robin-map/include)
# Add the path where utils.h is located
target_include_directories(fuzz_robinmap_range_insert PRIVATE robin-map/tests)

find_package(Boost REQUIRED COMPONENTS unit_test_framework)
target_link_libraries(fuzz_robinmap_range_insert PRIVATE ${Boost_LIBRARIES})


# Optionally add coverage instrumentation
if(COVERAGE_INSTRUMENTATION)
    target_compile_options(fuzz_robinmap_range_insert PRIVATE ${COVERAGE_FLAGS})
    target_compile_options(fuzz_robinmap_range_insert PRIVATE ${COVERAGE_FLAGS})
    target_link_options(fuzz_robinmap_range_insert PRIVATE ${COVERAGE_FLAGS})
endif()

# target_link_libraries(fuzz_robinmap_range_insert PRIVATE lodepng)
link_fuzztest(fuzz_robinmap_range_insert)

# link_directories(/home/zhangzhe/fuzzing-repo/lodepng_fuzzing/build/lib)
# target_link_libraries(fuzz_robinmap_range_insert PRIVATE libgtest libgtest_main)

# 手动指定库的路径
set(GTEST_LIB_DIR /home/zhangzhe/fuzzing-repo/lodepng_fuzzing/build/lib)

# 链接Google Test库
target_link_libraries(fuzz_robinmap_range_insert PRIVATE 
                       ${GTEST_LIB_DIR}/libgtest.a 
                       ${GTEST_LIB_DIR}/libgtest_main.a)
