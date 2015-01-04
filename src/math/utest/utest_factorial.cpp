#include <iostream>
#include <gtest/gtest.h>
#include <src/math/factorial.hpp>

using namespace std;

TEST(factorial, factorial) {

  EXPECT_EQ(factorial(3), 6);
  EXPECT_EQ(factorial(5), 120);
  EXPECT_EQ(double_factorial(5), 15);
  EXPECT_EQ(double_factorial(6), 48);

}
