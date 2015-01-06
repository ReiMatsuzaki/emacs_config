// * Begin    

#ifndef STO_GTO_INT_HPP
#define STO_GTO_INT_HPP

#include <math.h>
#include <stdio.h>
#include <iostream>
#include <src/math/support_mpack.hpp>
#include <src/math/erfc.hpp>
#include <src/math/factorial.hpp>
#include <src/math/sto_gto_int_minor.hpp>
#include <mpack/dd_complex.h>



using namespace std;

namespace StongMath {

// * STO      

  
  double STO_int(int n, double a) {

    return pow(a, -1.0 - n) * factorial(n);
  }
  dd_real STO_int(int n, dd_real a) {
    return pow(a, -1 - n) * factorial(n);
  }
  dd_complex STO_int(int n, dd_complex a) {
    return pow(a, -1.0 - n) * (1.0 * factorial(n));
  }
  std::complex<double> STO_int(int n, std::complex<double> a) {
    return pow(a, -1.0 - n) * (1.0 * factorial(n));
  }


// * GTO      

  template<class F>
  F GTO_int(int n, F a) {
    F res;
    if(n % 2 == 0) {
      int nn = n/2;
      res = double_factorial(2*nn-1) * sqrt(M_PI) /
	(pow(2, nn+1) * pow(sqrt(a), 2.0*nn+1.0));
    } else {
      int nn = (n-1)/2;
      res = (factorial(nn) * 1.0) / (2.0 * pow(a, nn+1));
    }
    return res;
  }
  
/*
  double GTO_int(int n, double a) {
    double res;
    if(n % 2 == 0) {
      int nn = n/2;
      res = double_factorial(2*nn-1) * sqrt(M_PI) /
	(pow(2, nn+1) * pow(sqrt(a), 2.0*nn+1.0));
    } else {
      int nn = (n-1)/2;
      res = (factorial(nn) * 1.0) / (2.0 * pow(a, nn+1));
    }
    return res;
  }
*/

// * STO-GTO  

  template<class F>
  F STO_GTO_int(int n, F as, F ag) {
  
    F res, erfc_val;
    erfc_calc_data data;
    

    erfc<F>(as / (2 * sqrt(ag)), erfc_val, data);
  
    switch(n) {
    case 0:
      res = sto_gto_int_0(as, ag);
      break;
    case 1:
      res = sto_gto_int_1(as, ag);
      break;
    case 2:
      res = sto_gto_int_2(as, ag);
      break;
    case 3:
      res = sto_gto_int_3(as, ag);
      break;
    case 4:
      res = sto_gto_int_4(as, ag);
      break;
    case 5:
      res = sto_gto_int_5(as, ag);
      break;
    case 6:
      res = sto_gto_int_6(as, ag);
      break;
    case 7:
      res = sto_gto_int_7(as, ag);
      break;
    case 8:
      res = sto_gto_int_8(as, ag);
      break;
    case 9:
      res = sto_gto_int_9(as, ag);
      break;      
      /*
    case 10:
      res = sto_gto_int_10(as, ag);
      break;
      */
    default:
      char msg[100];
      sprintf(msg, "n=%d is not supported in STO_GTO_int", n);
      std::cerr << msg << endl;
      break;
    }

    return res;
  }

  /*
  template<class F>
  F sto_gto_int_3(F as, F ag) {
    F erfcVal, expVal, sqrtPi,pi;
    erfc_calc_data data;
    erfc(as/(2*sqrt(ag)),erfcVal,data);
    expVal=exp(as*as/(4*ag));
    pi=value_pi<F>();
    sqrtPi=sqrt(pi);
    return(4*ag + pow(as,2))/(8*pow(ag,3)) - (as*(6*ag + \
						  pow(as,2))*erfcVal*expVal*sqrtPi)/(16*pow(ag,3.5));
}
  */

}
#endif
