#include <stdint.h>
#include <stdio.h>

#include <check.h>
#include <time.h>

#include "rng.h"

START_TEST(TEST_RNG) {
  RNG_Srand(time(NULL));
  for (int i = 0; i < 255; i++) {
    printf("%d\n", RNG_RandInt());
  }
  for (int i = 0; i < 255; i++) {
    double val = RNG_RandDouble();
    ck_assert(val <= 1 && val >= 0);
  }
}
END_TEST

START_TEST(TEST_RNG_MEAN) {
  RNG_Srand(time(NULL));
  uint32_t N = 10000;
  double mean = 0;
  for (int i = 0; i < N; i++)
    mean += RNG_RandDouble() / N;
  printf("moyenne : %f\n", mean);
}
END_TEST

void test_rng(Suite *s) {
  TCase *tests = tcase_create("test rng");
  tcase_add_test(tests, TEST_RNG);
  tcase_add_test(tests, TEST_RNG_MEAN);
  suite_add_tcase(s, tests);
}
