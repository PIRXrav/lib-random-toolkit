#ifndef _noise_perlin_H_
#define _noise_perlin_H_

/*******************************************************************************
 * Includes
 ******************************************************************************/

/*******************************************************************************
 * Macros
 ******************************************************************************/

/*******************************************************************************
 * Types
 ******************************************************************************/

/*******************************************************************************
 * Variables
 ******************************************************************************/

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

// init grid
void NoisePerlin2GridInit();

// Getters
double NoisePerlin2(double x, double y);
double noisePerlin2Recu(double x, double y, double freq, int depth);

#endif /* _noise_perlin_H_ */
