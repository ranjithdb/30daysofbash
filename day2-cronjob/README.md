```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday, 0 = Sunday)
│ │ │ │ │
* * * * * <command-to-execute>
```


### Every Minute:
Runs every minute of every hour.
Cron Expression: * * * * *


### Every Hour:
Runs every hour at the 0th minute.
Cron Expression: 0 * * * *


### Every Day at a Specific Time:
Runs at a specific time every day (e.g., 2:35 PM).
Cron Expression: 35 14 * * *


### Every Week on a Specific Day and Time:
Runs on a specific day of the week (e.g., Sunday at 4:00 PM).
Cron Expression: 0 16 * * 0


### Every Month on a Specific Day and Time:
Runs on a specific day of the month (e.g., 1st of the month at 3:00 AM).
Cron Expression: 0 3 1 * *


### Every Monday through Friday at a Specific Time:
Runs on weekdays (Monday to Friday) at a specific time (e.g., 9:15 AM).
Cron Expression: 15 9 * * 1-5


### Every 5 Minutes:
Runs every 5 minutes.
Cron Expression: */5 * * * *


### Every 10 Minutes Between 9:00 AM and 5:00 PM:
Runs every 10 minutes during working hours (9 AM to 5 PM).
Cron Expression: */10 9-17 * * *


### Once a Month on the Last Day:
Runs on the last day of every month at midnight.
Cron Expression: 0 0 28-31 * * [ "$(date +\%d -d tomorrow)" = "01" ] && /path/to/script.sh
The above expression checks if tomorrow is the 1st of the next month and runs the script accordingly.


### Every Sunday at Midnight:
Runs at 12:00 AM every Sunday.
Cron Expression: 0 0 * * 0


### Symbols in Cron:
* *: Any value (wildcard).
* /n: Every n units. For example, */5 means "every 5 minutes."
* -: A range of values. For example, 9-17 means "hours from 9 AM to 5 PM."
* ,: A list of values. For example, 1,15 means "on the 1st and 15th days of the month."

### Example Schedule Patterns:
* Every 15 minutes: */15 * * * *
* At 8:00 AM every Monday: 0 8 * * 1
* At 6:30 PM on the 1st of each month: 30 18 1 * *
* At 5:00 AM every Sunday and Wednesday: 0 5 * * 0,3

































