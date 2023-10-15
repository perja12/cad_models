#!/bin/bash

while IFS=, read -r name rotation scale
do
    echo "Rendering $name"
    symbol_name=\"mdi_svg/${name}\"
    openscad -D symbol_name=${symbol_name} -D symbol_rotation=${rotation} -D symbol_scale=${scale} \
             -o stl_output/key_tag_${name%.*}.stl key_tag.scad
done < symbols.csv

