# 
# Calculation of Exp(x^2)Erfc(x) in high accuracy for reference.
#

def exp2_erfc(x):
    return exp(x*x)*error_fcn(x)

def print_one(f, x):
    y = exp2_erfc(x)
    line = "(char*)\""+str(x)+"\",\n(char*)\""+str(y)+"\",\n"
    f.write(line)


# start calculation
f = open('result/ref_real200_exp2_erfc.h', 'w')

RF=RealField(200)
xmin = RF(1)/10000
xmax = RF(1000)
ratio=RF(2)
x = xmin
i=0
f.write("char* x_y_exp2_erfc[] = {\n")
while x < 2*xmax:
    i+=1
    print_one(f, x)
    x*=ratio
f.write("};\n")
f.write("unsigned int num_exp2_erfc = "+str(i)+";\n")
f.close()

    


