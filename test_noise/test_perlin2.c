#include "noise_perlin2.h"
#include <math.h>
#include <stdio.h>

int main(void) {
  NoisePerlin2GridInit();
  // create ppm
  const int dimx = 1000, dimy = 1000;
  int i, j;
  FILE *fp = fopen("perlin2.ppm", "wb"); /* b - binary mode */
  fprintf(fp, "P6\n%d %d\n255\n", dimx, dimy);
  for (j = 0; j < dimy; ++j) {
    for (i = 0; i < dimx; ++i) {
      double perlin = noisePerlin2Recu((double)i, (double)j, 0.01, 4);
      static unsigned char color[3];
      color[0] = perlin * 255; /* red */
      color[1] = perlin * 255; /* green */
      color[2] = perlin * 255; /* blue */
      fwrite(color, 1, 3, fp);
    }
  }
  fclose(fp);
  return 0;
}
