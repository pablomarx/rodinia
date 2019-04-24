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
import argparse

parser = argparse.ArgumentParser(description='Parse AGM bar files')
parser.add_argument('-ar_format', action='store_true', help='Display output in textual ar format')
parser.add_argument('file')
args = parser.parse_args()

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

def print_text_format(fields):
    print("  ROUTE (%s,%s) %s:%s:%s:O:%s %s:%s:%s:I:%s" % (fields[0], fields[1], fields[2], types[fields[3]], fields[4], fields[5], fields[6], types[fields[7]], fields[8], fields[9]))
    print("    DELAY : BEST %0.3f %0.3f %0.3f %0.3f" % (fields[10], fields[11], fields[12], fields[13]))
    print("    DELAY : WORST %0.3f %0.3f %0.3f %0.3f" % (fields[14], fields[15], fields[16], fields[17]))
    
    rows = fields[18]
    if len(rows) > 0:
        print("    PATH")
        for row in rows:
            print("      (%s,%s) %s:%s:%s" % (row[0], row[1], row[2], types[row[3]], row[4]))
        print("    END_PATH")
    print("  END_ROUTE")
    
def print_ar_format(fields):
    line = ""
    line += "(%s,%s) " % (fields[0], fields[1])
    line += "%s:%s%02i:O%s " % (fields[2], types[fields[3]], fields[4], fields[5])
    line += "%s:%s%02i:I%s " % (fields[6], types[fields[7]], fields[8], fields[9])
    for idx in range(10, 18):
        line += "%0.3f " % fields[idx]
    print(line)
    
    rows = fields[18]
    for row in rows:
        line = "  "
        line += "(%s,%s) " % (row[0], row[1])
        line += types[row[3]]
        line += "%02i" % row[4]
        print(line)
    
ar_format = args.ar_format
with open(args.file, "rb") as input_file:
    device = read_string(input_file)
    skip(input_file, 4)
    skip(input_file, 4)
    entries = read32(input_file)
    if ar_format is True:
        print("Device: %s" % device)
        print("Number of entries: %s" % entries)
    else:
        print("ROUTE_TABLE %s" % device)

    for i in range(0, entries):
        fields = []
        
        fields.append(read16(input_file))
        fields.append(read16(input_file))
        
        for _ in range(0, 2):
            fields.append(read_string(input_file))
            fields.append(read16(input_file))
            offset = read16(input_file)
            if offset == 0xffff:
                offset = -1
            fields.append(offset)
            fields.append(read16(input_file))

        for _ in range(0, 8):
            fields.append(read_float(input_file))
    
        repeat = read16(input_file)
        rows = []
        for _ in range(0, repeat):
            row = []

            row.append(read16(input_file))
            row.append(read16(input_file))

            row.append(read_string(input_file))
            row.append(read16(input_file))
            row.append(read16(input_file))

            rows.append(row)
        
        fields.append(rows)
        
        if ar_format is True:
            print_ar_format(fields)
        else:
            print_text_format(fields)
            
    if ar_format is not True:
        print("END_ROUTE_TABLE")