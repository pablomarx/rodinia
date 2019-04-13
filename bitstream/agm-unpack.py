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
from chips import chips
from tiles import TileNamed
from utils import *
from breader import BinaryReader

chip = None

#
# Tile bitstream
#
def decode_tile_bitstream(bits, length):
    row_width = round_up(chip.max_row_width(), 8)
    expected_size = 0
    for tile_row in range(chip.rows - 1,-1,-1):
        row_height = chip.max_row_height(tile_row)
        expected_size += (row_width + 32) * row_height

    if expected_size != length:
        print("Unexpected bitstream length %s (expected %s)" % (bit_len, expected_size))
        return;

    offset = 0
    for tile_row in range(chip.rows - 1,-1,-1):
        row_height = chip.max_row_height(tile_row)
        
        columns = []
        for tile_col in range(0, chip.columns):
            columns.append('')

        for row in range(0, row_height):
            row_offset = offset
            for tile_col in range(chip.columns - 1,-1,-1):
                #print("row %s col %s pos %s" % (row, tile_col, row_offset))
                tile = chip.tile_at(tile_col, tile_row)
                col_len = chip.column_width(tile_col)
                if tile is not None and tile.rows > row:
                    col_bits = bits[row_offset:row_offset+col_len]
                    col_bits = col_bits[::-1]
                    columns[tile_col] = bits_to_string(col_bits) + '\n' + columns[tile_col]
                row_offset = row_offset + col_len

            offset += row_width
            row_trailer = bits[offset:offset+32]
            offset += 32
            row_trailer = bits_to_bytes(row_trailer)
            row_trailer = bytes_to_num(row_trailer)
            if row_trailer != 0:
                print("Unexpected trailer after row bits: %s" % (hex(row_trailer)))
                return;
    
        for tile_col in range(0, chip.columns):
            tile = chip.tile_at(tile_col, tile_row)
            if tile is not None:
                print(".%s %s %s" % (tile.type, tile_row, tile_col))
                print(columns[tile_col])

#
# Main util
#
if len(sys.argv) != 2:
    print("usage: %s <spi binary>" % sys.argv[0])
    sys.exit(-1)
    
reader = BinaryReader(sys.argv[1]);

spi_mark = reader.read16()

# _master.bin is identical to .bin, except
# it comes with 0xffff at the start.
if spi_mark != 0xffff:
    reader.reset()


device_id = reader.read32()
for idx in range(0, len(chips)):
    if device_id == chips[idx].device_id:
        chip = chips[idx]
        break

if chip is None:
    print("Unexpected device id %s at pos %s" % (hex(device_id), pos - 4))
    sys.exit(-1);


# ????
reader.require32(0x0000FFFF)

while reader.endOfFile() == False:
    word = reader.read32()
    if word & 0xff000000 == 0x2a000000:
        # Register header, write address
        dest = reader.read32()
        value = reader.read32()
        if dest == 0x00000F8F: 
            print(".crc %s" % hex(value))
    elif word & 0xffffff00 == 0xA2000000:
        # Array header, write group

        # top 24-bits = length in bits, low 8-bits = ??
        size_group = reader.require32(0x00000020, 0x000000ff)

        bit_len = (size_group >> 8) + 1
        aligned_len = round_up(bit_len, 32)

        bytes = reader.readN(aligned_len / 8)
        bits = bytes_to_bits(bytes)
    
        dest = word & 0xff
        if dest == 0x00:
            decode_tile_bitstream(bits, bit_len)
        elif dest == 0x21:
            # PLL CONFIG_CHAIN
            print(".pll -1 -1")
            print(bits_to_string(bits[:bit_len]))
            print("");
        else: 
            # dest == 0x20 appears on AG1KLP
            print(".unknown_%s -1 -1" % hex(dest))
            print(bits_to_string(bits[:bit_len]))
            print("");
