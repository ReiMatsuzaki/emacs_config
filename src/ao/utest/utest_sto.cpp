#include <iostream>
#include <stdio.h>
#include <gtest/gtest.h>
#include <src/ao/sto.hpp>
#include <src/math/support_mpack.hpp>
#include <sage/result/ref_real200_exp2_erfc.h>

using namespace std;
// using namespace StongMath;

TEST(double_STO, Construct) {

  STO<double> sto(3);
  double zs[] = {1.1, 1.2, 1.3};
  double cs[] = {2.1, 2.2, 2.3};
  int   pns[] = {1,   2,   3};
  //  double ns[] = {3.1, 3.2, 3.3};

  double eps = 0.000000001;

  sto.Set_zs_without_normalization(zs);
  sto.Set_cs(cs);
  sto.Set_pns_without_normalization(pns);
  
  EXPECT_EQ(sto.Get_pns_i(0), 1);
  EXPECT_EQ(sto.Get_pns_i(2), 3);
  EXPECT_EQ(sto.Get_pns_i(1), 2);

  EXPECT_NEAR(sto.Get_zs_i(1), 1.2, eps);
  EXPECT_NEAR(sto.Get_cs_i(0), 2.1, eps);
  //  EXPECT_NEAR(sto.Get_ns_i(2), 3.3, eps);
    
}
TEST(double_STO, NormalizedSTO) {

  double zs[] = {1.1, 1.2, 1.3};
  double cs[] = {2.1, 2.2, 2.3};
  int   pns[] = {1,   2,   3};
  
  STO<double>* sto = STO<double>::NormalizedSTOs(3, zs, cs, pns);
  
  
  EXPECT_EQ(sto->Get_pns_i(0), 1);
  EXPECT_EQ(sto->Get_pns_i(2), 3);
  EXPECT_EQ(sto->Get_pns_i(1), 2);

  sto->Display();

  delete(sto);
  
}
TEST(double_STO, NormalizedSTO2) {

  double zs[] = {1.1, 1.2, 1.3};
  double cs[] = {2.1, 2.2, 2.3};
  
  STO<double>* sto = STO<double>::NormalizedSTOs(3, zs, cs, 2);

  EXPECT_EQ(sto->Get_pns_i(0), 2);
  
  delete(sto);
}





