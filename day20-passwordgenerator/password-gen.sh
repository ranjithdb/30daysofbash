#!/bin/bash

generate_password() {
    local length="$1"
    local use_uppercase="$2"
    local use_lowercase="$3"
    local use_digits="$4"
    local use_special="$5"

    local uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local lowercase="abcdefghijklmnopqrstuvwxyz"
    local digits="0123456789"
    local special="!@#$%^&*()-_=+[]{}|;:,.<>?/"

    local char_pool=""

    if [[ "$use_uppercase" == "y" ]]; then
        char_pool+="$uppercase"
    fi
    if [[ "$use_lowercase" == "y" ]]; then
        char_pool+="$lowercase"
    fi
    if [[ "$use_digits" == "y" ]]; then
        char_pool+="$digits"
    fi
    if [[ "$use_special" == "y" ]]; then
        char_pool+="$special"
    fi

    if [[ -z "$char_pool" ]]; then
        echo "Error: No character types selected."
        exit 1
    fi

    password=""
    for ((i = 0; i < length; i++)); do
        random_char="${char_pool:RANDOM % ${#char_pool}:1}"
        password+="$random_char"
    done

    echo "Generated password: $password"
}

read -p "Enter password length: " length
read -p "Include uppercase letters? (y/n): " use_uppercase
read -p "Include lowercase letters? (y/n): " use_lowercase
read -p "Include digits? (y/n): " use_digits
read -p "Include special characters? (y/n): " use_special

generate_password "$length" "$use_uppercase" "$use_lowercase" "$use_digits" "$use_special"

