#!/bin/bash
# Put the window on the other monitor.

# Effective resolutions of left and right monitors.
# Check these with xwininfo on a maximized window.
lwidth=1920
lheight=1008
rwidth=1671
rheight=1200

# Get current size and position.
window=`xdotool getactivewindow`
curx=`xwininfo -id $window | grep "Absolute upper-left X" | awk '{print $4}'`
curw=`xwininfo -id $window | grep "Width" | awk '{print $2}'`
curh=`xwininfo -id $window | grep "Height" | awk '{print $2}'`

# Don't change window size if it fits the other monitor, shrink it otherwise.
neww=-1
newh=-1

# Maximized windows someteimes don't move properly under some mysterious circumstances,
# so we have to unmaximize them while moving.
# FIXME: this works just with fully maximized windows, will have to detect
#        horizontal and vertical maximization separately
maximized=false

# Check on which monitor the window is and set new values.
if [ "$curx" -lt "$lwidth" ]; then
    if [ $curw -eq $lwidth ]; then maximized=true; fi
    newx=$[curx+lwidth]
    if [ $curw -gt $rwidth ]; then neww=$rwidth; fi
    if [ $curh -gt $rheight ]; then newh=$rheight; fi
else
    if [ $curw -eq $rwidth ]; then maximized=true; fi
    newx=$[curx-lwidth]
    if [ $curw -gt $lwidth ]; then neww=$lwidth; fi
    if [ $curh -gt $lheight ]; then newh=$lheight; fi
fi

# Temporarily unmaximize if needed
if $maximized; then
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
fi

# Move the window.
wmctrl -r :ACTIVE: -e 0,$newx,-1,$neww,$newh

# Maximize back if needed
if $maximized; then
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
fi
