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
import struct
import sys

if len(sys.argv) != 2:
    print("usage: %s <uncompressed bar file>" % sys.argv[0])
    sys.exit(-1)

def skip(file, n):
    file.read(n)

def read16(file):
    return struct.unpack('H', file.read(2))[0]

def read32(file):
    return struct.unpack('I', file.read(4))[0]

def read_float(file):
    return struct.unpack('f', file.read(4))[0]

def read_string(file):
    len = read16(file)
    return file.read(len)

# Came from at a table in af at 0x00a9fea0.
# Referenced by a function at 0x00419ff0.
# That in turn was called by the remnants of
# dump_route_table at 0x008319f0.
types = [
    'RMUX', 'LMUX', 'TMUX', '*__DDIOMUX', 'IMUX', 'WMUX', 'KMUX', 'CtrlMUX',
    'PllSeamMUX', 'TileClkEnMUX', 'TileClkMUX', 'TileSyncMUX', 'TileAsyncMUX', 'TileWeRenMUX', 'BramClkMUX', 'TileClkMUX',
    'TileAsyncMUX', 'LoopMUX', '*__DDIOMUX', 'GclkMUX', 'GclkDMUX', 'GdrvMUX', 'BBMUXE', 'BBMUXN',
    'BBMUXW', 'BBMUXS', 'ConstMUX', 'InputMUX', 'PllClkInMUX', 'CFG_PllClkFbMUX', 'CFG_PllIntFbMUX', 'PllSeamMUX',
    'BufMUX', 'GateMUX', 'IsoMUXPseudo', 'SinkMUXPseudo', 'SLICE_LOGIC', 'SLICE_SRAMCTRL', 'SLICE_SRAM', 'SLICE_WRAMCTRL',
    'SLICE_WRAM', 'SLICE_CLKENCTRL', 'SLICE_ASYNCCTRL', 'SLICE_SYNCCTRL', 'SLICE_IO', 'SLICE_RIO', 'SLICE_DIO', 'SLICE_IOREG',
    'SLICE_DIOREG', 'SLICE_INDEL', 'SLICE_UFM', 'SLICE_UFMS', 'SLICE_UFML', 'SLICE_BOOT', 'SLICE_OSC', 'SLICE_REMOTE',
    'SLICE_JTAG', 'SLICE_IRDA', 'SLICE_MCU', 'SLICE_MCU_M3', 'SLICE_PLL', 'SLICE_PLLX', 'SLICE_PLLV', 'SLICE_PLLVE',
    'SLICE_SARADC', 'SLICE_OCT', 'SLICE_BRAM', 'SLICE_BRAM9K', 'SLICE_MULT', 'SLICE_MULTM', 'SLICE_I2C', 'SLICE_SPI',
    'SLICE_GCLKSEL', 'SLICE_GCLKGEN', 'SLICE_GCLKGEN0', 'SLICE_GCLKGEN2', 'SLICE_DPCLKDEL', 'SLICE_IO_GCLK', 'SLICE_UFM_GDDD', None,
    'OMUXR', 'OMUXI', 'OMUXL', None, 
]

with open(sys.argv[1], "rb") as input_file:
    device = read_string(input_file)
    print("Device: %s" % device)
    skip(input_file, 4)
    skip(input_file, 4)
    entries = read32(input_file)
    print("Number of entries: %s" % entries)

    for i in range(0, entries):
        entry = []
    
        # Seems like a tile coordinate.
        # First value ranges from 0 to 12.
        # Second ranges from 0 to 9. 
        # AG1KLP is 10 x 14.  
        # First value being one short could be 
        # because the last column on the chip
        # is all Rogic
        entry.append(read16(input_file))
        entry.append(read16(input_file))
    
        # Tile name. Seen values:
        # BOOT_PLL, BRAM0, ION0_4_0, ION1_4_1, IOS0_4_0, IOS1_4_1, LOGIC0, PLL
        entry.append(read_string(input_file))

        # Seems like a type.. values are:
        # BOOT_PLL: 53, 78
        # BRAM0: 66
        # ION0_4_0: 44, 47
        # ION1_4_1: 44, 47, 77
        # IOS0_4_0: 44, 47
        # IOS1_4_1: 44, 47, 77
        # LOGIC0: 36, 41, 42, 43
        # PLL: 61
        ttype = read16(input_file)
        entry.append(types[ttype])

        # First value here ranges from 1 to 15, and then 65535
        entry.append(read16(input_file))

        # Second value ranges from 1 to 35
        entry.append(read16(input_file))

        # Tile name. Same values as above
        entry.append(read_string(input_file))

        # Type?  Same values as above.
        ttype = read16(input_file)
        entry.append(types[ttype])

        # Same 1 to 15, 65535
        entry.append(read16(input_file))

        # Ranges from 1 to 67
        entry.append(read16(input_file))

        # Seems like timing information
        for _ in range(0, 8):
            entry.append(read_float(input_file))
    
        # number of paths??
        repeat = read16(input_file)
        entry.append(repeat)

        for _ in range(0, repeat):
            row = []
            # Always seems to be 9 or 10
            row.append(read16(input_file))

            # Always seems to be 1
            row.append(read16(input_file))

            # Always seems to be LOGIC0 or BRAM0
            row.append(read_string(input_file))
        
            # Always seems to be 0, 3, 4, 36
            row.append(read16(input_file))

            # Ranges from 1 to 90
            row.append(read16(input_file))
        
            entry.append(row)

        print(entry)