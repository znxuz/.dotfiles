#!/usr/bin/env bash

xrandr --output DP-1-3 --mode 1920x1080 --primary --output DP-1-1 --mode 1920x1080 --same-as DP-1-3

pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI3__sink
