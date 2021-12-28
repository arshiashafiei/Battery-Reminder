#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
read input < $SCRIPT_DIR/input.txt

# Change these two to whatever you like
Battery_low=20
Battery_high=79

# If the script is not working and
# you are on arch-based distros
# you might need to change BAT0 to BAT1 in Battery_Percentage and Battery_Status
Battery_Percentage=$(cat /sys/class/power_supply/BAT0/capacity)
Battery_Status=$(cat /sys/class/power_supply/BAT0/status)

export DISPLAY=:0.0

# Check if user dismissed last time or not
if [ "$input" = "1" ]; then
    read Previous_Status < $SCRIPT_DIR/Battery_Status.txt
    # Check if user Battery_Status changed or not
    if [ "$Previous_Status" != "$Battery_Status" ]; then
        echo "0" > $SCRIPT_DIR/input.txt
    fi
fi

read input < $SCRIPT_DIR/input.txt

# Check if Previous input conditions are true or not for notifying user
if [ -z "$input" ] || [ "$input" != "1" ]; then
    # Check if Battery conditions are true or not for notifying user
    if [ "$Battery_Percentage" -le "$Battery_low" ] && [ "$Battery_Status" = "Discharging" ]; then
        echo "Plug your power"
        zenity --question --title "Battery Low" \
        --text "You might want to plug in your Computer" \
        --width 300 --height 100 \
        --ok-label=Snooze --cancel-label=Dismiss \
        --timeout=30
        input=$? 
    elif [ "$Battery_Percentage" -ge "$Battery_high" ] && [ "$Battery_Status" != "Discharging" ]; then
        echo "unplug your power"
        zenity --question --title "Battery limit reached" \
        --text "You might want to unplug your Computer" \
        --width 300 --height 100 \
        --ok-label=Snooze --cancel-label=Dismiss \
        --timeout=30
        input=$?
    fi
    echo $Battery_Status > $SCRIPT_DIR/Battery_Status.txt
    echo $input > $SCRIPT_DIR/input.txt
fi
