#!/usr/bin/env Rscript

options(warn=-1)

suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("stats"))

option_list <- list(
  make_option(c("-v", "--verbose"), action="store_true", default=FALSE,
              help="Print extra output [default]"),
  make_option("--generator", default="rnorm",
              help = "Theorical distribution [default \"%default\"]"),
  make_option("--mean", default=0,
              help="Mean if generator == \"rnorm\" [default %default]"),
  make_option("--sd", default=1, metavar="standard deviation",
              help="Standard deviation if generator == \"rnorm\" [default %default]")
)

# get command line options
opt <- parse_args(OptionParser(option_list=option_list))

# get stdin data
fd <- file("stdin")
u <- scan(fd, quiet=TRUE)
close(fd)

# summary data
if(opt$verbose){
  summary(u)
}

# test
# u = rnorm(100000, mean=opt$mean, sd=opt$sd) # OK
# u = runif(100000, opt$mean - opt$sd * 2, opt$mean + opt$sd * 2) # KO :)

# Kolmogorov-Smirnov test
# http://www.thibault.laurent.free.fr/cours/R_intro/chapitre5_tests.html
if(opt$generator == "norm") {
  res = ks.test(x = u, y = "pnorm", mean = opt$mean, sd = opt$sd)
  # shapiro.test(u) # normalite
  # cat(sprintf('norm test : mean=%f, sd=%f\n', opt$mean, opt$sd))

} else if(opt$generator == "unif") {
  print("exp test")
} else {
  cat("Generator not supported\n")
}

# result
if(opt$verbose){
  print(res)
} else{
  cat(sprintf("%f\n", res$p.value))
}
