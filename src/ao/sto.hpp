// * Begin       
// ** comment

/**
 * @file sto.hpp
 * @brief Normalized primitive Radial Slater type orbital basis.
 * @date 2014/1/7 new
 * @author Rei matsuzaki
 */

// ** ifndef

#ifndef STO_HPP
#define STO_HPP


// ** include

#include <src/math/sto_gto_int.hpp>
using namespace StongMath;


// ** start class

/**
 * normalized primitive radial slater type orbital basis.
 *
 */
template<class F>
class STO {

private:  
  F           z;     /** orbital exponent*/
  int         pn;    /** principle number  */
  F           n;     /** normalized constant */

// * Member      
// ** constructor/destructor
// *** constructor
  
public:
  /**
   * Constructor
   */
  STO() {}


// *** Destructor
  
  /** Destructor */
  ~STO() {
  }
  


// ** accessor
// *** getter
  
  /** get zeta */
  const F Get_z() { return z; }

  /** get principle number  */
  const int Get_pn() { return pn; }

  /** get normalization constant */
  const F Get_n() { return n; }
  
  
// *** setter
  
public:  
  //** set z without normalization*/  
  void Set_z_without_normalization(F _zs) {
    z = _zs;
    }

  //** set pns without normalization*/
  void Set_pn_without_normalization(int _pn) {
    pn = _pn;
  }
  
  //** set zs with normalization*/
  void Set_z(F _z) {
    z = _z;
    Normalize();
  }

  //** set pn with normalization*/
  void Set_pn(int _pn) {
    pn = _pn;
    Normalize();
  }

   //** compute and store normalization constant */
  void Normalize() { 
    F norm2 = STO_int(2 * pn, 2 * z);
    n = sqrt(norm2);
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

  
  /** compute normalized STOs */
  static STO* New_NormalizedSTO(F _z, int _pn) {

    STO* sto = new STO();
    sto->Set_z_without_normalization(_z);
    sto->Set_pn_without_normalization(_pns);
    sto->Normalize();
    return sto;
    
  }


// * End         

};
#endif




