#!/bin/bash

read -p "enter your marks " marks

if [[ $marks -gt 50 ]]
then
echo "you are pass"
else
    echo " you ar fail"
    fi

# in shell case condition is like switch case of programming

#!/bin/bash

echo "Enter the day of the week: "
read day

case $day in
  "Monday")
    echo "It's the start of the week."
    ;;
  "Tuesday" | "Wednesday" | "Thursday")
    echo "It's a weekday."
    ;;
  "Friday")
    echo "TGIF! It's Friday!"
    ;;
  "Saturday" | "Sunday")
    echo "It's the weekend. Enjoy!"
    ;;
  *)
    echo "Invalid day entered."
    ;;
esac
