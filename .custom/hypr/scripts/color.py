#!/usr/bin/env python3

# This file must be run with /home/$USER/.custom/hypr/scripts/.venv/bin/python3

import sys
from colormath.color_objects import sRGBColor, LabColor #type: ignore
from colormath.color_conversions import convert_color #type: ignore
from colormath.color_diff import delta_e_cie2000 #type: ignore
import numpy #type: ignore

if not hasattr(numpy, 'asscalar'):
    numpy.asscalar = lambda x: x.item()


def hex_to_lab(hex_color):
    hex_color = hex_color.lstrip('#')
    r, g, b = [int(hex_color[i:i+2], 16)/255.0 for i in (0, 2, 4)]
    srgb = sRGBColor(r, g, b)
    return convert_color(srgb, LabColor)

def get_main_color(hex_input, extended_palette):
    input_lab = hex_to_lab(hex_input)
    min_delta = float('inf')
    closest_main = None

    for main_color, similar_list in extended_palette.items():
        for variant in [main_color] + similar_list:
            delta = delta_e_cie2000(input_lab, hex_to_lab(variant))
            if delta < min_delta:
                min_delta = delta
                closest_main = main_color

    return closest_main

extended_palette = {
    "#FF0000": ["#AA4444", "#BB5555", "#55222C"],
    "#00FF00": ["#316631"],
    "#0000FF": [],
    "#FFFF00": [],
    "#00FFFF": ["#587194"],
    "#FF00FF": ["#CC7D94"],
    "#FFA500": [],
    "#800080": [],
    "#684A37": ["#857A69"],
    "#808080": ["#707070", "#A0A0A0"],
    "#000000": [],
    "#FFFFFF": []
}

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print('Usage: python3 color.py "#HEXCOLOR"')
        sys.exit(1)

    input_color = sys.argv[1]
    print(get_main_color(input_color, extended_palette))
