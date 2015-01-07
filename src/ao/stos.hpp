// * Begin       
// ** comment

/**
 * @file stos.hpp
 * @brief Radial Slater type orbital basis.
 * @date 2014/1/6 new
 * @author Rei matsuzaki
 */

// ** ifndef

#ifndef STOS_HPP
#define STOS_HPP


// ** include

#include <src/math/sto_gto_int.hpp>
using namespace StongMath;


// ** start class

/**
 * radial slater type orbital basis.
 *
 */
template<class F>
class STO {

private:
  unsigned int num;    /** number of primitive STOs. */
  F*           zs;     /** orbital exponent array (size = num)*/
  F*           cs;     /** coefficient array (size = num) */
  int*         pns;    /** principle number array (size = num) */
  F*           ns;     /** normalized constant array (size = num) */

// * Member      
// ** constructor/destructor
// *** constructor
  
public:
  /**
   * Constructor
   * @param _num number of primitive STOs.
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
  


// ** accessor
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
  
// ** IO
// *** display

  /** display internal state of this object */
  void Display() {

    std::cout << std::endl;
    std::cout << "==========================" << std::endl;
    std::cout << "===STO.Display============" << std::endl;
    std::cout << std::endl;
    std::cout << "# of primitives : " << num  << std::endl;
    std::cout << "zs, cs, pns, ns " << std::endl;
    for (unsigned int i = 0; i < num; i++) {
      std::cout << zs[i] << " " << cs[i] << " " ;
      std::cout << pns[i] << " " << ns[i] << std::endl;
    }
    std::cout << std::endl;
    std::cout << "==========================" << std::endl;

  }
  
// ** Factory (static)
// *** different principle number

  /** compute linear combination of normalized STOs
   *  with different principle numbers.
   */
  
  static STO* NormalizedSTOs(int _num, F* _zs, F* _cs, int* _pns) {

    STO* sto = new STO(_num);
    sto->Set_zs_without_normalization(_zs);
    sto->Set_cs(_cs);
    sto->Set_pns(_pns);

    return sto;
  }

// *** same principle number

  /** compute linear combination of normalized STOs
   *  with same principle numbers.
   */
  static STO* NormalizedSTOs(int _num, F* _zs, F* _cs, int _pn) {

    int* _pns = new int[_num];

    for(unsigned int i = 0; i < _num; i++)
      _pns[i] = _pn;

    STO<F>* ptr = STO<F>::NormalizedSTOs(_num, _zs, _cs, _pns);

    delete[] _pns;

    return (ptr);
  }


// * End         

};
#endif




