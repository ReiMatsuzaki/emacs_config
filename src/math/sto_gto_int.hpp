#ifndef STO_GTO_INT_HPP
#define STO_GTO_INT_HPP

#include <src/math/erfc.hpp>
#include <src/math/factorial.hpp>
#include <math.h>

template<class F>
F STO_int(int n, F a) {
  return pow(a, -1 - n) * (1.0 * factorial(n));
}

template<class F>
F GTO_int(int n, F a) {

  F res;

  if(n % 2 == 0) {
    int nn = n/2;
    //    res = double_factorial(2*nn-1)  /
    //      (pow(2.0*a, nn) * 2.0) * sqrt(M_PI/a);
    res = double_factorial(2*nn-1) * sqrt(M_PI) /
      (pow(2.0, nn+1) * pow(sqrt(a), 2*nn+1));
  } else {
    int nn = (n-1)/2;
    res = (factorial(nn) * 1.0) / (2.0 * pow(a, nn+1));
  }

  return res;
}

template<class F>
F STO_GTO_int(int ns, F as, int ng, F ag) {
  
  return as * ag;

}

#endif
