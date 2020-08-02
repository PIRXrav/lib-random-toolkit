#!/usr/bin/env bash

# CST
n=5000    # sample size
th="0.01" # threshold p value

# sucess
fail=0
sucess=0

check_pval(){
  pval=$1
  if [ $(bc <<< "$pval >= $th") -ne 1 ]
  then
    echo -e "\e[31mFAIL\e[39m"
    fail=$((fail+=1))
  else
    echo -e "\e[32mSUCESS\e[39m"
    sucess=$((sucess+=1))
  fi
}

test_norm(){
  m=$1
  s=$2
  echo "Test N($m, $s) # $n --> "
  check_pval $(
    ./generator --generator=norm --mean=$m --sd=$s --n=$n |
    ./test_distribution.R --generator=norm --mean=$m --sd=$s
  )
}

# Begin tests
test_norm 0 0.1
test_norm 0 1
test_norm 0 10
test_norm 0 1000
test_norm 10 1
test_norm -100 10
test_norm 1000 1
test_norm -1000 100
test_norm -1000 3.1415

echo "--------------- summary ------------------"
echo "sucess    : $sucess"
echo "fail      : $fail"
echo "sucessrate: $(echo "100 * $sucess / ($sucess + $fail)" | bc)%"
