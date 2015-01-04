include ../../makefile

CXXFLAGS = ${CXXFLAGS_DBG} ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}
#CXXFLAGS = ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}

utest_erfc:${HOME}/lib/libqd.a utest_erfc.cpp ../erfc.hpp
utest_factorial:utest_factorial.cpp ../factorial.hpp
utest_sto_gto_int:utest_sto_gto_int.cpp ../sto_gto_int.hpp

run_erfc:utest_erfc
	./$<

run_utest:utest_erfc utest_factorial utest_sto_gto_int
	./utest_factorial
	./utest_sto_gto_int	
	./utest_erfc


