#!/bin/bash
# vim:set ft=bash

# This script runs on amdgpu_bl0, for intel check backlight documentation
read -p 5 -t "Please, insert a value between 10 and 250: " val

if [[ ${val} -gt 250 ]]; then
  echo $1 is too bright! Setting to default value: 
  val=250
fi

if [[ ${val} -lt 10 ]]; then
  echo $1 is too dark! Setting to default value: 
  val=10
fi

echo $val | sudo tee /sys/class/backlight/amdgpu_bl0/brightness
exit 0