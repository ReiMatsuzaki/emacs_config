#include <iostream>
#include <gtest/gtest.h>
#include <src/math/sto_gto_int.hpp>

using namespace std;

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

  
