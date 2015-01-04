#ifndef STO_GTO_INT_HPP
#define STO_GTO_INT_HPP

#include <src/math/erfc.hpp>
#include <src/math/factorial.hpp>
#include <math.h>

template<type F>
F STO_int(int n, F a) {
  return pow(a, -1 - n) * factorial(n)
}

template<type F>
F GTO_int(int n, F a) {
  return pow(sqrt(a), -1-n) * double_factorial(n);
}

template<type F>
F STO_GTO_int(int ns, F as, int ng, F ag) {
  
  return as * ag;

}

#endif
