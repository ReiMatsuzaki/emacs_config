#include <iostream>
#include <gtest/gtest.h>
#include <qd/dd_real.h>
#include <src/math/support_mpack.hpp>

using namespace std;
using namespace StongMath;

TEST(Real, Add) {
  dd_real a,b,c,d;
  a = 1; b = 2;d=3;
  c = a + b;
  EXPECT_DOUBLE_EQ(c.x[0],d.x[0]);
  EXPECT_DOUBLE_EQ(c.x[1],d.x[1]);
}
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
  
  x = "0.5";
  y = "0.1";
  z = x/y;
  expect = 5;
  
  EXPECT_DOUBLE_EQ(expect.x[0], z.x[0]);
  EXPECT_NEAR(expect.x[1], z.x[1], eps);

}
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
