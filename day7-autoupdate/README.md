## Method 1(Unsafe)
### Replace ```yourpassword``` with your actual password

---

## Method 2(DIDN'T WORK)
### configure sudo to allow your user to run the apt command without a password
### open the sudoers file with visudo command
```sudo visudo```
### Add a line at the end of the file that allows your user to run the apt update command without a password. Replace yourusername with your actual username:
```yourusername ALL=(ALL) NOPASSWD: /usr/bin/apt update```
### If you want to allow all apt commands without a password, you can do this:
```yourusername ALL=(ALL) NOPASSWD: /usr/bin/apt```

---

## Cronjob to automate the update
### setup cronjob to run the script daily at 2am

```crontab -e```

### Add the following line at the end of the crontab file:

```0 2 * * * /path/to/auto-update.sh```

### To list all cronjobs

```crontab -l```

### To remove the all cronjobs

```crontab -r```
