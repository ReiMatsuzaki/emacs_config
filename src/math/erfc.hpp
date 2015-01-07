// * begin        
// ** ifndef

#ifndef ERFC_H
#define ERFC_H

// ** include

#include <math.h>
#include <iostream>
#include <qd/dd_real.h>
#include <mpack/dd_complex.h>
#include <src/math/support_mpack.hpp>

// ** namespace

namespace StongMath {



// * Utils        
// ** norm is lessear than

  template<class F> bool norm_is_less_than(F x, double y) {
    return true;}
  template<> bool norm_is_less_than(double x, double y) {
    return std::abs(x) < y; }
  template<> bool norm_is_less_than(dd_real x, double y) {
    dd_real xx = x>0 ? x : -x;
    return xx < y; }
  template<> bool norm_is_less_than(dd_complex x, double y) {
    dd_real xx = abs(x);
    return xx < y;}


// * Erfc         
// ** # of terms

  template<class F> int erfc_start_num_term() {
    return 0;}
  template<> int erfc_start_num_term<double>() {
    return 10; }
  template<> int erfc_start_num_term<dd_real>() {
    return 20; }
  template<> int erfc_start_num_term<dd_complex>() {
    return 20; }

// ** add Eh term or not
  template<class F>
  bool erfc_add_Eh_q(F x, F h) {return true; }
  template<> bool erfc_add_Eh_q(double x, double h) {
    return x < M_PI / h;
  }
  template<> bool erfc_add_Eh_q(dd_real x, dd_real h) {
    dd_real pi = value_pi<dd_real>();
    return x < pi / h;
  }
  template<> bool erfc_add_Eh_q(dd_complex x, dd_complex h) {
    dd_real pi = value_pi<dd_real>();
    return x.real() + abs(x.imag()) < pi / h.real();
  }    


// ** erfc using n term
  
  template<class F>
  int erfc_at_n(F x, unsigned int n, F& y, F& yn ) {

    F y0, yn0, one;
    F nnhh, h, xx, pi, t2;

    one = value_one<F>();
    pi = value_pi<F>();
    xx = x * x;
    h = sqrt(pi / (int)n);

    y0 = value_zero<F>();
    for(unsigned int i = 0; i < n; i++) {
      // nnhh = (2.0 * i + 1.0) * h / 2.0;
      nnhh = (2 * (int)i + 1) * h / 2;
      nnhh = nnhh * nnhh;
      t2 = exp(-nnhh) / (nnhh + xx);
      y0 += t2;
      yn0  = t2;
    }

    t2 = 2 * h / pi * exp(-xx) * x;
    y0  *= t2;
    yn0 *= t2;

    if(erfc_add_Eh_q<F>(x, h))
      y0 += 2 / (one + exp(2*pi*x/h));

    y = y0; yn = yn0;

    return(0);
  }

// ** erfc
  
  struct erfc_calc_data {
    int  num_term;
    bool convergence;
  };

  /*  
  template<class F>
  int erfc(F x, F & y, erfc_calc_data& data) {

    F y0, yn0, ratio;
    double eps = 1.0 * value_machine_eps<F>();

    unsigned n0, n1;
    n0 = erfc_start_num_term<F>();
    n1 = n0 + 10;

    data.convergence = false;
    for(unsigned n = n0; n < n1; n++) {
      erfc_at_n<F>(x, n, y0, yn0);
      ratio = yn0 / y0;
      data.num_term = n;

      if(norm_is_less_than(ratio, eps)) {
	data.convergence = true;
	break;
      }
    }

    y = y0;

    if(data.convergence)
      return (0);
    else 
      return (1);
  }
  */

  template<class F>
  int erfc(F x, F & y, erfc_calc_data& data) {

    F y0, yn0, ratio;
    double eps = 1.0 * value_machine_eps<F>();

    unsigned n0, n1;
    n0 = erfc_start_num_term<F>();
    n1 = n0 + 10;

    data.convergence = false;
    for(unsigned n = n0; n < n1; n++) {
      erfc_at_n<F>(x, n, y0, yn0);
      ratio = yn0 / y0;
      data.num_term = n;

      if(data.convergence)
	break;

      if(norm_is_less_than(ratio, eps) &&
	 norm_is_less_than(yn0, eps)) {
	data.convergence = true;
      }
    }

    y = y0;

    if(data.convergence)
      return (0);
    else 
      return (1);
  }


// * Exp(z^2) Erfc(z)
// ** calculated from n term

  template<class F>
  int exp2_erfc_at_n(F x, unsigned int n, F& y, F& yn) {

    F y0, yn0;
    F nnhh, h, xx, pi, t2;
    pi = value_pi<F>();
    xx = x * x;
    h = sqrt(pi / (int)n);

    y0 = value_zero<F>();
    for(unsigned int i = 0; i < n; i++) {
      nnhh = (2 * i + 1) * h / 2;
      nnhh = nnhh * nnhh;
      t2 = exp(-nnhh) / (nnhh + xx);
      y0 += t2;
      yn0 = t2;
    }

    t2 = 2 * h / pi * x;
    y0  *= t2;
    yn0 *= t2;

    if(erfc_add_Eh_q<F>(x, h))
      y0 += exp(xx) * 2 / (1 + exp(2*pi*x/h));

    y=y0; yn=yn0;
    return(0);
    
  }


// ** exp2_erfc

