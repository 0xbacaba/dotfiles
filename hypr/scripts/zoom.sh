#!/bin/bash
# Utility to adjust the current zoom factor. Currently just using hypr-zoom (https://github.com/FShou/hypr-zoom)

# Usage:
#  zoom.sh [[+ | - | / | *]<number>]
# Examples:
#  - zoom.sh +0.2   ->  add 0.2 to the current zoom factor
#  - zoom.sh \*1.2  ->  multiply the current zoom factor by 1.2
#  - zoom.sh 2      ->  set the zoom factor to 2
#  - zoom.sh        ->  zoom out (set zoom to 1)


input=$1
if [ -z "$input" ]; then
  input=1
fi

operation=`grep -Eo '^[+-/*]' <<< $input`
value=`grep -Eo '[0-9]*(\.[0-9]*)?$' <<< $input`

if [ -z "$operation" ]; then
  factor=$value
else
  # Get the value of another hypr-zoom process to be able to stack the calls
  other_inst=`pgrep -a hypr-zoom`
  if [ ! -z "$other_inst" ]; then
    other_pid=`awk '{print $1}' <<< $other_inst`
    other_cmd=`awk '{$1=""; print $0}' <<< $other_inst`

    # Parse the target zoom of the other process
    other_target=`echo $other_cmd | grep -Eo '\-target [0-9]*(\.[0-9]*)?' | grep -Eo '[0-9]*(\.[0-9]*)?'`
    if [ ! -z $other_target ]; then
      value=$other_target
    fi
  fi

  factor=`hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}'`
  factor=`awk "BEGIN {print ($factor $operation $value)}"`
fi

# Ensure only one hypr-zoom process is active at a time to avoid flickering
pkill hypr-zoom 2>/dev/null
hypr-zoom -force -duration 10 -easing OutQuad -interp Linear -steps 100 -target $factor
