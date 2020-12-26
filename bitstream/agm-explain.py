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

import argparse
import sys
from routefile import RouteFile
from chips import ChipWithID, chips

parser = argparse.ArgumentParser(description='Explain textual bitstream file.')
parser.add_argument('file', metavar='file', type=str, 
                    help='an ascii bitstream file (e.g. agm-unpack.py output)')
parser.add_argument('--output', metavar='output', default='explain',
                    help='output type. Supported types: "explain" (default) or "fasm"')
parser.add_argument('--route', metavar='route.tx file', default=None,
                    help='Optional path to route.tx file to annotate nets')

args = parser.parse_args()

filename = args.file
with open(filename, "r") as file:
    lines = file.readlines()
    
routing = None
if args.route != None:
    routing = RouteFile(args.route)

emit_fasm = args.output == 'fasm'
if emit_fasm:
    print("#nofmt!")

def print_fasm_data(data):
    owner = data['owner']
    if owner == None:
        sys.stderr.write("No owner for data: %s\n" % (data))
        return
    empty_bits = owner.empty_bits()
    empty_values = owner.decode(empty_bits)
    
    data_values = owner.decode(data['bits'])
    
    args = data['args']
    
    if 'x' in args:
        tile_x = args['x']
        tile_y = args['y']
        tile_type = owner.type[0]
        prefix = "%s_Y%02iX%02i." % (tile_type, tile_y, tile_x)
    elif 'chain_id' in args:
        prefix = "C_Y-1X%02i." % args['chain_id']
    else:
        prefix = "!!unknown!!"
    
    keys = list(data_values)
    keys.sort()
    
    for key in keys:
        empty_value = empty_values[key]
        data_value = data_values[key]
        if empty_value != data_value:
            comment = owner.format(key, data_values[key], **args)
            comps = comment.split(";")
            if len(comps) > 1:
                print("# %s" % ";".join(comps[1:]))
                
            # XXX: May be an issue with bram init_val too...
            if key.endswith("_LUT"):
                print("#fmt!")
            print("%s%s = %s" % (prefix, key, comps[0].strip()))
            if key.endswith("_LUT"):
                print("#nofmt!")
            print("")

def print_explain_data(data):
    owner = data['owner']
    if owner == None:
        sys.stderr.write("No owner for data: %s\n" % (data))
        return
    values = owner.decode(data['bits'])
    
    args = data['args']
    
    keys = list(values)
    keys.sort()
    
    print(data['header'])
    for key in keys:
        print("%s: %s" % (key, owner.format(key, values[key], **args)))

    print("")
    
def print_data(data):
    if emit_fasm:
        print_fasm_data(data)
    else:
        print_explain_data(data)

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
                assert(chip != None)
                print("%sdevice %s" % ( "# " if emit_fasm else ".", hex(chip.device_id)))
            elif comps[0] == ".config_chain":
                chain_id = int(comps[1])
                chain = None
                if chain_id < len(chip.configChain):
                    chain = chip.configChain[chain_id]
                data = { 'bits': [], 'owner': chain, 'header': line, 'args': { 'chain_id': chain_id } }
        if len(comps) == 3:
            if chip != None:
                x = int(comps[1])
                y = int(comps[2])
                if x >= 0 and y >= 0:
                    tile = chip.tile_at(x, y)
                    if tile != None:
                        data = {'owner': tile, 'header': line, 'bits': [], 'args': {'x': x, 'y': y, 'routing': routing }}
    elif len(line) > 0:
        if data != None:
            for char in line:
                if char == "0" or char == "1":
                    data['bits'].append(int(char))

if data != None:
    print_data(data)