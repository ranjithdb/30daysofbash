#!/bin/bash

REMOTE_USER="username"
REMOTE_HOST="remote-ip"
REMOTE_APP_DIR="/var/www/html"
LOCAL_APP_DIR="./app"
SERVICE_NAME="apache2"
KEY_FILE="./first.pem"
LOGFILE="deployment.log"

echo "Starting deployment at $(date)" | tee -a "$LOGFILE"

echo "Uploading application files to $REMOTE_USER@$REMOTE_HOST:$REMOTE_APP_DIR" | tee -a "$LOGFILE"
scp -i "$KEY_FILE" -r "$LOCAL_APP_DIR"/* "$REMOTE_USER@$REMOTE_HOST:$REMOTE_APP_DIR" | tee -a "$LOGFILE"

echo "Restarting service $SERVICE_NAME on remote server" | tee -a "$LOGFILE"
ssh -i "$KEY_FILE" "$REMOTE_USER@$REMOTE_HOST" "sudo systemctl restart $SERVICE_NAME" | tee -a "$LOGFILE"

echo "Checking status of $SERVICE_NAME on remote server" | tee -a "$LOGFILE"
ssh -i "$KEY_FILE" "$REMOTE_USER@$REMOTE_HOST" "systemctl status $SERVICE_NAME" | tee -a "$LOGFILE"

echo "Deployment completed successfully at $(date)" | tee -a "$LOGFILE"

