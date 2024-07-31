#!/usr/bin/bash

max=`brightnessctl m`
cur=`brightnessctl g`

echo $(($cur * 100 / $max))
