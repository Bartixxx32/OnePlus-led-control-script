#!/bin/bash

# Check for root access
if [[ "$(id -u)" -ne 0 ]]; then
  echo "Root access is required to control LEDs."
  exit 1
fi

# Check if arguments are passed
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <on/off> [brightness (0-255)] [white/yellow] "
  exit 1
fi

# Parse arguments
toggleAction=$1        # 'on' or 'off'
torchVal=${2:-50}      # Default brightness value is 50 if not specified
brightnessMax=255      # Max brightness (typically 255 for full brightness)
ledType=${3:-"both"}   # Default is "both", or "white" or "yellow"

# Validate brightness value for 'on' command
if [[ "$toggleAction" == "on" && ( $torchVal -lt 0 || $torchVal -gt 255 ) ]]; then
  echo "Brightness must be between 0 and 255."
  exit 1
fi

# Set LED file locations
whiteLedFileLocation="/sys/class/leds/led:torch_0/brightness"  # Path for white LED
yellowLedFileLocation="/sys/class/leds/led:torch_1/brightness"  # Path for yellow LED
toggleFileLocation="/sys/class/leds/led:switch_0/brightness"  # Optional toggle control path
toggleFileLocation2="/sys/class/leds/led:switch_1/brightness"  # Optional toggle control path
toggleFileLocation3="/sys/class/leds/led:switch_2/brightness"  # Optional toggle control path

# Turn LEDs off before turning them on to ensure they are off initially
if [[ "$toggleAction" == "on" ]]; then
  # Turn off LEDs first before turning them on
  echo "0" > $whiteLedFileLocation
  echo "0" > $yellowLedFileLocation
  echo "0" > $toggleFileLocation
  echo "0" > $toggleFileLocation2
  echo "0" > $toggleFileLocation3

  # Turn on the LEDs based on the provided type
  if [[ "$ledType" == "both" || "$ledType" == "white" ]]; then
    echo $torchVal > $whiteLedFileLocation
  fi
  if [[ "$ledType" == "both" || "$ledType" == "yellow" ]]; then
    echo $torchVal > $yellowLedFileLocation
  fi

  # Set the toggle control to max brightness (turn on LEDs)
  echo $brightnessMax > $toggleFileLocation
  echo $brightnessMax > $toggleFileLocation2

  echo "LEDs have been turned on with brightness $torchVal."

elif [[ "$toggleAction" == "off" ]]; then
  # Turn off LEDs (no brightness value needed)
  echo "0" > $whiteLedFileLocation
  echo "0" > $yellowLedFileLocation
  echo "0" > $toggleFileLocation
  echo "0" > $toggleFileLocation2
  echo "0" > $toggleFileLocation3

  echo "LEDs have been turned off."

else
  echo "Invalid argument. Use 'on' or 'off' to toggle the LEDs."
  exit 1
fi
