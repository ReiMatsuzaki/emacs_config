include ../../makefile

# CXXFLAGS = ${CXXFLAGS_DBG} ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}
# CXXFLAGS = ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}
CXXFLAGS=${CXXFLAGS_DBG} ${CXXFLAGS_INC}

run_utest_mpack: utest_mpack.cpp ../support_mpack.hpp
	${RUN_GTEST} $< -lqd
	./$@
run_utest_erfc: utest_erfc.cpp ../erfc.hpp
	${RUN_GTEST} $< -lqd
	./$@
run_utest_factorial:utest_factorial.cpp ../factorial.hpp
	${RUN_GTEST} $<
	./$@
run_utest_sto_gto_int: utest_sto_gto_int.cpp ../sto_gto_int.hpp
	${RUN_GTEST} $< -lqd
	./$@
run_utest_newton: utest_newton.cpp ../newton.hpp
	${RUN_GTEST} $< -lmlapack_dd_ref -lmblas_dd_ref -lqd
	./$@

run_utest_all:run_utest_mpack run_utest_erfc run_utest_factorial run_utest_sto_gto_int 



