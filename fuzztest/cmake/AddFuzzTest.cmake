function(link_fuzztest name)
  target_link_libraries(
    ${name}
    PRIVATE
    fuzztest::fuzztest
    fuzztest::fuzztest_gtest_main
  )
endfunction()
# 为目标（由 ${name} 变量表示）链接库。库链接操作是私有的（PRIVATE），
# 这意味着库只会链接到这个特定的目标，而不会传递给依赖这个目标的其他目标。

function(link_fuzztest_core name)
  target_link_libraries(
    ${name}
    PRIVATE
    fuzztest::fuzztest_core
    fuzztest::fuzztest_gtest_main
  )
endfunction()
