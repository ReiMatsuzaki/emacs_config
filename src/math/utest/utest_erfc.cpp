#include <iostream>
#include <stdio.h>
#include <gtest/gtest.h>
#include <src/math/erfc.hpp>

using namespace std;
using namespace StongMath;

TEST(erfc, erfc_double) {

  double y, x, expect;
  erfc_calc_data calc_data;

  x = 1.0;
  expect =0.157299207050285130658779364917390740703933002034;
  //erfc_d(x, y, calc_data);
  erfc<double>(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);
  
  x = 0.01;
  expect = 0.98871658444415038308409047645193078905089904517;
  //  erfc_d(x, y, calc_data);
  erfc<double>(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);

  x = 3.0;
  expect = 0.0000220904969985854413727761295823203798477070873992;
  //  erfc_d(x, y, calc_data);
  // erfc(x, y, calc_data);
  erfc<double>(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);
}
TEST(erfc, erfc_dd) {
  dd_real x = 1;
  dd_real y; 
  erfc_calc_data calc_data;
  double eps = 1.5 * 2.46519 * pow(10.0, -32);
  // erfc_dd(x, y, calc_data);
  erfc(x, y, calc_data);
  cout << calc_data.num_term << endl;
  char* str = (char*)"0.157299207050285130658779364917390740703933002034";
  dd_real z = str;
  EXPECT_TRUE(calc_data.convergence);
  EXPECT_DOUBLE_EQ(y.x[0], z.x[0]);
  EXPECT_NEAR(y.x[1], z.x[1], eps);
}
TEST(erfc, test_dd_complex) {

  dd_complex x, y, y_expect;
  erfc_calc_data calc_data;
  double eps = 4.0 * value_machine_eps<dd_real>();

  x.real() = 1;
  x.imag() = -1;

  char* str1 = (char*)"-0.316151281697947644880271080243670369027706529252";
  char* str2 = (char*)"0.190453469237834686284108861969162442437777309751";
  y_expect.real() = str1;
  y_expect.imag() = str2;

  erfc(x, y, calc_data);

  EXPECT_DOUBLE_EQ(y.real().x[0], y_expect.real().x[0]);
  EXPECT_NEAR(y.real().x[1], y_expect.real().x[1], eps);
  EXPECT_DOUBLE_EQ(y.imag().x[0], y_expect.imag().x[0]);
  EXPECT_NEAR(y.imag().x[1], y_expect.imag().x[1], eps);


  x.real() = (char*)"0.0157073173118206757532953533099067700869484507337789468321000772885264";
  x.imag() = (char*)"0.9998766324816605986389071277312521744992777875380061508983620174373615";
  
  y_expect.real() = (char*)"0.9518454552417991342017747365880510286010322149539034701140541117615676";
  y_expect.imag() = (char*)"-1.649291089650865177489342454033320005235646259013263828316361025320691";
  erfc(x, y, calc_data);
  EXPECT_TRUE(calc_data.convergence);
  EXPECT_DOUBLE_EQ(y.real().x[0], y_expect.real().x[0]);
  EXPECT_NEAR(     y.real().x[1], y_expect.real().x[1], eps);
  EXPECT_DOUBLE_EQ(y.imag().x[0], y_expect.imag().x[0]);
  EXPECT_NEAR(     y.imag().x[1], y_expect.imag().x[1], eps);

  x.real() = (char*)"0.001564344650402308690101053194671668923139";
  x.imag()= (char*)"0.009876883405951377261900402476934372607584";
  y_expect.real() = (char*)"0.9982346553205423153337357292658472915601";
  y_expect.imag() = (char*)"-0.0111452046101524188315708507537751407281";
  erfc(x, y, calc_data);
  EXPECT_TRUE(calc_data.convergence);
  EXPECT_DOUBLE_EQ(y.real().x[0], y_expect.real().x[0]);
  EXPECT_NEAR(y.real().x[1], y_expect.real().x[1], eps);
  EXPECT_DOUBLE_EQ(y.imag().x[0], y_expect.imag().x[0]);
  EXPECT_NEAR(y.imag().x[1], y_expect.imag().x[1], eps);
  
}
TEST(erfc, template_double) {
  double y1, y2, z1,z2, x;
  unsigned int nn = 10;
  x = 1.0;
  
  y1 = erfc_d_at_n(x, nn);
  z1 = erfc_d_last_term_at_n(x, nn);
  erfc_at_n<double>(x, nn, y2, z2);
  EXPECT_EQ(y1, y2);
  EXPECT_EQ(z1, z2);

  
}


