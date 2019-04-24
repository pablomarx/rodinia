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
    'RMUX', 'LMUX', 'TMUX', 'OMUX', 'IMUX', 'WMUX', 'KMUX', 'CtrlMUX',
    'PllSeamMUX', 'TileClkEnMUX', 'TileClkMUX', 'TileSyncMUX', 'TileAsyncMUX', 'TileWeRenMUX', 'BramClkMUX', 'TileClkMUX',
    'TileAsyncMUX', 'LoopMUX', 'IOMUX', 'GclkMUX', 'GclkDMUX', 'GdrvMUX', 'BBMUXE', 'BBMUXN',
    'BBMUXW', 'BBMUXS', 'ConstMUX', 'InputMUX', 'PllClkInMUX', 'CFG_PllClkFbMUX', 'CFG_PllIntFbMUX', 'PllSeamMUX',
    'BufMUX', 'GateMUX', 'IsoMUXPseudo', 'SinkMUXPseudo', 'SLICE_LOGIC', 'SLICE_SRAMCTRL', 'SLICE_SRAM', 'SLICE_WRAMCTRL',
    'SLICE_WRAM', 'SLICE_CLKENCTRL', 'SLICE_ASYNCCTRL', 'SLICE_SYNCCTRL', 'SLICE_IO', 'SLICE_RIO', 'SLICE_DIO', 'SLICE_IOREG',
    'SLICE_DIOREG', 'SLICE_INDEL', 'SLICE_UFM', 'SLICE_UFMS', 'SLICE_UFML', 'SLICE_BOOT', 'SLICE_OSC', 'SLICE_REMOTE',
    'SLICE_JTAG', 'SLICE_IRDA', 'SLICE_MCU', 'SLICE_MCU_M3', 'SLICE_PLL', 'SLICE_PLLX', 'SLICE_PLLV', 'SLICE_PLLVE',
    'SLICE_SARADC', 'SLICE_OCT', 'SLICE_BRAM', 'SLICE_BRAM9K', 'SLICE_MULT', 'SLICE_MULTM', 'SLICE_I2C', 'SLICE_SPI',
    'SLICE_GCLKSEL', 'SLICE_GCLKGEN', 'SLICE_GCLKGEN0', 'SLICE_GCLKGEN2', 'SLICE_DPCLKDEL', 'SLICE_IO_GCLK', 'SLICE_UFM_GDDD', None,
    'OMUXR', 'OMUXI', 'OMUXL', None, 
]
    
# Output matches what dump_route_table emits
# dump_route_table doesn't work in af. 
# The TCL SWIG wrapper removed the function 
# call to native code.
# The native code can exists and works. 
# First argument needs to be a pointer to the 
# loaded route table. This can be retrieved at 0x0f87fe0
with open(sys.argv[1], "rb") as input_file:
    device = read_string(input_file)
    print("Device: %s" % device)
    skip(input_file, 4)
    skip(input_file, 4)
    entries = read32(input_file)
    print("Number of entries: %s" % entries)

    for i in range(0, entries):
        line = ""
        
        x = read16(input_file)
        y = read16(input_file)
        line += "(%s,%s) " % (x, y)
        
        tile = read_string(input_file)
        ttype = read16(input_file)
        idx = read16(input_file)
        if idx == 0xffff:
            idx = -1
        num = read16(input_file)
        line += "%s:%s%02i:O%s " % (tile, types[ttype], idx, num)

        tile = read_string(input_file)
        ttype = read16(input_file)
        idx = read16(input_file)
        num = read16(input_file)
        line += "%s:%s%02i:I%s " % (tile, types[ttype], idx, num)

        for _ in range(0, 8):
            line += "%0.3f " % read_float(input_file)
    
        print(line)
        
        repeat = read16(input_file)

        for _ in range(0, repeat):
            line = "  "
            
            x = read16(input_file)
            y = read16(input_file)
            line += "(%s,%s) " % (x, y)
            
            # ignored in dump_route_table output
            tile = read_string(input_file)
            
            ttype = read16(input_file)
            line += types[ttype]

            line += "%02i" % read16(input_file)
            print(line)