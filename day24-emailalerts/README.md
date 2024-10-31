## Install Requirements: 
Make sure ```mailutils``` configured to send emails from your server.

## Run Periodically: 
Set up a cron job to run the script at regular intervals, for example, every hour:

```
0 * * * * /path/to/email_alerts.sh
```


## ```mailutils``` setup process that worked for me

```
sudo apt remove ssmtp
sudo apt update
sudo apt install mailutils postfix
sudo systemctl unmask postfix
sudo systemctl enable postfix
sudo systemctl start postfix
```

### Since mailutils uses Postfix, configure Postfix to use Gmail’s SMTP server.

```
sudo nano /etc/postfix/main.cf
```

```
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
smtp_use_tls = yes
```

### Create a file for your Gmail credentials:
```
sudo nano /etc/postfix/sasl_passwd
```

```
[smtp.gmail.com]:587 your_email@gmail.com:your_app_password
```
save and exit the file.

```
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
sudo systemctl restart postfix
```
### After completing these steps, try sending a test email:
```
echo "This is a test email from the server." | mail -s "Test Email" your_email@gmail.com
```

