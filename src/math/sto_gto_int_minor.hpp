#ifndef STO_GTO_INT_MINOR_HPP
#define STO_GTO_INT_MINOR_HPP

//This file is produce by mathematica. The file is located in 
// research/sto-ng_least_square/sto_gto_int_code in Dropbox.

using namespace std;

namespace StongMath {

template<class F>
F sto_gto_int_0(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (erfcVal*expVal*sqrtPi)/(2*sqrt(ag));

return (res);
}


template<class F>
F sto_gto_int_1(F as, F ag) {

  F exp2erfc, sqrtPi, sqrt_ag, pi, res;
  erfc_calc_data data;
  
  sqrt_ag = sqrt(ag);
  pi = value_pi<F>();
  sqrtPi = sqrt(pi);
  
  exp2_erfc(as/(2*sqrt_ag), exp2erfc, data);

  res = 1/(2*ag) - (as * exp2erfc * sqrtPi) /
    (4*ag*sqrt_ag);  
  
  return(res);

/* original code
   F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = 1/(2*ag) - (as*erfcVal*expVal*sqrtPi)/(4*pow(ag,1.5));
return (res);
*/
//  res = 1/(2*ag) - (as*erfcVal*expVal*sqrtPi)/(4*pow(sqrt(ag),3));


/*
    F erfcVal, expVal, sqrtPi,pi,res;
 erfc_calc_data data;
 F sqrt_ag = sqrt(ag);
 erfc(as/(2*sqrt_ag),erfcVal,data);
 expVal=exp(as*as/(4*ag));
 pi=value_pi<F>();
 sqrtPi=sqrt(pi);
 res = 1/(2*ag) - (as*erfcVal*expVal*sqrtPi) /
   (4*ag*sqrt_ag);
 // res = 1 / (2 * ag) * (1 - (as*erfcVal*expVal*sqrtPi)/(2*sqrt_ag));
 return res;
*/
}


template<class F>
F sto_gto_int_2(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
 res = (-2*sqrt(ag)*as + (2*ag + pow(as,2))*erfcVal*expVal*sqrtPi)/(8*pow(sqrt(ag),5));

return (res);
}


template<class F>
F sto_gto_int_3(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (4*ag + pow(as,2))/(8*pow(ag,3)) - (as*(6*ag + pow(as,2))*erfcVal*expVal*sqrtPi)/(16*pow(ag,3.5));

return (res);
}


template<class F>
F sto_gto_int_4(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (-2*sqrt(ag)*as*(10*ag + pow(as,2)) + (12*pow(ag,2) + 12*ag*pow(as,2) + pow(as,4))*erfcVal*expVal*sqrtPi)/(32*pow(ag,4.5));

return (res);
}


template<class F>
F sto_gto_int_5(F as, F ag) {
  F sqrtPi,pi,res, sqrt_ag, exp2erfcVal;
erfc_calc_data data;
// erfc(as/(2*sqrt(ag)),erfcVal,data);
// expVal=exp(as*as/(4*ag));
 exp2_erfc(as/(2*sqrt(ag)), exp2erfcVal, data);
 

pi=value_pi<F>();
sqrtPi=sqrt(pi);
 sqrt_ag = sqrt(ag);

/*
 res = (2*sqrt(ag)*(2*ag + pow(as,2))*(16*ag + pow(as,2)) - as*(60*pow(ag,2) + 20*ag*pow(as,2) + pow(as,4))*erfcVal*expVal*sqrtPi)/(64*pow(sqrt(ag),11));
*/

 F x = sqrt_ag;
 
  res = (2*sqrt_ag*(2*ag + as*as)*(16*ag + as*as) -
	 as*(60*ag*ag + 20*ag*as*as + as*as*as*as)*
	 exp2erfcVal*sqrtPi)/
    (64*x*ag*ag*ag*ag*ag);
				 
return (res);
}


template<class F>
F sto_gto_int_6(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (-2*sqrt(ag)*as*(6*ag + pow(as,2))*(22*ag + pow(as,2)) + (120*pow(ag,3) + 180*pow(ag,2)*pow(as,2) + 30*ag*pow(as,4) + pow(as,6))*erfcVal*expVal*sqrtPi)/(128*pow(ag,6.5));

return (res);
}


template<class F>
F sto_gto_int_7(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (2*sqrt(ag)*(384*pow(ag,3) + 348*pow(ag,2)*pow(as,2) + 40*ag*pow(as,4) + pow(as,6)) - as*(840*pow(ag,3) + 420*pow(ag,2)*pow(as,2) + 42*ag*pow(as,4) + pow(as,6))*erfcVal*expVal*sqrtPi)/(256*pow(ag,7.5));

return (res);
}


template<class F>
F sto_gto_int_8(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (-2*sqrt(ag)*as*(2232*pow(ag,3) + 740*pow(ag,2)*pow(as,2) + 54*ag*pow(as,4) + pow(as,6)) + (1680*pow(ag,4) + 3360*pow(ag,3)*pow(as,2) + 840*pow(ag,2)*pow(as,4) + 56*ag*pow(as,6) + pow(as,8))*erfcVal*expVal*sqrtPi)/(512*pow(ag,8.5));

return (res);
}


template<class F>
F sto_gto_int_9(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (2*sqrt(ag)*(6144*pow(ag,4) + 7800*pow(ag,3)*pow(as,2) + 1380*pow(ag,2)*pow(as,4) + 70*ag*pow(as,6) + pow(as,8)) - as*(15120*pow(ag,4) + 10080*pow(ag,3)*pow(as,2) + 1512*pow(ag,2)*pow(as,4) + 72*ag*pow(as,6) + pow(as,8))*erfcVal*expVal*sqrtPi)/(1024*pow(ag,9.5));

return (res);
}


template<class F>
F sto_gto_int_10(F as, F ag) {
F erfcVal, expVal, sqrtPi,pi,res;
erfc_calc_data data;
erfc(as/(2*sqrt(ag)),erfcVal,data);
expVal=exp(as*as/(4*ag));
pi=value_pi<F>();
sqrtPi=sqrt(pi);
res = (-2*sqrt(ag)*as*(46320*pow(ag,4) + 21120*pow(ag,3)*pow(as,2) + 2352*pow(ag,2)*pow(as,4) + 88*ag*pow(as,6) + pow(as,8)) + (30240*pow(ag,5) + 75600*pow(ag,4)*pow(as,2) + 25200*pow(ag,3)*pow(as,4) + 2520*pow(ag,2)*pow(as,6) + 90*ag*pow(as,8) + pow(as,10))*erfcVal*expVal*sqrtPi)/(2048*pow(ag,10.5));

return (res);
}


}
#endif
