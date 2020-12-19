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

class WireEnd:
    tile = None
    row = None
    col = None
    config = None
    bit = None
    name = None
    def __init__(self, tile, row, col, config, bit):
        self.tile = tile
        self.row = row
        self.col = col
        self.config = config
        self.bit = bit
        # XXX: alta_ioreg exclusion is due to breaking current nextpnr impl
        if config.startswith("alta_") and not config.startswith("alta_ioreg"):
            self.name = "%s(%02i,%02i):%s:%s" % (tile, col, row, config, bit)
        else:
            self.name = "%s(%02i,%02i):%s" % (tile, col, row, config)

class Wire:
    source = None
    dest = None
    wire_type = None
    delay = None
    name = None
    def __init__(self, source, dest, wire_type, delay):
        self.source = source
        self.dest = dest
        self.wire_type = wire_type
        self.delay = delay
        
        if dest.name.endswith(":" + dest.bit):
            name = dest.name
        else:
            name = "%s:%s" % (dest.name, dest.bit)
    
        name = name + " <= "
    
        if source.name.endswith(":" + source.bit):
            name = name + source.name
        else:
            name = "%s%s:%s" % (name, source.name, source.bit)
        
        self.name = name

filename = os.path.dirname(os.path.abspath(__file__))
filename = os.path.join(filename, "ag1k-wires.json.gz")
with gzip.open(filename, 'rb') as file:
	wires_by_tile = json.loads(file.read())

def enumerate_all_wires(callback):
    global wires_by_tile
    # e.g. LogicTILE, IOTILE
    for dest_tile in wires_by_tile:
        dest_configs = wires_by_tile[dest_tile]
        # e.g. IMUX34, IMUX35
        for dest_config in dest_configs:           
            dest_bits = dest_configs[dest_config]
            # e.g. I0, I1, I2
            for dest_bit in dest_bits:        
                src_tiles = dest_bits[dest_bit]
                # e.g. LogicTILE, IOTILE
                for src_tile in src_tiles:     
                    src_configs = src_tiles[src_tile]
                    # e.g. OMUX01, OMX07
                    for src_config in src_configs:
                        src_bits = src_configs[src_config]
                        # e.g. O0, O1
                        for src_bit in src_bits:
                            connections = src_bits[src_bit]
                            # e.g. [9, 1, 9, 1, "T0", 0.867]
                            last = []
                            for connection in connections: 
                                dest_col = connection[0]
                                dest_row = connection[1]
                                src_col = connection[2]
                                src_row = connection[3]
                                wire_type = connection[4]
                                delay = connection[5]
                                
                                # There seems to be ~ 4222 duplicates in the json
                                if last == connection[0:4]:
                                    continue
                                    
                                last = connection[0:4]
                                
                                dest = WireEnd(dest_tile, dest_row, dest_col, dest_config, dest_bit)
                                source = WireEnd(src_tile, src_row, src_col, src_config, src_bit)
                                wire = Wire(source, dest, wire_type, delay)
                                callback(wire)


def input_for_tile_config(tile, x, y, config, value):
    global wires_by_tile

    if tile not in wires_by_tile:
        return None
    
    if config.startswith("alta_slice"):
        config = config[13:]
    
    configs = wires_by_tile[tile]
    if config not in configs:
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
