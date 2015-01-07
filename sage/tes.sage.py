# This file was *autogenerated* from the file tes.sage
from sage.all_cmdline import *   # import sage library
_sage_const_1p0 = RealNumber('1.0'); _sage_const_150 = Integer(150)
def exp2_erfc(x):
    return exp(x*x)*error_fcn(x)
    

RF=RealField(_sage_const_150 )
x=RF(_sage_const_1p0 ); print exp(x*x)*error_fcn(x)
x=RF(_sage_const_1p0 ); print exp2_erfc(x)





