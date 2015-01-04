#include <iostream>
#include <gtest/gtest.h>
#include <src/math/sto_gto_int.hpp>

using namespace std;
using namespace StongMath;

TEST(dd_check, sqrt) {
  double eps = 4.0 * value_machine_eps<dd_real>();
  dd_real pi = value_pi<dd_real>();
  dd_real sqrt_pi = sqrt(pi);
  dd_real expect = (char*)"1.7724538509055160272981674833411451827975494561223871282138077898529112845910322";

  EXPECT_DOUBLE_EQ(sqrt_pi.x[0], expect.x[0]);
  EXPECT_NEAR(sqrt_pi.x[1], expect.x[1], eps);
}
TEST(dd_check, div) {

  dd_real x,y,z, expect;
  double eps = 4.0 * value_machine_eps<dd_real>();
  
  x = 0.5; y =0.1;
  z = x/y;
  expect = 5;
  
  EXPECT_DOUBLE_EQ(expect.x[0], z.x[0]);
  EXPECT_NEAR(expect.x[1], z.x[1], eps);

  x = 0.5; y = 0.1;
  z = x * inv(y);
  expect = 5;
  EXPECT_DOUBLE_EQ(expect.x[0], z.x[0]);
  EXPECT_NEAR(expect.x[1], z.x[1], eps);

}
TEST(STO, Double) {
  double x = 1.1;
  double y = 1.5026296018031555221637866265965440;
  double z = STO_int(2, x);
  EXPECT_DOUBLE_EQ(y, z);
}
TEST(STO, DoubleComplex) {
   
  std::complex<double> x(1.1, -2.3);
  std::complex<double> y(-0.030107181121109204859773817443366829 ,-0.138783712054900038514057631035327895);
  std::complex<double> z = STO_int(3, x);
  double eps = pow(10.0, -10);
  EXPECT_NEAR(y.real(), z.real(), eps);
  EXPECT_NEAR(y.imag(), z.imag(), eps);
}
TEST(GTO, Double) {
  double x = 1.1;
  double y = 0.3840837359097032615988967440087721449512;
  double z = GTO_int(2, x);
  EXPECT_DOUBLE_EQ(y, z);
  
  x = 1.1;
  y = 0.4132231404958677685950413223140495867769;
  z = GTO_int(3, x);
  EXPECT_DOUBLE_EQ(y, z);  
}
TEST(GTO, DoubleComplex) {
  
  std::complex<double> x(1.1, -2.3);
  std::complex<double> y(-0.01262427599494484245598991901270428310951, 0.10811582531034464917648143354989700487491);
  std::complex<double> z = GTO_int(2, x);
  double eps = pow(10.0, -10);
  EXPECT_NEAR(y.real(), z.real(), eps);
  EXPECT_NEAR(y.imag(), z.imag(), eps);
}
TEST(STO_GTO, Double) {

  int pn;
  double as, ag, y, y_expect,eps;
  eps = 4.0 * value_machine_eps<double>();
  
  pn = 0; as = 1.1; ag = 1.3;
  y_expect = 0.48566757012515757667736758130877904;
  y = STO_GTO_int(pn, as, ag);
  EXPECT_NEAR(y_expect, y, eps);

  pn = 1; as = 1.1; ag = 0.1;
  y_expect = 0.585719411226244633762213101544943;
  y = STO_GTO_int(pn, as, ag);
  EXPECT_NEAR(y_expect, y, eps);

  pn = 3;  as = 1.1; ag = 1.3;
  y_expect =  0.090836863478013385158773890626347914;
  y = STO_GTO_int(pn, as, ag);
  EXPECT_NEAR(y_expect, y, eps);

  pn = 8;
  y_expect = 0.27193461725393429405975733254931307;
  y = STO_GTO_int(pn, as, ag);
  EXPECT_NEAR(y_expect, y, eps);

  /*
  pn = 10;
  y_expect = 0.75533967406133247170809884662546579;
  y = STO_GTO_int(pn, as, ag);
  EXPECT_NEAR(y_expect, y, eps);
  */
}

TEST(STO_GTO, n_1) {
  dd_real as, ag, t0, t1;
  dd_real erfcVal, expVal, sqrtPi,pi,res;
  erfc_calc_data data;
  double eps = 4.0 * value_machine_eps<dd_real>();
  
  dd_real sqrt_ag = sqrt(ag);
  erfc(as/(2*sqrt_ag),erfcVal,data);
  expVal=exp(as*as/(4*ag));
  pi=value_pi<dd_real>();
  sqrtPi=sqrt(pi);

  as = 1.1;
  ag = 0.1;
  EXPECT_NEAR(ag.x[1], 0.0, eps);
  
  dd_real one_two = 0.5;
  t0 = one_two / ag;
  t1 = 5;
  EXPECT_NEAR(t0.x[1], t1.x[1], eps);

  t0 = - (as*erfcVal*expVal*sqrtPi) / (4*ag*sqrt_ag);
  t1 = (char*)"-4.4142805887737553662377868984550566571229782666631755745732489021234904539097795";
  EXPECT_DOUBLE_EQ(t0.x[0], t1.x[0]);
  EXPECT_NEAR(t0.x[1], t1.x[1], eps);
  
}
TEST(STO_GTO, DoubleDouble) {

  dd_real as, ag, y;
  double eps = 4.0 * value_machine_eps<dd_real>();
  
  as.x[0] = 1.1; ag.x[0] = 0.1;
  as.x[1] = 0.0; ag.x[1] = 0.0;
  y = (char*)"0.58571941122624463376221310154494334287702173333682442542675109787650954609022047";
  
  dd_real y1 = STO_GTO_int(1, as, ag);
  EXPECT_DOUBLE_EQ(y.x[0], y1.x[0]);
  EXPECT_NEAR(y.x[1], y1.x[1],eps);

  as = 1.1; ag = 3;
  y = (char*)"0.02498252858852675878686270017945428022426874388163742953284688301864";
  dd_real y2 = STO_GTO_int(2, as, ag);
  EXPECT_DOUBLE_EQ(y.x[0], y2.x[0]);
  EXPECT_NEAR(y.x[1], y2.x[1],eps);


  as = 0.5; ag = 0.01;
  y = (char*)"2437.980152853301720785910520950149994561404997016298575752944667317";
  dd_real y5 = STO_GTO_int(5, as, ag);
  EXPECT_DOUBLE_EQ(y.x[0], y5.x[0]);
  EXPECT_NEAR(y.x[1], y5.x[1],eps);
	      
	      
}
  
