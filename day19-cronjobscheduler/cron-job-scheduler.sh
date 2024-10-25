#!/bin/bash

CRON_FILE="my_cron_jobs"

function show_menu {
    echo "Cron Job Manager"
    echo "1) List cron jobs"
    echo "2) Add a cron job"
    echo "3) Remove a cron job"
    echo "4) Exit"
    read -p "Choose an option: " choice
}

function list_jobs {
    echo "Current cron jobs:"
    crontab -l
}

function add_job {
    read -p "Enter the cron schedule (e.g., '0 1 * * *'): " schedule
    read -p "Enter the command to run: " command

    (crontab -l; echo "$schedule $command") | crontab -
    echo "Cron job added successfully."
}

function remove_job {
    echo "Current cron jobs:"
    crontab -l > $CRON_FILE

    nl -w2 -s". " $CRON_FILE
    read -p "Enter the job number to remove: " job_number

    sed -i "${job_number}d" $CRON_FILE
    crontab $CRON_FILE
    echo "Cron job removed successfully."
}

while true; do
    show_menu
    case $choice in
        1) list_jobs ;;
        2) add_job ;;
        3) remove_job ;;
        4) echo "Exiting."; break ;;
        *) echo "Invalid choice." ;;
    esac
    echo
done

