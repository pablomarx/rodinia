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
from chips import ChipWithID
from utils import *
from breader import BinaryReader
from lzw import lzw_decode

chip = None

#
# Tile bitstream
#
def decode_tile_bitstream(bits, length, bitstream_num):
    row_width = round_up(chip.bitstream_row_width(), 8)
    rounded_row_width = ((int(row_width / 32) + 1) * 32)
    row_padding = rounded_row_width - row_width
    
    expected_size = 0
    for tile_row in range(0, chip.rows):
        row_height = chip.bitstream_height_for_row(tile_row)
        expected_size += rounded_row_width * row_height

    if expected_size != length:
        sys.stderr.write("Unexpected bitstream length %s (expected %s)\n" % (bit_len, expected_size))
        return False

    offset = 0
    for tile_row in range(chip.rows - 1,-1,-1):
        row_height = chip.bitstream_height_for_row(tile_row)
        
        columns = [''] * chip.columns

        for row in range(0, row_height):
            row_offset = offset
            for tile_col in range(chip.columns - 1,-1,-1):
                #print("row %s col %s pos %s" % (row, tile_col, row_offset))
                tile = chip.tile_at(tile_col, tile_row)
                col_len = chip.bitstream_width_for_column(tile_col)
                if tile is not None and tile.bitstream_height > row:
                    tile_width = tile.bitstream_width
                    col_bits = bits[row_offset:row_offset+tile_width]
                    col_bits = col_bits[::-1]
                    columns[tile_col] += bits_to_string(col_bits) + '\n'
                row_offset = row_offset + col_len

            offset += row_width
            row_trailer = bits[offset:offset+row_padding]
            offset += row_padding
            
            row_trailer = bits_to_bytes(row_trailer)
            row_trailer = bytes_to_num(row_trailer)
            if row_trailer != 0:
                print("Unexpected trailer after row bits: %s" % (hex(row_trailer)))
                return False
    
        for tile_col in range(0, chip.columns):
            tile = chip.tile_at(tile_col, tile_row)
            if tile is not None and len(tile.values) > 0:
                print(".%s %s %s" % (tile.type, tile_col, tile_row))
                print(columns[tile_col])

#
# Main util
#
if len(sys.argv) != 2:
    print("usage: %s <spi binary>" % sys.argv[0])
    sys.exit(-1)
    
reader = BinaryReader(sys.argv[1]);

spi_mark = reader.read16()

if spi_mark == 0xff55 or spi_mark == 0x5555:
    # ff55 is observed on AG16K spi flash bitstreams
    # 5555 is observed on AG10K spi flash bitstreams
    # After these series of bits they appear identical to non-spi flash bitstreams
    prefix = [ 0x00,0x00,0x0e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 ]
    for byte in prefix:
        if reader.read8() != byte:
            reader.reset()
            break
elif spi_mark != 0xffff:
    # ffff is observed on AG1K spi flash bitstreams
    # _master.bin is identical to .bin, except
    # it comes with 0xffff at the start.
    reader.reset()

cur_pos = reader.pos
unknown_mark = reader.read32()
if unknown_mark != 0x967e3c5a:
    # This is seen on the AG16K bitstreams. 
    # It's purpose is unknown
    reader.seek(cur_pos)
    
device_id = reader.read32()
chip = ChipWithID(device_id)
if chip is None:
    print("Unexpected device id %s at pos %s" % (hex(device_id), reader.pos - 4))
    sys.exit(-1);


print(".device %s" % hex(device_id))

# ????
reader.require32(0x0000FFFF)

pos = reader.pos

lzw_marker = reader.read8()
if lzw_marker != 0x55:
    # Not lzw, roll-back the reader
    reader.seek(pos)
else:
    reader.skip(round_up(reader.pos, 32) - reader.pos)
    lzw_data = reader.rest()
    bitstream_bytes = lzw_decode(lzw_data, **chip.lzw_info)
    reader = BinaryReader(None, bitstream_bytes)

last_bits = None
last_bit_len = 0
while reader.endOfFile() == False:
    word = reader.read32()
    if word & 0xff000000 == 0x22000000:
        # Unknown... Seen in AG10K bitstream
        value = reader.read32()
    elif word & 0xff000000 == 0x2a000000:
        # Register header, write address
        dest = reader.read32()
        value = reader.read32()
        if dest == 0x00000F8F: 
            print(".crc %s" % hex(value))
        else:
            print(".regwrite %s %s" % (hex(dest), hex(value)))    
    elif word & 0xffffff00 == 0xA2000000:
        # Array header, write group

        # top 24-bits = length in bits, low 8-bits = ??
        size_group = reader.require32(0x00000020, 0x000000ff)

        bit_len = (size_group >> 8) + 1
        aligned_len = round_up(bit_len, 32)

        bytes = reader.readN(int(aligned_len / 8))
        bits = bytes_to_bits(bytes)
        if last_bits != None:
            bits = last_bits + bits
            bit_len = last_bit_len + bit_len
            last_bits = None
    
        dest = word & 0xff
        if dest & 0xf0 == 0x00:
            success = decode_tile_bitstream(bits, bit_len, (dest & 0xf))
            if success == False:
                last_bits = bits
                last_bit_len = bit_len
        elif dest & 0xf0 == 0x20:
            chain_id = dest & 0xf
            chain = chip.configChain[chain_id]
            exp_len = len(chain.empty_bits())
            chain_bits = bits[:bit_len]
            if chip.device_id == 0x01500010 and exp_len * 4 == bit_len:
                chain_bits = [chain_bits[x] for x in range(0, len(chain_bits), 4)]
            print(".config_chain %s" % (chain_id))
            print(bits_to_string(chain_bits))
            print("");
        else: 
            print(".unknown_%s -1 -1" % hex(dest))
            print(bits_to_string(bits[:bit_len]))
            print("");
    else:
        sys.stderr.write("Unhandled word %08x at position %i\n" % (word, reader.pos))
