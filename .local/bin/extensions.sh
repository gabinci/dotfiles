#!/bin/bash
 # Filename: get_extensions.sh
 # Last Change: Mon, 21 Nov 2022 15:30:44
 # Author: CURRENT_USER

read -p "What is your first name? " firstname
read -p "L is your last name? " lastname

PS3="What type of phone do you have? "

select phone in headset handheld; do 
  echo "You chose $phone"
  break
done

PS3="Which department do you work in? "
select department in finance sales engineering "customer service"; do 
  echo "You chose $department"
  break
done

read -N 4 -p  "what is your current extension number? (must be 4 digits)" ext ; echo
read -N 4 -s -p "What access code would you like to use when dialling in? (must be 4 digits): " access ; echo
echo "$firstname,$lastname,$ext,$access,$phone,$department" >> extensions.csv
