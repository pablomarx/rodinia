#!/usr/bin/python
#
# Copyright 2020 Steve White
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
import sys
import os
import re

sys.path.append(os.path.join(os.path.join(sys.path[0], '..'), 'bitstream'))
from chips import ChipWithID
from utils import string_to_bits, bits_to_string

if len(sys.argv) != 3:
    print("usage: %s <input fasm file> <output asc file>" % sys.argv[0])
    sys.exit(-1)
        

#
# Create bits for the bitstream
#
chip = ChipWithID(0x00120010)

bits_by_tile = []
for col in range(0, chip.columns):
    col_bits = []
    for row in range(0, chip.rows):
        tile = chip.tile_at(col, row)
        if tile is None:
            col_bits.append([])
        else:
            col_bits.append(tile.empty_bits())
    bits_by_tile.append(col_bits)

bits_by_config = []
for chain in chip.configChain:
    bits_by_config.append(chain.empty_bits())

#
# Read the fasm file
#
filename = sys.argv[1]
with open(filename, "r") as file:
    lines = file.readlines()

useFormatters = True
for line in lines:
    line = line.strip()
    if len(line) == 0:
        continue
    if line[0] == "#":
        if line == "#nofmt!":
            useFormatters = False
        elif line == "#fmt!":
            useFormatters = True
        continue
        
    match = re.match("^([^_]*)_([XY]-?[0-9]*)([XY]-?[0-9]*).(.*)$", line)
    assert match is not None
    
    comps = match.groups()
    assert len(comps) == 4
    
    row = None
    col = None
    for comp_index in range(1,3):
        coordinate = comps[comp_index]
        if coordinate[0] == 'X':
            col = int(coordinate[1:])
        elif coordinate[0] == 'Y':
            row = int(coordinate[1:])
    
    assert row is not None
    assert col is not None
    
    setting = comps[3].split("=")
    if len(setting) == 1:
        setting.append("1")
    
    key = setting[0].strip()
    if key[-1] == "]":
        openb = key.rfind("[")
        key = key[0:openb]
    value = string_to_bits(setting[1].strip())
    
    if row < 0 and comps[0] == 'C':
        chain_idx = col
        success = chip.configChain[chain_idx].encode(chip, None, None, None, key, value, bits_by_config[chain_idx])
        assert success;
        continue;
    
    tile = chip.tile_at(col, row)
    assert tile is not None
    assert tile.type[0] == comps[0]
        
    bits = bits_by_tile[col][row]
    success = tile.encode(key, value, bits, useFormatters) 
    if success:
        if useFormatters:
            if key.startswith("TileClkMUX"):
                # In af bitstreams, used logic tiles get this key/value set..
                value = [0,0,0,1]
                tile.encode("TileAsyncMUX00", value, bits)
            elif key.startswith("alta_slice") and key.endswith("INIT[15:0]"):
                key = key[:-11] + "_CARRY_CRL"
                tile.encode(key, [1], bits)
    else:
        chain_idx = 0
        for chain in chip.configChain:
            success = chain.encode(chip, tile.type, row, col, key, value, bits_by_config[chain_idx])
            if success:
                break
            chain_idx += 1
        
        if not success:
            print("Did not enocde key:%s line:%s" % (key, line))
        
        # Hack to fix I/O
        if useFormatters and key.startswith("alta_rio") and key.endswith("OUTPUT_USED"):
            slice = int(key[8:10])
            if slice < 4:
                for x in range (1, 4):
                    tile.encode("IOMUX%02i" % (slice + (4 * x)), [0,0,0,0, 0,0,0], bits, False)


#
# Write the ASC file
#
asc = open(sys.argv[2], 'w')
asc.write(".device 0x%x\n\n" % chip.device_id)

chain_idx = 0
for chain in bits_by_config:
    asc.write(".config_chain %i\n" % (chain_idx))
    asc.write(bits_to_string(bits_by_config[chain_idx]))
    asc.write("\n\n")
    chain_idx += 1

for tile_col in range(0, chip.columns):
    for tile_row in range(0, chip.rows):
        tile = chip.tile_at(tile_col, tile_row)
        if tile is None:
            continue
        asc.write(".%s %i %i\n" % (tile.type, tile_col, tile_row))
        bits = bits_by_tile[tile_col][tile_row]
        bit_idx = 0
        for bit_row in range(0, tile.bitstream_height):
            row_str = ""
            for bit_col in range(0, tile.bitstream_width):
                row_str += str(bits[bit_idx])
                bit_idx += 1
            asc.write(row_str)
            asc.write("\n")
        asc.write("\n")
asc.close()