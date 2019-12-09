#!/bin/bash

set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h               - help"
  echo "  -i <input-file>  - Input file ( default '../../01/input.txt' )"
  exit 1
}

INPUT_FILE="../../inputs/01/input.txt"

while getopts "i:h" opt; do
  case $opt in
    i)
      INPUT_FILE=$OPTARG
      ;;
    h)
      usage
      exit;;
    *)
      usage
      exit;;
  esac
done

# Create array from input file
set +e
IFS=$'\n' read -d '' -r -a MODULE_MASS < "$INPUT_FILE"
set -e

# Function to calculate required fuel
# usage: required_fuel <module-mass>
function required_fuel() {
  local MASS
  local REQUIRED_FUEL
  MASS="$1"
  REQUIRED_FUEL=$(($((MASS / 3)) - 2))
  echo "$REQUIRED_FUEL"
}

# Calculate total required fuel
TOTAL_FUEL=0
for mass in "${MODULE_MASS[@]}"
do
  REQUIRED_FUEL=$(required_fuel "$mass")
  while [ "$REQUIRED_FUEL" -gt 0 ];
  do
    TOTAL_FUEL=$((TOTAL_FUEL + REQUIRED_FUEL))
    REQUIRED_FUEL=$(required_fuel "$REQUIRED_FUEL")
  done
done

# Return total fuel required
echo "$TOTAL_FUEL"
