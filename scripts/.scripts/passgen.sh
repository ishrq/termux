#!/usr/bin/env bash

# Generate a random lowercase alphanumeric username of 6-8 characters
username_length=$(echo $RANDOM % 3 + 6 | awk '{printf "%d\n", int(rand() * 1.2 + 5)}' | head -c 1)
username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w ${username_length} | head -n 1)

# Ask for email alias
read -p "Use username as email alias (y/n)? " app_domain
if [[ "$app_domain" == [yY] ]]; then
  read -p "Enter email: " email_domain
  echo "Generated username: $username$email_domain"
else
  echo "Generated username: $username"
fi

# Pick password length
passlength(){
    read -p "Enter password length (default 20): " password_length
    if
        [[ -z "$password_length" ]]; then
        password_length=20
    elif
        [[ "$password_length" -lt 8 ]]; then
        read -p "Password is too short. Do you want to continue (y/n)?" short_pass
        if [[ "$short_pass" == [nN] ]]; then
            passlength
        fi
    fi
}
passlength

# Generate password
password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-={}[]|\/:";<>,.?' | fold -w ${password_length} |
head -n 1)
echo "Password: $password"

# Ask to copy username and password
read -p "Copy username (y/n)? " copy_username
if [[ "$copy_username" == [yY] ]]; then
  echo "$username" | xclip -sel clip
fi
read -p "Copy password (y/n)? " copy_password
if [[ "$copy_password" == [yY] ]]; then
  echo "$password" | xclip -sel clip -selection clipboard
fi
