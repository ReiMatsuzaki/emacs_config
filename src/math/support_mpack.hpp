// * Begin       
// ** ifndef

#ifndef SUPPORT_MPACK_HPP
#define SUPPORT_MPACK_HPP

// ** include

#include <qd/dd_real.h>
#include <mpack/dd_complex.h>


// * function    
// ** exp for dd complex

  inline dd_complex exp(dd_complex z) {
    dd_real zr, zi, exp_zr;
    dd_complex exp_z;
    zr = z.real();
    zi = z.imag();
    exp_zr = exp(zr);
    exp_z.real() = exp_zr * cos(zi);
    exp_z.imag() = exp_zr * sin(zi);
    return exp_z;
  }

// ** pow for dd complex

inline dd_complex pow(dd_complex z, int n) {

  dd_complex y = z;
  unsigned int nn = (unsigned int)n;
    for(unsigned int i = 1; i < nn; i++) 
    y *= z;

  return y;
}

// ** pow for double

/*
inline double pow(double x, int n) {
  double y = x;
  unsigned int nn = (unsigned int)n;
  for(unsigned int i = 1; i < nn; i++)
    y *= x;
  return y;
}
*/



// * namespace   
// ** namespace

namespace StongMath {
  
// * Constant    
// ** one

  template<class F> F value_one() {}
  template<> int value_one() {return 1;}
  template<> double value_one() {return 1.0;}
  template<> dd_real value_one() {
    dd_real one = 1;
    return one;
  }
  template<> dd_complex value_one() {
    dd_complex one;
    one.real() = 1;
    return one;
  }

// ** zero
  
  template<class F> F value_zero() {}
  template<> int value_zero() {return 0;}
  template<> double value_zero() {return 0.0;}
  template<> dd_real value_zero() {
    dd_real zero = 0;
    return zero;
  }
  template<> dd_complex value_zero() {
    dd_complex zero;
    dd_real r_zero = value_zero<dd_real>();
    zero.real() = r_zero;
    zero.imag() = r_zero;
    return zero;
  }

// ** pi
  template<class F> F value_pi (){}
  template<> double value_pi() {return M_PI;}
  template<> dd_real value_pi() {
    dd_real one = value_one<dd_real>();
    dd_real four =4;
    dd_real pi = four * atan(one);
    return pi;
  }
  template<> dd_complex value_pi() {
    dd_real pi = value_pi<dd_real>();
    return pi;
  }

// ** machine epsilon
  template<class F> double value_machine_eps() {
    return 1.0;}
  template<> double value_machine_eps<double>() {
    double eps = 2.22 * pow(10.0, -16.0);
    return eps;
  }
  template<> double value_machine_eps<dd_real>() {
    double eps = 2.46519 * pow(10.0, -32.0);
    return eps;
  }
  template<> double value_machine_eps<dd_complex>() {
    double eps = value_machine_eps<dd_real>();
    return eps;
  }
  

// * End         
}
#endif
