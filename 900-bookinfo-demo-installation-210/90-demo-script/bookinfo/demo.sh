#!/bin/bash

source ./config.sh

menu_option_1() {

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Introduce anomaly into ratings Service in BookInfo App ...started ....$date1"

  op1/create-events.sh
  # op1/create-log-anamoly.sh
  
  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Introduce anomaly into ratings Service in BookInfo App...completed ....$date1"
}

menu_option_2() {
  echo "Process completed...."
}

menu_option_3() {
  echo "Process completed...."
}

menu_option_4() {
  echo "Process completed...."
}

menu_option_5() {
  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Clear events ...started ....$date1"
  
  op6/clear-events.sh

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Clear events ...completed ....$date1"
}

menu_option_6() {
  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Reset ...started ....$date1"
  
  op6/clear-events.sh
  op6/clear-aimanager.sh

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Reset ...completed ....$date1"
}

press_enter() {
  echo ""
  read -p "	Press Enter to continue "
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}


until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "      Watson AI-Ops Demo "
  echo "      -------------------"
  echo ""
  echo "      1  -  Introduce anomaly into BookInfo App"
  echo "      5  -  Clear events"
  echo "      6  -  Reset"
  echo ""
  echo "      0  -  Exit"
  echo ""
  read -p "      Enter selection: " selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_1 ; press_enter ;;
    2 ) clear ; menu_option_2 ; press_enter ;;
    3 ) clear ; menu_option_3 ; press_enter ;;
    4 ) clear ; menu_option_4 ; press_enter ;;
    5 ) clear ; menu_option_5 ; press_enter ;;
    6 ) clear ; menu_option_6 ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
