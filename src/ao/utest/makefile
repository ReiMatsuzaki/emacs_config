include ../../makefile

CXXFLAGS=${CXXFLAGS_DBG} ${CXXFLAGS_INC}

run_utest_sto: utest_sto.cpp ../sto.hpp
	${RUN_GTEST} $< -lqd
	./$@

run_utest_all:run_utest_mpack run_utest_erfc run_utest_factorial run_utest_sto_gto_int 



