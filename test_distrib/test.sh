#!/usr/bin/env bash

# CST
n=5000    # sample size
th="0.01" # threshold p value

# sucess
fail=0
sucess=0

check_pval(){
  pval=$1
  echo $pval
  if [ $(bc <<< "$pval >= $th") -ne 1 ]
  then
    echo -e "\e[31mFAIL\e[39m"
    fail=$((fail+=1))
  else
    echo -e "\e[32mSUCESS\e[39m"
    sucess=$((sucess+=1))
  fi
}

test(){
  config=$@
  printf "test $config --> "
  check_pval $(./generator $config --n=$n | ./test_distribution.R $config)
}

# Begin tests
test --generator=norm --mean=0 --sd=1
test --generator=norm --mean=0 --sd=10
test --generator=norm --mean=0 --sd=1000
test --generator=norm --mean=-100 --sd=10
test --generator=norm --mean=1000 --sd=1
test --generator=norm --mean=-1000 --sd=100
test --generator=norm --mean=-1000 --sd=3.1415

test --generator=unifd --a=0 --b=1
test --generator=unifd --a=0.1 --b=0.2
test --generator=unifd --a=10 --b=100
test --generator=unifd --a=0.3 --b=3.1425
test --generator=unifd --a=100000000 --b=100000001
test --generator=unifd --a=0.0000001 --b=0.0000002

test --generator=exp --lambda=1
test --generator=exp --lambda=2
test --generator=exp --lambda=10
test --generator=exp --lambda=10000
test --generator=exp --lambda=0.00001
test --generator=exp --lambda=8.854187817e-12


echo "--------------- summary ------------------"
echo "sucess    : $sucess"
echo "fail      : $fail"
echo "sucessrate: $(echo "100 * $sucess / ($sucess + $fail)" | bc)%"
