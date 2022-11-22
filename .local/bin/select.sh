#!/bin/bash
 # Filename: select.sh
 # Last Change: Mon, 21 Nov 2022 12:46:31
 # Author: CURRENT_USER

PS3="What is the day of the week? "
select day in mon tue wed thu fri sat sun;
do
  echo "the day of the week is $day"
  break
done
