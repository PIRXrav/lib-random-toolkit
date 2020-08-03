/*
 * Generate distribution
 */

#include "distrib.h"
#include "rng.h"
#include <argp.h>
#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static struct argp_option options[] = {
    {"n", 'n', "NUMBER", 0, "Sample size"},
    {"generator", 'g', "NAME", 0, "Distribution type"},
    {"mean", 'm', "NUMBER", 0, "Mean"},
    {"sd", 's', "NUMBER", 0, "Standard deviation"},
    {"lambda", 'l', "NUMBER", 0, "Lambda"},
    {"a", 'a', "NUMBER", 0, "a"},
    {"b", 'b', "NUMBER", 0, "b"},
    {0}};

/* Used by main to communicate with parse_opt. */
struct arguments {
  size_t n;
  char *g;
  double m; // Mean
  double s; // Sd
  double a; // a
  double b; // b
  double l; // lambda
};

static error_t parse_opt(int key, char *arg, struct argp_state *state) {
  struct arguments *arguments = state->input;
  switch (key) {
  case 'g':
    arguments->g = arg;
    break;
  case 'n':
    arguments->n = atoi(arg);
    break;
  case 'm':
    arguments->m = atof(arg);
    break;
  case 's':
    arguments->s = atof(arg);
    break;
  case 'a':
    arguments->a = atof(arg);
    break;
  case 'b':
    arguments->b = atof(arg);
    break;
  case 'l':
    arguments->l = atof(arg);
    break;
  default:
    return ARGP_ERR_UNKNOWN;
  }
  return 0;
}

#define CALLN(_n, _a)                                                          \
  {                                                                            \
    for (size_t icalln = 0; icalln < (_n); icalln++) {                         \
      _a;                                                                      \
    }                                                                          \
  }

/* Our argp parser. */
static struct argp argp = {options, parse_opt, NULL, NULL};

int main(int argc, char **argv) {
  /* Init RNG */
  RNG_Srand(0);
  /* Default values. */
  struct arguments arg = {
      .g = "norm", .n = 10U, .m = 0.f, .s = 1.f, .a = 0.f, .b = 10.f, .l = 1};
  argp_parse(&argp, argc, argv, 0, 0, &arg);

  if (strcmp(arg.g, "norm") == 0) {
    CALLN(arg.n, printf("%.*e\n", DBL_DIG, Normal(arg.m, arg.s)));
  } else if (strcmp(arg.g, "unifd") == 0) {
    CALLN(arg.n, printf("%.*e\n", DBL_DIG, Unifd(arg.a, arg.b)));
  } else if (strcmp(arg.g, "exp") == 0) {
    CALLN(arg.n, printf("%.*e\n", DBL_DIG, Exp(arg.l)));
  } else {
    fprintf(stderr, "Generator not supported\n");
    exit(1);
  }
  return 0;
}
