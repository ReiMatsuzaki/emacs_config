#include <iostream>
#include <stdio.h>
#include <gtest/gtest.h>
#include <src/math/erfc.hpp>

using namespace std;
using namespace StongMath; 

TEST(dd_real, exp) {
  dd_real x,y,z,two;
  double eps = 10.0 * value_machine_eps<dd_real>();
  two = 2;
    
  x = 10 * sqrt(two);
  y = exp(x);
  z = (char*)"1386281.6152947822172266602497411511747352581619963839338686762902445915316711763";
  EXPECT_DOUBLE_EQ(y.x[0], z.x[0]);
  EXPECT_NEAR(y.x[1], z.x[1], eps);

  x = sqrt(two);
  y = exp(x);
  z = (char*)"4.1132503787829275171735818151403045024016639431511096100683647098515097858308073";
  EXPECT_DOUBLE_EQ(y.x[0], z.x[0]);
  EXPECT_NEAR(y.x[1], z.x[1], eps);  


  x = sqrt(two)/10;
  y = exp(x);
  z = (char*)"1.1519099101689089509765695840976418446376199957262033456848927733454560752242805";
  EXPECT_DOUBLE_EQ(y.x[0], z.x[0]);
  EXPECT_NEAR(y.x[1], z.x[1], eps);
  
}
TEST(erfc, erfc_double) {

  double y, x, expect;
  erfc_calc_data calc_data;

  x = 1.0;
  expect =0.157299207050285130658779364917390740703933002034;
  //erfc_d(x, y, calc_data);
  erfc<double>(x, y, calc_data);
  EXPECT_DOUBLE_EQ(expect, y);
  EXPECT_TRUE(calc_data.convergence);
  
  x = 1.0;
  x = 1.0 / 100.0;
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
  double eps = 10.0 * value_machine_eps<dd_real>();

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
TEST(exp2_erfc, dd_real) {

  dd_real x,y,y_expect,two;
  erfc_calc_data data;
  double eps = 10.0 * value_machine_eps<dd_real>();
  two = 2;

  x = 1000;
  exp2_erfc_safe(x, y, data);
  y_expect = (char*)"0.000564189301453387654199745028061695727166402115006965391673638970767186230";
  EXPECT_TRUE(data.convergence);
  EXPECT_DOUBLE_EQ(y.x[0], y_expect.x[0]);
  EXPECT_NEAR(y.x[1], y_expect.x[1], eps);

  x = 1;
  exp2_erfc_safe(x, y, data);
  y_expect = (char*)"0.427583576155807004410750344490515180820159503164252663745539770740505422";
  EXPECT_TRUE(data.convergence);  
  EXPECT_DOUBLE_EQ(y.x[0], y_expect.x[0]);
  EXPECT_NEAR(y.x[1], y_expect.x[1], eps);

  //  x = 0.1 * sqrt(two)+0.01;
  x = 1;
  x = x / 100 + sqrt(two) / 10;
  exp2_erfc_safe(x, y, data);
  y_expect = (char*)"0.84969677805129388481366918087432309562268580614995884360988093850588676";
  EXPECT_TRUE(data.convergence);
  EXPECT_DOUBLE_EQ(y.x[0], y_expect.x[0]);
  EXPECT_NEAR(y.x[1], y_expect.x[1], eps);

  x = sqrt(two) / 100;
  exp2_erfc_safe(x, y, data);
  y_expect = (char*)"0.98424020092288885191445867736134214647609742652301131588156251063080162";
  EXPECT_TRUE(data.convergence);
  EXPECT_DOUBLE_EQ(y.x[0], y_expect.x[0]);
  EXPECT_NEAR(y.x[1], y_expect.x[1], eps);  

  x = sqrt(two)/1000;
  exp2_erfc_safe(x, y, data);
  y_expect = (char*)"0.99840622875270040632589756092830951970018875155597523417773450375510215";
  EXPECT_TRUE(data.convergence);
  EXPECT_DOUBLE_EQ(y.x[0], y_expect.x[0]);
  EXPECT_NEAR(y.x[1], y_expect.x[1], eps);
  
}


