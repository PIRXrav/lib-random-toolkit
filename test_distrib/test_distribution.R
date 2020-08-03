#!/usr/bin/env Rscript

options(warn=-1)

suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("stats"))


option_list <- list(
  make_option(c("-v", "--verbose"), action="store_true", default=FALSE,
              help="Print extra output [default]"),
  make_option("--generator", default="rnorm",
              help = "Theorical distribution [default \"%default\"]"),
  make_option("--mean", default=0,  metavar=" Mean",
              help="Mean if generator == \"rnorm\" [default %default]"),
  make_option("--sd", default=0, metavar="standard deviation",
              help="Standard deviation if generator == \"rnorm\" [default %default]"),
  make_option("--a", default=0, metavar="a",
              help="a if generator == \"unifd\" or \"unifi\" [default %default]"),
  make_option("--b", default=0, metavar="b",
              help="b if generator == \"unifd\" or \"unifi\" [default %default]"),
  make_option("--lambda", default=0, metavar="Lambda",
              help="Lambda if generator == \"exp\" [default %default]")
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
  if (opt$verbose){
    pdf("Rplot.pdf", width=6,height=4)

    plot(ecdf(u), main = "norm cumulative distribution function", lwd = 2, col = "grey")
    x <- seq(opt$mean - opt$sd * 4, opt$mean + opt$sd * 4,  length.out=100)
    lines(x, pnorm(x, opt$mean, opt$sd), lty = 2, lwd = 2, col = "magenta")
    rug(u, col = "grey")
    legend("topleft", c("emp", "th"), lty = 1:2, lwd = 2, col = c("grey", "magenta"), cex = 0.7)
  }
} else if (opt$generator == "unifd"){
  res = ks.test(x = u, y = "punif", opt$a, opt$b)
  if (opt$verbose){
    plot(ecdf(u), main = "unif cumulative distribution function", lwd = 2, col = "grey")
    x <- seq(opt$a, opt$b,  length.out=100)
    lines(x, punif(x, opt$a, opt$b), lty = 2, lwd = 2, col = "magenta")
    rug(u, col = "grey")
    legend("topleft", c("emp", "th"), lty = 1:2, lwd = 2, col = c("grey", "magenta"), cex = 0.7)
  }
} else if(opt$generator == "exp") {
  res = ks.test(x = u, "pexp", opt$lambda)
  if (opt$verbose){
    plot(ecdf(u), main = "exp cumulative distribution function", lwd = 2, col = "grey")
    x <- seq(0, opt$lambda*3,  length.out=100)
    lines(x, pexp(x, opt$lambda), lty = 2, lwd = 2, col = "magenta")
    rug(u, col = "grey")
    legend("topleft", c("emp", "th"), lty = 1:2, lwd = 2, col = c("grey", "magenta"), cex = 0.7)
  }
} else {
  cat("Generator not supported\n")
}

# result
if(opt$verbose){
  print(res)
} else{
  cat(sprintf("%f\n", res$p.value))
}
