#!/bin/bash

set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h                    - help"
  echo "  -i <input-file>       - arg option  ( default '../../02/input.txt' )"
  echo "  -r <expected-result>  - expected result"
  exit 1
}

INPUT_FILE="../../inputs/02/input.txt"

while getopts "i:r:h" opt; do
  case $opt in
    i)
      INPUT_FILE=$OPTARG
      ;;
    r)
      EXPECTED_RESULT=$OPTARG
      ;;
    h)
      usage
      exit;;
    *)
      usage
      exit;;
  esac
done

if [ -z "$EXPECTED_RESULT" ];
then
  usage
  exit 1
fi

FIX_CODE_ONE=-1
FIX_CODE_TWO=0
RESULT=0

echo "Finding codes, this may take some time ..."

# Brute force ./gravity-assist-p1.sh to find expected result
while [ "$RESULT" != "$EXPECTED_RESULT" ];
do
  FIX_CODE_ONE=$((FIX_CODE_ONE + 1))
  if [ "$FIX_CODE_ONE" == 100 ];
  then
    FIX_CODE_ONE=0
    FIX_CODE_TWO=$((FIX_CODE_TWO + 1))
  fi
  RESULT=$(./gravity-assist-p1.sh -i "$INPUT_FILE" -o "$FIX_CODE_ONE" -t "$FIX_CODE_TWO")
done

FIX_CODE_ONE=$(printf "%02d" $FIX_CODE_ONE)
FIX_CODE_TWO=$(printf "%02d" $FIX_CODE_TWO)
echo "$FIX_CODE_ONE$FIX_CODE_TWO"
