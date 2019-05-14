#!/usr/bin/python
#
# Copyright 2019 Steve White
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the 'Software'), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
#

import os
import gzip
import json

wires_by_tile = None

def input_for_tile_config(tile, x, y, config, value):
    global wires_by_tile

    if wires_by_tile is None:
        filename = os.path.dirname(os.path.abspath(__file__))
        filename = os.path.join(filename, "ag1k-wires.json.gz")
        with gzip.open(filename, 'rb') as file:
            wires_by_tile = json.loads(file.read())
        
    if tile not in wires_by_tile:
        return None
    
    if config.startswith("CFG_"):
        config = config[4:]

    if config.startswith("SLICE_LOGIC"):
        config = config[14:]
        if config.startswith("OMUX_") or config.startswith("IMUX_"):
            config = config[0:4] + config[5:]
    
    configs = wires_by_tile[tile]
    if config not in configs:
        matched = False
        for key in configs.keys():
            if key.lower() == config.lower():
                config = key
                matched = True
                break
        if matched is False:
            return None
        
    values = configs[config]
    val_str = 'I%s' % value
    if val_str not in values:
        return None
    
    output_tiles = values[val_str]
    for output_tile_name in output_tiles:
        output_configs = output_tiles[output_tile_name]
        for output_config_name in output_configs:
            output_config = output_configs[output_config_name]
            for output_index in output_config:
                tile_pairs = output_config[output_index]
                for tile_pair in tile_pairs:
                    if tile_pair[0] == x and tile_pair[1] == y:
                        return {'tile': output_tile_name, 'x': tile_pair[2], 'y': tile_pair[3], 'config': output_config_name, 'index': output_index, 'wire': tile_pair[4], 'timing': tile_pair[5] }

    return None
