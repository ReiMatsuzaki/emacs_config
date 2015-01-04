#include <iostream>
#include <gtest/gtest.h>
#include <src/math/erfc.hpp>

using namespace std;

TEST(erfc, erfc_double) {

  double y, x, expect;
  erfc_calc_data calc_data;

  x = 1.0;
  expect =0.157299207050285130658779364917390740703933002034;
  erfc_d(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);
  
  x = 0.01;
  expect = 0.98871658444415038308409047645193078905089904517;
  erfc_d(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);

  x = 3.0;
  expect = 0.0000220904969985854413727761295823203798477070873992;
  erfc_d(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);


}
TEST(erfc, erfc_double_compex) {
  
  std::complex<double> expect, x, y;
  erfc_calc_data calc_data;

  x = std::complex<double>(1.0, -1.0);
  expect = std::complex<double>(-0.316151281697947644880271080243670369027706529252, 0.190453469237834686284108861969162442437777309751);
  erfc_dc(x, y, calc_data);
  EXPECT_DOUBLE_EQ(real(expect), real(y));
  
  x = std::complex<double>(0.015707317311820675753295353309906770086948450734, 0.999876632481660598638907127731252174499277787538);
  expect = std::complex<double>(0.95184545524179913420177473658805102860103221495, -1.64929108965086517748934245403332000523564625901);
  erfc_dc(x, y, calc_data);
  EXPECT_DOUBLE_EQ(real(expect), real(y));
  EXPECT_DOUBLE_EQ(expect.imag(), y.imag());
  EXPECT_TRUE(calc_data.convergence);

  x = std::complex<double>(0.001564344650402308690101053194671668923139,0.009876883405951377261900402476934372607584);
  expect = std::complex<double>(0.9982346553205423153337357292658472915601, 0.0111452046101524188315708507537751407281);
  erfc_dc(x, y, calc_data);
  EXPECT_DOUBLE_EQ(real(expect), real(y));
  EXPECT_DOUBLE_EQ(expect.imag(), y.imag());
  EXPECT_TRUE(calc_data.convergence);

}

