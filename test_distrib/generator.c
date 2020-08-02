/*
 * Generate distribution
 */

#include "distrib.h"
#include <stdio.h>
#include <stdlib.h>

int main(void) {
  for (size_t i = 0; i < 10; i++)
    printf("%f\n", Normal(0, 1));
  return 0;
}
