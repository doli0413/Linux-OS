#!/bin/bash

echo "1st arg = $1"

# Variable
sum=0

for i in {0..9}
  do
    sum=$(($sum+$i))
    echo Current Number is $sum
  done