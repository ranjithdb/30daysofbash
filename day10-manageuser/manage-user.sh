#!/bin/bash

add_user() {
    read -p "Enter the username to add: " username
    sudo useradd "$username"
    echo "User '$username' added."
    
    read -p "Do you want to set a password for the user? (y/n): " set_password
    if [[ "$set_password" == "y" || "$set_password" == "Y" ]]; then
        sudo passwd "$username"
    fi
}

delete_user() {
    read -p "Enter the username to delete: " username
    sudo userdel "$username"
    echo "User '$username' deleted."
}

modify_user() {
    read -p "Enter the username to modify: " username
    read -p "Enter the new home directory for the user: " homedir
    sudo usermod -d "$homedir" "$username"
    echo "User '$username' modified with new home directory '$homedir'."
}

add_group() {
    read -p "Enter the group name to add: " groupname
    sudo groupadd "$groupname"
    echo "Group '$groupname' added."
}

delete_group() {
    read -p "Enter the group name to delete: " groupname
    sudo groupdel "$groupname"
    echo "Group '$groupname' deleted."
}

add_user_to_group() {
    read -p "Enter the username to modify: " username
    read -p "Enter the group to add the user to: " groupname
    sudo usermod -aG "$groupname" "$username"
    echo "User '$username' added to group '$groupname'."
}

menu() {
    echo "User Management Script"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Modify User"
    echo "4. Add Group"
    echo "5. Delete Group"
    echo "6. Add User to Group"
    echo "7. Exit"
    read -p "Choose an option: " option
    
    case $option in
        1) add_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) add_group ;;
        5) delete_group ;;
        6) add_user_to_group ;;
        7) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}

while true; do
    menu
done

