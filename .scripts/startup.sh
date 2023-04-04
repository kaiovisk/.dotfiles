#!/bin/bash 

# Launch polybar.
~/.config/polybar/launch.sh

# Get rid of that screen tearing.
nvidia-force-comp-pipeline

# Start compositor.
picom -b 

# Setup the arandr monitor layout AFTER compositor and BEFORE wallpaper.
~/.screenlayout/single_monitor.sh 

# Set nitrogen AFTER compositor.
nitrogen --restore
