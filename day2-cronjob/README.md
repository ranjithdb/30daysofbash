"┌───────────── minute (0 - 59)"
"│ ┌───────────── hour (0 - 23)"
"│ │ ┌───────────── day of the month (1 - 31)"
"│ │ │ ┌───────────── month (1 - 12)"
"│ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday, 0 = Sunday)"
"│ │ │ │ │"
"* * * * * <command-to-execute>"



Every Minute:
Runs every minute of every hour.
Cron Expression: * * * * *


Every Hour:
Runs every hour at the 0th minute.
Cron Expression: 0 * * * *


Every Day at a Specific Time:
Runs at a specific time every day (e.g., 2:35 PM).
Cron Expression: 35 14 * * *


Every Week on a Specific Day and Time:
Runs on a specific day of the week (e.g., Sunday at 4:00 PM).
Cron Expression: 0 16 * * 0


Every Month on a Specific Day and Time:
Runs on a specific day of the month (e.g., 1st of the month at 3:00 AM).
Cron Expression: 0 3 1 * *


Every Monday through Friday at a Specific Time:
Runs on weekdays (Monday to Friday) at a specific time (e.g., 9:15 AM).
Cron Expression: 15 9 * * 1-5


Every 5 Minutes:
Runs every 5 minutes.
Cron Expression: */5 * * * *


Every 10 Minutes Between 9:00 AM and 5:00 PM:
Runs every 10 minutes during working hours (9 AM to 5 PM).
Cron Expression: */10 9-17 * * *


































