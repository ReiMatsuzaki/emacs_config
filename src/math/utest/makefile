include ../../makefile

# CXXFLAGS = ${CXXFLAGS_DBG} ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}
# CXXFLAGS = ${CXXFLAGS_INC} ${CXXFLAGS_GTEST}
CXXFLAGS=${CXXFLAGS_DBG} ${CXXFLAGS_INC}

run_utest_erfc: utest_erfc.cpp ../erfc.hpp
	${RUN_GTEST} $< -lqd
	./$@
run_utest_factorial:utest_factorial.cpp ../factorial.hpp
	${RUN_GTEST} $<
	./$@
run_utest_sto_gto_int: utest_sto_gto_int.cpp ../sto_gto_int.hpp
	${RUN_GTEST} $< -lqd
	./$@
#utest_erfc:${HOME}/lib/libqd.a utest_erfc.cpp ../erfc.hpp
#utest_factorial:utest_factorial.cpp ../factorial.hpp
#utest_sto_gto_int:${HOME}/lib/libqd.a utest_sto_gto_int.cpp ../sto_gto_int.hpp

run_utest:utest_erfc utest_factorial utest_sto_gto_int
	./utest_factorial
	./utest_sto_gto_int	
	./utest_erfc


