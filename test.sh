#!/bin/sh

set -e

test() {
  if [ "$2" != "" ]; then
    echo "----------------------------------------"
  fi
  echo "$1"
  echo "----------------------------------------"
}

test "help"
./bump-license-year -h

test "version" 1
./bump-license-year -V

# LINK="$HOME/.vmodules/prantlf/bump-license-year"

# echo "----------------------------------------"
# echo "clean up"
# rm -rf "$LINK"

# test "link" 1
# ./bump-license-year link
# if [ ! -L "$LINK" ]; then
#   echo "link not created"
#   exit 1
# fi

# test "unlink" 1
# ./bump-license-year unlink
# if [ -L "$LINK" ]; then
#   echo "link not removed"
#   exit 1
# fi

echo "----------------------------------------"
echo "done"
