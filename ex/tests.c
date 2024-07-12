/* Copyright 2023 The MathWorks, Inc. */
#include "pstunit.h"

extern double myAbs(double x);

PST_SUITE(abs_suite);

PST_TEST(abs_suite, test1) {
    PST_ASSERT(myAbs(2.0) == 2.0);
}

PST_TEST(abs_suite, test2) {
	PST_ASSERT(myAbs(-2.0) == 2.0);
}


PST_REGFCN(registerTests) {
    PST_ADD_TEST(abs_suite, test1);
    PST_ADD_TEST(abs_suite, test2);
}
