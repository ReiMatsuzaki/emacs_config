def exp2_erfc(x):
    return exp(x*x)*error_fcn(x)
    

RF=RealField(150)
x=RF(1.0); print exp(x*x)*error_fcn(x)
x=RF(1.0); print exp2_erfc(x)





