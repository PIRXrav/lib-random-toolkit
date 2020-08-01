/*
 *  Test RNG with test_testu01
 * http://www.iro.umontreal.ca/~simardr/testu01/guideshorttestu01.pdf
 * http://www.iro.umontreal.ca/~simardr/testu01/tu01.html
 */

#include <bbattery.h>
#include <ulcg.h>
#include <unif01.h>

#include <rng.h> // our rng
#include <time.h>

int main(void) {
  RNG_Srand(3);
  unif01_Gen *gen;
  gen = unif01_CreateExternGen01("OurLCG", RNG_RandDouble);
  // gen = ulcg_CreateLCG(0x7FFFFFFF, 1103515245U, 12345, 1);
  // ========================== TEST
  bbattery_SmallCrush(gen);
  // ========================== TIMER
  unif01_TimerSumGenWr(gen, 100000000, TRUE);
  unif01_DeleteExternGen01(gen);
  return 0;
}
