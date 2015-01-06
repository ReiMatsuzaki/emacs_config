// * Begin          
// ** comment

/**
 * @file gto.hpp
 * @brief Gaussian type orbital basis.
 * @date 2014/1/7 new
 * @author Rei matsuzaki
 */

// ** ifndef

#ifndef GTO_HPP
#define GTO_HPP


// ** include

#include <src/math/sto_gto_int.hpp>
using namespace StongMath;

// ** start class

/**
 * radial gauss type orbital basis
 */
tempalte<class F>
class GTO {
  
private:
  unsigned int num;    /** number of primitive STOs. */
  F*           zs;     /** orbital exponent array (size = num)*/
  F*           cs;     /** coefficient array (size = num) */
  int*         pns;    /** principle number array (size = num) */
  F*           ns;     /** normalized constant array (size = num) */

// * Member         
// ** constructor/destructor
// *** Constructor  

public:
  /**
   * Constructor
   * @param _num number of primitive GTOs.
   */
  STO(unsigned int _num) :
    num(_num) {
    zs  = new F[num];
    cs  = new F[num];
    pns = new int[num];
    ns  = new F[num];
  }


// *** Destructor

  /** Destructor */
  ~STO() {
    delete[] zs;
    delete[] cs;
    delete[] pns;
    delete[] ns;
  }


#endif

// ** Accessor
// *** getter
  
  /** get number of term */
  const unsigned int Get_num() { return num; }

  /** get i th term of zs */
  const F Get_zs_i(unsigned int i ) { return zs[i]; }

  /** get i th term of cs */
  const F Get_cs_i(unsigned int i ) { return cs[i]; }

  /** get i th term of pns */
  const int Get_pns_i(unsigned int i) { return pns[i]; }

  /** get i th term of ns */
  const F Get_ns_i(unsigned int i) { return ns[i]; }
  
  
// *** setter

public:  
  //** set zs without normalization*/  
  void Set_zs_without_normalization(const F* _zs) {
    for(unsigned int i = 0; i < num; i++) 
      zs[i]= _zs[i];
    }

  //** set pns without normalization*/
  void Set_pns_without_normalization(const int* _pns) {
    for(unsigned int i = 0; i < num; i++) 
      pns[i]= _pns[i];  
  }
  
  //** set zs with normalization*/
  void Set_zs(const F* _zs) {
    for(unsigned int i = 0; i < num; i++) {
      zs[i]= _zs[i];
      Compute_ns_i(i);
    }
  }

  //** set cs*/
  void Set_cs(const F* _cs) {
    for(unsigned int i = 0; i < num; i++)
      cs[i]= _cs[i];
  }

  //** set pns with normalization*/
  void Set_pns(const int* _pns) {
    for(unsigned int i = 0; i < num; i++) {
      pns[i]= _pns[i];
      Compute_ns_i(i);
    }
  }

  //** compute and store normalization constant */
  void Compute_ns_i(unsigned int i) {
    F norm2 = STO_int(2 * pns[i], 2 * zs[i]);
    ns[i] = sqrt(norm2);
  }
  

// ** Factory (static)
// *** different principle number

  /** compute linear combination of normalized GTOs
   *  with different principle numbers.
   */
  
  static GTO* NormalizedGTOs(int _num, F* _zs, F* _cs, int* _pns) {

    GTO* gto = new GTO(_num);
    gto->Set_zs_without_normalization(_zs);
    gto->Set_cs(_cs);
    gto->Set_pns(_pns);

    return gto;
  }

// *** same principle number

  /** compute linear combination of normalized GTOs
   *  with same principle numbers.
   */
  static GTO* NormalizedGTOs(int _num, F* _zs, F* _cs, int _pn) {

    int* _pns = new int[_num];

    for(unsigned int i = 0; i < _num; i++)
      _pns[i] = _pn;

    GTO<F>* ptr = GTO<F>::NormalizedGTOs(_num, _zs, _cs, _pns);

    delete[] _pns;

    return (ptr);
  }
// * End            


};
#endif

