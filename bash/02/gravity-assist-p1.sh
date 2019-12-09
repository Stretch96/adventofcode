#!/bin/bash

set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h                - help"
  echo "  -o <fix-code-one> - Fix code 1 (required)"
  echo "  -t <fix-code-two> - Fix code 2 (required)"
  echo "  -i <input-file>   - Input file ( default '../../02/input.txt' )"
  exit 1
}

INPUT_FILE="../../inputs/02/input.txt"

while getopts "i:o:t:h" opt; do
  case $opt in
    i)
      INPUT_FILE=$OPTARG
      ;;
    o)
      FIX_CODE_ONE=$OPTARG
      ;;
    t)
      FIX_CODE_TWO=$OPTARG
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
IFS=$',' read -d '' -r -a INTEGERS  < "$INPUT_FILE"
set -e

if [[ -z "$FIX_CODE_ONE" || -z "$FIX_CODE_TWO" ]];
then
  usage
  exit 1
fi

# Fix position 1 and 2
INTEGERS[1]="$FIX_CODE_ONE"
INTEGERS[2]="$FIX_CODE_TWO"

POS=0;
OPCODE="${INTEGERS[0]}"

while [ "$OPCODE" != 99 ];
do
  if [ "$OPCODE" == 1 ];
  then
    INTEGERS["${INTEGERS[$((POS + 3))]}"]=$((INTEGERS[INTEGERS[$((POS + 1))]] + INTEGERS[INTEGERS[$((POS + 2))]]))
  fi
  if [ "$OPCODE" == 2 ];
  then
    INTEGERS["${INTEGERS[$((POS + 3))]}"]=$((INTEGERS[INTEGERS[$((POS + 1))]] * INTEGERS[INTEGERS[$((POS + 2))]]))
  fi
  POS=$((POS + 4)) 
  OPCODE="${INTEGERS[$POS]}"
done
echo "${INTEGERS[0]}"
