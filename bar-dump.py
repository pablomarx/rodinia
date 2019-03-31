#!/usr/bin/python

# This has only been tested with route.AG1200.bar
# Output is:
# (file position, string type, int type, data length, data)
# e.g.
# (0, 'AG1200', 40, 15, [0, 0, 0, 6, 0, 0, 0, 105, 89, 8, 0, 0, 0, 0, 0])
#
# Most output seems to be a short item 
# (24, 'PLL', 61, 5, [0, 0, 0, 0, 0])
# followed by a long item (len=43)
# (35, 'PLL', 61, 43, [0, 0, 0, 1, 0, 24, 4, 214, 62, 32, 176, 242, 62, 100, 59, 223, 62, 90, 100, 251, 62, 106, 188, 52, 63, 139, 108, 71, 63, 72, 225, 58, 63, 123, 20, 78, 63, 0, 0, 3, 0, 1, 0])
#
# Could this be a routing connection? First is from, second is to?
#
# First 4 bytes of the data often look like tile coordinates, but 
# not always...

import os
import struct
import sys

small_types = [0, 3, 4]
std_types = [44, 61, 53, 78, 66, 47, 77, 36, 41, 42, 43]
last_type = None
last_len = 0
pos = 0
with open(sys.argv[1], "rb") as input_file:
    size = os.fstat(input_file.fileno()).st_size
    print(size)
    while pos < size:
        name_len = struct.unpack('h', input_file.read(2))[0]
        name = input_file.read(name_len)
        type = ord(input_file.read(1))
        
        if type == 40:    # device header?
            val_len = 15 
        elif type in small_types:
            val_len = 7
        elif type in std_types:
            if last_len == 5:
                val_len = 43 
            else:
                val_len = 5 
        else:
            print("Unknown type! %s" % (type))
        
        last_type = type
        last_len = val_len
        i = 0
        val = []
        while i < val_len:
            try:
                val.append(ord(input_file.read(1)))
                i = i + 1
                if type != 66 and val_len == 5 and i == val_len and val[-2] == 9:
                    val_len = val_len + 2
            except:
                break
                
        print(pos, name, type, val_len, val)
        pos = pos + 2 + name_len + 1 + val_len
