#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_DIR="$SCRIPT_DIR/!_setup"

if [ ! -d "$SETUP_DIR" ]; then
  echo "ERROR: !_setup folder not found in $SCRIPT_DIR"
  exit 1
fi

echo "Running all scripts from: $SETUP_DIR"

for script in "$SETUP_DIR"/*.sh; do
  if [ -x "$script" ]; then
    echo "Executing: $(basename "$script")"
    "$script"
  else
    echo "Skipped (not executable): $(basename "$script")"
  fi
done

echo "Success: All scripts executed." 
