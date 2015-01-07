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
// ** STO, STO
// *** c-product

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


// *** Hermitian default

/** <STO, STO>, Hermitian-product of STO and STO */
template<class F>
F HIP_sto_sto(const STO<F>& a, const STO<F>& b) {
  return CIP_sto_sto(a, b);
}

// *** Hermitian dd_complex

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


// ** GTO, GTO
// *** c-product

/** (GTO, GTO) : c-product of GTO and GTO */
template<class F>
F CIP_gto_gto(const GTO<F>& a, const GTO<F>& b) {

  F acc = value_zero<F>();
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc += a.Get_cs_i(i) * b.Get_cs_i(j) *
	a.Get_ns_i(i) * b.Get_cs_i(j) *
	GTO_int(a.Get_pns_i(i) + b.Get_pns_i(j),
		a.Get_zs_i(i) + b.Get_zs_i(j));
  return(acc);
}


// *** Hermitian product (default)

/** <GTO, GTO>, Hermitian-product of GTO and GTO */
template<class F>
F HIP_gto_gto(const STO<F>& a, const STO<F>& b) {
  return CIP_gto_gto(a, b);
}

// *** Hermitian product (dd_complex)

template<>
dd_complex HIP_gto_gto(const GTO<dd_complex>& a, 
		       const GTO<dd_complex>& b) {
  dd_complex acc = 0;
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc +=a.Get_cs_i(i).conjugate() * b.Get_cs_i(j) *
	a.Get_ns_i(i).conjugate() * b.Get_cs_i(j) *
	GTO_int(a.Get_pns_i(i).conjuagate() + b.Get_pns_i(j),
		a.Get_zs_i(i).conjugate() + b.Get_zs_i(j));

  return(acc);
}





// ** STO, GTO
// *** c-product

/** (STO, GTO) : c-product of STO and GTO */
template<class F>
F CIP_sto_gto(const STO<F>& a, const GTO<F>& b) {
  F acc = value_zero<F>();
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc += a.Get_cs_i(i) * b.Get_cs_i(j) *
	a.Get_ns_i(i) * b.Get_cs_i(j) *
	STO_GTO_int(a.Get_pns_i(i) + b.Get_pns_i(j),
		    a.Get_zs_i(i), b.Get_zs_i(j));
  return(acc);  
}

// *** Hermitian product (default)

/** <STO, GTO>, Hermitian-product of STO and GTO */
template<class F>
F HIP_sto_gto(const STO<F>& a, const GTO<F>& b) {
  return CIP_sto_gto(a, b);
}

// *** Hermitian product (dd_complex)

template<>
dd_complex HIP_sto_gto(const STO<dd_complex>& a, 
		       const GTO<dd_complex>& b) {
  dd_complex acc = 0;
  for(unsigned int i = 0; i < a.Get_num(); i++)
    for(unsigned int j = 0; j < b.Get_num(); j++) 
      acc +=a.Get_cs_i(i).conjugate() * b.Get_cs_i(j) *
	a.Get_ns_i(i).conjugate() * b.Get_cs_i(j) *
	STO_GTO_int(a.Get_pns_i(i).conjuagate() + b.Get_pns_i(j),
		    a.Get_zs_i(i).conjugate(), b.Get_zs_i(j));

  return(acc);
}



// ** GTO, STO
// *** c-product

template<class F>
F CIP_gto_sto(const GTO<F>& a, const STO<F>& b) {
  return (CIP_sto_gto(b, a));
}

// *** hermitian product (default)

template<class F>
F HIP_gto_sto(const GTO<F>& a, const STO<F>& b) {
  return HIP_sto_gto(b, a);
}

// *** Hermitian product (complex)

template<>
dd_complex HIP_gto_sto(const GTO<dd_complex>& a,
		       const STO<dd_complex>& b) {
  return conjugate(HIP_sto_gto(b, a));
}



// * End               

#endif
