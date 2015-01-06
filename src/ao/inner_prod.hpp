// * Begin           
// ** comment

/**
 * @file inner_prod.hpp
 * @brief inner product of STOs and GTOs.
 * @date 2014/1/6 new
 * @author Rei matsuzaki
 */

// ** ifndef

#ifndef INNER_PROD_HPP
#define INNER_PROD_HPP

// ** include

#include <src/math/sto_gto_int.hpp>
#include <src/math/support_mpack.hpp>
#include <qd/dd_real.h>
#include <dd_complex.h>
using namespace StongMath;


// * Functions       
// ** (STO, STO)

/** (STO, STO), c-product of STO and STO */
template<class F>
F CIP_sto_sto(const STO<F>& a, const STO<F>& b) {

  F acc = value_zero<F>();
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc += a.Get_cs_i(i) * b.Get_cs_i(j) *
	a.Get_ns_i(i) * b.Get_cs_i(j) *
	STO_int(a.Get_pns_i(i) + b.Get_pns_i(j),
		a.Get_zs_i(i) + b.Get_zs_i(j));

  return(acc);
}

// ** <STO, STO>
// *** default

/** <STO, STO>, Hermitian-product of STO and STO */
template<class F>
F HIP_sto_sto(const STO<F>& a, const STO<F>& b) {
  return CIP_sto_sto(a, b);
}

// *** dd_complex

template<>
dd_complex HIP_sto_sto(const STO<dd_complex>& a, 
		       const STO<dd_complex>& b) {
  dd_complex acc = 0;
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc +=a.Get_cs_i(i).conjugate() * b.Get_cs_i(j) *
	a.Get_ns_i(i).conjugate() * b.Get_cs_i(j) *
	STO_int(a.Get_pns_i(i).conjuagate() + b.Get_pns_i(j),
		a.Get_zs_i(i).conjugate() + b.Get_zs_i(j));

  return(acc);
}




#endif
