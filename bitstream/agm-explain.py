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
from routefile import RouteFile
from chips import ChipWithID, chips

if len(sys.argv) != 2 and len(sys.argv) != 3:
    print("usage: %s <agm-unpack.py output> [route.tx file]" % sys.argv[0])
    sys.exit(-1)

filename = sys.argv[1]
with open(filename, "r") as file:
    lines = file.readlines()
    
routing = None
if len(sys.argv) == 3:
    routing = RouteFile(sys.argv[2])

def print_data(data):
    owner = data['owner']
    values = owner.decode(data['bits'])
    
    keys = values.keys()
    keys.sort()
    
    x = None
    y = None
    if 'x' in data:
        x = data['x']
        y = data['y']
    
    print(data['header'])
    for key in keys:
        net = None
        if routing != None and x != None and y != None:
            net = routing.net_for_tile_config(x, y, key)
        if net is None:
            net = ''
        else:
            net = '\t; ' + net
        print("%s: %s%s" % (key, owner.format(key, values[key]), net))

    print("")

data = None
for line in lines:
    line = line.strip()
    if line.startswith("."):
        if data != None:
            print_data(data)
            
        data = None
        comps = line.split(" ")
        if len(comps) == 2:
            if comps[0] == ".device":
                chip_id = int(comps[1], 16)
                chip = ChipWithID(chip_id)
                if chip != None:
                    print(".device %s" % hex(chip.device_id))
            elif comps[0] == ".config_chain":
                chain_id = int(comps[1])
                chain = chip.configChain[chain_id]
                data = { 'bits': [], 'owner': chain, 'header': line }
        if len(comps) == 3:
            if chip != None:
                x = int(comps[1])
                y = int(comps[2])
                if x >= 0 and y >= 0:
                    tile = chip.tile_at(x, y)
                    if tile != None:
                        data = {'x': x, 'y': y, 'owner': tile, 'header': line, 'bits': []}
    elif len(line) > 0:
        if data != None:
            for char in line:
                if char == "0" or char == "1":
                    data['bits'].append(int(char))

if data != None:
    print_data(data)