#!/usr/bin/python
#
# Copyright 2019 Steve White
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
#

import sys
from bwriter import BinaryWriter
from crc import crc
from chips import ChipWithID, chips
from utils import round_up

if len(sys.argv) != 3:
    print("usage: %s <asc file input> <bin file output>" % sys.argv[0])
    sys.exit(-1)

filename = sys.argv[1]
with open(filename, "r") as file:
    lines = file.readlines()

#
# Parse the .asc file
#
entries = []
data = None
chip = None
for line in lines:
    line = line.strip()
    if line.startswith("."):
        data = None
        comps = line.split(" ")
        if len(comps) == 2:
            if comps[0] == ".device":
                chip_id = int(comps[1], 16)
                chip = ChipWithID(chip_id)
            elif comps[0] == ".config_chain":
                chain_id = int(comps[1])
                data = { 'bits': [], 'type': 'chain', 'id': chain_id }
                entries.append(data)
        if len(comps) == 3:
            if chip != None:
                x = int(comps[1])
                y = int(comps[2])
                if x >= 0 and y >= 0:
                    data = {'x': x, 'y': y, 'type': 'tile', 'bits': []}
                    entries.append(data)
    elif len(line) > 0:
        if data != None:
            for char in line:
                if char == "0" or char == "1":
                    data['bits'].append(int(char))

#
# Helpers for retrieving parsed data
#
def chain_with_id(id):
    for entry in entries:
        if entry['type'] != 'chain':
            continue
        if entry['id'] == id:
            return entry
    return None
    
def tile_at_coord(x,y):
    for entry in entries:
        if entry['type'] != 'tile':
            continue
        if entry['x'] == x and entry['y'] == y:
            return entry
    return None
    

#
# Writing...
#
writer = BinaryWriter()
writer.write32(chip.device_id)
writer.write32(0x0000FFFF)

def write_register_data(reg, len, data):
    writer.write32(0xA2000000 | reg)
    writer.write32(((len - 1) << 8) | 0x20)
    writer.writeBits(data)

#
# Enumerate config chains
#
for chain_id in range(0, len(chip.configChain)):
    chain = chain_with_id(chain_id)
    chain_bits = chain['bits']
    chain_len = len(chain_bits)

    num_padding_bits = round_up(chain_len, 32) - chain_len

    write_register_data(0x20 | chain_id, chain_len, chain_bits + ([0] * num_padding_bits))

#
# Write the bitstream
#
bitstream = []
for tile_row in range(chip.rows - 1,-1,-1):
    row_height = chip.max_row_height(tile_row)
    
    for row in range(0, row_height):    
        row_bits = []
        for tile_col in range(chip.columns - 1,-1,-1):
            column_width = chip.column_width(tile_col)
            entry = tile_at_coord(tile_col, tile_row)
            if entry is None:
                bits = [1] * column_width
            else:
                offset = column_width * row
                bits = entry['bits'][offset:offset+column_width]
                if len(bits) < column_width:
                    bits += [1] * (column_width - len(bits))

            row_bits += bits[::-1]
        
        assert(chip.max_row_width() == len(row_bits))

        row_width = round_up(len(row_bits), 8)        
        rounded_row_width = int(((row_width / 32) + 1) * 32)
        
        num_padding_bits = rounded_row_width - len(row_bits)
        
        row_bits += [0] * num_padding_bits
        bitstream += row_bits

write_register_data(0x00, len(bitstream), bitstream)

#
# Write the checksum
#
writer.write32(0x2A00FC02)
writer.write32(0x00000F8F)
writer.write32(crc(writer.getBytes()))

binfile = open(sys.argv[2], 'wb')
binfile.write(writer.getBytes())
binfile.close()