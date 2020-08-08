/*
 * NOISE Perlin
 *
 * https://cochoy-jeremy.developpez.com/tutoriels/2d/introduction-bruit-perlin/
 * https://en.wikipedia.org/wiki/Perlin_noise
 *
 */
/*******************************************************************************
 * Includes
 ******************************************************************************/

#include "noise_perlin2.h"
#include "rng.h"
#include <math.h>
#include <stdint.h>

/*******************************************************************************
 * Macros
 ******************************************************************************/

#define IXMAX 100
#define IYMAX 100

/*******************************************************************************
 * Types
 ******************************************************************************/

/*******************************************************************************
 * Internal function declaration
 ******************************************************************************/

double lerp(double a0, double a1, double w);
double smoothlerp(double a0, double a1, double w);
double dotGridGradient(int32_t ix, int32_t iy, float x, float y);

/*******************************************************************************
 * Variables
 ******************************************************************************/

// Precomputed (or otherwise) gradient vectors at each grid node
double Gradient[IYMAX][IXMAX][2];

/*******************************************************************************
 * Public function
 ******************************************************************************/

// init grid
void NoisePerlin2GridInit() {
  for (size_t iy = 0; iy < IYMAX; iy++) {
    for (size_t ix = 0; ix < IXMAX; ix++) {
      double angle = RNG_RandDouble() * 2 * 3.14159265358979323846;
      Gradient[iy][ix][0] = cos(angle);
      Gradient[iy][ix][1] = sin(angle);
    }
  }
}

// Getter
double NoisePerlin2(double x, double y) {
  // Determine grid cell coordinates
  int32_t x0 = (int32_t)x;
  int32_t x1 = x0 + 1;
  int32_t y0 = (int32_t)y;
  int32_t y1 = y0 + 1;

  // Determine interpolation weights
  // Could also use higher order polynomial/s-curve here
  double sx = x - (double)x0;
  double sy = y - (double)y0;

  // Interpolate between grid point gradients
  double n0, n1, ix0, ix1, value;
  n0 = dotGridGradient(x0, y0, x, y);
  n1 = dotGridGradient(x1, y0, x, y);
  ix0 = smoothlerp(n0, n1, sx);
  n0 = dotGridGradient(x0, y1, x, y);
  n1 = dotGridGradient(x1, y1, x, y);
  ix1 = smoothlerp(n0, n1, sx);
  value = smoothlerp(ix0, ix1, sy);

  return (value + 1.f) / 2.f;
}

// Perlin recu
double noisePerlin2Recu(double x, double y, double freq, int depth) {
  double amp = 1.0;
  double fin = 0;
  double norm = 0;

  for (int i = 0; i < depth; i++) {
    double coef = (double)(1 << i);
    fin += NoisePerlin2(x * freq * coef, y * freq * coef) * amp / coef;
    norm += amp / coef;
  }
  return fin / norm;
}

/*******************************************************************************
 * Internal function
 ******************************************************************************/

// Function to linearly interpolate between a0 and a1
// Weight w should be in the range [0.0, 1.0]
double lerp(double a0, double a1, double w) { return a0 + w * (a1 - a0); }

// Weight w should be in the range [0.0, 1.0]
double smoothlerp(double a0, double a1, double w) {
  // https://mrl.nyu.edu/~perlin/paper445.pdf
  return lerp(a0, a1, w * w * w * (10 + w * (-15 + w * 6)));
}

// Computes the dot product of the distance and gradient vectors.
double dotGridGradient(int ix, int iy, float x, float y) {

  // Compute the distance vector
  double dx = x - (double)ix;
  double dy = y - (double)iy;

  // Compute the dot-product
  return (dx * Gradient[iy % IYMAX][ix % IXMAX][0] +
          dy * Gradient[iy % IYMAX][ix % IXMAX][1]);
}
