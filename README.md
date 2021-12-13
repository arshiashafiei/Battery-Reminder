# Battery Reminder

This might not work with older kernels

Tested with Ubuntu Desktop 20.04 LTS
___
This simple script will remind you with desktop notification if your battery is at high percentage and plugged in or at low percentage and not plugged in so you know when to plug or unplug your computer for increasing the Battery lifespan in your laptop or for whatever reason you like.
___
Add

```bash
*/5 * * * * /YOUR/PATH/TO/battery.sh > /YOUR/PATH/TO/battery.log 2>&1
```

in your crontab using `crontab -e` command in terminal

this will run the script every 5 minutes and save the last log in battery.log

If the script is not working and
you are on arch-based distros
you might need to change BAT0 to BAT1 in Battery_Percentage and Battery_Status in the script
