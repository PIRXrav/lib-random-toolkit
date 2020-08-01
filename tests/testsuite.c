#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <check.h>

extern void test_rng(Suite *s);

Suite *test_suite(void) {
  Suite *s = suite_create("Default");
  test_rng(s);
  return s;
}

void run_testsuite() {
  Suite *s = test_suite();
  SRunner *sr = srunner_create(s);
  srunner_run_all(sr, CK_VERBOSE);
  srunner_free(sr);
}

int main(void) {
  srand((unsigned)time(NULL));
  run_testsuite();

  return EXIT_SUCCESS;
}
