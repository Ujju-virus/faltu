#!/bin/bash

PASSWORD="mysecretpassword"
TRIES=3
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
CENTER=$(tput cols)

function clear_screen {
    tput clear
    tput cup 0 0
}

function display_menu {
    clear_screen
    tput cup 5 $((CENTER/2-5))
    echo "${BOLD}MENU${NORMAL}"
    tput cup 7 $((CENTER/2-6))
    echo "1. Number of users currently logged in"
    tput cup 8 $((CENTER/2-6))
    echo "2. Calendar of current month"
    tput cup 9 $((CENTER/2-6))
    echo "3. Date in the format: dd/mm/yyyy"
    tput cup 10 $((CENTER/2-6))
    echo "4. Quit"
}

function check_password {
    local attempt=1
    while [ $attempt -le $TRIES ]; do
        read -s -p "Enter password: " password
        echo
        if [ "$password" == "$PASSWORD" ]; then
            return 0
        else
            echo "Incorrect password. Try again."
            attempt=$((attempt+1))
        fi
    done
    echo "Too many failed attempts. Exiting."
    exit 1
}

function num_users {
    clear_screen
    tput cup 5 $((CENTER/2-10))
    echo "${BOLD}NUMBER OF USERS CURRENTLY LOGGED IN${NORMAL}"
    tput cup 7 $((CENTER/2-6))
    who | wc -l
    read -p "Press Enter to continue"
}

function show_calendar {
    clear_screen
    tput cup 5 $((CENTER/2-9))
    echo "${BOLD}CALENDAR OF CURRENT MONTH${NORMAL}"
    tput cup 7 $((CENTER/2-12))
    cal
    read -p "Press Enter to continue"
}

function show_date {
    clear_screen
    tput cup 5 $((CENTER/2-9))
    echo "${BOLD}DATE IN THE FORMAT: DD/MM/YYYY${NORMAL}"
    tput cup 7 $((CENTER/2-4))
    date +"%d/%m/%Y"
    read -p "Press Enter to continue"
}

check_password
while true; do
    display_menu
    read -p "Enter your choice: " choice
    case $choice in
        1) num_users ;;
        2) show_calendar ;;
        3) show_date ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again." ;;
    esac
done
