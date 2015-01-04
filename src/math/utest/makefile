include ../../makefile

CXXFLAGS = ${CXXFLAGS_DBG} ${CXXFLAGS_GTEST}

utest_erfc:utest_erfc.cpp ../erfc.hpp
utest_factorial:utest_factorial.cpp ../factorial.hpp

run_utest:utest_erfc utest_factorial
	./utest_factorial
	./utest_erfc

