#!/bin/bash

# Loop infinitely
while true; do
  # Execute command to turn on yellow LED with brightness 10
  sudo bash ledcontrol.sh on 10 yellow
  
  # Wait for 0.5 seconds
  #sleep 0.5
  
  # Execute command to turn on white LED with brightness 10
  sudo bash ledcontrol.sh on 10 white
  
  # Wait for 0.5 seconds
  #sleep 0.5
done
