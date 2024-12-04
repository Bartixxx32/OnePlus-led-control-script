#!/bin/bash

# Function to increase brightness from 10 to 255 and then decrease
increase_decrease_brightness() {
  # Increasing brightness
  for ((brightness=10; brightness<=255; brightness+=10)); do
    sudo bash ledcontrol.sh on $brightness
    #sleep 0.1  # Wait for 0.5 seconds before next command
  done

  # Decreasing brightness
  for ((brightness=245; brightness>=10; brightness-=10)); do
    sudo bash ledcontrol.sh on $brightness
    #sleep 0.1  # Wait for 0.5 seconds before next command
  done
}

# Execute the increase/decrease loop
while true; do
  increase_decrease_brightness
done
