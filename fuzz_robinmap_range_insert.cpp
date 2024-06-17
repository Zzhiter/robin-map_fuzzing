/*
 * This is an example fuzz test for the lodepng
 * library using the google/fuzztest framework.
 *
 * Based on:
 * https://github.com/lvandeve/lodepng/blob/master/lodepng_fuzzer.cpp
 */

#include "fuzztest/fuzztest.h"

#include <tsl/robin_map.h>

#include <boost/mpl/list.hpp>
#include <boost/test/unit_test.hpp>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <iterator>
#include <memory>
#include <stdexcept>
#include <string>
#include <tuple>
#include <type_traits>
#include <utility>
#include <vector>

#include "utils.h"

using namespace fuzztest;

void RangeInsertMaintainsMapProperties(
    const std::vector<std::pair<int, int>>& value_pairs) {
  // 创建一个tsl::robin_map实例并初始化两个元素
  tsl::robin_map<int, int> map = {{-1, 1}, {-2, 2}};
  
  // 插入提供的值对范围
  for (const auto& pair : value_pairs) {
    map.insert(pair);
  }

  // 验证map的大小是否等于value_pairs.size() + 初始元素数量
  ASSERT_TRUE(map.size() == value_pairs.size() + 2);

  // 验证初始插入的元素是否还在
  ASSERT_TRUE(map.at(-1) == 1);
  ASSERT_TRUE(map.at(-2) == 2);

  // 遍历value_pairs，验证每个插入的元素是否存在且值正确
  for (const auto& pair : value_pairs) {
    ASSERT_TRUE(map.at(pair.first) == pair.second);
  }
}

FUZZ_TEST(RangeInsertTestSuite, RangeInsertMaintainsMapProperties)
  .WithDomains(/*value_pairs:*/fuzztest::Arbitrary<std::vector<std::pair<int, int>>>())
//   .WithSeeds({{ /* 种子值示例，您可以根据需要添加更多的种子值 */ }});