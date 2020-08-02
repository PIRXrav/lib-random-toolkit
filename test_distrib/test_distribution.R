#!/usr/bin/env Rscript

suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("stats"))

option_list <- list(
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
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
x <- scan(file("stdin"))
summary(x)

if( opt$generator == "norm") {
  cat(sprintf('norm test : mean=%f, sd=%f\n', opt$mean, opt$sd))
} else if(opt$generator == "unif") {
  print("exp test")
} else {
  cat("Generator not supported\n")
}
