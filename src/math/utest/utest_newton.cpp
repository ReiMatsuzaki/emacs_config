#include <iostream>
#include <gtest/gtest.h>
#include <src/math/newton.hpp>

using namespace std;


dd_real hess_x2(dd_real x) {return 2; }
dd_real grad_x2(dd_real x) {return 2 * x; }
TEST(Newton, update) {
  double eps = 0.0001;
  FindMinNewton<dd_real> *solv = 
    new FindMinNewton<dd_real>(1, eps);
  dd_real* hess = new dd_real[1];
  dd_real* grad = new dd_real[1];
  dd_real* x0 = new dd_real[1];
  x0[0] = 1;

  solv->SetInitGuess(x0);

  solv->GetCurrent(x0);
  hess[0] = hess_x2(x0[0]);
  grad[0] = grad_x2(x0[0]);
  solv->Update(hess, grad);

  bool convQ = solv->ConvergenceQ();
  EXPECT_FALSE(convQ);

  solv->GetCurrent(x0);
  hess[0] = hess_x2(x0[0]);
  grad[0] = grad_x2(x0[0]);
  solv->Update(hess, grad);
  convQ =solv->ConvergenceQ();
  EXPECT_TRUE(convQ);

  dd_real zero = 0;
  EXPECT_DOUBLE_EQ(x0[0].x[0], zero.x[0]);
  EXPECT_DOUBLE_EQ(x0[0].x[1], zero.x[1]);
  
  delete solv;
  delete[] hess;
  delete[] grad;
  delete[] x0;
}
dd_real hess_x3(dd_real x) {return 6 * x; }
dd_real grad_x3(dd_real x) {return 3 * x * x; }
TEST(Newton, while_test) {
  
  double eps = pow(10.0, -20);
  FindMinNewton<dd_real> *solv = 
    new FindMinNewton<dd_real>(1, eps, 100);
  dd_real* hess = new dd_real[1];
  dd_real* grad = new dd_real[1];
  dd_real* x0 = new dd_real[1];

  // set initial guess
  x0[0] = 3;
  solv->SetInitGuess(x0);

  do {

    // compute hess and grad
    hess[0] = hess_x3(x0[0]);
    grad[0] = grad_x3(x0[0]);

    // update
    solv->Update(hess, grad);
    solv->GetCurrent(x0);


  } while(solv->ContinueQ());

  EXPECT_TRUE(solv->ConvergenceQ());

  dd_real zero = 0;
  EXPECT_NEAR(x0[0].x[0], zero.x[0], eps);
  EXPECT_DOUBLE_EQ(x0[0].x[1], zero.x[1]);

}



