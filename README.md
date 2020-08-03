# lib-random-toolkit

A set of functions on pseudo-random numbers that simulate random variables and various noises.

## Install

```
	todo
```

## Random number generator (RNG)
##### Mutivation
##### usage
##### Empirical statistical testing of uniform random number generators
```
	$ make run_rng_test
```

## Random variables
##### Motivation
##### Usage
##### Testing samples with the Kolmogorov Smirnov test
* `./test_distrib/generator [theorical distribution config]`: generate a sample according to the desired distribution on the standard output
* `./test_distrib/test_distribution.R [theorical distribution config]`: Returns the p-value (H0: {F_emp = F_th}) of the Kolmogorov – Smirnov test on the data coming from stdin.

Exemple:
```
$ cd ./test_distrib
$ make generator
$ ./generator --generator=norm --mean=10 --sd=3.14 --n=10000
 |./test_distribution.R --generator=norm --mean=10 --sd=3.14 --verbose
 && firefox Rplot.pdf

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# -1.423   7.837   9.953   9.987  12.136  21.033
#
#        One-sample Kolmogorov-Smirnov test
#
# D = 0.010176, p-value = 0.2516
```
<p align="center">
	<img src="/doc/rplotnorm.png" alt="output plot" width="400"/>
</p>

Automated test:
```
$ make run_test_distrib
```


## Noises
todo
