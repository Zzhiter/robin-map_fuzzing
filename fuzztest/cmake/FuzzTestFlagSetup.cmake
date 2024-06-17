macro(fuzztest_setup_fuzzing_flags)
  if (FUZZTEST_FUZZING_MODE OR (FUZZTEST_COMPATIBILITY_MODE STREQUAL "libfuzzer"))
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -UNDEBUG -fsanitize=address")
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -UNDEBUG -fsanitize=address")
    SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
  endif ()
  if (FUZZTEST_COMPATIBILITY_MODE STREQUAL "libfuzzer")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=fuzzer-no-link -DFUZZTEST_COMPATIBILITY_MODE")
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=fuzzer-no-link -DFUZZTEST_COMPATIBILITY_MODE")
  endif ()
  # 在这里设置的覆盖率inline-8bit-counters、trace-cmp都打开了
  if (FUZZTEST_FUZZING_MODE OR (FUZZTEST_COMPATIBILITY_MODE STREQUAL "libfuzzer"))
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize-coverage=inline-8bit-counters -fsanitize-coverage=trace-cmp -fsanitize=address -DADDRESS_SANITIZER")
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize-coverage=inline-8bit-counters -fsanitize-coverage=trace-cmp -fsanitize=address -DADDRESS_SANITIZER")
  endif ()
endmacro ()

# 这个 `macro` 是一个 CMake 宏，名为 `fuzztest_setup_fuzzing_flags`，它的作用是设置模糊测试（fuzzing）相关的编译和链接标志。宏定义了一系列的条件来添加不同的编译选项，具体如下：

# 1. **基本模糊测试标志**：
#    - 如果定义了 `FUZZTEST_FUZZING_MODE` 或者 `FUZZTEST_COMPATIBILITY_MODE` 被设置为 `"libfuzzer"`，则会添加以下标志：
#      - `-g`：生成调试信息。
#      - `-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION`：定义一个宏，表明当前的构建模式不适合生产环境。
#      - `-UNDEBUG`：这可能是一个错误，通常应该是 `-DNDEBUG`，用于定义发布模式下禁用断言的标志。
#      - `-fsanitize=address`：启用地址卫生器（AddressSanitizer），用于检测内存泄漏和越界访问等问题。

# 2. **特定于 libfuzzer 的标志**：
#    - 如果 `FUZZTEST_COMPATIBILITY_MODE` 被设置为 `"libfuzzer"`，则会添加以下标志：
#      - `-fsanitize=fuzzer-no-link`：指示编译器不要链接 libFuzzer 库，而是在运行时动态加载。
#      - `-DFUZZTEST_COMPATIBILITY_MODE`：定义一个宏，表明正在使用 libfuzzer 兼容性模式。

# 3. **代码覆盖和模糊测试标志**：
#    - 如果定义了 `FUZZTEST_FUZZING_MODE` 或者 `FUZZTEST_COMPATIBILITY_MODE` 被设置为 `"libfuzzer"`，则会添加以下标志来控制代码覆盖和模糊测试的行为：
#      - `-fsanitize-coverage=inline-8bit-counters`：使用内联8位计数器进行代码覆盖。
#      - `-fsanitize-coverage=trace-cmp`：追踪比较和分支，用于更精确的代码覆盖。
#      - `-fsanitize=address`：再次添加地址卫生器标志。
#      - `-DADDRESS_SANITIZER`：定义一个宏，表明正在使用地址卫生器。

# 宏的结尾是一个 `endmacro()`，这表示宏定义的结束。

# 使用这个宏时，它会根据当前的编译模式和兼容性选项来设置相应的编译和链接标志，以便于构建适用于模糊测试的程序。这些标志有助于在模糊测试过程中发现潜在的错误和安全问题。
