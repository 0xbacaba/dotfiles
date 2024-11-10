#!/bin/bash

change=$1

brightnessctl s "$change"

newval=`brightnessctl g -P`
notify-send Brightness -h "int:value:$newval"
