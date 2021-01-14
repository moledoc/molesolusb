#!/bin/zsh

# README: Script to comfortably increase/decrease/reset redshift

cur_redshift="/tmp/cur_redshift"

# Accepted $1 values are '+', '-', and '='

# Set default redshift value to <default>
default=6500
change=500
cur_val=$(< $cur_redshift)

if [[ "$1" = "=" ]]
then 
	new_val=$default
else
	new_val=$(expr $cur_val $1 $change)
fi

if [[ $new_val -lt 1000 ]]
then
	new_val=1000
elif [[ $new_val -gt 25000 ]]
then
	new_val=25000
fi

redshift -P -O $new_val
echo $new_val > $cur_redshift
