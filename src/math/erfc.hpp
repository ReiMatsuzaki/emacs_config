// ** begin

#ifndef ERFC_H
#define ERFC_H

#include <math.h>
#include <iostream>
#include <complex>

typedef std::complex<double> DC;

// ** general
struct erfc_calc_data {
  int  num_term;
  bool convergence;
};

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

// ** double complex
DC erfc_dc_at_n(DC x, unsigned int n) {
  DC tmp;
  DC nnhh;
  double h = sqrt(M_PI / n);

  tmp = 0.0;
  for(unsigned int i = 0; i < n; i++) {
    nnhh = (2.0 * i + 1.0) * h / 2.0;
    nnhh = nnhh * nnhh;
    tmp += exp(-nnhh) / (nnhh + x * x);
  }
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
  
  if(x.real() + std::abs(x.imag()) < M_PI/h)
    tmp += 2.0 / (1.0 + exp(2*M_PI * x / h));
      
  return tmp;
}
DC erfc_dc_last_term_at_n(DC x, unsigned int n) {
  DC tmp;
  DC nnhh;
  DC h = sqrt(M_PI / n);

  nnhh = (2.0 * n - 1.0) * h / 2.0;
  nnhh = nnhh * nnhh;
  tmp = exp(-nnhh) / (nnhh + x * x);
  tmp *= 2.0 * h / M_PI * exp(-x*x) * x;
      
  return tmp;
}
int erfc_dc(DC x, DC &y,erfc_calc_data &data) {
  
  DC at_n, last_term, ratio;
  double eps = 1.5 * 2.22 * pow(10.0, -16.0);
  unsigned int i;

  data.convergence = false;
  for(i = 10; i < 15; i++) {
    at_n = erfc_dc_at_n(x, i);
    last_term = erfc_dc_last_term_at_n(x, i);
    ratio = last_term / at_n;
    data.num_term = i;

    if(abs(ratio) < eps) {
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
#endif