  template<class F>
  int exp2_erfc(F x, F& y, erfc_calc_data& data) {

    F y0, yn0, ratio;
    double eps = 1.0 * value_machine_eps<F>();

    unsigned n0, n1;
    n0 = erfc_start_num_term<F>();
    n1 = n0 + 10;

    data.convergence = false;
    for(unsigned n = n0; n < n1; n++) {
      exp2_erfc_at_n<F>(x, n, y0, yn0);
      ratio = yn0 / y0;
      data.num_term = n;

      if(data.convergence)
	break;

      if(norm_is_less_than(ratio, eps) &&
	 norm_is_less_than(yn0, eps)) {
	data.convergence = true;
      }
    }

    y = y0;

    if(data.convergence)
      return (0);
    else 
      return (1);    

  }

// ** exp2_erfc_safe
  
  template<class F>
  int exp2_erfc_safe(F x, F& y, erfc_calc_data& data) {
    return (exp2_erfc(x,y,data));
  }

  template<>
  int exp2_erfc_safe<dd_real>(dd_real x, dd_real& y, erfc_calc_data& d){

    int res;
    
    if(x > 1) 
      res = exp2_erfc(x, y, d);
    else {
      res = erfc(x, y, d);
      y *= exp(x * x);
    }
    res = exp2_erfc(x, y, d);
    return (res);
  }
  
  
// * Old          
// ** general


// ** double
double erfc_d_at_n(double x, unsigned int n) {

  double tmp;
  double nnhh;
  double h = sqrt(M_PI / n);

  tmp = 0.0;
  for(unsigned int i = 0; i < n; i++) {
    nnhh = (2.0 * i + 1.0) * h / 2.0;
    nnhh = nnhh * nnhh;
    tmp += exp(-nnhh) / (nnhh + x * x);
  }
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
  
  if(x < M_PI/h)
    tmp += 2.0 / (1.0 + exp(2*M_PI * x / h));
      
  return tmp;
}
double erfc_d_last_term_at_n(double x, unsigned int n) {
  double tmp;
  double nnhh;
  double h = sqrt(M_PI / n);

  nnhh = (2.0 * n - 1.0) * h / 2.0;
  nnhh = nnhh * nnhh;
  tmp = exp(-nnhh) / (nnhh + x * x);
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
      
  return tmp;
}
// ** double main
int erfc_d(double x, double &y,erfc_calc_data &data) {
  
  double at_n, last_term, ratio;
  double eps = 1.5 * 2.22 * pow(10.0, -16.0);
  unsigned int i;

  if(x < 0.01 or 3 < x) {
    std::cout << "I have not checked the accuracy for x= ";
    std::cout << x << ", so you must warn about the result.";
    std::cout << std::endl;
  }
  
  data.convergence = false;
  for(i = 10; i < 15; i++) {
    at_n = erfc_d_at_n(x, i);
    last_term = erfc_d_last_term_at_n(x, i);
    ratio = last_term / at_n;
    data.num_term = i;

    if(ratio < eps) {
      data.convergence = true;
      break;
    }
  }

  y = at_n;

  if(data.convergence)
    return(0);
  else
    return (1);
}


// ** double-double

dd_real erfc_dd_at_n(dd_real x, unsigned int n) {
  dd_real tmp=0;
  dd_real nnhh=0;
  dd_real one = 1;
  dd_real four =4;
  dd_real pi = four * atan(one);
  dd_real h = sqrt(pi / n);

  for(unsigned int i = 0; i < n; i++) {
    nnhh = (2*i+1)*h/2;
    nnhh = nnhh * nnhh;
    tmp += exp(-nnhh) / (nnhh + x * x);
  }
  tmp *= 2 * h / pi * exp(-x*x)*x;

  if(x < pi/h)
    tmp += 2 / (1 + exp(2*pi * x/h));

  return tmp;

}
dd_real erfc_dd_last_term_at_n(dd_real x, unsigned int n) {
  dd_real tmp=0;
  dd_real nnhh=0;
  dd_real one = 1;
  dd_real four =4;
  dd_real pi = four * atan(one);
  dd_real h = sqrt(pi / n);

  nnhh = (2*n-1)*h/2;
  nnhh = nnhh * nnhh;
  tmp += exp(-nnhh) / (nnhh + x * x);
  tmp *= 2 * h / pi * exp(-x*x)*x;

  return tmp;
}
int erfc_dd(dd_real x, dd_real &y, erfc_calc_data &data) {

  dd_real at_n, last_term, ratio;
  dd_real ten = 10;
  dd_real eps = 1.5 * 2.46519 * pow(ten, -32);
  unsigned int i;
  
  data.convergence = false;
  for(i = 20; i < 30; i++) {

    at_n = erfc_dd_at_n(x, i);
    last_term = erfc_dd_last_term_at_n(x, i);
    ratio = last_term / at_n;
    data.num_term = i;

    if(ratio < eps) {
      data.convergence = true;
      break;
    }
  }

  y = at_n;

  if(data.convergence)
    return (0);
  else
    return (1);
  
  
}

// ** template
// ** test

int test_dd() {

  dd_real mtmp = 1.23;
  dd_real mtmp2;
  mtmp2 = exp(mtmp);
  std::cout << mtmp.x[0] << std::endl;
  std::cout << mtmp2.x[0] << std::endl;
  return(0);
}
  

// * end          

}
  
#endif
