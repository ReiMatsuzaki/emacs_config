// * Begin     

#ifndef NEWTON_HPP
#define NEWTON_HPP

#include <qd/dd_real.h>
#include <mpack/mblas_dd.h>
#include <mlapack_dd.h>
#include <memory.h>


// * Test      
// ** print
void print_vector(std::string name, dd_real* a, mpackint n) {
  
  std::cout << std::endl << name << std::endl;
  for(unsigned int i = 0; i < n; i++)
    std::cout << a[i].x[0] << "  ";
  std::cout << std::endl;
}

// ** blas
int blas_test() {

  mpackint n = 3;
  dd_real *A = new dd_real[n * n];
  dd_real *x = new dd_real[n];
  dd_real *b = new dd_real[n];

  // setting A matrix
  A[0+0*n] = 1; A[0+1*n]=4; A[0+2*n]=6;
  A[1+0*n] = 1; A[1+1*n]=12; A[1+2*n]=14;
  A[2+0*n] = 3; A[2+1*n]=9; A[2+2*n]=23;

  // setting solution vector
  x[0] = 2; x[1] = 4; x[2] = 6;
  b[0] = 1; b[1] = 1; b[2] = 1;

  // compute LH
  // Rgemv is mBlas level 2 routine.
  // b = alpha Ax + beta b
  dd_real alpha = 1;
  dd_real beta = 0;
  Rgemv("N", n, n, alpha, A, n, x, 1, beta, b, 1);

  print_vector("RHS", b, n);
  
  // solve linear equation
  mpackint *ipiv =new mpackint[n];
  mpackint info;
  Rgesv(n, 1, A, n, ipiv, b, n, &info);
  print_vector("calc", b, n);
  print_vector("exact", x, n);
  std::cout << std::endl;
  
  // free
  delete[] A;
  delete[] x;
  delete[] b;
  delete[] ipiv;
  return(0);
  
}

// ** Real ?

template<class F>
void add_real (F a, F b, F &c) {
  c = a + b;
}

// * Utils               
// ** copy from old to new
/*
template<class F>
void copy_array(F* a, F* b, unsigned int n) {
  
  for(unsigned int i = 0; i < n; i++)
    b[i] = a[i];
  
}
*/


// * Class Begin         
// ** field member

template<class F>
class FindMinNewton {

private:

  // ---- calculation setting ----
  int n;        // variable size
  double eps;   // convergence epsilon  
  int max_iter; // maximum iteration number
  

  // ----- states ----
  F* xs_old;      // old value vector
  F* xs;          // current value vector
  int iter_count; // iteration count
  F dx_max;       // max_i {x_i-x_i^old}_i
  F grad_max;     // max_i {d_i f(x)}_i
  

// * Member Function     
// ** constructor

public:
  FindMinNewton(int _n, double _eps) :
    n(_n), eps(_eps), max_iter(20) {
    xs = new F[n];
    xs_old = new F[n];
    iter_count = 0;
  }
  FindMinNewton(int _n, double _eps, int _max) :
    n(_n), eps(_eps), max_iter(_max) {
    xs = new F[n];
    xs_old = new F[n];
    iter_count = 0;
  }

  ~FindMinNewton() {
    delete[] xs;
    delete[] xs_old;
  }

// ** set initial guess

public:
  void SetInitGuess(F* xs0) {
    
    for(unsigned int i = 0; i < n; i++) {
      xs[i] = xs0[i];
      xs_old[i] = xs[i];
    }
    
  }

// ** get current value

public:
  void GetCurrent(F* xs1) {
    for(unsigned int i = 0; i < n; i++) 
      xs1[i] = xs[i];
  }
  
// ** update

public:
  void Update(F *hess, F *grad) {

    // variable for Rgesv in mpack
    mpackint *ipiv = new mpackint[n];
    mpackint info;

    // update vector
    F *d = new F[n];

    // solve linear equation and compute update vector
    for(unsigned int i = 0; i < n; i++) 
      d[i] = grad[i];
    Rgesv(n, 1, hess, n, ipiv, d, n, &info);

    // update
    for(unsigned int i = 0; i < n; i++)  {
      xs_old[i] = xs[i];
      xs[i] -= d[i];
    }

    // compute maximum of update and gradient
    dx_max = -1; grad_max = -1;
    for(unsigned int i = 0; i < n; i++) {
      F abs_dx = abs(d[i]);
      F abs_grad = abs(grad[i]);
      
      if(grad_max < abs_grad)
	grad_max = abs_grad;
      if(dx_max < abs_dx)
	dx_max = abs_dx;
    }

    // count
    iter_count++;

    // free
    delete[] ipiv;
    delete[] d;
	
  }

// ** Convergence ?

public:
  bool ConvergenceQ() {
    bool res1 = dx_max < eps && grad_max < eps;
    bool res2 = iter_count != 0;
					  
    return( res1 && res2);

  }

// ** Continue ?

public:
  bool ContinueQ() {
    return (!ConvergenceQ() && iter_count < max_iter);
  }


// * End                 
};
#endif
