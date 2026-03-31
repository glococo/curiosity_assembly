#!/bin/bash

# Directory containing the AVR headers
HDR_DIR="/usr/lib/avr/include/avr"

# Iterate over all ioavr*.h files
for file in "$HDR_DIR"/ioavr*.h; do
    # Check if files exist to avoid processing the literal glob pattern
    [ -e "$file" ] || continue

    # Get the base filename without extension
    base=$(basename "$file" .h)

    # Define the output filename
    output="${base}_gc.S"

    echo "Processing $base.h -> $output"
    # Apply the transformation:
    # 1. Filter for lines containing '_gc'
    # 2. Remove leading whitespace
    # 3. Replace '=' with a space
    # 4. Remove trailing commas before comments or at the end of the line
    # 5. Prepend '#define '
    sed -n '/_gc/{s/^[[:space:]]*//; s/=[[:space:]]*/ /; s/,[[:space:]]*\(\/\*.*\)/ \1/; s/,[[:space:]]*$//; s/^/#define /; p}' "$file" > "$output"
done

echo "Done."
