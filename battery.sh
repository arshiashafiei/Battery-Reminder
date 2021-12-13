#!/bin/bash

# Change these two to whatever you like
Battery_low=20
Battery_high=79

# If the script is not working and
# you are on arch-based distros
# you might need to change BAT0 to BAT1 in Battery_Percentage and Battery_Status
Battery_Percentage=$(cat /sys/class/power_supply/BAT0/capacity)
Battery_Status=$(cat /sys/class/power_supply/BAT0/status)

export DISPLAY=:0.0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

if [ $Battery_Percentage -le $Battery_low ] && [ $Battery_Status = Discharging ]; then
    echo "Plug your power"
    notify-send "Battery Low" "You might want to plug in your Computer"
elif [ $Battery_Percentage -ge $Battery_high ] && [ $Battery_Status != Discharging ]; then
    echo "unplug your power"
    notify-send "Battery limit reached" "You might want to unplug your Computer"
fi
