#!/bin/bash
# Put the window on the other monitor.

# Effective resolutions of left and right monitors.
# Check these with xwininfo on a maximized window.
lwidth=1920
lheight=1008
rwidth=1680
rheight=1028

# Get current size and position.
window=`xdotool getactivewindow`
curx=`xwininfo -id $window | grep "Absolute upper-left X" | awk '{print $4}'`
curw=`xwininfo -id $window | grep "Width" | awk '{print $2}'`
curh=`xwininfo -id $window | grep "Height" | awk '{print $2}'`

# Don't change window size if it fits the other monitor, shrink it otherwise.
# Maximized (even in only one dimension) windows seem to automatically get re-maximized properly.
neww=-1
newh=-1

# Check on which monitor the window is and set new values.
if [ "$curx" -lt "$lwidth" ]; then
    newx=$[curx+lwidth]
    if [ $curw -gt $rwidth ]; then neww=$rwidth; fi
    if [ $curh -gt $rheight ]; then newh=$rheight; fi
else
    newx=$[curx-lwidth]
    if [ $curw -gt $lwidth ]; then neww=$lwidth; fi
    if [ $curh -gt $lheight ]; then newh=$lheight; fi
fi

# Move the window.
wmctrl -r :ACTIVE: -e 0,$newx,-1,$neww,$newh
