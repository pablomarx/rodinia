#!/usr/bin/python
#
# Copyright 2019 Steve White
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

from utils import bits_to_string, bits_to_bytes, bytes_to_num, bits_invert, num_to_bits, bits_to_num
import wires
from math import log
import re

tiles = {}

class Tile:
    name = None
    type = None
    columns = 0
    rows = 0
    slices = 0
    values = {}
    formatters = {}
    annotations = {}
    encoders = {}
    key_transformers = {}
    defaults = {}
    bitmapTable = None
    
    def __init__(self, name, type, columns, rows, slices, values, formatters={}, annotations={}, encoders={}, key_transformers={}, defaults={}):
        self.name = name
        self.type = type
        self.columns = columns
        self.rows = rows
        self.slices = slices
        self.values = values
        self.formatters = formatters
        self.formatters['__NAME'] = lambda key,val: val
        self.annotations = annotations
        self.encoders = encoders
        self.key_transformers = key_transformers
        self.defaults = defaults
    
    def buildBitmapTable(self):
        bitmapTable = [];
        for bit in range(0, self.columns * self.rows):
            matched = False
            for name in self.values:
                if bit in self.values[name]:
                    bitmapTable.append((name, self.values[name].index(bit)))
                    matched = True
                    break
            if matched == False:
                bitmapTable.append(None)
        self.bitmapTable = bitmapTable
    
    def bit_owner(self, bit):
        if self.bitmapTable is None:
            self.buildBitmapTable()
        
        return self.bitmapTable[bit]
    
    def bit_format(self, name, bits):
        if name in self.formatters:
            return self.formatters[name](name,bits)
        for pattern in self.formatters:
            if re.match(pattern, name):
                return self.formatters[pattern](name,bits)
        return bits_to_string(bits, 0, True)
    
    def format(self, name, bits, x, y, routing=None):
        result = self.bit_format(name, bits)
        if name in self.annotations:
            result += "\t; "+self.annotations[name]
        else:
            for pattern in self.annotations:
                if re.match(pattern, name):
                    result += "\t; "+self.annotations[pattern]
                    break
            
        if name.lower().find("mux") != -1:
            value = mux_decode(bits)
            if value != -1:
                wire = wires.input_for_tile_config(self.type, x, y, name, value)
                if wire is not None:
                    source = "%s(%s,%s):%s:%s %s %s" % (wire['tile'], wire['x'], wire['y'], wire['config'], wire['index'], wire['wire'], wire['timing'])
                    result += "\t; <= " + source
        if routing != None:
            net = routing.net_for_tile_config(x, y, name)
            if net is not None:
                result += '\t; ' + net
        return result
        
    def encode(self, key, value, bits, use_encoder=True):
        for pattern in self.key_transformers:
            if re.match(pattern, key):
                key = self.key_transformers[pattern](key)
                if type(key) is not str:
                    return key
                break
        
        if key not in self.values:
            print("Can't find key:%s in %s values" % (key, self.type))
            return None    
        
        if use_encoder:
            for pattern in self.encoders:
                if re.match(pattern, key):
                    value = self.encoders[pattern](key,value)
                    break
                
        indices = self.values[key]
        assert len(indices) == len(value)

        val_index = 0
        for bit_index in indices:
            bits[bit_index] = value[val_index]
            val_index += 1
        
        return True
        
    def decode(self, bits):
        values = { '__NAME': self.name }
        for idx in range(0, len(bits)):
            owner = self.bit_owner(idx)
            if owner != None:
                name = owner[0]
                position = owner[1]
            
                if name not in values:
                    values[name] = [None] * len(self.values[name])
            
                values[name][position] = bits[idx]
        return values
        
    def empty_bits(self):
        bits = [1] * (self.columns * self.rows)
        for key in self.values:
            for bit_idx in self.values[key]:
                bits[bit_idx] = 0
            for pattern in self.defaults:
                if re.match(pattern, key):
                    values = self.defaults[pattern]
                    src_idx = 0
                    for dst_idx in self.values[key]:
                        bits[dst_idx] = values[src_idx]
                        src_idx += 1
                    break
        return bits

def mux_encode(val, bit_len, val_len):
    if type(val) != int:
        val = bits_to_num(val)
    if val_len > 0:
        length = bit_len * val_len
        assert(val <= length)
        if val == -1:
            result = [0] * (bit_len + val_len)
        else:
            bottom = 1 << (val_len - 1 - int(val / bit_len))
            top = 1 << (bit_len - 1 - (val % bit_len))
            result = num_to_bits((top << val_len) | bottom, bit_len + val_len)
        assert val == mux_decode(result, bit_len)
    else:
        length = bit_len
        assert(val <= length)
        result = num_to_bits(1 << (bit_len-1-val), bit_len)
    return result

def mux_decode(bits, length=None):
    if length:
        X = len(bits) - length
    else:
        X = 3
        length = len(bits) - X
    
    strval = bits_to_string(bits)
    val = int(strval, 2)
    if val == 0:
        return -1
    
    top = val >> X
    bottom = val & ((1<<X)-1)
    
    if top == 0 or bottom == 0:
        return -1

    return int(((length-1) - log(top, 2)) + (length * (X - 1 - log(bottom, 2))))
    
def mux_format(bits, length, type):
    index = mux_decode(bits, length)
    return '%s\'b%s_%s\t; %s:%s' % (len(bits), bits_to_string(bits[0:length]), bits_to_string(bits[length:]), type, int(index)) 

def lut_slice_from_key(key):
    if key.startswith("alta_slice") and key.endswith("_LUT"):
        return int(key[10:-4])
    return None

def lut_encode(key, inbits):
    outbits = bits_invert(inbits)
    return outbits[::-1]

def lut_decode(key, inbits):
    outbits = bits_invert(inbits)
    return outbits[::-1]

def slice_omux_format(bits):
    if bits[0] == 0:
        name = 'LutOut'
    else:
        name = 'Q'
    return '1\'b%s\t; %s' % (bits[0], name)

def InstallTile(tile):
    global tiles
    tiles[tile.name] = tile

def TileNamed(name):
    global tiles
    return tiles[name]

InstallTile(Tile('AG1200_IOTILE_BOOT_PLL', 'UFMTILE', columns=34, rows=20, slices=0, values={
	# Each BBMUXE0 contains 1 entry of 9 bits each
	'BBMUXE00': [ 498, 532, 497, 531, 496, 530, 495, 529, 526 ],
	'BBMUXE01': [ 506, 540, 505, 539, 504, 538, 503, 537, 534 ],
	'BBMUXE02': [ 566, 600, 565, 599, 564, 598, 563, 597, 594 ],
	'BBMUXE03': [ 574, 608, 573, 607, 572, 606, 571, 605, 602 ],
	'BBMUXE04': [ 634, 668, 633, 667, 632, 666, 631, 665, 662 ],
	'BBMUXE05': [ 642, 676, 641, 675, 640, 674, 639, 673, 670 ],

	# Each BBMUXN0 contains 1 entry of 9 bits each
	'BBMUXN00': [ 90, 124, 89, 123, 88, 122, 87, 121, 118 ],
	'BBMUXN01': [ 98, 132, 97, 131, 96, 130, 95, 129, 126 ],
	'BBMUXN02': [ 158, 192, 157, 191, 156, 190, 155, 189, 186 ],
	'BBMUXN03': [ 166, 200, 165, 199, 164, 198, 163, 197, 194 ],

	'GdrvMUX00': [ 268, 234, 267, 233, 266, 265, 264, 263, 232, 231, 230, 229 ],

	'SeamMUX00':[287,288,289,290,291,292,293,294],
	'SeamMUX01':[321,322,323,324,325,326,327,328],
	'SeamMUX02':[355,356,357,358,359,360,361,362],
	'SeamMUX03':[389,390,391,392,393,394,395,396],
	'SeamMUX04':[423,424,425,426,427,428,429,430],
	'SeamMUX05':[431,432,433,434,435,436,437,438],
	'SeamMUX06':[397,398,399,400,401,402,403,404],
	'SeamMUX07':[363,364,365,366,367,368,369,370],
	'SeamMUX08':[329,330,331,332,333,334,335,336],
	'SeamMUX09':[295,296,297,298,299,300,301,302],
}, encoders={
	'BBMUXN[0-9][0-9]': lambda key,val: mux_encode(val, 7, 2),
    'BBMUXE[0-9][0-9]': lambda key,val: mux_encode(val, 7, 2),
}))

InstallTile(Tile('AG1200_IOTILE_N4_G1', 'IOTILE', columns=34, rows=20, slices=4, values={
	# Tile is identical to AG1200_IOTILE_N4, with the addition of CFG_GclkDMUX00

	# Each CtrlMUX contains 2 entries of 6 bits each
	'CtrlMUX00': [ 274, 308, 273, 307, 272, 306, 342, 376, 341, 375, 340, 374 ],
	'CtrlMUX01': [ 280, 314, 279, 313, 278, 312, 348, 382, 347, 381, 346, 380 ],
	'CtrlMUX02': [ 275, 309, 276, 310, 277, 311, 343, 377, 344, 378, 345, 379 ],
	'CtrlMUX03': [ 281, 315, 282, 316, 283, 317, 349, 383, 350, 384, 351, 385 ],

	'GclkDMUX00': [ 235, 474, 473, 236 ],

	'InputMUX00':[33],
	'InputMUX01':[135],
	'InputMUX02':[169],
	'InputMUX03':[237],
	'InputMUX04':[679],
	'InputMUX05':[577],
	'InputMUX06':[543],
	'InputMUX07':[475],

	'IOMUX00':[18,52,17,51,16,50,49],
	'IOMUX01':[86,120,85,119,84,118,117],
	'IOMUX02':[630,664,629,663,628,662,661],
	'IOMUX03':[562,596,561,595,560,594,593],
	'IOMUX04':[154,188,153,187,152,186,185],
	'IOMUX05':[222,256,221,255,220,254,253],
	'IOMUX06':[494,528,493,527,492,526,525],
	'IOMUX07':[426,460,425,459,424,458,457],
	'IOMUX08':[155,189,156,190,157,191,192],
	'IOMUX09':[223,257,224,258,225,259,260],
	'IOMUX10':[495,529,496,530,497,531,532],
	'IOMUX11':[427,461,428,462,429,463,464],
	'IOMUX12':[19,53,20,54,21,55,56],
	'IOMUX13':[87,121,88,122,89,123,124],
	'IOMUX14':[631,665,632,666,633,667,668],
	'IOMUX15':[563,597,564,598,565,599,600],
	'IOMUX16':[26,60,25,59,24,58,57],
	'IOMUX17':[94,128,93,127,92,126,125],
	'IOMUX18':[638,672,637,671,636,670,669],
	'IOMUX19':[570,604,569,603,568,602,601],
	'IOMUX20':[162,196,161,195,160,194,193],
	'IOMUX21':[230,264,229,263,228,262,261],
	'IOMUX22':[502,536,501,535,500,534,533],
	'IOMUX23':[434,468,433,467,432,466,465],

	# Each of these contains 4 entries of 1 bit each
	'IN_ASYNC_MODE': [ 28, 31, 674, 677 ],
	'IN_POWERUP': [ 61, 66, 639, 644 ],
	'IN_SYNC_MODE': [ 27, 32, 673, 678 ],
	'OE_ASYNC_MODE': [ 164, 167, 538, 541 ],
	'OE_POWERUP': [ 197, 202, 503, 508 ],
	'OE_REG_MODE': [ 130, 133, 572, 575 ],
	'OE_SYNC_MODE': [ 163, 168, 537, 542 ],
	'OUT_ASYNC_MODE': [ 96, 99, 606, 609 ],
	'OUT_POWERUP': [ 129, 134, 571, 576 ],
	'OUT_REG_MODE': [ 198, 201, 504, 507 ],
	'OUT_SYNC_MODE': [ 95, 100, 605, 610 ],

	'RMUX00':[2,36,1,0,35,34],
	'RMUX01':[70,104,69,68,103,102],
	'RMUX02':[138,172,137,136,171,170],
	'RMUX03':[206,240,205,204,239,238],
	'RMUX04':[614,648,613,612,647,646],
	'RMUX05':[546,580,545,544,579,578],
	'RMUX06':[478,512,477,476,511,510],
	'RMUX07':[410,444,409,408,443,442],
	'RMUX08':[3,37,4,5,38,39],
	'RMUX09':[71,105,72,73,106,107],
	'RMUX10':[139,173,140,141,174,175],
	'RMUX11':[207,241,208,209,242,243],
	'RMUX12':[615,649,616,617,650,651],
	'RMUX13':[547,581,548,549,582,583],
	'RMUX14':[479,513,480,481,514,515],
	'RMUX15':[411,445,412,413,446,447],
	'RMUX16':[8,42,7,6,41,40],
	'RMUX17':[76,110,75,74,109,108],
	'RMUX18':[144,178,143,142,177,176],
	'RMUX19':[212,246,211,210,245,244],
	'RMUX20':[620,654,619,618,653,652],
	'RMUX21':[552,586,551,550,585,584],
	'RMUX22':[484,518,483,482,517,516],
	'RMUX23':[416,450,415,414,449,448],
	'RMUX24':[9,43,10,11,44,45],
	'RMUX25':[77,111,78,79,112,113],
	'RMUX26':[145,179,146,147,180,181],
	'RMUX27':[213,247,214,215,248,249],
	'RMUX28':[621,655,622,623,656,657],
	'RMUX29':[553,587,554,555,588,589],
	'RMUX30':[485,519,486,487,520,521],
	'RMUX31':[417,451,418,419,452,453],

	'SeamMUX00':[287,288,289,290,291,292,293,294],
	'SeamMUX01':[389,390,391,392,393,394,395,396],
	'SeamMUX02':[321,322,323,324,325,326,327,328],
	'SeamMUX03':[355,356,357,358,359,360,361,362],
	'SeamMUX04':[295,296,297,298,299,300,266,265],
	'SeamMUX05':[397,398,399,400,401,402,436,435],
	'SeamMUX06':[329,330,331,332,333,334,232,231],
	'SeamMUX07':[363,364,365,366,367,368,470,469],

	'TileClkMUX00':[303,302,269],
	'TileClkMUX01':[405,404,439],
	'TileClkMUX02':[337,336,268],
	'TileClkMUX03':[371,370,438],
	'TileClkMUX04':[304,305,270],
	'TileClkMUX05':[406,407,440],
	'TileClkMUX06':[338,339,271],
	'TileClkMUX07':[372,373,441],
}, formatters={
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 3, 'I'),
	'IOMUX[0-9][0-9]': lambda key,val: mux_format(val, 4, 'I'),
	'TileClkMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 3, True),
	'CtrlMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 6, True),
	'GclkDMUX00': lambda key,val: bits_to_string(bits_invert(val), 6, True),
}, key_transformers={
    'alta_rio[0-9][0-9].[A-Z]*_USED': lambda x: None,
}, encoders={
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
	'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 3, 3),
	'IOMUX[0-9][0-9]': lambda key,val: mux_encode(val, 4, 3),
	'TileClkMUX[0-9][0-9]': lambda key,val: mux_encode(val, 2, 1),
    'GclkDMUX00': lambda key,val: bits_invert(([0] * (4 - len(val))) + val),
}, defaults={
	'TileClkMUX[0-9][0-9]': [0,0,1],
	'IOMUX[0-9][0-9]': [0, 0, 0, 0, 0, 0, 1],
}))

InstallTile(Tile('AG1200_IOTILE_N4', 'IOTILE', columns=34, rows=20, slices=4, values={
	# Each CtrlMUX contains 2 entries of 6 bits each
	'CtrlMUX00': [ 274, 308, 273, 307, 272, 306, 342, 376, 341, 375, 340, 374 ],
	'CtrlMUX01': [ 280, 314, 279, 313, 278, 312, 348, 382, 347, 381, 346, 380 ],
	'CtrlMUX02': [ 275, 309, 276, 310, 277, 311, 343, 377, 344, 378, 345, 379 ],
	'CtrlMUX03': [ 281, 315, 282, 316, 283, 317, 349, 383, 350, 384, 351, 385 ],

	'InputMUX00':[33],
	'InputMUX01':[135],
	'InputMUX02':[169],
	'InputMUX03':[237],
	'InputMUX04':[679],
	'InputMUX05':[577],
	'InputMUX06':[543],
	'InputMUX07':[475],

	'IOMUX00':[18,52,17,51,16,50,49],
	'IOMUX01':[86,120,85,119,84,118,117],
	'IOMUX02':[630,664,629,663,628,662,661],
	'IOMUX03':[562,596,561,595,560,594,593],
	'IOMUX04':[154,188,153,187,152,186,185],
	'IOMUX05':[222,256,221,255,220,254,253],
	'IOMUX06':[494,528,493,527,492,526,525],
	'IOMUX07':[426,460,425,459,424,458,457],
	'IOMUX08':[155,189,156,190,157,191,192],
	'IOMUX09':[223,257,224,258,225,259,260],
	'IOMUX10':[495,529,496,530,497,531,532],
	'IOMUX11':[427,461,428,462,429,463,464],
	'IOMUX12':[19,53,20,54,21,55,56],
	'IOMUX13':[87,121,88,122,89,123,124],
	'IOMUX14':[631,665,632,666,633,667,668],
	'IOMUX15':[563,597,564,598,565,599,600],
	'IOMUX16':[26,60,25,59,24,58,57],
	'IOMUX17':[94,128,93,127,92,126,125],
	'IOMUX18':[638,672,637,671,636,670,669],
	'IOMUX19':[570,604,569,603,568,602,601],
	'IOMUX20':[162,196,161,195,160,194,193],
	'IOMUX21':[230,264,229,263,228,262,261],
	'IOMUX22':[502,536,501,535,500,534,533],
	'IOMUX23':[434,468,433,467,432,466,465],

	# Each of these contains 4 entries of 1 bit each
	'IN_ASYNC_MODE': [ 28, 31, 674, 677 ],
	'IN_POWERUP': [ 61, 66, 639, 644 ],
	'IN_SYNC_MODE': [ 27, 32, 673, 678 ],
	'OE_ASYNC_MODE': [ 164, 167, 538, 541 ],
	'OE_POWERUP': [ 197, 202, 503, 508 ],
	'OE_REG_MODE': [ 130, 133, 572, 575 ],
	'OE_SYNC_MODE': [ 163, 168, 537, 542 ],
	'OUT_ASYNC_MODE': [ 96, 99, 606, 609 ],
	'OUT_POWERUP': [ 129, 134, 571, 576 ],
	'OUT_REG_MODE': [ 198, 201, 504, 507 ],
	'OUT_SYNC_MODE': [ 95, 100, 605, 610 ],

	'RMUX00':[2,36,1,0,35,34],
	'RMUX01':[70,104,69,68,103,102],
	'RMUX02':[138,172,137,136,171,170],
	'RMUX03':[206,240,205,204,239,238],
	'RMUX04':[614,648,613,612,647,646],
	'RMUX05':[546,580,545,544,579,578],
	'RMUX06':[478,512,477,476,511,510],
	'RMUX07':[410,444,409,408,443,442],
	'RMUX08':[3,37,4,5,38,39],
	'RMUX09':[71,105,72,73,106,107],
	'RMUX10':[139,173,140,141,174,175],
	'RMUX11':[207,241,208,209,242,243],
	'RMUX12':[615,649,616,617,650,651],
	'RMUX13':[547,581,548,549,582,583],
	'RMUX14':[479,513,480,481,514,515],
	'RMUX15':[411,445,412,413,446,447],
	'RMUX16':[8,42,7,6,41,40],
	'RMUX17':[76,110,75,74,109,108],
	'RMUX18':[144,178,143,142,177,176],
	'RMUX19':[212,246,211,210,245,244],
	'RMUX20':[620,654,619,618,653,652],
	'RMUX21':[552,586,551,550,585,584],
	'RMUX22':[484,518,483,482,517,516],
	'RMUX23':[416,450,415,414,449,448],
	'RMUX24':[9,43,10,11,44,45],
	'RMUX25':[77,111,78,79,112,113],
	'RMUX26':[145,179,146,147,180,181],
	'RMUX27':[213,247,214,215,248,249],
	'RMUX28':[621,655,622,623,656,657],
	'RMUX29':[553,587,554,555,588,589],
	'RMUX30':[485,519,486,487,520,521],
	'RMUX31':[417,451,418,419,452,453],

	'SeamMUX00':[287,288,289,290,291,292,293,294],
	'SeamMUX01':[389,390,391,392,393,394,395,396],
	'SeamMUX02':[321,322,323,324,325,326,327,328],
	'SeamMUX03':[355,356,357,358,359,360,361,362],
	'SeamMUX04':[295,296,297,298,299,300,266,265],
	'SeamMUX05':[397,398,399,400,401,402,436,435],
	'SeamMUX06':[329,330,331,332,333,334,232,231],
	'SeamMUX07':[363,364,365,366,367,368,470,469],

	'TileClkMUX00':[303,302,269],
	'TileClkMUX01':[405,404,439],
	'TileClkMUX02':[337,336,268],
	'TileClkMUX03':[371,370,438],
	'TileClkMUX04':[304,305,270],
	'TileClkMUX05':[406,407,440],
	'TileClkMUX06':[338,339,271],
	'TileClkMUX07':[372,373,441],
}, formatters={
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 3, 'I'),
	'IOMUX[0-9][0-9]': lambda key,val: mux_format(val, 4, 'I'),
	'TileClkMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 3, True),
	'CtrlMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 6, True)
}, key_transformers={
    'alta_rio[0-9][0-9].[A-Z]*_USED': lambda x: None,
}, encoders={
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
	'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 3, 3),
	'IOMUX[0-9][0-9]': lambda key,val: mux_encode(val, 4, 3),
	'TileClkMUX[0-9][0-9]': lambda key,val: mux_encode(val, 2, 1),
}, defaults={
	'TileClkMUX[0-9][0-9]': [0,0,1],
	'IOMUX[0-9][0-9]': [0, 0, 0, 0, 0, 0, 1],
}))

InstallTile(Tile('AG1200_IOTILE_S4_G1', 'IOTILE', columns=34, rows=20, slices=4, values={
	# Tile is identical to AG1200_TILE_S4, with the addition of CFG_GclkDMUX00
	# Each CtrlMUX contains 2 entries of 6 bits each
	'CtrlMUX00': [ 376, 342, 375, 341, 374, 340, 308, 274, 307, 273, 306, 272 ],
	'CtrlMUX01': [ 382, 348, 381, 347, 380, 346, 314, 280, 313, 279, 312, 278 ],
	'CtrlMUX02': [ 377, 343, 378, 344, 379, 345, 309, 275, 310, 276, 311, 277 ],
	'CtrlMUX03': [ 383, 349, 384, 350, 385, 351, 315, 281, 316, 282, 317, 283 ],

	'GclkDMUX00': [ 473, 236, 235, 474 ],

	'InputMUX00':[679],
	'InputMUX01':[577],
	'InputMUX02':[543],
	'InputMUX03':[475],
	'InputMUX04':[33],
	'InputMUX05':[135],
	'InputMUX06':[169],
	'InputMUX07':[237],

	'IOMUX00':[664,630,663,629,662,628,627],
	'IOMUX01':[596,562,595,561,594,560,559],
	'IOMUX02':[52,18,51,17,50,16,15],
	'IOMUX03':[120,86,119,85,118,84,83],
	'IOMUX04':[528,494,527,493,526,492,491],
	'IOMUX05':[460,426,459,425,458,424,423],
	'IOMUX06':[188,154,187,153,186,152,151],
	'IOMUX07':[256,222,255,221,254,220,219],
	'IOMUX08':[529,495,530,496,531,497,498],
	'IOMUX09':[461,427,462,428,463,429,430],
	'IOMUX10':[189,155,190,156,191,157,158],
	'IOMUX11':[257,223,258,224,259,225,226],
	'IOMUX12':[665,631,666,632,667,633,634],
	'IOMUX13':[597,563,598,564,599,565,566],
	'IOMUX14':[53,19,54,20,55,21,22],
	'IOMUX15':[121,87,122,88,123,89,90],
	'IOMUX16':[672,638,671,637,670,636,635],
	'IOMUX17':[604,570,603,569,602,568,567],
	'IOMUX18':[60,26,59,25,58,24,23],
	'IOMUX19':[128,94,127,93,126,92,91],
	'IOMUX20':[536,502,535,501,534,500,499],
	'IOMUX21':[468,434,467,433,466,432,431],
	'IOMUX22':[196,162,195,161,194,160,159],
	'IOMUX23':[264,230,263,229,262,228,227],

	# Each of these contains 4 entries of 1 bit each
	'IN_ASYNC_MODE': [ 674, 677, 28, 31 ],
	'IN_POWERUP': [ 639, 644, 61, 66 ],
	'IN_SYNC_MODE': [ 673, 678, 27, 32 ],
	'OE_ASYNC_MODE': [ 538, 541, 164, 167 ],
	'OE_POWERUP': [ 503, 508, 197, 202 ],
	'OE_REG_MODE': [ 572, 575, 130, 133 ],
	'OE_SYNC_MODE': [ 537, 542, 163, 168 ],
	'OUT_ASYNC_MODE': [ 606, 609, 96, 99 ],
	'OUT_POWERUP': [ 571, 576, 129, 134 ],
	'OUT_REG_MODE': [ 504, 507, 198, 201 ],
	'OUT_SYNC_MODE': [ 605, 610, 95, 100 ],

	'RMUX00':[648,614,647,646,613,612],
	'RMUX01':[580,546,579,578,545,544],
	'RMUX02':[512,478,511,510,477,476],
	'RMUX03':[444,410,443,442,409,408],
	'RMUX04':[36,2,35,34,1,0],
	'RMUX05':[104,70,103,102,69,68],
	'RMUX06':[172,138,171,170,137,136],
	'RMUX07':[240,206,239,238,205,204],
	'RMUX08':[649,615,650,651,616,617],
	'RMUX09':[581,547,582,583,548,549],
	'RMUX10':[513,479,514,515,480,481],
	'RMUX11':[445,411,446,447,412,413],
	'RMUX12':[37,3,38,39,4,5],
	'RMUX13':[105,71,106,107,72,73],
	'RMUX14':[173,139,174,175,140,141],
	'RMUX15':[241,207,242,243,208,209],
	'RMUX16':[654,620,653,652,619,618],
	'RMUX17':[586,552,585,584,551,550],
	'RMUX18':[518,484,517,516,483,482],
	'RMUX19':[450,416,449,448,415,414],
	'RMUX20':[42,8,41,40,7,6],
	'RMUX21':[110,76,109,108,75,74],
	'RMUX22':[178,144,177,176,143,142],
	'RMUX23':[246,212,245,244,211,210],
	'RMUX24':[655,621,656,657,622,623],
	'RMUX25':[587,553,588,589,554,555],
	'RMUX26':[519,485,520,521,486,487],
	'RMUX27':[451,417,452,453,418,419],
	'RMUX28':[43,9,44,45,10,11],
	'RMUX29':[111,77,112,113,78,79],
	'RMUX30':[179,145,180,181,146,147],
	'RMUX31':[247,213,248,249,214,215],

	'SeamMUX00':[389,390,391,392,393,394,395,396],
	'SeamMUX01':[287,288,289,290,291,292,293,294],
	'SeamMUX02':[355,356,357,358,359,360,361,362],
	'SeamMUX03':[321,322,323,324,325,326,327,328],
	'SeamMUX04':[397,398,399,400,401,402,436,435],
	'SeamMUX05':[295,296,297,298,299,300,266,265],
	'SeamMUX06':[363,364,365,366,367,368,470,469],
	'SeamMUX07':[329,330,331,332,333,334,232,231],

	'TileClkMUX00':[405,404,439],
	'TileClkMUX01':[303,302,269],
	'TileClkMUX02':[371,370,438],
	'TileClkMUX03':[337,336,268],
	'TileClkMUX04':[406,407,440],
	'TileClkMUX05':[304,305,270],
	'TileClkMUX06':[372,373,441],
	'TileClkMUX07':[338,339,271],
}, formatters={
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 3, 'I'),
	'IOMUX[0-9][0-9]': lambda key,val: mux_format(val, 4, 'I'),
	'TileClkMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 3, True),
	'CtrlMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 6, True),
	'GclkDMUX00': lambda key,val: bits_to_string(bits_invert(val), 6, True),
}, key_transformers={
    'alta_rio[0-9][0-9].[A-Z]*_USED': lambda x: None,
}, encoders={
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
	'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 3, 3),
	'IOMUX[0-9][0-9]': lambda key,val: mux_encode(val, 4, 3),
	'TileClkMUX[0-9][0-9]': lambda key,val: mux_encode(val, 2, 1),
    'GclkDMUX00': lambda key,val: bits_invert(([0] * (4 - len(val))) + val),
}, defaults={
	'TileClkMUX[0-9][0-9]': [0,0,1],
	'IOMUX[0-9][0-9]': [0, 0, 0, 0, 0, 0, 1],
}))

InstallTile(Tile('AG1200_IOTILE_S4', 'IOTILE', columns=34, rows=20, slices=4, values={
	# Each CtrlMUX contains 2 entries of 6 bits each
	'CtrlMUX00': [ 376, 342, 375, 341, 374, 340, 308, 274, 307, 273, 306, 272 ],
	'CtrlMUX01': [ 382, 348, 381, 347, 380, 346, 314, 280, 313, 279, 312, 278 ],
	'CtrlMUX02': [ 377, 343, 378, 344, 379, 345, 309, 275, 310, 276, 311, 277 ],
	'CtrlMUX03': [ 383, 349, 384, 350, 385, 351, 315, 281, 316, 282, 317, 283 ],

	'InputMUX00':[679],
	'InputMUX01':[577],
	'InputMUX02':[543],
	'InputMUX03':[475],
	'InputMUX04':[33],
	'InputMUX05':[135],
	'InputMUX06':[169],
	'InputMUX07':[237],

	'IOMUX00':[664,630,663,629,662,628,627],
	'IOMUX01':[596,562,595,561,594,560,559],
	'IOMUX02':[52,18,51,17,50,16,15],
	'IOMUX03':[120,86,119,85,118,84,83],
	'IOMUX04':[528,494,527,493,526,492,491],
	'IOMUX05':[460,426,459,425,458,424,423],
	'IOMUX06':[188,154,187,153,186,152,151],
	'IOMUX07':[256,222,255,221,254,220,219],
	'IOMUX08':[529,495,530,496,531,497,498],
	'IOMUX09':[461,427,462,428,463,429,430],
	'IOMUX10':[189,155,190,156,191,157,158],
	'IOMUX11':[257,223,258,224,259,225,226],
	'IOMUX12':[665,631,666,632,667,633,634],
	'IOMUX13':[597,563,598,564,599,565,566],
	'IOMUX14':[53,19,54,20,55,21,22],
	'IOMUX15':[121,87,122,88,123,89,90],
	'IOMUX16':[672,638,671,637,670,636,635],
	'IOMUX17':[604,570,603,569,602,568,567],
	'IOMUX18':[60,26,59,25,58,24,23],
	'IOMUX19':[128,94,127,93,126,92,91],
	'IOMUX20':[536,502,535,501,534,500,499],
	'IOMUX21':[468,434,467,433,466,432,431],
	'IOMUX22':[196,162,195,161,194,160,159],
	'IOMUX23':[264,230,263,229,262,228,227],

	# Each of these contains 4 entries of 1 bit each
	'IN_ASYNC_MODE': [ 674, 677, 28, 31 ],
	'IN_POWERUP': [ 639, 644, 61, 66 ],
	'IN_SYNC_MODE': [ 673, 678, 27, 32 ],
	'OE_ASYNC_MODE': [ 538, 541, 164, 167 ],
	'OE_POWERUP': [ 503, 508, 197, 202 ],
	'OE_REG_MODE': [ 572, 575, 130, 133 ],
	'OE_SYNC_MODE': [ 537, 542, 163, 168 ],
	'OUT_ASYNC_MODE': [ 606, 609, 96, 99 ],
	'OUT_POWERUP': [ 571, 576, 129, 134 ],
	'OUT_REG_MODE': [ 504, 507, 198, 201 ],
	'OUT_SYNC_MODE': [ 605, 610, 95, 100 ],

	'RMUX00':[648,614,647,646,613,612],
	'RMUX01':[580,546,579,578,545,544],
	'RMUX02':[512,478,511,510,477,476],
	'RMUX03':[444,410,443,442,409,408],
	'RMUX04':[36,2,35,34,1,0],
	'RMUX05':[104,70,103,102,69,68],
	'RMUX06':[172,138,171,170,137,136],
	'RMUX07':[240,206,239,238,205,204],
	'RMUX08':[649,615,650,651,616,617],
	'RMUX09':[581,547,582,583,548,549],
	'RMUX10':[513,479,514,515,480,481],
	'RMUX11':[445,411,446,447,412,413],
	'RMUX12':[37,3,38,39,4,5],
	'RMUX13':[105,71,106,107,72,73],
	'RMUX14':[173,139,174,175,140,141],
	'RMUX15':[241,207,242,243,208,209],
	'RMUX16':[654,620,653,652,619,618],
	'RMUX17':[586,552,585,584,551,550],
	'RMUX18':[518,484,517,516,483,482],
	'RMUX19':[450,416,449,448,415,414],
	'RMUX20':[42,8,41,40,7,6],
	'RMUX21':[110,76,109,108,75,74],
	'RMUX22':[178,144,177,176,143,142],
	'RMUX23':[246,212,245,244,211,210],
	'RMUX24':[655,621,656,657,622,623],
	'RMUX25':[587,553,588,589,554,555],
	'RMUX26':[519,485,520,521,486,487],
	'RMUX27':[451,417,452,453,418,419],
	'RMUX28':[43,9,44,45,10,11],
	'RMUX29':[111,77,112,113,78,79],
	'RMUX30':[179,145,180,181,146,147],
	'RMUX31':[247,213,248,249,214,215],

	'SeamMUX00':[389,390,391,392,393,394,395,396],
	'SeamMUX01':[287,288,289,290,291,292,293,294],
	'SeamMUX02':[355,356,357,358,359,360,361,362],
	'SeamMUX03':[321,322,323,324,325,326,327,328],
	'SeamMUX04':[397,398,399,400,401,402,436,435],
	'SeamMUX05':[295,296,297,298,299,300,266,265],
	'SeamMUX06':[363,364,365,366,367,368,470,469],
	'SeamMUX07':[329,330,331,332,333,334,232,231],

	'TileClkMUX00':[405,404,439],
	'TileClkMUX01':[303,302,269],
	'TileClkMUX02':[371,370,438],
	'TileClkMUX03':[337,336,268],
	'TileClkMUX04':[406,407,440],
	'TileClkMUX05':[304,305,270],
	'TileClkMUX06':[372,373,441],
	'TileClkMUX07':[338,339,271],
}, formatters={
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 3, 'I'),
	'IOMUX[0-9][0-9]': lambda key,val: mux_format(val, 4, 'I'),
	'TileClkMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 3, True),
	'SeamMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 8, True),
	'CtrlMUX[0-9][0-9]': lambda key,val: bits_to_string(val, 6, True)
}, key_transformers={
    'alta_rio[0-9][0-9].[A-Z]*_USED': lambda x: None,
}, encoders={
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
	'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 3, 3),
	'IOMUX[0-9][0-9]': lambda key,val: mux_encode(val, 4, 3),
	'TileClkMUX[0-9][0-9]': lambda key,val: mux_encode(val, 2, 1),
}, defaults={
	'TileClkMUX[0-9][0-9]': [0,0,1],
	'IOMUX[0-9][0-9]': [0, 0, 0, 0, 0, 0, 1],
}))

InstallTile(Tile('ALTA_EMB4K5', 'BramTILE', columns=108, rows=68, slices=0, values={
	'BramClkMUX00': [ 3489, 3490, 3491, 3488 ], # alta_bram00:Clk0
	'BramClkMUX01': [ 3813, 3814, 3815, 3812 ], # alta_bram00:Clk1

	'CLKMODE': [ 3703 ],

	'CtrlMUX00':[3472,3580,3473,3581,3474,3582,3475,3583,3585,3584,3477,3476],   # BramClkMUX00 | TileWeRenMUX00
	'CtrlMUX01':[3483,3591,3482,3590,3481,3589,3480,3588,3586,3587,3478,3479],   # BramClkMUX01 | TileWeRenMUX01
	'CtrlMUX02':[3796,3688,3797,3689,3798,3690,3799,3691,3693,3692,3801,3800],   # TileAsyncMUX00 | TileClkEnMUX00
	'CtrlMUX03':[3807,3699,3806,3698,3805,3697,3804,3696,3694,3695,3802,3803],   # TileAsyncMUX01 | TileClkEnMUX01

	'DWSEL_A0': [ 1542, 462, 1326, 570 ],
	'DWSEL_B0': [ 5754, 6834, 5970, 6726 ],

	'IMUX00':[16,124,17,125,18,126,19,127,20,21,129,128],       # AddressA[0]
	'IMUX01':[27,135,26,134,25,133,24,132,23,22,130,131],       # AddressA[1]
	'IMUX02':[232,340,233,341,234,342,235,343,236,237,345,344], # AddressA[2]
	'IMUX03':[243,351,242,350,241,349,240,348,239,238,346,347], # AddressA[3]
	'IMUX04':[448,556,449,557,450,558,451,559,452,453,561,560], # AddressA[4]
	'IMUX05':[459,567,458,566,457,565,456,564,455,454,562,563], # AddressA[5]
	'IMUX06':[664,772,665,773,666,774,667,775,668,669,777,776], # AddressA[6]
	'IMUX07':[675,783,674,782,673,781,672,780,671,670,778,779], # AddressA[7]
	'IMUX08':[880,988,881,989,882,990,883,991,884,885,993,992], # AddressA[8]
	'IMUX09':[891,999,890,998,889,997,888,996,887,886,994,995], # AddressA[9]
	'IMUX10':[1096,1204,1097,1205,1098,1206,1099,1207,1100,1101,1209,1208], # AddressA[10]
	'IMUX11':[1107,1215,1106,1214,1105,1213,1104,1212,1103,1102,1210,1211], # AddressA[11]
	'IMUX12':[1312,1420,1313,1421,1314,1422,1315,1423,1316,1317,1425,1424], # DataInA[0]
	'IMUX13':[1323,1431,1322,1430,1321,1429,1320,1428,1319,1318,1426,1427], # DataInA[1]
	'IMUX14':[1528,1636,1529,1637,1530,1638,1531,1639,1532,1533,1641,1640], # DataInA[2]
	'IMUX15':[1539,1647,1538,1646,1537,1645,1536,1644,1535,1534,1642,1643], # DataInA[3]
	'IMUX16':[1744,1852,1745,1853,1746,1854,1747,1855,1748,1749,1857,1856], # DataInA[4]
	'IMUX17':[1755,1863,1754,1862,1753,1861,1752,1860,1751,1750,1858,1859], # DataInA[5]
	'IMUX18':[1960,2068,1961,2069,1962,2070,1963,2071,1964,1965,2073,2072], # DataInA[6]
	'IMUX19':[1971,2079,1970,2078,1969,2077,1968,2076,1967,1966,2074,2075], # DataInA[7]
	'IMUX20':[2176,2284,2177,2285,2178,2286,2179,2287,2180,2181,2289,2288], # DataInA[8]
	'IMUX21':[2187,2295,2186,2294,2185,2293,2184,2292,2183,2182,2290,2291], # DataInA[9]
	'IMUX22':[2392,2500,2393,2501,2394,2502,2395,2503,2396,2397,2505,2504], # DataInA[10]
	'IMUX23':[2403,2511,2402,2510,2401,2509,2400,2508,2399,2398,2506,2507], # DataInA[11]
	'IMUX24':[2608,2716,2609,2717,2610,2718,2611,2719,2612,2613,2721,2720], # DataInA[12]
	'IMUX25':[2619,2727,2618,2726,2617,2725,2616,2724,2615,2614,2722,2723], # DataInA[13]
	'IMUX26':[2824,2932,2825,2933,2826,2934,2827,2935,2828,2829,2937,2936], # DataInA[14]
	'IMUX27':[2835,2943,2834,2942,2833,2941,2832,2940,2831,2830,2938,2939], # DataInA[15]
	'IMUX28':[3040,3148,3041,3149,3042,3150,3043,3151,3044,3045,3153,3152], # DataInA[16]
	'IMUX29':[3051,3159,3050,3158,3049,3157,3048,3156,3047,3046,3154,3155], # DataInA[17]
	'IMUX30':[3256,3364,3257,3365,3258,3366,3259,3367,3260,3261,3369,3368], # BramClkMUX00 | TileWeRenMUX00
	'IMUX31':[3267,3375,3266,3374,3265,3373,3264,3372,3263,3262,3370,3371], # BramClkMUX01 | TileWeRenMUX01
	'IMUX32':[3904,4012,3905,4013,3906,4014,3907,4015,3908,3909,4017,4016], # TileAsyncMUX00 | TileClkEnMUX00
	'IMUX33':[3915,4023,3914,4022,3913,4021,3912,4020,3911,3910,4018,4019], # TileAsyncMUX01 | TileClkEnMUX01
	'IMUX34':[4120,4228,4121,4229,4122,4230,4123,4231,4124,4125,4233,4232], # DataInB[]
	'IMUX35':[4131,4239,4130,4238,4129,4237,4128,4236,4127,4126,4234,4235], # DataInB[]
	'IMUX36':[4336,4444,4337,4445,4338,4446,4339,4447,4340,4341,4449,4448], # DataInB[]
	'IMUX37':[4347,4455,4346,4454,4345,4453,4344,4452,4343,4342,4450,4451], # DataInB[]
	'IMUX38':[4552,4660,4553,4661,4554,4662,4555,4663,4556,4557,4665,4664], # DataInB[]
	'IMUX39':[4563,4671,4562,4670,4561,4669,4560,4668,4559,4558,4666,4667], # DataInB[]
	'IMUX40':[4768,4876,4769,4877,4770,4878,4771,4879,4772,4773,4881,4880], # DataInB[]
	'IMUX41':[4779,4887,4778,4886,4777,4885,4776,4884,4775,4774,4882,4883], # DataInB[]
	'IMUX42':[4984,5092,4985,5093,4986,5094,4987,5095,4988,4989,5097,5096], # DataInB[]
	'IMUX43':[4995,5103,4994,5102,4993,5101,4992,5100,4991,4990,5098,5099], # DataInB[]
	'IMUX44':[5200,5308,5201,5309,5202,5310,5203,5311,5204,5205,5313,5312], # DataInB[]
	'IMUX45':[5211,5319,5210,5318,5209,5317,5208,5316,5207,5206,5314,5315], # DataInB[]
	'IMUX46':[5416,5524,5417,5525,5418,5526,5419,5527,5420,5421,5529,5528], # DataInB[]
	'IMUX47':[5427,5535,5426,5534,5425,5533,5424,5532,5423,5422,5530,5531], # DataInB[]
	'IMUX48':[5632,5740,5633,5741,5634,5742,5635,5743,5636,5637,5745,5744], # DataInB[]
	'IMUX49':[5643,5751,5642,5750,5641,5749,5640,5748,5639,5638,5746,5747], # DataInB[]
	'IMUX50':[5848,5956,5849,5957,5850,5958,5851,5959,5852,5853,5961,5960], # DataInB[]
	'IMUX51':[5859,5967,5858,5966,5857,5965,5856,5964,5855,5854,5962,5963], # DataInB[]
	'IMUX52':[6064,6172,6065,6173,6066,6174,6067,6175,6068,6069,6177,6176], # AddressB[11]
	'IMUX53':[6075,6183,6074,6182,6073,6181,6072,6180,6071,6070,6178,6179], # AddressB[10]
	'IMUX54':[6280,6388,6281,6389,6282,6390,6283,6391,6284,6285,6393,6392], # AddressB[9]
	'IMUX55':[6291,6399,6290,6398,6289,6397,6288,6396,6287,6286,6394,6395], # AddressB[8]
	'IMUX56':[6496,6604,6497,6605,6498,6606,6499,6607,6500,6501,6609,6608], # AddressB[7]
	'IMUX57':[6507,6615,6506,6614,6505,6613,6504,6612,6503,6502,6610,6611], # AddressB[6]
	'IMUX58':[6712,6820,6713,6821,6714,6822,6715,6823,6716,6717,6825,6824], # AddressB[5]
	'IMUX59':[6723,6831,6722,6830,6721,6829,6720,6828,6719,6718,6826,6827], # AddressB[4]
	'IMUX60':[6928,7036,6929,7037,6930,7038,6931,7039,6932,6933,7041,7040], # AddressB[3]
	'IMUX61':[6939,7047,6938,7046,6937,7045,6936,7044,6935,6934,7042,7043], # AddressB[2]
	'IMUX62':[7144,7252,7145,7253,7146,7254,7147,7255,7148,7149,7257,7256], # AddressB[1]
	'IMUX63':[7155,7263,7154,7262,7153,7261,7152,7260,7151,7150,7258,7259], # AddressB[0]

	'RMUX00':[5,113,4,112,3,111,2,1,109,110],
	'RMUX01':[869,977,868,976,867,975,866,865,973,974],
	'RMUX02':[6,114,7,115,8,116,9,10,118,117],
	'RMUX03':[870,978,871,979,872,980,873,874,982,981],
	'RMUX04':[15,123,14,122,13,121,12,11,119,120],
	'RMUX05':[879,987,878,986,877,985,876,875,983,984],
	'RMUX06':[221,329,220,328,219,327,218,217,325,326],
	'RMUX07':[1085,1193,1084,1192,1083,1191,1082,1081,1189,1190],
	'RMUX08':[222,330,223,331,224,332,225,226,334,333],
	'RMUX09':[1086,1194,1087,1195,1088,1196,1089,1090,1198,1197],
	'RMUX10':[231,339,230,338,229,337,228,227,335,336],
	'RMUX11':[1095,1203,1094,1202,1093,1201,1092,1091,1199,1200],
	'RMUX12':[1302,1410,1303,1411,1304,1412,1305,1306,1414,1413],
	'RMUX13':[438,546,439,547,440,548,441,442,550,549],
	'RMUX14':[1311,1419,1310,1418,1309,1417,1308,1307,1415,1416],
	'RMUX15':[447,555,446,554,445,553,444,443,551,552],
	'RMUX16':[1301,1409,1300,1408,1299,1407,1298,1297,1405,1406],
	'RMUX17':[437,545,436,544,435,543,434,433,541,542],
	'RMUX18':[1518,1626,1519,1627,1520,1628,1521,1522,1630,1629],
	'RMUX19':[654,762,655,763,656,764,657,658,766,765],
	'RMUX20':[1527,1635,1526,1634,1525,1633,1524,1523,1631,1632],
	'RMUX21':[663,771,662,770,661,769,660,659,767,768],
	'RMUX22':[1517,1625,1516,1624,1515,1623,1514,1513,1621,1622],
	'RMUX23':[653,761,652,760,651,759,650,649,757,758],
	'RMUX24':[1733,1841,1732,1840,1731,1839,1730,1729,1837,1838],
	'RMUX25':[2597,2705,2596,2704,2595,2703,2594,2593,2701,2702],
	'RMUX26':[1734,1842,1735,1843,1736,1844,1737,1738,1846,1845],
	'RMUX27':[2598,2706,2599,2707,2600,2708,2601,2602,2710,2709],
	'RMUX28':[1743,1851,1742,1850,1741,1849,1740,1739,1847,1848],
	'RMUX29':[2607,2715,2606,2714,2605,2713,2604,2603,2711,2712],
	'RMUX30':[1949,2057,1948,2056,1947,2055,1946,1945,2053,2054],
	'RMUX31':[2813,2921,2812,2920,2811,2919,2810,2809,2917,2918],
	'RMUX32':[1950,2058,1951,2059,1952,2060,1953,1954,2062,2061],
	'RMUX33':[2814,2922,2815,2923,2816,2924,2817,2818,2926,2925],
	'RMUX34':[1959,2067,1958,2066,1957,2065,1956,1955,2063,2064],
	'RMUX35':[2823,2931,2822,2930,2821,2929,2820,2819,2927,2928],
	'RMUX36':[3030,3138,3031,3139,3032,3140,3033,3034,3142,3141],
	'RMUX37':[2166,2274,2167,2275,2168,2276,2169,2170,2278,2277],
	'RMUX38':[3039,3147,3038,3146,3037,3145,3036,3035,3143,3144],
	'RMUX39':[2175,2283,2174,2282,2173,2281,2172,2171,2279,2280],
	'RMUX40':[3029,3137,3028,3136,3027,3135,3026,3025,3133,3134],
	'RMUX41':[2165,2273,2164,2272,2163,2271,2162,2161,2269,2270],
	'RMUX42':[3246,3354,3247,3355,3248,3356,3249,3250,3358,3357],
	'RMUX43':[2382,2490,2383,2491,2384,2492,2385,2386,2494,2493],
	'RMUX44':[3255,3363,3254,3362,3253,3361,3252,3251,3359,3360],
	'RMUX45':[2391,2499,2390,2498,2389,2497,2388,2387,2495,2496],
	'RMUX46':[3245,3353,3244,3352,3243,3351,3242,3241,3349,3350],
	'RMUX47':[2381,2489,2380,2488,2379,2487,2378,2377,2485,2486],
	'RMUX48':[3893,4001,3892,4000,3891,3999,3890,3889,3997,3998],
	'RMUX49':[4757,4865,4756,4864,4755,4863,4754,4753,4861,4862],
	'RMUX50':[3894,4002,3895,4003,3896,4004,3897,3898,4006,4005],
	'RMUX51':[4758,4866,4759,4867,4760,4868,4761,4762,4870,4869],
	'RMUX52':[3903,4011,3902,4010,3901,4009,3900,3899,4007,4008],
	'RMUX53':[4767,4875,4766,4874,4765,4873,4764,4763,4871,4872],
	'RMUX54':[4109,4217,4108,4216,4107,4215,4106,4105,4213,4214],
	'RMUX55':[4973,5081,4972,5080,4971,5079,4970,4969,5077,5078],
	'RMUX56':[4110,4218,4111,4219,4112,4220,4113,4114,4222,4221],
	'RMUX57':[4974,5082,4975,5083,4976,5084,4977,4978,5086,5085],
	'RMUX58':[4119,4227,4118,4226,4117,4225,4116,4115,4223,4224],
	'RMUX59':[4983,5091,4982,5090,4981,5089,4980,4979,5087,5088],
	'RMUX60':[5190,5298,5191,5299,5192,5300,5193,5194,5302,5301],
	'RMUX61':[4326,4434,4327,4435,4328,4436,4329,4330,4438,4437],
	'RMUX62':[5199,5307,5198,5306,5197,5305,5196,5195,5303,5304],
	'RMUX63':[4335,4443,4334,4442,4333,4441,4332,4331,4439,4440],
	'RMUX64':[5189,5297,5188,5296,5187,5295,5186,5185,5293,5294],
	'RMUX65':[4325,4433,4324,4432,4323,4431,4322,4321,4429,4430],
	'RMUX66':[5406,5514,5407,5515,5408,5516,5409,5410,5518,5517],
	'RMUX67':[4542,4650,4543,4651,4544,4652,4545,4546,4654,4653],
	'RMUX68':[5415,5523,5414,5522,5413,5521,5412,5411,5519,5520],
	'RMUX69':[4551,4659,4550,4658,4549,4657,4548,4547,4655,4656],
	'RMUX70':[5405,5513,5404,5512,5403,5511,5402,5401,5509,5510],
	'RMUX71':[4541,4649,4540,4648,4539,4647,4538,4537,4645,4646],
	'RMUX72':[5621,5729,5620,5728,5619,5727,5618,5617,5725,5726],
	'RMUX73':[6485,6593,6484,6592,6483,6591,6482,6481,6589,6590],
	'RMUX74':[5622,5730,5623,5731,5624,5732,5625,5626,5734,5733],
	'RMUX75':[6486,6594,6487,6595,6488,6596,6489,6490,6598,6597],
	'RMUX76':[5631,5739,5630,5738,5629,5737,5628,5627,5735,5736],
	'RMUX77':[6495,6603,6494,6602,6493,6601,6492,6491,6599,6600],
	'RMUX78':[5837,5945,5836,5944,5835,5943,5834,5833,5941,5942],
	'RMUX79':[6701,6809,6700,6808,6699,6807,6698,6697,6805,6806],
	'RMUX80':[5838,5946,5839,5947,5840,5948,5841,5842,5950,5949],
	'RMUX81':[6702,6810,6703,6811,6704,6812,6705,6706,6814,6813],
	'RMUX82':[5847,5955,5846,5954,5845,5953,5844,5843,5951,5952],
	'RMUX83':[6711,6819,6710,6818,6709,6817,6708,6707,6815,6816],
	'RMUX84':[6918,7026,6919,7027,6920,7028,6921,6922,7030,7029],
	'RMUX85':[6054,6162,6055,6163,6056,6164,6057,6058,6166,6165],
	'RMUX86':[6927,7035,6926,7034,6925,7033,6924,6923,7031,7032],
	'RMUX87':[6063,6171,6062,6170,6061,6169,6060,6059,6167,6168],
	'RMUX88':[6917,7025,6916,7024,6915,7023,6914,6913,7021,7022],
	'RMUX89':[6053,6161,6052,6160,6051,6159,6050,6049,6157,6158],
	'RMUX90':[7134,7242,7135,7243,7136,7244,7137,7138,7246,7245],
	'RMUX91':[6270,6378,6271,6379,6272,6380,6273,6274,6382,6381],
	'RMUX92':[7143,7251,7142,7250,7141,7249,7140,7139,7247,7248],
	'RMUX93':[6279,6387,6278,6386,6277,6385,6276,6275,6383,6384],
	'RMUX94':[7133,7241,7132,7240,7131,7239,7130,7129,7237,7238],
	'RMUX95':[6269,6377,6268,6376,6267,6375,6266,6265,6373,6374],

	'SeamMUX00':[3457,3458,3459,3460,3461,3462,3463,3464],   # IsoMUXPseudo00 | BramClkMUX00
	'SeamMUX01':[3781,3782,3783,3784,3785,3786,3787,3788],   # IsoMUXPseudo01 | BramClkMUX01
	'SeamMUX02':[3465,3466,3578,3467,3468,3469,3470,3471],   # IsoMUXPseudo02 | TileAsyncMUX00
	'SeamMUX03':[3789,3790,3686,3791,3792,3793,3794,3795],   # IsoMUXPseudo03 | TileAsyncMUX01
	'SeamMUX04':[2592,2700,2808,2916,3024,3132,3240,3348],   # TileWeRenMUX00 
	'SeamMUX05':[4644,4536,4428,4320,4212,4104,3996,3888],   # TileWeRenMUX01

	'SELOUT_A': [ 30 ],
	'SELOUT_B': [ 7266 ],
	'SEL_PORTMODE': [ 3918 ],
	'SEL_WKMODE_A': [ 1866 ],
	'SEL_WKMODE_B': [ 5430 ],
	'SEL_WRTHU_A': [ 3270 ],
	'SEL_WRTHU_B': [ 4026 ],

	'TileAsyncMUX00':[3486,3485,3484,3487],  # alta_bram00:AsyncReset0
	'TileAsyncMUX01':[3810,3809,3808,3811],  # alta_bram00:AsyncReset1

	'TileClkEnMUX00':[3593,3592,3594],   # alta_bram00:ClkEn0
	'TileClkEnMUX01':[3701,3700,3702],   # alta_bram00:ClkEn1

	'TileWeRenMUX00':[3597,3598,3599,3596],  # alta_bram00:WeRenA
	'TileWeRenMUX01':[3705,3706,3707,3704],  # alta_bram00:WeRenB

	# INIT_VAL contains 4608 bits 
	# Value appears backwards from how it is supplied in Verilog
	'INIT_VAL': [
        36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 37, 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93, 97, 101, 105, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74, 78, 82, 86, 90, 94, 98, 102, 106, 39, 43, 47, 51, 55, 59, 63, 67, 71, 75, 
        79, 83, 87, 91, 95, 99, 103, 107, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188, 192, 196, 200, 204, 208, 212, 145, 149, 153, 157, 161, 165, 169, 173, 177, 181, 185, 189, 193, 197, 201, 205, 209, 213, 146, 150, 154, 158, 162, 166, 170, 174, 178, 182, 186, 190, 194, 198, 202, 206, 210, 214, 147, 151, 
        155, 159, 163, 167, 171, 175, 179, 183, 187, 191, 195, 199, 203, 207, 211, 215, 252, 256, 260, 264, 268, 272, 276, 280, 284, 288, 292, 296, 300, 304, 308, 312, 316, 320, 253, 257, 261, 265, 269, 273, 277, 281, 285, 289, 293, 297, 301, 305, 309, 313, 317, 321, 254, 258, 262, 266, 270, 274, 278, 282, 286, 290, 294, 298, 
        302, 306, 310, 314, 318, 322, 255, 259, 263, 267, 271, 275, 279, 283, 287, 291, 295, 299, 303, 307, 311, 315, 319, 323, 360, 364, 368, 372, 376, 380, 384, 388, 392, 396, 400, 404, 408, 412, 416, 420, 424, 428, 361, 365, 369, 373, 377, 381, 385, 389, 393, 397, 401, 405, 409, 413, 417, 421, 425, 429, 362, 366, 370, 374, 
        378, 382, 386, 390, 394, 398, 402, 406, 410, 414, 418, 422, 426, 430, 363, 367, 371, 375, 379, 383, 387, 391, 395, 399, 403, 407, 411, 415, 419, 423, 427, 431, 468, 472, 476, 480, 484, 488, 492, 496, 500, 504, 508, 512, 516, 520, 524, 528, 532, 536, 469, 473, 477, 481, 485, 489, 493, 497, 501, 505, 509, 513, 517, 521, 
        525, 529, 533, 537, 470, 474, 478, 482, 486, 490, 494, 498, 502, 506, 510, 514, 518, 522, 526, 530, 534, 538, 471, 475, 479, 483, 487, 491, 495, 499, 503, 507, 511, 515, 519, 523, 527, 531, 535, 539, 576, 580, 584, 588, 592, 596, 600, 604, 608, 612, 616, 620, 624, 628, 632, 636, 640, 644, 577, 581, 585, 589, 593, 597, 
        601, 605, 609, 613, 617, 621, 625, 629, 633, 637, 641, 645, 578, 582, 586, 590, 594, 598, 602, 606, 610, 614, 618, 622, 626, 630, 634, 638, 642, 646, 579, 583, 587, 591, 595, 599, 603, 607, 611, 615, 619, 623, 627, 631, 635, 639, 643, 647, 684, 688, 692, 696, 700, 704, 708, 712, 716, 720, 724, 728, 732, 736, 740, 744, 
        748, 752, 685, 689, 693, 697, 701, 705, 709, 713, 717, 721, 725, 729, 733, 737, 741, 745, 749, 753, 686, 690, 694, 698, 702, 706, 710, 714, 718, 722, 726, 730, 734, 738, 742, 746, 750, 754, 687, 691, 695, 699, 703, 707, 711, 715, 719, 723, 727, 731, 735, 739, 743, 747, 751, 755, 792, 796, 800, 804, 808, 812, 816, 820, 
        824, 828, 832, 836, 840, 844, 848, 852, 856, 860, 793, 797, 801, 805, 809, 813, 817, 821, 825, 829, 833, 837, 841, 845, 849, 853, 857, 861, 794, 798, 802, 806, 810, 814, 818, 822, 826, 830, 834, 838, 842, 846, 850, 854, 858, 862, 795, 799, 803, 807, 811, 815, 819, 823, 827, 831, 835, 839, 843, 847, 851, 855, 859, 863, 
        900, 904, 908, 912, 916, 920, 924, 928, 932, 936, 940, 944, 948, 952, 956, 960, 964, 968, 901, 905, 909, 913, 917, 921, 925, 929, 933, 937, 941, 945, 949, 953, 957, 961, 965, 969, 902, 906, 910, 914, 918, 922, 926, 930, 934, 938, 942, 946, 950, 954, 958, 962, 966, 970, 903, 907, 911, 915, 919, 923, 927, 931, 935, 939, 
        943, 947, 951, 955, 959, 963, 967, 971, 1008, 1012, 1016, 1020, 1024, 1028, 1032, 1036, 1040, 1044, 1048, 1052, 1056, 1060, 1064, 1068, 1072, 1076, 1009, 1013, 1017, 1021, 1025, 1029, 1033, 1037, 1041, 1045, 1049, 1053, 1057, 1061, 1065, 1069, 1073, 1077, 1010, 1014, 1018, 1022, 1026, 1030, 1034, 1038, 1042, 1046, 1050, 1054, 1058, 1062, 1066, 1070, 1074, 1078, 1011, 1015, 
        1019, 1023, 1027, 1031, 1035, 1039, 1043, 1047, 1051, 1055, 1059, 1063, 1067, 1071, 1075, 1079, 1116, 1120, 1124, 1128, 1132, 1136, 1140, 1144, 1148, 1152, 1156, 1160, 1164, 1168, 1172, 1176, 1180, 1184, 1117, 1121, 1125, 1129, 1133, 1137, 1141, 1145, 1149, 1153, 1157, 1161, 1165, 1169, 1173, 1177, 1181, 1185, 1118, 1122, 1126, 1130, 1134, 1138, 1142, 1146, 1150, 1154, 1158, 1162, 
        1166, 1170, 1174, 1178, 1182, 1186, 1119, 1123, 1127, 1131, 1135, 1139, 1143, 1147, 1151, 1155, 1159, 1163, 1167, 1171, 1175, 1179, 1183, 1187, 1224, 1228, 1232, 1236, 1240, 1244, 1248, 1252, 1256, 1260, 1264, 1268, 1272, 1276, 1280, 1284, 1288, 1292, 1225, 1229, 1233, 1237, 1241, 1245, 1249, 1253, 1257, 1261, 1265, 1269, 1273, 1277, 1281, 1285, 1289, 1293, 1226, 1230, 1234, 1238, 
        1242, 1246, 1250, 1254, 1258, 1262, 1266, 1270, 1274, 1278, 1282, 1286, 1290, 1294, 1227, 1231, 1235, 1239, 1243, 1247, 1251, 1255, 1259, 1263, 1267, 1271, 1275, 1279, 1283, 1287, 1291, 1295, 1332, 1336, 1340, 1344, 1348, 1352, 1356, 1360, 1364, 1368, 1372, 1376, 1380, 1384, 1388, 1392, 1396, 1400, 1333, 1337, 1341, 1345, 1349, 1353, 1357, 1361, 1365, 1369, 1373, 1377, 1381, 1385, 
        1389, 1393, 1397, 1401, 1334, 1338, 1342, 1346, 1350, 1354, 1358, 1362, 1366, 1370, 1374, 1378, 1382, 1386, 1390, 1394, 1398, 1402, 1335, 1339, 1343, 1347, 1351, 1355, 1359, 1363, 1367, 1371, 1375, 1379, 1383, 1387, 1391, 1395, 1399, 1403, 1440, 1444, 1448, 1452, 1456, 1460, 1464, 1468, 1472, 1476, 1480, 1484, 1488, 1492, 1496, 1500, 1504, 1508, 1441, 1445, 1449, 1453, 1457, 1461, 
        1465, 1469, 1473, 1477, 1481, 1485, 1489, 1493, 1497, 1501, 1505, 1509, 1442, 1446, 1450, 1454, 1458, 1462, 1466, 1470, 1474, 1478, 1482, 1486, 1490, 1494, 1498, 1502, 1506, 1510, 1443, 1447, 1451, 1455, 1459, 1463, 1467, 1471, 1475, 1479, 1483, 1487, 1491, 1495, 1499, 1503, 1507, 1511, 1548, 1552, 1556, 1560, 1564, 1568, 1572, 1576, 1580, 1584, 1588, 1592, 1596, 1600, 1604, 1608, 
        1612, 1616, 1549, 1553, 1557, 1561, 1565, 1569, 1573, 1577, 1581, 1585, 1589, 1593, 1597, 1601, 1605, 1609, 1613, 1617, 1550, 1554, 1558, 1562, 1566, 1570, 1574, 1578, 1582, 1586, 1590, 1594, 1598, 1602, 1606, 1610, 1614, 1618, 1551, 1555, 1559, 1563, 1567, 1571, 1575, 1579, 1583, 1587, 1591, 1595, 1599, 1603, 1607, 1611, 1615, 1619, 1656, 1660, 1664, 1668, 1672, 1676, 1680, 1684, 
        1688, 1692, 1696, 1700, 1704, 1708, 1712, 1716, 1720, 1724, 1657, 1661, 1665, 1669, 1673, 1677, 1681, 1685, 1689, 1693, 1697, 1701, 1705, 1709, 1713, 1717, 1721, 1725, 1658, 1662, 1666, 1670, 1674, 1678, 1682, 1686, 1690, 1694, 1698, 1702, 1706, 1710, 1714, 1718, 1722, 1726, 1659, 1663, 1667, 1671, 1675, 1679, 1683, 1687, 1691, 1695, 1699, 1703, 1707, 1711, 1715, 1719, 1723, 1727, 
        1764, 1768, 1772, 1776, 1780, 1784, 1788, 1792, 1796, 1800, 1804, 1808, 1812, 1816, 1820, 1824, 1828, 1832, 1765, 1769, 1773, 1777, 1781, 1785, 1789, 1793, 1797, 1801, 1805, 1809, 1813, 1817, 1821, 1825, 1829, 1833, 1766, 1770, 1774, 1778, 1782, 1786, 1790, 1794, 1798, 1802, 1806, 1810, 1814, 1818, 1822, 1826, 1830, 1834, 1767, 1771, 1775, 1779, 1783, 1787, 1791, 1795, 1799, 1803, 
        1807, 1811, 1815, 1819, 1823, 1827, 1831, 1835, 1872, 1876, 1880, 1884, 1888, 1892, 1896, 1900, 1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 1936, 1940, 1873, 1877, 1881, 1885, 1889, 1893, 1897, 1901, 1905, 1909, 1913, 1917, 1921, 1925, 1929, 1933, 1937, 1941, 1874, 1878, 1882, 1886, 1890, 1894, 1898, 1902, 1906, 1910, 1914, 1918, 1922, 1926, 1930, 1934, 1938, 1942, 1875, 1879, 
        1883, 1887, 1891, 1895, 1899, 1903, 1907, 1911, 1915, 1919, 1923, 1927, 1931, 1935, 1939, 1943, 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 2044, 2048, 1981, 1985, 1989, 1993, 1997, 2001, 2005, 2009, 2013, 2017, 2021, 2025, 2029, 2033, 2037, 2041, 2045, 2049, 1982, 1986, 1990, 1994, 1998, 2002, 2006, 2010, 2014, 2018, 2022, 2026, 
        2030, 2034, 2038, 2042, 2046, 2050, 1983, 1987, 1991, 1995, 1999, 2003, 2007, 2011, 2015, 2019, 2023, 2027, 2031, 2035, 2039, 2043, 2047, 2051, 2088, 2092, 2096, 2100, 2104, 2108, 2112, 2116, 2120, 2124, 2128, 2132, 2136, 2140, 2144, 2148, 2152, 2156, 2089, 2093, 2097, 2101, 2105, 2109, 2113, 2117, 2121, 2125, 2129, 2133, 2137, 2141, 2145, 2149, 2153, 2157, 2090, 2094, 2098, 2102, 
        2106, 2110, 2114, 2118, 2122, 2126, 2130, 2134, 2138, 2142, 2146, 2150, 2154, 2158, 2091, 2095, 2099, 2103, 2107, 2111, 2115, 2119, 2123, 2127, 2131, 2135, 2139, 2143, 2147, 2151, 2155, 2159, 2196, 2200, 2204, 2208, 2212, 2216, 2220, 2224, 2228, 2232, 2236, 2240, 2244, 2248, 2252, 2256, 2260, 2264, 2197, 2201, 2205, 2209, 2213, 2217, 2221, 2225, 2229, 2233, 2237, 2241, 2245, 2249, 
        2253, 2257, 2261, 2265, 2198, 2202, 2206, 2210, 2214, 2218, 2222, 2226, 2230, 2234, 2238, 2242, 2246, 2250, 2254, 2258, 2262, 2266, 2199, 2203, 2207, 2211, 2215, 2219, 2223, 2227, 2231, 2235, 2239, 2243, 2247, 2251, 2255, 2259, 2263, 2267, 2304, 2308, 2312, 2316, 2320, 2324, 2328, 2332, 2336, 2340, 2344, 2348, 2352, 2356, 2360, 2364, 2368, 2372, 2305, 2309, 2313, 2317, 2321, 2325, 
        2329, 2333, 2337, 2341, 2345, 2349, 2353, 2357, 2361, 2365, 2369, 2373, 2306, 2310, 2314, 2318, 2322, 2326, 2330, 2334, 2338, 2342, 2346, 2350, 2354, 2358, 2362, 2366, 2370, 2374, 2307, 2311, 2315, 2319, 2323, 2327, 2331, 2335, 2339, 2343, 2347, 2351, 2355, 2359, 2363, 2367, 2371, 2375, 2412, 2416, 2420, 2424, 2428, 2432, 2436, 2440, 2444, 2448, 2452, 2456, 2460, 2464, 2468, 2472, 
        2476, 2480, 2413, 2417, 2421, 2425, 2429, 2433, 2437, 2441, 2445, 2449, 2453, 2457, 2461, 2465, 2469, 2473, 2477, 2481, 2414, 2418, 2422, 2426, 2430, 2434, 2438, 2442, 2446, 2450, 2454, 2458, 2462, 2466, 2470, 2474, 2478, 2482, 2415, 2419, 2423, 2427, 2431, 2435, 2439, 2443, 2447, 2451, 2455, 2459, 2463, 2467, 2471, 2475, 2479, 2483, 2520, 2524, 2528, 2532, 2536, 2540, 2544, 2548, 
        2552, 2556, 2560, 2564, 2568, 2572, 2576, 2580, 2584, 2588, 2521, 2525, 2529, 2533, 2537, 2541, 2545, 2549, 2553, 2557, 2561, 2565, 2569, 2573, 2577, 2581, 2585, 2589, 2522, 2526, 2530, 2534, 2538, 2542, 2546, 2550, 2554, 2558, 2562, 2566, 2570, 2574, 2578, 2582, 2586, 2590, 2523, 2527, 2531, 2535, 2539, 2543, 2547, 2551, 2555, 2559, 2563, 2567, 2571, 2575, 2579, 2583, 2587, 2591, 
        2628, 2632, 2636, 2640, 2644, 2648, 2652, 2656, 2660, 2664, 2668, 2672, 2676, 2680, 2684, 2688, 2692, 2696, 2629, 2633, 2637, 2641, 2645, 2649, 2653, 2657, 2661, 2665, 2669, 2673, 2677, 2681, 2685, 2689, 2693, 2697, 2630, 2634, 2638, 2642, 2646, 2650, 2654, 2658, 2662, 2666, 2670, 2674, 2678, 2682, 2686, 2690, 2694, 2698, 2631, 2635, 2639, 2643, 2647, 2651, 2655, 2659, 2663, 2667, 
        2671, 2675, 2679, 2683, 2687, 2691, 2695, 2699, 2736, 2740, 2744, 2748, 2752, 2756, 2760, 2764, 2768, 2772, 2776, 2780, 2784, 2788, 2792, 2796, 2800, 2804, 2737, 2741, 2745, 2749, 2753, 2757, 2761, 2765, 2769, 2773, 2777, 2781, 2785, 2789, 2793, 2797, 2801, 2805, 2738, 2742, 2746, 2750, 2754, 2758, 2762, 2766, 2770, 2774, 2778, 2782, 2786, 2790, 2794, 2798, 2802, 2806, 2739, 2743, 
        2747, 2751, 2755, 2759, 2763, 2767, 2771, 2775, 2779, 2783, 2787, 2791, 2795, 2799, 2803, 2807, 2844, 2848, 2852, 2856, 2860, 2864, 2868, 2872, 2876, 2880, 2884, 2888, 2892, 2896, 2900, 2904, 2908, 2912, 2845, 2849, 2853, 2857, 2861, 2865, 2869, 2873, 2877, 2881, 2885, 2889, 2893, 2897, 2901, 2905, 2909, 2913, 2846, 2850, 2854, 2858, 2862, 2866, 2870, 2874, 2878, 2882, 2886, 2890, 
        2894, 2898, 2902, 2906, 2910, 2914, 2847, 2851, 2855, 2859, 2863, 2867, 2871, 2875, 2879, 2883, 2887, 2891, 2895, 2899, 2903, 2907, 2911, 2915, 2952, 2956, 2960, 2964, 2968, 2972, 2976, 2980, 2984, 2988, 2992, 2996, 3000, 3004, 3008, 3012, 3016, 3020, 2953, 2957, 2961, 2965, 2969, 2973, 2977, 2981, 2985, 2989, 2993, 2997, 3001, 3005, 3009, 3013, 3017, 3021, 2954, 2958, 2962, 2966, 
        2970, 2974, 2978, 2982, 2986, 2990, 2994, 2998, 3002, 3006, 3010, 3014, 3018, 3022, 2955, 2959, 2963, 2967, 2971, 2975, 2979, 2983, 2987, 2991, 2995, 2999, 3003, 3007, 3011, 3015, 3019, 3023, 3060, 3064, 3068, 3072, 3076, 3080, 3084, 3088, 3092, 3096, 3100, 3104, 3108, 3112, 3116, 3120, 3124, 3128, 3061, 3065, 3069, 3073, 3077, 3081, 3085, 3089, 3093, 3097, 3101, 3105, 3109, 3113, 
        3117, 3121, 3125, 3129, 3062, 3066, 3070, 3074, 3078, 3082, 3086, 3090, 3094, 3098, 3102, 3106, 3110, 3114, 3118, 3122, 3126, 3130, 3063, 3067, 3071, 3075, 3079, 3083, 3087, 3091, 3095, 3099, 3103, 3107, 3111, 3115, 3119, 3123, 3127, 3131, 3168, 3172, 3176, 3180, 3184, 3188, 3192, 3196, 3200, 3204, 3208, 3212, 3216, 3220, 3224, 3228, 3232, 3236, 3169, 3173, 3177, 3181, 3185, 3189, 
        3193, 3197, 3201, 3205, 3209, 3213, 3217, 3221, 3225, 3229, 3233, 3237, 3170, 3174, 3178, 3182, 3186, 3190, 3194, 3198, 3202, 3206, 3210, 3214, 3218, 3222, 3226, 3230, 3234, 3238, 3171, 3175, 3179, 3183, 3187, 3191, 3195, 3199, 3203, 3207, 3211, 3215, 3219, 3223, 3227, 3231, 3235, 3239, 3276, 3280, 3284, 3288, 3292, 3296, 3300, 3304, 3308, 3312, 3316, 3320, 3324, 3328, 3332, 3336, 
        3340, 3344, 3277, 3281, 3285, 3289, 3293, 3297, 3301, 3305, 3309, 3313, 3317, 3321, 3325, 3329, 3333, 3337, 3341, 3345, 3278, 3282, 3286, 3290, 3294, 3298, 3302, 3306, 3310, 3314, 3318, 3322, 3326, 3330, 3334, 3338, 3342, 3346, 3279, 3283, 3287, 3291, 3295, 3299, 3303, 3307, 3311, 3315, 3319, 3323, 3327, 3331, 3335, 3339, 3343, 3347, 3384, 3388, 3392, 3396, 3400, 3404, 3408, 3412, 
        3416, 3420, 3424, 3428, 3432, 3436, 3440, 3444, 3448, 3452, 3385, 3389, 3393, 3397, 3401, 3405, 3409, 3413, 3417, 3421, 3425, 3429, 3433, 3437, 3441, 3445, 3449, 3453, 3386, 3390, 3394, 3398, 3402, 3406, 3410, 3414, 3418, 3422, 3426, 3430, 3434, 3438, 3442, 3446, 3450, 3454, 3387, 3391, 3395, 3399, 3403, 3407, 3411, 3415, 3419, 3423, 3427, 3431, 3435, 3439, 3443, 3447, 3451, 3455, 
        3924, 3928, 3932, 3936, 3940, 3944, 3948, 3952, 3956, 3960, 3964, 3968, 3972, 3976, 3980, 3984, 3988, 3992, 3925, 3929, 3933, 3937, 3941, 3945, 3949, 3953, 3957, 3961, 3965, 3969, 3973, 3977, 3981, 3985, 3989, 3993, 3926, 3930, 3934, 3938, 3942, 3946, 3950, 3954, 3958, 3962, 3966, 3970, 3974, 3978, 3982, 3986, 3990, 3994, 3927, 3931, 3935, 3939, 3943, 3947, 3951, 3955, 3959, 3963, 
        3967, 3971, 3975, 3979, 3983, 3987, 3991, 3995, 4032, 4036, 4040, 4044, 4048, 4052, 4056, 4060, 4064, 4068, 4072, 4076, 4080, 4084, 4088, 4092, 4096, 4100, 4033, 4037, 4041, 4045, 4049, 4053, 4057, 4061, 4065, 4069, 4073, 4077, 4081, 4085, 4089, 4093, 4097, 4101, 4034, 4038, 4042, 4046, 4050, 4054, 4058, 4062, 4066, 4070, 4074, 4078, 4082, 4086, 4090, 4094, 4098, 4102, 4035, 4039, 
        4043, 4047, 4051, 4055, 4059, 4063, 4067, 4071, 4075, 4079, 4083, 4087, 4091, 4095, 4099, 4103, 4140, 4144, 4148, 4152, 4156, 4160, 4164, 4168, 4172, 4176, 4180, 4184, 4188, 4192, 4196, 4200, 4204, 4208, 4141, 4145, 4149, 4153, 4157, 4161, 4165, 4169, 4173, 4177, 4181, 4185, 4189, 4193, 4197, 4201, 4205, 4209, 4142, 4146, 4150, 4154, 4158, 4162, 4166, 4170, 4174, 4178, 4182, 4186, 
        4190, 4194, 4198, 4202, 4206, 4210, 4143, 4147, 4151, 4155, 4159, 4163, 4167, 4171, 4175, 4179, 4183, 4187, 4191, 4195, 4199, 4203, 4207, 4211, 4248, 4252, 4256, 4260, 4264, 4268, 4272, 4276, 4280, 4284, 4288, 4292, 4296, 4300, 4304, 4308, 4312, 4316, 4249, 4253, 4257, 4261, 4265, 4269, 4273, 4277, 4281, 4285, 4289, 4293, 4297, 4301, 4305, 4309, 4313, 4317, 4250, 4254, 4258, 4262, 
        4266, 4270, 4274, 4278, 4282, 4286, 4290, 4294, 4298, 4302, 4306, 4310, 4314, 4318, 4251, 4255, 4259, 4263, 4267, 4271, 4275, 4279, 4283, 4287, 4291, 4295, 4299, 4303, 4307, 4311, 4315, 4319, 4356, 4360, 4364, 4368, 4372, 4376, 4380, 4384, 4388, 4392, 4396, 4400, 4404, 4408, 4412, 4416, 4420, 4424, 4357, 4361, 4365, 4369, 4373, 4377, 4381, 4385, 4389, 4393, 4397, 4401, 4405, 4409, 
        4413, 4417, 4421, 4425, 4358, 4362, 4366, 4370, 4374, 4378, 4382, 4386, 4390, 4394, 4398, 4402, 4406, 4410, 4414, 4418, 4422, 4426, 4359, 4363, 4367, 4371, 4375, 4379, 4383, 4387, 4391, 4395, 4399, 4403, 4407, 4411, 4415, 4419, 4423, 4427, 4464, 4468, 4472, 4476, 4480, 4484, 4488, 4492, 4496, 4500, 4504, 4508, 4512, 4516, 4520, 4524, 4528, 4532, 4465, 4469, 4473, 4477, 4481, 4485, 
        4489, 4493, 4497, 4501, 4505, 4509, 4513, 4517, 4521, 4525, 4529, 4533, 4466, 4470, 4474, 4478, 4482, 4486, 4490, 4494, 4498, 4502, 4506, 4510, 4514, 4518, 4522, 4526, 4530, 4534, 4467, 4471, 4475, 4479, 4483, 4487, 4491, 4495, 4499, 4503, 4507, 4511, 4515, 4519, 4523, 4527, 4531, 4535, 4572, 4576, 4580, 4584, 4588, 4592, 4596, 4600, 4604, 4608, 4612, 4616, 4620, 4624, 4628, 4632, 
        4636, 4640, 4573, 4577, 4581, 4585, 4589, 4593, 4597, 4601, 4605, 4609, 4613, 4617, 4621, 4625, 4629, 4633, 4637, 4641, 4574, 4578, 4582, 4586, 4590, 4594, 4598, 4602, 4606, 4610, 4614, 4618, 4622, 4626, 4630, 4634, 4638, 4642, 4575, 4579, 4583, 4587, 4591, 4595, 4599, 4603, 4607, 4611, 4615, 4619, 4623, 4627, 4631, 4635, 4639, 4643, 4680, 4684, 4688, 4692, 4696, 4700, 4704, 4708, 
        4712, 4716, 4720, 4724, 4728, 4732, 4736, 4740, 4744, 4748, 4681, 4685, 4689, 4693, 4697, 4701, 4705, 4709, 4713, 4717, 4721, 4725, 4729, 4733, 4737, 4741, 4745, 4749, 4682, 4686, 4690, 4694, 4698, 4702, 4706, 4710, 4714, 4718, 4722, 4726, 4730, 4734, 4738, 4742, 4746, 4750, 4683, 4687, 4691, 4695, 4699, 4703, 4707, 4711, 4715, 4719, 4723, 4727, 4731, 4735, 4739, 4743, 4747, 4751, 
        4788, 4792, 4796, 4800, 4804, 4808, 4812, 4816, 4820, 4824, 4828, 4832, 4836, 4840, 4844, 4848, 4852, 4856, 4789, 4793, 4797, 4801, 4805, 4809, 4813, 4817, 4821, 4825, 4829, 4833, 4837, 4841, 4845, 4849, 4853, 4857, 4790, 4794, 4798, 4802, 4806, 4810, 4814, 4818, 4822, 4826, 4830, 4834, 4838, 4842, 4846, 4850, 4854, 4858, 4791, 4795, 4799, 4803, 4807, 4811, 4815, 4819, 4823, 4827, 
        4831, 4835, 4839, 4843, 4847, 4851, 4855, 4859, 4896, 4900, 4904, 4908, 4912, 4916, 4920, 4924, 4928, 4932, 4936, 4940, 4944, 4948, 4952, 4956, 4960, 4964, 4897, 4901, 4905, 4909, 4913, 4917, 4921, 4925, 4929, 4933, 4937, 4941, 4945, 4949, 4953, 4957, 4961, 4965, 4898, 4902, 4906, 4910, 4914, 4918, 4922, 4926, 4930, 4934, 4938, 4942, 4946, 4950, 4954, 4958, 4962, 4966, 4899, 4903, 
        4907, 4911, 4915, 4919, 4923, 4927, 4931, 4935, 4939, 4943, 4947, 4951, 4955, 4959, 4963, 4967, 5004, 5008, 5012, 5016, 5020, 5024, 5028, 5032, 5036, 5040, 5044, 5048, 5052, 5056, 5060, 5064, 5068, 5072, 5005, 5009, 5013, 5017, 5021, 5025, 5029, 5033, 5037, 5041, 5045, 5049, 5053, 5057, 5061, 5065, 5069, 5073, 5006, 5010, 5014, 5018, 5022, 5026, 5030, 5034, 5038, 5042, 5046, 5050, 
        5054, 5058, 5062, 5066, 5070, 5074, 5007, 5011, 5015, 5019, 5023, 5027, 5031, 5035, 5039, 5043, 5047, 5051, 5055, 5059, 5063, 5067, 5071, 5075, 5112, 5116, 5120, 5124, 5128, 5132, 5136, 5140, 5144, 5148, 5152, 5156, 5160, 5164, 5168, 5172, 5176, 5180, 5113, 5117, 5121, 5125, 5129, 5133, 5137, 5141, 5145, 5149, 5153, 5157, 5161, 5165, 5169, 5173, 5177, 5181, 5114, 5118, 5122, 5126, 
        5130, 5134, 5138, 5142, 5146, 5150, 5154, 5158, 5162, 5166, 5170, 5174, 5178, 5182, 5115, 5119, 5123, 5127, 5131, 5135, 5139, 5143, 5147, 5151, 5155, 5159, 5163, 5167, 5171, 5175, 5179, 5183, 5220, 5224, 5228, 5232, 5236, 5240, 5244, 5248, 5252, 5256, 5260, 5264, 5268, 5272, 5276, 5280, 5284, 5288, 5221, 5225, 5229, 5233, 5237, 5241, 5245, 5249, 5253, 5257, 5261, 5265, 5269, 5273, 
        5277, 5281, 5285, 5289, 5222, 5226, 5230, 5234, 5238, 5242, 5246, 5250, 5254, 5258, 5262, 5266, 5270, 5274, 5278, 5282, 5286, 5290, 5223, 5227, 5231, 5235, 5239, 5243, 5247, 5251, 5255, 5259, 5263, 5267, 5271, 5275, 5279, 5283, 5287, 5291, 5328, 5332, 5336, 5340, 5344, 5348, 5352, 5356, 5360, 5364, 5368, 5372, 5376, 5380, 5384, 5388, 5392, 5396, 5329, 5333, 5337, 5341, 5345, 5349, 
        5353, 5357, 5361, 5365, 5369, 5373, 5377, 5381, 5385, 5389, 5393, 5397, 5330, 5334, 5338, 5342, 5346, 5350, 5354, 5358, 5362, 5366, 5370, 5374, 5378, 5382, 5386, 5390, 5394, 5398, 5331, 5335, 5339, 5343, 5347, 5351, 5355, 5359, 5363, 5367, 5371, 5375, 5379, 5383, 5387, 5391, 5395, 5399, 5436, 5440, 5444, 5448, 5452, 5456, 5460, 5464, 5468, 5472, 5476, 5480, 5484, 5488, 5492, 5496, 
        5500, 5504, 5437, 5441, 5445, 5449, 5453, 5457, 5461, 5465, 5469, 5473, 5477, 5481, 5485, 5489, 5493, 5497, 5501, 5505, 5438, 5442, 5446, 5450, 5454, 5458, 5462, 5466, 5470, 5474, 5478, 5482, 5486, 5490, 5494, 5498, 5502, 5506, 5439, 5443, 5447, 5451, 5455, 5459, 5463, 5467, 5471, 5475, 5479, 5483, 5487, 5491, 5495, 5499, 5503, 5507, 5544, 5548, 5552, 5556, 5560, 5564, 5568, 5572, 
        5576, 5580, 5584, 5588, 5592, 5596, 5600, 5604, 5608, 5612, 5545, 5549, 5553, 5557, 5561, 5565, 5569, 5573, 5577, 5581, 5585, 5589, 5593, 5597, 5601, 5605, 5609, 5613, 5546, 5550, 5554, 5558, 5562, 5566, 5570, 5574, 5578, 5582, 5586, 5590, 5594, 5598, 5602, 5606, 5610, 5614, 5547, 5551, 5555, 5559, 5563, 5567, 5571, 5575, 5579, 5583, 5587, 5591, 5595, 5599, 5603, 5607, 5611, 5615, 
        5652, 5656, 5660, 5664, 5668, 5672, 5676, 5680, 5684, 5688, 5692, 5696, 5700, 5704, 5708, 5712, 5716, 5720, 5653, 5657, 5661, 5665, 5669, 5673, 5677, 5681, 5685, 5689, 5693, 5697, 5701, 5705, 5709, 5713, 5717, 5721, 5654, 5658, 5662, 5666, 5670, 5674, 5678, 5682, 5686, 5690, 5694, 5698, 5702, 5706, 5710, 5714, 5718, 5722, 5655, 5659, 5663, 5667, 5671, 5675, 5679, 5683, 5687, 5691, 
        5695, 5699, 5703, 5707, 5711, 5715, 5719, 5723, 5760, 5764, 5768, 5772, 5776, 5780, 5784, 5788, 5792, 5796, 5800, 5804, 5808, 5812, 5816, 5820, 5824, 5828, 5761, 5765, 5769, 5773, 5777, 5781, 5785, 5789, 5793, 5797, 5801, 5805, 5809, 5813, 5817, 5821, 5825, 5829, 5762, 5766, 5770, 5774, 5778, 5782, 5786, 5790, 5794, 5798, 5802, 5806, 5810, 5814, 5818, 5822, 5826, 5830, 5763, 5767, 
        5771, 5775, 5779, 5783, 5787, 5791, 5795, 5799, 5803, 5807, 5811, 5815, 5819, 5823, 5827, 5831, 5868, 5872, 5876, 5880, 5884, 5888, 5892, 5896, 5900, 5904, 5908, 5912, 5916, 5920, 5924, 5928, 5932, 5936, 5869, 5873, 5877, 5881, 5885, 5889, 5893, 5897, 5901, 5905, 5909, 5913, 5917, 5921, 5925, 5929, 5933, 5937, 5870, 5874, 5878, 5882, 5886, 5890, 5894, 5898, 5902, 5906, 5910, 5914, 
        5918, 5922, 5926, 5930, 5934, 5938, 5871, 5875, 5879, 5883, 5887, 5891, 5895, 5899, 5903, 5907, 5911, 5915, 5919, 5923, 5927, 5931, 5935, 5939, 5976, 5980, 5984, 5988, 5992, 5996, 6000, 6004, 6008, 6012, 6016, 6020, 6024, 6028, 6032, 6036, 6040, 6044, 5977, 5981, 5985, 5989, 5993, 5997, 6001, 6005, 6009, 6013, 6017, 6021, 6025, 6029, 6033, 6037, 6041, 6045, 5978, 5982, 5986, 5990, 
        5994, 5998, 6002, 6006, 6010, 6014, 6018, 6022, 6026, 6030, 6034, 6038, 6042, 6046, 5979, 5983, 5987, 5991, 5995, 5999, 6003, 6007, 6011, 6015, 6019, 6023, 6027, 6031, 6035, 6039, 6043, 6047, 6084, 6088, 6092, 6096, 6100, 6104, 6108, 6112, 6116, 6120, 6124, 6128, 6132, 6136, 6140, 6144, 6148, 6152, 6085, 6089, 6093, 6097, 6101, 6105, 6109, 6113, 6117, 6121, 6125, 6129, 6133, 6137, 
        6141, 6145, 6149, 6153, 6086, 6090, 6094, 6098, 6102, 6106, 6110, 6114, 6118, 6122, 6126, 6130, 6134, 6138, 6142, 6146, 6150, 6154, 6087, 6091, 6095, 6099, 6103, 6107, 6111, 6115, 6119, 6123, 6127, 6131, 6135, 6139, 6143, 6147, 6151, 6155, 6192, 6196, 6200, 6204, 6208, 6212, 6216, 6220, 6224, 6228, 6232, 6236, 6240, 6244, 6248, 6252, 6256, 6260, 6193, 6197, 6201, 6205, 6209, 6213, 
        6217, 6221, 6225, 6229, 6233, 6237, 6241, 6245, 6249, 6253, 6257, 6261, 6194, 6198, 6202, 6206, 6210, 6214, 6218, 6222, 6226, 6230, 6234, 6238, 6242, 6246, 6250, 6254, 6258, 6262, 6195, 6199, 6203, 6207, 6211, 6215, 6219, 6223, 6227, 6231, 6235, 6239, 6243, 6247, 6251, 6255, 6259, 6263, 6300, 6304, 6308, 6312, 6316, 6320, 6324, 6328, 6332, 6336, 6340, 6344, 6348, 6352, 6356, 6360, 
        6364, 6368, 6301, 6305, 6309, 6313, 6317, 6321, 6325, 6329, 6333, 6337, 6341, 6345, 6349, 6353, 6357, 6361, 6365, 6369, 6302, 6306, 6310, 6314, 6318, 6322, 6326, 6330, 6334, 6338, 6342, 6346, 6350, 6354, 6358, 6362, 6366, 6370, 6303, 6307, 6311, 6315, 6319, 6323, 6327, 6331, 6335, 6339, 6343, 6347, 6351, 6355, 6359, 6363, 6367, 6371, 6408, 6412, 6416, 6420, 6424, 6428, 6432, 6436, 
        6440, 6444, 6448, 6452, 6456, 6460, 6464, 6468, 6472, 6476, 6409, 6413, 6417, 6421, 6425, 6429, 6433, 6437, 6441, 6445, 6449, 6453, 6457, 6461, 6465, 6469, 6473, 6477, 6410, 6414, 6418, 6422, 6426, 6430, 6434, 6438, 6442, 6446, 6450, 6454, 6458, 6462, 6466, 6470, 6474, 6478, 6411, 6415, 6419, 6423, 6427, 6431, 6435, 6439, 6443, 6447, 6451, 6455, 6459, 6463, 6467, 6471, 6475, 6479, 
        6516, 6520, 6524, 6528, 6532, 6536, 6540, 6544, 6548, 6552, 6556, 6560, 6564, 6568, 6572, 6576, 6580, 6584, 6517, 6521, 6525, 6529, 6533, 6537, 6541, 6545, 6549, 6553, 6557, 6561, 6565, 6569, 6573, 6577, 6581, 6585, 6518, 6522, 6526, 6530, 6534, 6538, 6542, 6546, 6550, 6554, 6558, 6562, 6566, 6570, 6574, 6578, 6582, 6586, 6519, 6523, 6527, 6531, 6535, 6539, 6543, 6547, 6551, 6555, 
        6559, 6563, 6567, 6571, 6575, 6579, 6583, 6587, 6624, 6628, 6632, 6636, 6640, 6644, 6648, 6652, 6656, 6660, 6664, 6668, 6672, 6676, 6680, 6684, 6688, 6692, 6625, 6629, 6633, 6637, 6641, 6645, 6649, 6653, 6657, 6661, 6665, 6669, 6673, 6677, 6681, 6685, 6689, 6693, 6626, 6630, 6634, 6638, 6642, 6646, 6650, 6654, 6658, 6662, 6666, 6670, 6674, 6678, 6682, 6686, 6690, 6694, 6627, 6631, 
        6635, 6639, 6643, 6647, 6651, 6655, 6659, 6663, 6667, 6671, 6675, 6679, 6683, 6687, 6691, 6695, 6732, 6736, 6740, 6744, 6748, 6752, 6756, 6760, 6764, 6768, 6772, 6776, 6780, 6784, 6788, 6792, 6796, 6800, 6733, 6737, 6741, 6745, 6749, 6753, 6757, 6761, 6765, 6769, 6773, 6777, 6781, 6785, 6789, 6793, 6797, 6801, 6734, 6738, 6742, 6746, 6750, 6754, 6758, 6762, 6766, 6770, 6774, 6778, 
        6782, 6786, 6790, 6794, 6798, 6802, 6735, 6739, 6743, 6747, 6751, 6755, 6759, 6763, 6767, 6771, 6775, 6779, 6783, 6787, 6791, 6795, 6799, 6803, 6840, 6844, 6848, 6852, 6856, 6860, 6864, 6868, 6872, 6876, 6880, 6884, 6888, 6892, 6896, 6900, 6904, 6908, 6841, 6845, 6849, 6853, 6857, 6861, 6865, 6869, 6873, 6877, 6881, 6885, 6889, 6893, 6897, 6901, 6905, 6909, 6842, 6846, 6850, 6854, 
        6858, 6862, 6866, 6870, 6874, 6878, 6882, 6886, 6890, 6894, 6898, 6902, 6906, 6910, 6843, 6847, 6851, 6855, 6859, 6863, 6867, 6871, 6875, 6879, 6883, 6887, 6891, 6895, 6899, 6903, 6907, 6911, 6948, 6952, 6956, 6960, 6964, 6968, 6972, 6976, 6980, 6984, 6988, 6992, 6996, 7000, 7004, 7008, 7012, 7016, 6949, 6953, 6957, 6961, 6965, 6969, 6973, 6977, 6981, 6985, 6989, 6993, 6997, 7001, 
        7005, 7009, 7013, 7017, 6950, 6954, 6958, 6962, 6966, 6970, 6974, 6978, 6982, 6986, 6990, 6994, 6998, 7002, 7006, 7010, 7014, 7018, 6951, 6955, 6959, 6963, 6967, 6971, 6975, 6979, 6983, 6987, 6991, 6995, 6999, 7003, 7007, 7011, 7015, 7019, 7056, 7060, 7064, 7068, 7072, 7076, 7080, 7084, 7088, 7092, 7096, 7100, 7104, 7108, 7112, 7116, 7120, 7124, 7057, 7061, 7065, 7069, 7073, 7077, 
        7081, 7085, 7089, 7093, 7097, 7101, 7105, 7109, 7113, 7117, 7121, 7125, 7058, 7062, 7066, 7070, 7074, 7078, 7082, 7086, 7090, 7094, 7098, 7102, 7106, 7110, 7114, 7118, 7122, 7126, 7059, 7063, 7067, 7071, 7075, 7079, 7083, 7087, 7091, 7095, 7099, 7103, 7107, 7111, 7115, 7119, 7123, 7127, 7164, 7168, 7172, 7176, 7180, 7184, 7188, 7192, 7196, 7200, 7204, 7208, 7212, 7216, 7220, 7224, 
        7228, 7232, 7165, 7169, 7173, 7177, 7181, 7185, 7189, 7193, 7197, 7201, 7205, 7209, 7213, 7217, 7221, 7225, 7229, 7233, 7166, 7170, 7174, 7178, 7182, 7186, 7190, 7194, 7198, 7202, 7206, 7210, 7214, 7218, 7222, 7226, 7230, 7234, 7167, 7171, 7175, 7179, 7183, 7187, 7191, 7195, 7199, 7203, 7207, 7211, 7215, 7219, 7223, 7227, 7231, 7235, 7272, 7276, 7280, 7284, 7288, 7292, 7296, 7300, 
        7304, 7308, 7312, 7316, 7320, 7324, 7328, 7332, 7336, 7340, 7273, 7277, 7281, 7285, 7289, 7293, 7297, 7301, 7305, 7309, 7313, 7317, 7321, 7325, 7329, 7333, 7337, 7341, 7274, 7278, 7282, 7286, 7290, 7294, 7298, 7302, 7306, 7310, 7314, 7318, 7322, 7326, 7330, 7334, 7338, 7342, 7275, 7279, 7283, 7287, 7291, 7295, 7299, 7303, 7307, 7311, 7315, 7319, 7323, 7327, 7331, 7335, 7339, 7343,
    ], # end INIT_VAL
}, formatters={
	'INIT_VAL': lambda key,val: str(len(val)) + "'h" + "".join([format(bit, '02x') for bit in bits_to_bytes(val[::-1])]),
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 7, 'I'),
	'IMUX[0-9][0-9]': lambda key,val: mux_format(val, 9, 'I'),
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_format(val, 8, 'I'),
}, key_transformers={
    'INIT_VAL\[[^\]]*]': lambda x: 'INIT_VAL',
}, encoders={
    'INIT_VAL': lambda key,val: val[::-1],
	'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 7, 3),
	'IMUX[0-9][0-9]': lambda key,val: mux_encode(val, 9, 3),
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
    # XXX: Haven't verified...
    'BramClkMUX0[0-9]': lambda key, val: mux_encode(val, 3, 1),
    'SeamMUX[0-9][0-9]': lambda key, val: mux_encode(val, 7, 1),
    'TileAsyncMUX0[0-9]': lambda key, val: mux_encode(val, 4, 0),
    'TileClkEnMUX0[0-9]': lambda key, val: mux_encode(val, 3, 0), 
    'TileWeRenMUX0[0-9]': lambda key, val: mux_encode(val, 4, 0),
}, annotations={
	'BramClkMUX00': 'Clk0',
	'BramClkMUX01': 'Clk1',
	'IMUX00': 'AddressA[0]',
	'IMUX01': 'AddressA[1]',
	'IMUX02': 'AddressA[2]',
	'IMUX03': 'AddressA[3]',
	'IMUX04': 'AddressA[4]',
	'IMUX05': 'AddressA[5]',
	'IMUX06': 'AddressA[6]',
	'IMUX07': 'AddressA[7]',
	'IMUX08': 'AddressA[8]',
	'IMUX09': 'AddressA[9]',
	'IMUX10': 'AddressA[10]',
	'IMUX11': 'AddressA[11]',
	'IMUX12': 'DataInA[0]',
	'IMUX13': 'DataInA[1]',
	'IMUX14': 'DataInA[2]',
	'IMUX15': 'DataInA[3]',
	'IMUX16': 'DataInA[4]',
	'IMUX17': 'DataInA[5]',
	'IMUX18': 'DataInA[6]',
	'IMUX19': 'DataInA[7]',
	'IMUX20': 'DataInA[8]',
	'IMUX21': 'DataInA[9]',
	'IMUX22': 'DataInA[10]',
	'IMUX23': 'DataInA[11]',
	'IMUX24': 'DataInA[12]',
	'IMUX25': 'DataInA[13]',
	'IMUX26': 'DataInA[14]',
	'IMUX27': 'DataInA[15]',
	'IMUX28': 'DataInA[16]',
	'IMUX29': 'DataInA[17]',
	'IMUX29': 'DataInA[17]',
	'IMUX34': 'DataInB[17]',
	'IMUX35': 'DataInB[16]',
	'IMUX36': 'DataInB[15]',
	'IMUX37': 'DataInB[14]',
	'IMUX38': 'DataInB[13]',
	'IMUX39': 'DataInB[12]',
	'IMUX40': 'DataInB[11]',
	'IMUX41': 'DataInB[10]',
	'IMUX42': 'DataInB[9]',
	'IMUX43': 'DataInB[8]',
	'IMUX44': 'DataInB[7]',
	'IMUX45': 'DataInB[6]',
	'IMUX46': 'DataInB[5]',
	'IMUX47': 'DataInB[4]',
	'IMUX48': 'DataInB[3]',
	'IMUX49': 'DataInB[2]',
	'IMUX50': 'DataInB[1]',
	'IMUX51': 'DataInB[0]',
	'IMUX52': 'AddressB[11]',
	'IMUX53': 'AddressB[10]',
	'IMUX54': 'AddressB[9]',
	'IMUX55': 'AddressB[8]',
	'IMUX56': 'AddressB[7]',
	'IMUX57': 'AddressB[6]',
	'IMUX58': 'AddressB[5]',
	'IMUX59': 'AddressB[4]',
	'IMUX60': 'AddressB[3]',
	'IMUX61': 'AddressB[2]',
	'IMUX62': 'AddressB[1]',
	'IMUX63': 'AddressB[0]',
	'TileAsyncMUX00':'AsyncReset0',
	'TileAsyncMUX01':'AsyncReset1',
	'TileClkEnMUX00':'ClkEn0',
	'TileClkEnMUX01':'ClkEn1',
	'TileWeRenMUX00':'WeRenA',
	'TileWeRenMUX01':'WeRenB',
}))

# This is a pseudo tile.  The bits are handled in a ConfigChain.  Here for wire/routing purposes.
InstallTile(Tile('ALTA_PLLX', 'PLLTILE', columns=0, rows=0, slices=0, values={}))

InstallTile(Tile('ALTA_TILE_SRAM_DIST', 'LogicTILE', columns=34, rows=68, slices=16, values={
	# 16 slices per tile

    # Presumably selects between alta_asyncctrl00:Dout/TileAsyncMUX00 
    # and alta_asyncctrl01:Dout/TileAsyncMUX01
	'AsyncMUX00':[32],
	'AsyncMUX01':[168],
	'AsyncMUX02':[304],
	'AsyncMUX03':[440],
	'AsyncMUX04':[576],
	'AsyncMUX05':[712],
	'AsyncMUX06':[848],
	'AsyncMUX07':[984],
	'AsyncMUX08':[1256],
	'AsyncMUX09':[1392],
	'AsyncMUX10':[1528],
	'AsyncMUX11':[1664],
	'AsyncMUX12':[1800],
	'AsyncMUX13':[1936],
	'AsyncMUX14':[2072],
	'AsyncMUX15':[2208],

    # Presumably selects between alta_clkenctrl00:ClkOut/TileClkMUX00 
    # and alta_clkenctrl01:ClkOut/TileClkMUX01
	'ClkMUX00':[66],
	'ClkMUX01':[202],
	'ClkMUX02':[338],
	'ClkMUX03':[474],
	'ClkMUX04':[610],
	'ClkMUX05':[746],
	'ClkMUX06':[882],
	'ClkMUX07':[1018],
	'ClkMUX08':[1290],
	'ClkMUX09':[1426],
	'ClkMUX10':[1562],
	'ClkMUX11':[1698],
	'ClkMUX12':[1834],
	'ClkMUX13':[1970],
	'ClkMUX14':[2106],
	'ClkMUX15':[2242],

    # Feeds TileClkMUX, TileClkEnMUX, TileAsyncMUX, TileSyncMUX
	'CtrlMUX00': [ 1103, 1137, 1104, 1138, 1105, 1139, 1106, 1140, 1107, 1141, 1108, 1142 ],
	'CtrlMUX01': [ 1114, 1148, 1113, 1147, 1112, 1146, 1111, 1145, 1110, 1144, 1109, 1143 ],
	'CtrlMUX02': [ 1205, 1171, 1206, 1172, 1207, 1173, 1208, 1174, 1209, 1175, 1210, 1176 ],
	'CtrlMUX03': [ 1216, 1182, 1215, 1181, 1214, 1180, 1213, 1179, 1212, 1178, 1211, 1177 ],

	# DSTRSTB contains 2 entries of 1 bit each (SLICE_SRAMCTRL)
	'DSTRSTB': [ 1136, 1170 ],

	'RMUX00':[4,38,3,37,2,36,1,0,34,35],
	'RMUX01':[276,310,275,309,274,308,273,272,306,307],
	'RMUX02':[5,39,6,40,7,41,8,9,43,42],
	'RMUX03':[277,311,278,312,279,313,280,281,315,314],
	'RMUX04':[14,48,13,47,12,46,11,10,44,45],
	'RMUX05':[286,320,285,319,284,318,283,282,316,317],
	'RMUX06':[72,106,71,105,70,104,69,68,102,103],
	'RMUX07':[344,378,343,377,342,376,341,340,374,375],
	'RMUX08':[73,107,74,108,75,109,76,77,111,110],
	'RMUX09':[345,379,346,380,347,381,348,349,383,382],
	'RMUX10':[82,116,81,115,80,114,79,78,112,113],
	'RMUX11':[354,388,353,387,352,386,351,350,384,385],
	'RMUX12':[413,447,414,448,415,449,416,417,451,450],
	'RMUX13':[141,175,142,176,143,177,144,145,179,178],
	'RMUX14':[422,456,421,455,420,454,419,418,452,453],
	'RMUX15':[150,184,149,183,148,182,147,146,180,181],
	'RMUX16':[412,446,411,445,410,444,409,408,442,443],
	'RMUX17':[140,174,139,173,138,172,137,136,170,171],
	'RMUX18':[481,515,482,516,483,517,484,485,519,518],
	'RMUX19':[209,243,210,244,211,245,212,213,247,246],
	'RMUX20':[490,524,489,523,488,522,487,486,520,521],
	'RMUX21':[218,252,217,251,216,250,215,214,248,249],
	'RMUX22':[480,514,479,513,478,512,477,476,510,511],
	'RMUX23':[208,242,207,241,206,240,205,204,238,239],
	'RMUX24':[548,582,547,581,546,580,545,544,578,579],
	'RMUX25':[820,854,819,853,818,852,817,816,850,851],
	'RMUX26':[549,583,550,584,551,585,552,553,587,586],
	'RMUX27':[821,855,822,856,823,857,824,825,859,858],
	'RMUX28':[558,592,557,591,556,590,555,554,588,589],
	'RMUX29':[830,864,829,863,828,862,827,826,860,861],
	'RMUX30':[616,650,615,649,614,648,613,612,646,647],
	'RMUX31':[888,922,887,921,886,920,885,884,918,919],
	'RMUX32':[617,651,618,652,619,653,620,621,655,654],
	'RMUX33':[889,923,890,924,891,925,892,893,927,926],
	'RMUX34':[626,660,625,659,624,658,623,622,656,657],
	'RMUX35':[898,932,897,931,896,930,895,894,928,929],
	'RMUX36':[957,991,958,992,959,993,960,961,995,994],
	'RMUX37':[685,719,686,720,687,721,688,689,723,722],
	'RMUX38':[966,1000,965,999,964,998,963,962,996,997],
	'RMUX39':[694,728,693,727,692,726,691,690,724,725],
	'RMUX40':[956,990,955,989,954,988,953,952,986,987],
	'RMUX41':[684,718,683,717,682,716,681,680,714,715],
	'RMUX42':[1025,1059,1026,1060,1027,1061,1028,1029,1063,1062],
	'RMUX43':[753,787,754,788,755,789,756,757,791,790],
	'RMUX44':[1034,1068,1033,1067,1032,1066,1031,1030,1064,1065],
	'RMUX45':[762,796,761,795,760,794,759,758,792,793],
	'RMUX46':[1024,1058,1023,1057,1022,1056,1021,1020,1054,1055],
	'RMUX47':[752,786,751,785,750,784,749,748,782,783],
	'RMUX48':[1228,1262,1227,1261,1226,1260,1225,1224,1258,1259],
	'RMUX49':[1500,1534,1499,1533,1498,1532,1497,1496,1530,1531],
	'RMUX50':[1229,1263,1230,1264,1231,1265,1232,1233,1267,1266],
	'RMUX51':[1501,1535,1502,1536,1503,1537,1504,1505,1539,1538],
	'RMUX52':[1238,1272,1237,1271,1236,1270,1235,1234,1268,1269],
	'RMUX53':[1510,1544,1509,1543,1508,1542,1507,1506,1540,1541],
	'RMUX54':[1296,1330,1295,1329,1294,1328,1293,1292,1326,1327],
	'RMUX55':[1568,1602,1567,1601,1566,1600,1565,1564,1598,1599],
	'RMUX56':[1297,1331,1298,1332,1299,1333,1300,1301,1335,1334],
	'RMUX57':[1569,1603,1570,1604,1571,1605,1572,1573,1607,1606],
	'RMUX58':[1306,1340,1305,1339,1304,1338,1303,1302,1336,1337],
	'RMUX59':[1578,1612,1577,1611,1576,1610,1575,1574,1608,1609],
	'RMUX60':[1637,1671,1638,1672,1639,1673,1640,1641,1675,1674],
	'RMUX61':[1365,1399,1366,1400,1367,1401,1368,1369,1403,1402],
	'RMUX62':[1646,1680,1645,1679,1644,1678,1643,1642,1676,1677],
	'RMUX63':[1374,1408,1373,1407,1372,1406,1371,1370,1404,1405],
	'RMUX64':[1636,1670,1635,1669,1634,1668,1633,1632,1666,1667],
	'RMUX65':[1364,1398,1363,1397,1362,1396,1361,1360,1394,1395],
	'RMUX66':[1705,1739,1706,1740,1707,1741,1708,1709,1743,1742],
	'RMUX67':[1433,1467,1434,1468,1435,1469,1436,1437,1471,1470],
	'RMUX68':[1714,1748,1713,1747,1712,1746,1711,1710,1744,1745],
	'RMUX69':[1442,1476,1441,1475,1440,1474,1439,1438,1472,1473],
	'RMUX70':[1704,1738,1703,1737,1702,1736,1701,1700,1734,1735],
	'RMUX71':[1432,1466,1431,1465,1430,1464,1429,1428,1462,1463],
	'RMUX72':[1772,1806,1771,1805,1770,1804,1769,1768,1802,1803],
	'RMUX73':[2044,2078,2043,2077,2042,2076,2041,2040,2074,2075],
	'RMUX74':[1773,1807,1774,1808,1775,1809,1776,1777,1811,1810],
	'RMUX75':[2045,2079,2046,2080,2047,2081,2048,2049,2083,2082],
	'RMUX76':[1782,1816,1781,1815,1780,1814,1779,1778,1812,1813],
	'RMUX77':[2054,2088,2053,2087,2052,2086,2051,2050,2084,2085],
	'RMUX78':[1840,1874,1839,1873,1838,1872,1837,1836,1870,1871],
	'RMUX79':[2112,2146,2111,2145,2110,2144,2109,2108,2142,2143],
	'RMUX80':[1841,1875,1842,1876,1843,1877,1844,1845,1879,1878],
	'RMUX81':[2113,2147,2114,2148,2115,2149,2116,2117,2151,2150],
	'RMUX82':[1850,1884,1849,1883,1848,1882,1847,1846,1880,1881],
	'RMUX83':[2122,2156,2121,2155,2120,2154,2119,2118,2152,2153],
	'RMUX84':[2181,2215,2182,2216,2183,2217,2184,2185,2219,2218],
	'RMUX85':[1909,1943,1910,1944,1911,1945,1912,1913,1947,1946],
	'RMUX86':[2190,2224,2189,2223,2188,2222,2187,2186,2220,2221],
	'RMUX87':[1918,1952,1917,1951,1916,1950,1915,1914,1948,1949],
	'RMUX88':[2180,2214,2179,2213,2178,2212,2177,2176,2210,2211],
	'RMUX89':[1908,1942,1907,1941,1906,1940,1905,1904,1938,1939],
	'RMUX90':[2249,2283,2250,2284,2251,2285,2252,2253,2287,2286],
	'RMUX91':[1977,2011,1978,2012,1979,2013,1980,1981,2015,2014],
	'RMUX92':[2258,2292,2257,2291,2256,2290,2255,2254,2288,2289],
	'RMUX93':[1986,2020,1985,2019,1984,2018,1983,1982,2016,2017],
	'RMUX94':[2248,2282,2247,2281,2246,2280,2245,2244,2278,2279],
	'RMUX95':[1976,2010,1975,2009,1974,2008,1973,1972,2006,2007],

	'SeamMUX00':[1088,1089,1090,1091,1092,1093,1094,1095],
	'SeamMUX01':[1190,1191,1192,1193,1194,1195,1196,1197],
	'SeamMUX02':[1096,1097,1135,1098,1099,1100,1101,1102],
	'SeamMUX03':[1198,1199,1169,1200,1201,1202,1203,1204],

	'TileAsyncMUX00':[1152,1151,1150,1149],
	'TileAsyncMUX01':[1186,1185,1184,1183],

	'TileClkEnMUX00':[1223,1222,1221],
	'TileClkEnMUX01':[1121,1120,1119],

    # 0100 = CtrlMUX00, 0010 = CtrlMUX01
	'TileClkMUX00':[1118,1117,1116,1115],
    # 0100 = CtrlMUX02, 0010 = CtrlMUX03
	'TileClkMUX01':[1220,1219,1218,1217],

	'TileSyncMUX00':[1189,1188,1187],
	'TileSyncMUX01':[1155,1154,1153],


	# LUTs appear reversed and inverted from their counterparts in the _routed.v file.
	# e.g. defparam syn__49_.mask = 16'h78F0 (0111 1000 1111 0000)
	# this tool prints out
	# alta_slice08_LUT: 1111 0000 1110 0001 (F0E1)
	# Those bits reversed:
	# 1000 0111 0000 1111
	# and inverted:
	# 0111 1000 1111 0000
	'alta_slice00_BYPASSEN':[134],
	'alta_slice00_CARRY_CRL':[99],
	'alta_slice00_LUTCMUX':[133,31],
	'alta_slice00_LUT':[30,27,29,28,63,62,64,61,98,95,97,96,131,130,132,129],
	'alta_slice00_SHIFTMUX':[100],
	'alta_slice00_IMUX00':[15,49,16,50,17,51,18,52,19,20,54,53],	   	# A
	'alta_slice00_IMUX01':[26,60,25,59,24,58,23,57,22,21,55,56],			# B
	'alta_slice00_IMUX02':[83,117,84,118,85,119,86,120,87,88,122,121],	# C
	'alta_slice00_IMUX03':[94,128,93,127,92,126,91,125,90,89,123,124],	# D
	'alta_slice00_OMUX00':[33],
	'alta_slice00_OMUX01':[101],
	'alta_slice00_OMUX02':[135],

	'alta_slice01_BYPASSEN':[270],
	'alta_slice01_CARRY_CRL':[235],
	'alta_slice01_LUTCMUX':[269,167],
	'alta_slice01_LUT':[166,163,165,164,199,198,200,197,234,231,233,232,267,266,268,265],
	'alta_slice01_SHIFTMUX':[236],
	'alta_slice01_IMUX04':[151,185,152,186,153,187,154,188,155,156,190,189],	# A
	'alta_slice01_IMUX05':[162,196,161,195,160,194,159,193,158,157,191,192],	# B
	'alta_slice01_IMUX06':[219,253,220,254,221,255,222,256,223,224,258,257],	# C
	'alta_slice01_IMUX07':[230,264,229,263,228,262,227,261,226,225,259,260],	# D
	'alta_slice01_OMUX03':[169],
	'alta_slice01_OMUX04':[237],
	'alta_slice01_OMUX05':[271],

	'alta_slice02_BYPASSEN':[406],
	'alta_slice02_CARRY_CRL':[371],
	'alta_slice02_LUTCMUX':[405,303],
	'alta_slice02_LUT':[302,299,301,300,335,334,336,333,370,367,369,368,403,402,404,401],
	'alta_slice02_SHIFTMUX':[372],
	'alta_slice02_IMUX08':[287,321,288,322,289,323,290,324,291,292,326,325],	# A
	'alta_slice02_IMUX09':[298,332,297,331,296,330,295,329,294,293,327,328],	# B
	'alta_slice02_IMUX10':[355,389,356,390,357,391,358,392,359,360,394,393],	# C
	'alta_slice02_IMUX11':[366,400,365,399,364,398,363,397,362,361,395,396],	# D
	'alta_slice02_OMUX06':[305],
	'alta_slice02_OMUX07':[373],
	'alta_slice02_OMUX08':[407],

	'alta_slice03_BYPASSEN':[542],
	'alta_slice03_CARRY_CRL':[507],
	'alta_slice03_LUTCMUX':[541,439],
	'alta_slice03_LUT':[438,435,437,436,471,470,472,469,506,503,505,504,539,538,540,537],
	'alta_slice03_SHIFTMUX':[508],
	'alta_slice03_IMUX12':[423,457,424,458,425,459,426,460,427,428,462,461],	# A
	'alta_slice03_IMUX13':[434,468,433,467,432,466,431,465,430,429,463,464],	# B
	'alta_slice03_IMUX14':[491,525,492,526,493,527,494,528,495,496,530,529],	# C
	'alta_slice03_IMUX15':[502,536,501,535,500,534,499,533,498,497,531,532],	# D
	'alta_slice03_OMUX09':[441],
	'alta_slice03_OMUX10':[509],
	'alta_slice03_OMUX11':[543],

	'alta_slice04_BYPASSEN':[678],
	'alta_slice04_CARRY_CRL':[643],
	'alta_slice04_LUTCMUX':[677,575],
	'alta_slice04_LUT':[574,571,573,572,607,606,608,605,642,639,641,640,675,674,676,673],
	'alta_slice04_SHIFTMUX':[644],
	'alta_slice04_IMUX16':[559,593,560,594,561,595,562,596,563,564,598,597],	# A
	'alta_slice04_IMUX17':[570,604,569,603,568,602,567,601,566,565,599,600],	# B
	'alta_slice04_IMUX18':[627,661,628,662,629,663,630,664,631,632,666,665],	# C
	'alta_slice04_IMUX19':[638,672,637,671,636,670,635,669,634,633,667,668],	# D
	'alta_slice04_OMUX12':[577],
	'alta_slice04_OMUX13':[645],
	'alta_slice04_OMUX14':[679],

	'alta_slice05_BYPASSEN':[814],
	'alta_slice05_CARRY_CRL':[779],
	'alta_slice05_LUTCMUX':[813,711],
	'alta_slice05_LUT':[710,707,709,708,743,742,744,741,778,775,777,776,811,810,812,809],
	'alta_slice05_SHIFTMUX':[780],
	'alta_slice05_IMUX20':[695,729,696,730,697,731,698,732,699,700,734,733],	# A
	'alta_slice05_IMUX21':[706,740,705,739,704,738,703,737,702,701,735,736],	# B
	'alta_slice05_IMUX22':[763,797,764,798,765,799,766,800,767,768,802,801],	# C
	'alta_slice05_IMUX23':[774,808,773,807,772,806,771,805,770,769,803,804],	# D
	'alta_slice05_OMUX15':[713],
	'alta_slice05_OMUX16':[781],
	'alta_slice05_OMUX17':[815],

	'alta_slice06_BYPASSEN':[950],
	'alta_slice06_CARRY_CRL':[915],
	'alta_slice06_LUTCMUX':[949,847],
	'alta_slice06_LUT':[846,843,845,844,879,878,880,877,914,911,913,912,947,946,948,945],
	'alta_slice06_SHIFTMUX':[916],
	'alta_slice06_IMUX24':[831,865,832,866,833,867,834,868,835,836,870,869],	# A
	'alta_slice06_IMUX25':[842,876,841,875,840,874,839,873,838,837,871,872],	# B
	'alta_slice06_IMUX26':[899,933,900,934,901,935,902,936,903,904,938,937],	# C
	'alta_slice06_IMUX27':[910,944,909,943,908,942,907,941,906,905,939,940],	# D
	'alta_slice06_OMUX18':[849],
	'alta_slice06_OMUX19':[917],
	'alta_slice06_OMUX20':[951],

	'alta_slice07_BYPASSEN':[1086],
	'alta_slice07_CARRY_CRL':[1051],
	'alta_slice07_LUTCMUX':[1085,983],
	'alta_slice07_LUT':[982,979,981,980,1015,1014,1016,1013,1050,1047,1049,1048,1083,1082,1084,1081],
	'alta_slice07_SHIFTMUX':[1052],
	'alta_slice07_IMUX28':[967,1001,968,1002,969,1003,970,1004,971,972,1006,1005],	# A
	'alta_slice07_IMUX29':[978,1012,977,1011,976,1010,975,1009,974,973,1007,1008],	# B
	'alta_slice07_IMUX30':[1035,1069,1036,1070,1037,1071,1038,1072,1039,1040,1074,1073],	# C
	'alta_slice07_IMUX31':[1046,1080,1045,1079,1044,1078,1043,1077,1042,1041,1075,1076],	# D
	'alta_slice07_OMUX21':[985],
	'alta_slice07_OMUX22':[1053],
	'alta_slice07_OMUX23':[1087],

	'alta_slice08_BYPASSEN':[1358],
	'alta_slice08_CARRY_CRL':[1323],
	'alta_slice08_LUTCMUX':[1357,1255],
	'alta_slice08_LUT':[1254,1251,1253,1252,1287,1286,1288,1285,1322,1319,1321,1320,1355,1354,1356,1353],
	'alta_slice08_SHIFTMUX':[1324],
	'alta_slice08_IMUX32':[1239,1273,1240,1274,1241,1275,1242,1276,1243,1244,1278,1277],	# A
	'alta_slice08_IMUX33':[1250,1284,1249,1283,1248,1282,1247,1281,1246,1245,1279,1280],	# B
	'alta_slice08_IMUX34':[1307,1341,1308,1342,1309,1343,1310,1344,1311,1312,1346,1345],	# C
	'alta_slice08_IMUX35':[1318,1352,1317,1351,1316,1350,1315,1349,1314,1313,1347,1348],	# D
	'alta_slice08_OMUX24':[1257],
	'alta_slice08_OMUX25':[1325],
	'alta_slice08_OMUX26':[1359],

	'alta_slice09_BYPASSEN':[1494],
	'alta_slice09_CARRY_CRL':[1459],
	'alta_slice09_LUTCMUX':[1493,1391],
	'alta_slice09_LUT':[1390,1387,1389,1388,1423,1422,1424,1421,1458,1455,1457,1456,1491,1490,1492,1489],
	'alta_slice09_SHIFTMUX':[1460],
	'alta_slice09_IMUX36':[1375,1409,1376,1410,1377,1411,1378,1412,1379,1380,1414,1413],	# A
	'alta_slice09_IMUX37':[1386,1420,1385,1419,1384,1418,1383,1417,1382,1381,1415,1416],	# B
	'alta_slice09_IMUX38':[1443,1477,1444,1478,1445,1479,1446,1480,1447,1448,1482,1481],	# C
	'alta_slice09_IMUX39':[1454,1488,1453,1487,1452,1486,1451,1485,1450,1449,1483,1484],	# D
	'alta_slice09_OMUX27':[1393],
	'alta_slice09_OMUX28':[1461],
	'alta_slice09_OMUX29':[1495],

	'alta_slice10_BYPASSEN':[1630],
	'alta_slice10_CARRY_CRL':[1595],
	'alta_slice10_LUTCMUX':[1629,1527],
	'alta_slice10_LUT':[1526,1523,1525,1524,1559,1558,1560,1557,1594,1591,1593,1592,1627,1626,1628,1625],
	'alta_slice10_SHIFTMUX':[1596],
	'alta_slice10_IMUX40':[1511,1545,1512,1546,1513,1547,1514,1548,1515,1516,1550,1549],	# A
	'alta_slice10_IMUX41':[1522,1556,1521,1555,1520,1554,1519,1553,1518,1517,1551,1552],	# B
	'alta_slice10_IMUX42':[1579,1613,1580,1614,1581,1615,1582,1616,1583,1584,1618,1617],	# C
	'alta_slice10_IMUX43':[1590,1624,1589,1623,1588,1622,1587,1621,1586,1585,1619,1620],	# D
	'alta_slice10_OMUX30':[1529],
	'alta_slice10_OMUX31':[1597],
	'alta_slice10_OMUX32':[1631],

	'alta_slice11_BYPASSEN':[1766],
	'alta_slice11_CARRY_CRL':[1731],
	'alta_slice11_LUTCMUX':[1765,1663],
	'alta_slice11_LUT':[1662,1659,1661,1660,1695,1694,1696,1693,1730,1727,1729,1728,1763,1762,1764,1761],
	'alta_slice11_SHIFTMUX':[1732],
	'alta_slice11_IMUX44':[1647,1681,1648,1682,1649,1683,1650,1684,1651,1652,1686,1685],	# A
	'alta_slice11_IMUX45':[1658,1692,1657,1691,1656,1690,1655,1689,1654,1653,1687,1688],	# B
	'alta_slice11_IMUX46':[1715,1749,1716,1750,1717,1751,1718,1752,1719,1720,1754,1753],	# C
	'alta_slice11_IMUX47':[1726,1760,1725,1759,1724,1758,1723,1757,1722,1721,1755,1756],	# D
	'alta_slice11_OMUX33':[1665],
	'alta_slice11_OMUX34':[1733],
	'alta_slice11_OMUX35':[1767],

	'alta_slice12_BYPASSEN':[1902],
	'alta_slice12_CARRY_CRL':[1867],
	'alta_slice12_LUTCMUX':[1901,1799],
	'alta_slice12_LUT':[1798,1795,1797,1796,1831,1830,1832,1829,1866,1863,1865,1864,1899,1898,1900,1897],
	'alta_slice12_SHIFTMUX':[1868],
	'alta_slice12_IMUX48':[1783,1817,1784,1818,1785,1819,1786,1820,1787,1788,1822,1821],	# A
	'alta_slice12_IMUX49':[1794,1828,1793,1827,1792,1826,1791,1825,1790,1789,1823,1824],	# B
	'alta_slice12_IMUX50':[1851,1885,1852,1886,1853,1887,1854,1888,1855,1856,1890,1889],	# C
	'alta_slice12_IMUX51':[1862,1896,1861,1895,1860,1894,1859,1893,1858,1857,1891,1892],	# D
	'alta_slice12_OMUX36':[1801],
	'alta_slice12_OMUX37':[1869],
	'alta_slice12_OMUX38':[1903],

	'alta_slice13_BYPASSEN':[2038],
	'alta_slice13_CARRY_CRL':[2003],
	'alta_slice13_LUTCMUX':[2037,1935],
	'alta_slice13_LUT':[1934,1931,1933,1932,1967,1966,1968,1965,2002,1999,2001,2000,2035,2034,2036,2033],
	'alta_slice13_SHIFTMUX':[2004],
	'alta_slice13_IMUX52':[1919,1953,1920,1954,1921,1955,1922,1956,1923,1924,1958,1957],	# A
	'alta_slice13_IMUX53':[1930,1964,1929,1963,1928,1962,1927,1961,1926,1925,1959,1960],	# B
	'alta_slice13_IMUX54':[1987,2021,1988,2022,1989,2023,1990,2024,1991,1992,2026,2025],	# C
	'alta_slice13_IMUX55':[1998,2032,1997,2031,1996,2030,1995,2029,1994,1993,2027,2028],	# D
	'alta_slice13_OMUX39':[1937],
	'alta_slice13_OMUX40':[2005],
	'alta_slice13_OMUX41':[2039],

	'alta_slice14_BYPASSEN':[2174],
	'alta_slice14_CARRY_CRL':[2139],
	'alta_slice14_LUTCMUX':[2173,2071],
	'alta_slice14_LUT':[2070,2067,2069,2068,2103,2102,2104,2101,2138,2135,2137,2136,2171,2170,2172,2169],
	'alta_slice14_SHIFTMUX':[2140],
	'alta_slice14_IMUX56':[2055,2089,2056,2090,2057,2091,2058,2092,2059,2060,2094,2093],	# A
	'alta_slice14_IMUX57':[2066,2100,2065,2099,2064,2098,2063,2097,2062,2061,2095,2096],	# B
	'alta_slice14_IMUX58':[2123,2157,2124,2158,2125,2159,2126,2160,2127,2128,2162,2161],	# C
	'alta_slice14_IMUX59':[2134,2168,2133,2167,2132,2166,2131,2165,2130,2129,2163,2164],	# D
	'alta_slice14_OMUX42':[2073],
	'alta_slice14_OMUX43':[2141],
	'alta_slice14_OMUX44':[2175],

	'alta_slice15_BYPASSEN':[2310],
	'alta_slice15_CARRY_CRL':[2275],
	'alta_slice15_LUTCMUX':[2309,2207],
	'alta_slice15_LUT':[2206,2203,2205,2204,2239,2238,2240,2237,2274,2271,2273,2272,2307,2306,2308,2305],
	'alta_slice15_SHIFTMUX':[2276],
	'alta_slice15_IMUX60':[2191,2225,2192,2226,2193,2227,2194,2228,2195,2196,2230,2229],	# A
	'alta_slice15_IMUX61':[2202,2236,2201,2235,2200,2234,2199,2233,2198,2197,2231,2232],	# B
	'alta_slice15_IMUX62':[2259,2293,2260,2294,2261,2295,2262,2296,2263,2264,2298,2297],	# C
	'alta_slice15_IMUX63':[2270,2304,2269,2303,2268,2302,2267,2301,2266,2265,2299,2300],	# D
	'alta_slice15_OMUX45':[2209],
	'alta_slice15_OMUX46':[2277],
	'alta_slice15_OMUX47':[2311],
}, formatters={
	'^alta_slice[0-9][0-9]_LUT$': lambda key,val: '16\'h'+format(bytes_to_num(bits_to_bytes(lut_decode(key,val))), '04x'),
	'alta_slice[0-9][0-9]_IMUX[0-9][0-9]': lambda key,val: mux_format(val, 9, 'I'),
	'alta_slice[0-9][0-9]_OMUX[0-9][0-9]': lambda key,val: slice_omux_format(val), 
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 7, 'I'),
	'CtrlMUX[0-9][0-9]': lambda key,val: mux_format(val, 8, 'I'),
	'TileAsyncMUX0[01]': lambda key,val: bits_to_string(val, 4, True),
	'TileClkEnMUX0[01]': lambda key,val: bits_to_string(val, 3, True),
	'TileClkMUX0[01]': lambda key,val: bits_to_string(val, 4, True),
	'TileSyncMUX0[01]': lambda key,val: bits_to_string(val, 3, True),
}, key_transformers={
    'IMUX[0-9][0-9]': lambda x: "alta_slice%02i_%s" % (int(int(x[4:]) / 4), x),
    'OMUX[0-9][0-9]': lambda x: "alta_slice%02i_%s" % (int(int(x[4:]) / 3), x),
    'alta_slice[0-9][0-9].FF_USED': lambda x: "alta_slice%02i_CARRY_CRL" % (int(x[10:12])),
    'alta_slice[0-9][0-9].INIT': lambda x: re.sub('(alta_slice[0-9][0-9]).INIT', lambda x: x.groups()[0] + "_LUT", x),
}, encoders={
    'alta_slice[0-9][0-9]_IMUX[0-9][0-9]': lambda key,val: mux_encode(val, 9, 3),
    'alta_slice[0-9][0-9]_LUT$': lambda key,val: lut_encode(key,val),
    'alta_slice[0-9][0-9]_LUTCMUX': lambda key,val: [val[0], 0],
    'RMUX[0-9][0-9]': lambda key,val: mux_encode(val, 7, 3),
    'CtrlMUX[0-9][0-9]': lambda key,val: mux_encode(val, 8, 4),
	'TileClkMUX[0-9][0-9]': lambda key,val: mux_encode(val, 4, 0),
	'SeamMUX[0-9][0-9]': lambda key,val: mux_encode(val, 7, 1),
}, annotations={
    'alta_slice[0-9][0-9]_LUTCMUX': 'FeedbackMux?',
	'alta_slice00_IMUX00':'A',
	'alta_slice00_IMUX01':'B',
	'alta_slice00_IMUX02':'C',
	'alta_slice00_IMUX03':'D',
	'alta_slice01_IMUX04':'A',
	'alta_slice01_IMUX05':'B',
	'alta_slice01_IMUX06':'C',
	'alta_slice01_IMUX07':'D',
	'alta_slice02_IMUX08':'A',
	'alta_slice02_IMUX09':'B',
	'alta_slice02_IMUX10':'C',
	'alta_slice02_IMUX11':'D',
	'alta_slice03_IMUX12':'A',
	'alta_slice03_IMUX13':'B',
	'alta_slice03_IMUX14':'C',
	'alta_slice03_IMUX15':'D',
	'alta_slice04_IMUX16':'A',
	'alta_slice04_IMUX17':'B',
	'alta_slice04_IMUX18':'C',
	'alta_slice04_IMUX19':'D',
	'alta_slice05_IMUX20':'A',
	'alta_slice05_IMUX21':'B',
	'alta_slice05_IMUX22':'C',
	'alta_slice05_IMUX23':'D',
	'alta_slice06_IMUX24':'A',
	'alta_slice06_IMUX25':'B',
	'alta_slice06_IMUX26':'C',
	'alta_slice06_IMUX27':'D',
	'alta_slice07_IMUX28':'A',
	'alta_slice07_IMUX29':'B',
	'alta_slice07_IMUX30':'C',
	'alta_slice07_IMUX31':'D',
	'alta_slice08_IMUX32':'A',
	'alta_slice08_IMUX33':'B',
	'alta_slice08_IMUX34':'C',
	'alta_slice08_IMUX35':'D',
	'alta_slice09_IMUX36':'A',
	'alta_slice09_IMUX37':'B',
	'alta_slice09_IMUX38':'C',
	'alta_slice09_IMUX39':'D',
	'alta_slice10_IMUX40':'A',
	'alta_slice10_IMUX41':'B',
	'alta_slice10_IMUX42':'C',
	'alta_slice10_IMUX43':'D',
	'alta_slice11_IMUX44':'A',
	'alta_slice11_IMUX45':'B',
	'alta_slice11_IMUX46':'C',
	'alta_slice11_IMUX47':'D',
	'alta_slice12_IMUX48':'A',
	'alta_slice12_IMUX49':'B',
	'alta_slice12_IMUX50':'C',
	'alta_slice12_IMUX51':'D',
	'alta_slice13_IMUX52':'A',
	'alta_slice13_IMUX53':'B',
	'alta_slice13_IMUX54':'C',
	'alta_slice13_IMUX55':'D',
	'alta_slice14_IMUX56':'A',
	'alta_slice14_IMUX57':'B',
	'alta_slice14_IMUX58':'C',
	'alta_slice14_IMUX59':'D',
	'alta_slice15_IMUX60':'A',
	'alta_slice15_IMUX61':'B',
	'alta_slice15_IMUX62':'C',
	'alta_slice15_IMUX63':'D',
}))

InstallTile(Tile('IOTILE_ROUTE', 'RogicTILE', columns=16, rows=68, slices=0, values={
	'OMUX00': [ 15 ],
	'OMUX01': [ 79 ],
	'OMUX02': [ 143 ],
	'OMUX03': [ 207 ],
	'OMUX04': [ 271 ],
	'OMUX05': [ 335 ],
	'OMUX06': [ 399 ],
	'OMUX07': [ 463 ],
	'OMUX08': [ 591 ],
	'OMUX09': [ 655 ],
	'OMUX10': [ 719 ],
	'OMUX11': [ 783 ],
	'OMUX12': [ 847 ],
	'OMUX13': [ 911 ],
	'OMUX14': [ 975 ],
	'OMUX15': [ 1039 ],

	'RMUX00':[4,20,3,19,2,18,1,0,16,17],
	'RMUX01':[132,148,131,147,130,146,129,128,144,145],
	'RMUX02':[5,21,6,22,7,23,8,9,25,24],
	'RMUX03':[133,149,134,150,135,151,136,137,153,152],
	'RMUX04':[14,30,13,29,12,28,11,10,26,27],
	'RMUX05':[142,158,141,157,140,156,139,138,154,155],
	'RMUX06':[36,52,35,51,34,50,33,32,48,49],
	'RMUX07':[164,180,163,179,162,178,161,160,176,177],
	'RMUX08':[37,53,38,54,39,55,40,41,57,56],
	'RMUX09':[165,181,166,182,167,183,168,169,185,184],
	'RMUX10':[46,62,45,61,44,60,43,42,58,59],
	'RMUX11':[174,190,173,189,172,188,171,170,186,187],
	'RMUX12':[197,213,198,214,199,215,200,201,217,216],
	'RMUX13':[69,85,70,86,71,87,72,73,89,88],
	'RMUX14':[206,222,205,221,204,220,203,202,218,219],
	'RMUX15':[78,94,77,93,76,92,75,74,90,91],
	'RMUX16':[196,212,195,211,194,210,193,192,208,209],
	'RMUX17':[68,84,67,83,66,82,65,64,80,81],
	'RMUX18':[229,245,230,246,231,247,232,233,249,248],
	'RMUX19':[101,117,102,118,103,119,104,105,121,120],
	'RMUX20':[238,254,237,253,236,252,235,234,250,251],
	'RMUX21':[110,126,109,125,108,124,107,106,122,123],
	'RMUX22':[228,244,227,243,226,242,225,224,240,241],
	'RMUX23':[100,116,99,115,98,114,97,96,112,113],
	'RMUX24':[260,276,259,275,258,274,257,256,272,273],
	'RMUX25':[388,404,387,403,386,402,385,384,400,401],
	'RMUX26':[261,277,262,278,263,279,264,265,281,280],
	'RMUX27':[389,405,390,406,391,407,392,393,409,408],
	'RMUX28':[270,286,269,285,268,284,267,266,282,283],
	'RMUX29':[398,414,397,413,396,412,395,394,410,411],
	'RMUX30':[292,308,291,307,290,306,289,288,304,305],
	'RMUX31':[420,436,419,435,418,434,417,416,432,433],
	'RMUX32':[293,309,294,310,295,311,296,297,313,312],
	'RMUX33':[421,437,422,438,423,439,424,425,441,440],
	'RMUX34':[302,318,301,317,300,316,299,298,314,315],
	'RMUX35':[430,446,429,445,428,444,427,426,442,443],
	'RMUX36':[453,469,454,470,455,471,456,457,473,472],
	'RMUX37':[325,341,326,342,327,343,328,329,345,344],
	'RMUX38':[462,478,461,477,460,476,459,458,474,475],
	'RMUX39':[334,350,333,349,332,348,331,330,346,347],
	'RMUX40':[452,468,451,467,450,466,449,448,464,465],
	'RMUX41':[324,340,323,339,322,338,321,320,336,337],
	'RMUX42':[485,501,486,502,487,503,488,489,505,504],
	'RMUX43':[357,373,358,374,359,375,360,361,377,376],
	'RMUX44':[494,510,493,509,492,508,491,490,506,507],
	'RMUX45':[366,382,365,381,364,380,363,362,378,379],
	'RMUX46':[484,500,483,499,482,498,481,480,496,497],
	'RMUX47':[356,372,355,371,354,370,353,352,368,369],
	'RMUX48':[580,596,579,595,578,594,577,576,592,593],
	'RMUX49':[708,724,707,723,706,722,705,704,720,721],
	'RMUX50':[581,597,582,598,583,599,584,585,601,600],
	'RMUX51':[709,725,710,726,711,727,712,713,729,728],
	'RMUX52':[590,606,589,605,588,604,587,586,602,603],
	'RMUX53':[718,734,717,733,716,732,715,714,730,731],
	'RMUX54':[612,628,611,627,610,626,609,608,624,625],
	'RMUX55':[740,756,739,755,738,754,737,736,752,753],
	'RMUX56':[613,629,614,630,615,631,616,617,633,632],
	'RMUX57':[741,757,742,758,743,759,744,745,761,760],
	'RMUX58':[622,638,621,637,620,636,619,618,634,635],
	'RMUX59':[750,766,749,765,748,764,747,746,762,763],
	'RMUX60':[773,789,774,790,775,791,776,777,793,792],
	'RMUX61':[645,661,646,662,647,663,648,649,665,664],
	'RMUX62':[782,798,781,797,780,796,779,778,794,795],
	'RMUX63':[654,670,653,669,652,668,651,650,666,667],
	'RMUX64':[772,788,771,787,770,786,769,768,784,785],
	'RMUX65':[644,660,643,659,642,658,641,640,656,657],
	'RMUX66':[805,821,806,822,807,823,808,809,825,824],
	'RMUX67':[677,693,678,694,679,695,680,681,697,696],
	'RMUX68':[814,830,813,829,812,828,811,810,826,827],
	'RMUX69':[686,702,685,701,684,700,683,682,698,699],
	'RMUX70':[804,820,803,819,802,818,801,800,816,817],
	'RMUX71':[676,692,675,691,674,690,673,672,688,689],
	'RMUX72':[836,852,835,851,834,850,833,832,848,849],
	'RMUX73':[964,980,963,979,962,978,961,960,976,977],
	'RMUX74':[837,853,838,854,839,855,840,841,857,856],
	'RMUX75':[965,981,966,982,967,983,968,969,985,984],
	'RMUX76':[846,862,845,861,844,860,843,842,858,859],
	'RMUX77':[974,990,973,989,972,988,971,970,986,987],
	'RMUX78':[868,884,867,883,866,882,865,864,880,881],
	'RMUX79':[996,1012,995,1011,994,1010,993,992,1008,1009],
	'RMUX80':[869,885,870,886,871,887,872,873,889,888],
	'RMUX81':[997,1013,998,1014,999,1015,1000,1001,1017,1016],
	'RMUX82':[878,894,877,893,876,892,875,874,890,891],
	'RMUX83':[1006,1022,1005,1021,1004,1020,1003,1002,1018,1019],
	'RMUX84':[1029,1045,1030,1046,1031,1047,1032,1033,1049,1048],
	'RMUX85':[901,917,902,918,903,919,904,905,921,920],
	'RMUX86':[1038,1054,1037,1053,1036,1052,1035,1034,1050,1051],
	'RMUX87':[910,926,909,925,908,924,907,906,922,923],
	'RMUX88':[1028,1044,1027,1043,1026,1042,1025,1024,1040,1041],
	'RMUX89':[900,916,899,915,898,914,897,896,912,913],
	'RMUX90':[1061,1077,1062,1078,1063,1079,1064,1065,1081,1080],
	'RMUX91':[933,949,934,950,935,951,936,937,953,952],
	'RMUX92':[1070,1086,1069,1085,1068,1084,1067,1066,1082,1083],
	'RMUX93':[942,958,941,957,940,956,939,938,954,955],
	'RMUX94':[1060,1076,1059,1075,1058,1074,1057,1056,1072,1073],
	'RMUX95':[932,948,931,947,930,946,929,928,944,945],

	'SeamMUX00':[512,513,514,515,516,517,518,519],
	'SeamMUX01':[560,561,562,563,564,565,566,567],
	'SeamMUX02':[520,521,541,522,523,524,525,526],
	'SeamMUX03':[568,569,557,570,571,572,573,574],
}, formatters={
	'RMUX[0-9][0-9]': lambda key,val: mux_format(val, 7, 'I'),
}))


#
# For AG10K & AG16K
#
InstallTile(Tile('alta_multiplier', 'MultTILE', columns=26, rows=68, slices=0, values={
    "CtrlMUX00":[847,873,848,874,849,875,876,851,877,850],
    "CtrlMUX01":[856,882,855,881,854,880,879,852,878,853],
    "CtrlMUX02":[925,899,926,900,927,901,902,929,903,928],
    "CtrlMUX03":[934,908,933,907,932,906,905,930,904,931],

    "KMUX00":[15,41,16,42,17,43,18,19,45,44,25],
    "KMUX01":[24,50,23,49,22,48,21,20,46,47,51],
    "KMUX02":[67,93,68,94,69,95,70,71,97,96,77],
    "KMUX03":[76,102,75,101,74,100,73,72,98,99,103],
    "KMUX04":[119,145,120,146,121,147,122,123,149,148,129],
    "KMUX05":[128,154,127,153,126,152,125,124,150,151,155],
    "KMUX06":[171,197,172,198,173,199,174,175,201,200,181],
    "KMUX07":[180,206,179,205,178,204,177,176,202,203,207],
    "KMUX08":[223,249,224,250,225,251,226,227,253,252,233],
    "KMUX09":[232,258,231,257,230,256,229,228,254,255,259],
    "KMUX10":[275,301,276,302,277,303,278,279,305,304,285],
    "KMUX11":[284,310,283,309,282,308,281,280,306,307,311],
    "KMUX12":[327,353,328,354,329,355,330,331,357,356,337],
    "KMUX13":[336,362,335,361,334,360,333,332,358,359,363],
    "KMUX14":[379,405,380,406,381,407,382,383,409,408,389],
    "KMUX15":[388,414,387,413,386,412,385,384,410,411,415],
    "KMUX16":[431,457,432,458,433,459,434,435,461,460,441],
    "KMUX17":[440,466,439,465,438,464,437,436,462,463,467],
    "KMUX18":[483,509,484,510,485,511,486,487,513,512,493],
    "KMUX19":[492,518,491,517,490,516,489,488,514,515,519],
    "KMUX20":[1315,1341,1316,1342,1317,1343,1318,1319,1345,1344,1325],
    "KMUX21":[1324,1350,1323,1349,1322,1348,1321,1320,1346,1347,1351],
    "KMUX22":[1367,1393,1368,1394,1369,1395,1370,1371,1397,1396,1377],
    "KMUX23":[1376,1402,1375,1401,1374,1400,1373,1372,1398,1399,1403],
    "KMUX24":[1419,1445,1420,1446,1421,1447,1422,1423,1449,1448,1429],
    "KMUX25":[1428,1454,1427,1453,1426,1452,1425,1424,1450,1451,1455],
    "KMUX26":[1471,1497,1472,1498,1473,1499,1474,1475,1501,1500,1481],
    "KMUX27":[1480,1506,1479,1505,1478,1504,1477,1476,1502,1503,1507],
    "KMUX28":[1523,1549,1524,1550,1525,1551,1526,1527,1553,1552,1533],
    "KMUX29":[1532,1558,1531,1557,1530,1556,1529,1528,1554,1555,1559],
    "KMUX30":[1575,1601,1576,1602,1577,1603,1578,1579,1605,1604,1585],
    "KMUX31":[1584,1610,1583,1609,1582,1608,1581,1580,1606,1607,1611],
    "KMUX32":[1627,1653,1628,1654,1629,1655,1630,1631,1657,1656,1637],
    "KMUX33":[1636,1662,1635,1661,1634,1660,1633,1632,1658,1659,1663],
    "KMUX34":[1679,1705,1680,1706,1681,1707,1682,1683,1709,1708,1689],
    "KMUX35":[1688,1714,1687,1713,1686,1712,1685,1684,1710,1711,1715],
    "KMUX36":[1731,1757,1732,1758,1733,1759,1734,1735,1761,1760,1741],
    "KMUX37":[1740,1766,1739,1765,1738,1764,1737,1736,1762,1763,1767],

    # LMUX00 ... LMUX03 ?

    "RMUX00":[4,30,3,29,2,28,1,0,26,27],
    "RMUX01":[212,238,211,237,210,236,209,208,234,235],
    "RMUX02":[5,31,6,32,7,33,8,9,35,34],
    "RMUX03":[213,239,214,240,215,241,216,217,243,242],
    "RMUX04":[14,40,13,39,12,38,11,10,36,37],
    "RMUX05":[222,248,221,247,220,246,219,218,244,245],
    "RMUX06":[56,82,55,81,54,80,53,52,78,79],
    "RMUX07":[264,290,263,289,262,288,261,260,286,287],
    "RMUX08":[57,83,58,84,59,85,60,61,87,86],
    "RMUX09":[265,291,266,292,267,293,268,269,295,294],
    "RMUX10":[66,92,65,91,64,90,63,62,88,89],
    "RMUX11":[274,300,273,299,272,298,271,270,296,297],
    "RMUX12":[317,343,318,344,319,345,320,321,347,346],
    "RMUX13":[109,135,110,136,111,137,112,113,139,138],
    "RMUX14":[326,352,325,351,324,350,323,322,348,349],
    "RMUX15":[118,144,117,143,116,142,115,114,140,141],
    "RMUX16":[316,342,315,341,314,340,313,312,338,339],
    "RMUX17":[108,134,107,133,106,132,105,104,130,131],
    "RMUX18":[369,395,370,396,371,397,372,373,399,398],
    "RMUX19":[161,187,162,188,163,189,164,165,191,190],
    "RMUX20":[378,404,377,403,376,402,375,374,400,401],
    "RMUX21":[170,196,169,195,168,194,167,166,192,193],
    "RMUX22":[368,394,367,393,366,392,365,364,390,391],
    "RMUX23":[160,186,159,185,158,184,157,156,182,183],
    "RMUX24":[420,446,419,445,418,444,417,416,442,443],
    "RMUX25":[628,654,627,653,626,652,625,624,650,651],
    "RMUX26":[421,447,422,448,423,449,424,425,451,450],
    "RMUX27":[629,655,630,656,631,657,632,633,659,658],
    "RMUX28":[430,456,429,455,428,454,427,426,452,453],
    "RMUX29":[638,664,637,663,636,662,635,634,660,661],
    "RMUX30":[472,498,471,497,470,496,469,468,494,495],
    "RMUX31":[680,706,679,705,678,704,677,676,702,703],
    "RMUX32":[473,499,474,500,475,501,476,477,503,502],
    "RMUX33":[681,707,682,708,683,709,684,685,711,710],
    "RMUX34":[482,508,481,507,480,506,479,478,504,505],
    "RMUX35":[690,716,689,715,688,714,687,686,712,713],
    "RMUX36":[733,759,734,760,735,761,736,737,763,762],
    "RMUX37":[525,551,526,552,527,553,528,529,555,554],
    "RMUX38":[742,768,741,767,740,766,739,738,764,765],
    "RMUX39":[534,560,533,559,532,558,531,530,556,557],
    "RMUX40":[732,758,731,757,730,756,729,728,754,755],
    "RMUX41":[524,550,523,549,522,548,521,520,546,547],
    "RMUX42":[785,811,786,812,787,813,788,789,815,814],
    "RMUX43":[577,603,578,604,579,605,580,581,607,606],
    "RMUX44":[794,820,793,819,792,818,791,790,816,817],
    "RMUX45":[586,612,585,611,584,610,583,582,608,609],
    "RMUX46":[784,810,783,809,782,808,781,780,806,807],
    "RMUX47":[576,602,575,601,574,600,573,572,598,599],
    "RMUX48":[940,966,939,965,938,964,937,936,962,963],
    "RMUX49":[1148,1174,1147,1173,1146,1172,1145,1144,1170,1171],
    "RMUX50":[941,967,942,968,943,969,944,945,971,970],
    "RMUX51":[1149,1175,1150,1176,1151,1177,1152,1153,1179,1178],
    "RMUX52":[950,976,949,975,948,974,947,946,972,973],
    "RMUX53":[1158,1184,1157,1183,1156,1182,1155,1154,1180,1181],
    "RMUX54":[992,1018,991,1017,990,1016,989,988,1014,1015],
    "RMUX55":[1200,1226,1199,1225,1198,1224,1197,1196,1222,1223],
    "RMUX56":[993,1019,994,1020,995,1021,996,997,1023,1022],
    "RMUX57":[1201,1227,1202,1228,1203,1229,1204,1205,1231,1230],
    "RMUX58":[1002,1028,1001,1027,1000,1026,999,998,1024,1025],
    "RMUX59":[1210,1236,1209,1235,1208,1234,1207,1206,1232,1233],
    "RMUX60":[1253,1279,1254,1280,1255,1281,1256,1257,1283,1282],
    "RMUX61":[1045,1071,1046,1072,1047,1073,1048,1049,1075,1074],
    "RMUX62":[1262,1288,1261,1287,1260,1286,1259,1258,1284,1285],
    "RMUX63":[1054,1080,1053,1079,1052,1078,1051,1050,1076,1077],
    "RMUX64":[1252,1278,1251,1277,1250,1276,1249,1248,1274,1275],
    "RMUX65":[1044,1070,1043,1069,1042,1068,1041,1040,1066,1067],
    "RMUX66":[1305,1331,1306,1332,1307,1333,1308,1309,1335,1334],
    "RMUX67":[1097,1123,1098,1124,1099,1125,1100,1101,1127,1126],
    "RMUX68":[1314,1340,1313,1339,1312,1338,1311,1310,1336,1337],
    "RMUX69":[1106,1132,1105,1131,1104,1130,1103,1102,1128,1129],
    "RMUX70":[1304,1330,1303,1329,1302,1328,1301,1300,1326,1327],
    "RMUX71":[1096,1122,1095,1121,1094,1120,1093,1092,1118,1119],
    "RMUX72":[1356,1382,1355,1381,1354,1380,1353,1352,1378,1379],
    "RMUX73":[1564,1590,1563,1589,1562,1588,1561,1560,1586,1587],
    "RMUX74":[1357,1383,1358,1384,1359,1385,1360,1361,1387,1386],
    "RMUX75":[1565,1591,1566,1592,1567,1593,1568,1569,1595,1594],
    "RMUX76":[1366,1392,1365,1391,1364,1390,1363,1362,1388,1389],
    "RMUX77":[1574,1600,1573,1599,1572,1598,1571,1570,1596,1597],
    "RMUX78":[1408,1434,1407,1433,1406,1432,1405,1404,1430,1431],
    "RMUX79":[1616,1642,1615,1641,1614,1640,1613,1612,1638,1639],
    "RMUX80":[1409,1435,1410,1436,1411,1437,1412,1413,1439,1438],
    "RMUX81":[1617,1643,1618,1644,1619,1645,1620,1621,1647,1646],
    "RMUX82":[1418,1444,1417,1443,1416,1442,1415,1414,1440,1441],
    "RMUX83":[1626,1652,1625,1651,1624,1650,1623,1622,1648,1649],
    "RMUX84":[1669,1695,1670,1696,1671,1697,1672,1673,1699,1698],
    "RMUX85":[1461,1487,1462,1488,1463,1489,1464,1465,1491,1490],
    "RMUX86":[1678,1704,1677,1703,1676,1702,1675,1674,1700,1701],
    "RMUX87":[1470,1496,1469,1495,1468,1494,1467,1466,1492,1493],
    "RMUX88":[1668,1694,1667,1693,1666,1692,1665,1664,1690,1691],
    "RMUX89":[1460,1486,1459,1485,1458,1484,1457,1456,1482,1483],
    "RMUX90":[1721,1747,1722,1748,1723,1749,1724,1725,1751,1750],
    "RMUX91":[1513,1539,1514,1540,1515,1541,1516,1517,1543,1542],
    "RMUX92":[1730,1756,1729,1755,1728,1754,1727,1726,1752,1753],
    "RMUX93":[1522,1548,1521,1547,1520,1546,1519,1518,1544,1545],
    "RMUX94":[1720,1746,1719,1745,1718,1744,1717,1716,1742,1743],
    "RMUX95":[1512,1538,1511,1537,1510,1536,1509,1508,1534,1535],

    "SeamMUX00":[834,835,836,837,838,839],
    "SeamMUX01":[912,913,914,915,916,917],
    "SeamMUX02":[840,841,842,843,844,845],
    "SeamMUX03":[918,919,920,921,922,923],

    "SELMODE":[1297],
    "SELOUTA":[824],
    "SELOUTB":[1298],
    "SEL_DA0_REG":[541],
    "SEL_DA1_REG":[1296],
    "SEL_DB0_REG":[542],
    "SEL_DB1_REG":[1295],
    "SEL_SIGNA_REG":[544],
    "SEL_SIGNB_REG":[543],
    "TileAsyncMUX00":[960,959,958,957],
    "TileClkEnMUX00":[956,826,955,825,954],
    "TileClkMUX00":[830,829,828,827],
}))

InstallTile(Tile('alta_bram9k', 'BramTILE', columns=180, rows=68, slices=0, values={
    "CLKMODE":[8855,8854],

    "CtrlMUX00":[5776,5956,5777,5957,5778,5958,5779,5959,5961,5960,5781,5780],
    "CtrlMUX01":[5787,5967,5786,5966,5785,5965,5784,5964,5962,5963,5782,5783],
    "CtrlMUX02":[6316,6136,6317,6137,6318,6138,6319,6139,6141,6140,6321,6320],
    "CtrlMUX03":[6327,6147,6326,6146,6325,6145,6324,6144,6142,6143,6322,6323],

    "DLYTIME":[4534,7054],
    "DWSEL_A":[4535,4175,3454,2375,8134],
    "DWSEL_B":[7775,7774,8853,9934,8135],

    "IMUX00":[16,196,17,197,18,198,19,199,20,21,201,200],
    "IMUX01":[27,207,26,206,25,205,24,204,23,22,202,203],
    "IMUX02":[376,556,377,557,378,558,379,559,380,381,561,560],
    "IMUX03":[387,567,386,566,385,565,384,564,383,382,562,563],
    "IMUX04":[736,916,737,917,738,918,739,919,740,741,921,920],
    "IMUX05":[747,927,746,926,745,925,744,924,743,742,922,923],
    "IMUX06":[1096,1276,1097,1277,1098,1278,1099,1279,1100,1101,1281,1280],
    "IMUX07":[1107,1287,1106,1286,1105,1285,1104,1284,1103,1102,1282,1283],
    "IMUX08":[1456,1636,1457,1637,1458,1638,1459,1639,1460,1461,1641,1640],
    "IMUX09":[1467,1647,1466,1646,1465,1645,1464,1644,1463,1462,1642,1643],
    "IMUX10":[1816,1996,1817,1997,1818,1998,1819,1999,1820,1821,2001,2000],
    "IMUX11":[1827,2007,1826,2006,1825,2005,1824,2004,1823,1822,2002,2003],
    "IMUX12":[2176,2356,2177,2357,2178,2358,2179,2359,2180,2181,2361,2360],
    "IMUX13":[2187,2367,2186,2366,2185,2365,2184,2364,2183,2182,2362,2363],
    "IMUX14":[2536,2716,2537,2717,2538,2718,2539,2719,2540,2541,2721,2720],
    "IMUX15":[2547,2727,2546,2726,2545,2725,2544,2724,2543,2542,2722,2723],
    "IMUX16":[2896,3076,2897,3077,2898,3078,2899,3079,2900,2901,3081,3080],
    "IMUX17":[2907,3087,2906,3086,2905,3085,2904,3084,2903,2902,3082,3083],
    "IMUX18":[3256,3436,3257,3437,3258,3438,3259,3439,3260,3261,3441,3440],
    "IMUX19":[3267,3447,3266,3446,3265,3445,3264,3444,3263,3262,3442,3443],
    "IMUX20":[3616,3796,3617,3797,3618,3798,3619,3799,3620,3621,3801,3800],
    "IMUX21":[3627,3807,3626,3806,3625,3805,3624,3804,3623,3622,3802,3803],
    "IMUX22":[3976,4156,3977,4157,3978,4158,3979,4159,3980,3981,4161,4160],
    "IMUX23":[3987,4167,3986,4166,3985,4165,3984,4164,3983,3982,4162,4163],
    "IMUX24":[4336,4516,4337,4517,4338,4518,4339,4519,4340,4341,4521,4520],
    "IMUX25":[4347,4527,4346,4526,4345,4525,4344,4524,4343,4342,4522,4523],
    "IMUX26":[4696,4876,4697,4877,4698,4878,4699,4879,4700,4701,4881,4880],
    "IMUX27":[4707,4887,4706,4886,4705,4885,4704,4884,4703,4702,4882,4883],
    "IMUX28":[5056,5236,5057,5237,5058,5238,5059,5239,5060,5061,5241,5240],
    "IMUX29":[5067,5247,5066,5246,5065,5245,5064,5244,5063,5062,5242,5243],
    "IMUX30":[5416,5596,5417,5597,5418,5598,5419,5599,5420,5421,5601,5600],
    "IMUX31":[5427,5607,5426,5606,5425,5605,5424,5604,5423,5422,5602,5603],
    "IMUX32":[6496,6676,6497,6677,6498,6678,6499,6679,6500,6501,6681,6680],
    "IMUX33":[6507,6687,6506,6686,6505,6685,6504,6684,6503,6502,6682,6683],
    "IMUX34":[6856,7036,6857,7037,6858,7038,6859,7039,6860,6861,7041,7040],
    "IMUX35":[6867,7047,6866,7046,6865,7045,6864,7044,6863,6862,7042,7043],
    "IMUX36":[7216,7396,7217,7397,7218,7398,7219,7399,7220,7221,7401,7400],
    "IMUX37":[7227,7407,7226,7406,7225,7405,7224,7404,7223,7222,7402,7403],
    "IMUX38":[7576,7756,7577,7757,7578,7758,7579,7759,7580,7581,7761,7760],
    "IMUX39":[7587,7767,7586,7766,7585,7765,7584,7764,7583,7582,7762,7763],
    "IMUX40":[7936,8116,7937,8117,7938,8118,7939,8119,7940,7941,8121,8120],
    "IMUX41":[7947,8127,7946,8126,7945,8125,7944,8124,7943,7942,8122,8123],
    "IMUX42":[8296,8476,8297,8477,8298,8478,8299,8479,8300,8301,8481,8480],
    "IMUX43":[8307,8487,8306,8486,8305,8485,8304,8484,8303,8302,8482,8483],
    "IMUX44":[8656,8836,8657,8837,8658,8838,8659,8839,8660,8661,8841,8840],
    "IMUX45":[8667,8847,8666,8846,8665,8845,8664,8844,8663,8662,8842,8843],
    "IMUX46":[9016,9196,9017,9197,9018,9198,9019,9199,9020,9021,9201,9200],
    "IMUX47":[9027,9207,9026,9206,9025,9205,9024,9204,9023,9022,9202,9203],
    "IMUX48":[9376,9556,9377,9557,9378,9558,9379,9559,9380,9381,9561,9560],
    "IMUX49":[9387,9567,9386,9566,9385,9565,9384,9564,9383,9382,9562,9563],
    "IMUX50":[9736,9916,9737,9917,9738,9918,9739,9919,9740,9741,9921,9920],
    "IMUX51":[9747,9927,9746,9926,9745,9925,9744,9924,9743,9742,9922,9923],
    "IMUX52":[10096,10276,10097,10277,10098,10278,10099,10279,10100,10101,10281,10280],
    "IMUX53":[10107,10287,10106,10286,10105,10285,10104,10284,10103,10102,10282,10283],
    "IMUX54":[10456,10636,10457,10637,10458,10638,10459,10639,10460,10461,10641,10640],
    "IMUX55":[10467,10647,10466,10646,10465,10645,10464,10644,10463,10462,10642,10643],
    "IMUX56":[10816,10996,10817,10997,10818,10998,10819,10999,10820,10821,11001,11000],
    "IMUX57":[10827,11007,10826,11006,10825,11005,10824,11004,10823,10822,11002,11003],
    "IMUX58":[11176,11356,11177,11357,11178,11358,11179,11359,11180,11181,11361,11360],
    "IMUX59":[11187,11367,11186,11366,11185,11365,11184,11364,11183,11182,11362,11363],
    "IMUX60":[11536,11716,11537,11717,11538,11718,11539,11719,11540,11541,11721,11720],
    "IMUX61":[11547,11727,11546,11726,11545,11725,11544,11724,11543,11542,11722,11723],
    "IMUX62":[11896,12076,11897,12077,11898,12078,11899,12079,11900,11901,12081,12080],
    "IMUX63":[11907,12087,11906,12086,11905,12085,11904,12084,11903,11902,12082,12083],

    "KMUX00":[11915,12095,11914,12094,11913,11912,12092,12093,12089],
    "KMUX01":[35,215,34,214,33,32,212,213,209],
    "KMUX02":[755,935,754,934,753,752,932,933,929],
    "KMUX03":[1835,2015,1834,2014,1833,1832,2012,2013,2009],
    "KMUX04":[2555,2735,2554,2734,2553,2552,2732,2733,2729],
    "KMUX05":[2915,3095,2914,3094,2913,2912,3092,3093,3089],
    "KMUX06":[3635,3815,3634,3814,3633,3632,3812,3813,3809],
    "KMUX07":[4715,4895,4714,4894,4713,4712,4892,4893,4889],
    "KMUX08":[5435,5615,5434,5614,5433,5432,5612,5613,5609],
    "KMUX09":[6515,6695,6514,6694,6513,6512,6692,6693,6689],
    "KMUX10":[7235,7415,7234,7414,7233,7232,7412,7413,7409],
    "KMUX11":[8315,8495,8314,8494,8313,8312,8492,8493,8489],
    "KMUX12":[9035,9215,9034,9214,9033,9032,9212,9213,9209],
    "KMUX13":[9395,9575,9394,9574,9393,9392,9572,9573,9569],
    "KMUX14":[10115,10295,10114,10294,10113,10112,10292,10293,10289],
    "KMUX15":[11195,11375,11194,11374,11193,11192,11372,11373,11369],

    "PACKEDMODE":[574],
    "PORTA_CLKIN_EN":[575],
    "PORTA_CLKOUT_EN":[1295],
    "PORTA_RSTIN_EN":[9935],
    "PORTA_RSTOUT_EN":[10655],
    "PORTB_CLKIN_EN":[3455],
    "PORTB_CLKOUT_EN":[5255],
    "PORTB_RSTIN_EN":[11015],
    "PORTB_RSTOUT_EN":[11735],

    "RMUX00":[5,185,4,184,3,183,2,1,181,182],
    "RMUX01":[1445,1625,1444,1624,1443,1623,1442,1441,1621,1622],
    "RMUX02":[6,186,7,187,8,188,9,10,190,189],
    "RMUX03":[1446,1626,1447,1627,1448,1628,1449,1450,1630,1629],
    "RMUX04":[15,195,14,194,13,193,12,11,191,192],
    "RMUX05":[1455,1635,1454,1634,1453,1633,1452,1451,1631,1632],
    "RMUX06":[365,545,364,544,363,543,362,361,541,542],
    "RMUX07":[1805,1985,1804,1984,1803,1983,1802,1801,1981,1982],
    "RMUX08":[366,546,367,547,368,548,369,370,550,549],
    "RMUX09":[1806,1986,1807,1987,1808,1988,1809,1810,1990,1989],
    "RMUX10":[375,555,374,554,373,553,372,371,551,552],
    "RMUX11":[1815,1995,1814,1994,1813,1993,1812,1811,1991,1992],
    "RMUX12":[2166,2346,2167,2347,2168,2348,2169,2170,2350,2349],
    "RMUX13":[726,906,727,907,728,908,729,730,910,909],
    "RMUX14":[2175,2355,2174,2354,2173,2353,2172,2171,2351,2352],
    "RMUX15":[735,915,734,914,733,913,732,731,911,912],
    "RMUX16":[2165,2345,2164,2344,2163,2343,2162,2161,2341,2342],
    "RMUX17":[725,905,724,904,723,903,722,721,901,902],
    "RMUX18":[2526,2706,2527,2707,2528,2708,2529,2530,2710,2709],
    "RMUX19":[1086,1266,1087,1267,1088,1268,1089,1090,1270,1269],
    "RMUX20":[2535,2715,2534,2714,2533,2713,2532,2531,2711,2712],
    "RMUX21":[1095,1275,1094,1274,1093,1273,1092,1091,1271,1272],
    "RMUX22":[2525,2705,2524,2704,2523,2703,2522,2521,2701,2702],
    "RMUX23":[1085,1265,1084,1264,1083,1263,1082,1081,1261,1262],
    "RMUX24":[2885,3065,2884,3064,2883,3063,2882,2881,3061,3062],
    "RMUX25":[4325,4505,4324,4504,4323,4503,4322,4321,4501,4502],
    "RMUX26":[2886,3066,2887,3067,2888,3068,2889,2890,3070,3069],
    "RMUX27":[4326,4506,4327,4507,4328,4508,4329,4330,4510,4509],
    "RMUX28":[2895,3075,2894,3074,2893,3073,2892,2891,3071,3072],
    "RMUX29":[4335,4515,4334,4514,4333,4513,4332,4331,4511,4512],
    "RMUX30":[3245,3425,3244,3424,3243,3423,3242,3241,3421,3422],
    "RMUX31":[4685,4865,4684,4864,4683,4863,4682,4681,4861,4862],
    "RMUX32":[3246,3426,3247,3427,3248,3428,3249,3250,3430,3429],
    "RMUX33":[4686,4866,4687,4867,4688,4868,4689,4690,4870,4869],
    "RMUX34":[3255,3435,3254,3434,3253,3433,3252,3251,3431,3432],
    "RMUX35":[4695,4875,4694,4874,4693,4873,4692,4691,4871,4872],
    "RMUX36":[5046,5226,5047,5227,5048,5228,5049,5050,5230,5229],
    "RMUX37":[3606,3786,3607,3787,3608,3788,3609,3610,3790,3789],
    "RMUX38":[5055,5235,5054,5234,5053,5233,5052,5051,5231,5232],
    "RMUX39":[3615,3795,3614,3794,3613,3793,3612,3611,3791,3792],
    "RMUX40":[5045,5225,5044,5224,5043,5223,5042,5041,5221,5222],
    "RMUX41":[3605,3785,3604,3784,3603,3783,3602,3601,3781,3782],
    "RMUX42":[5406,5586,5407,5587,5408,5588,5409,5410,5590,5589],
    "RMUX43":[3966,4146,3967,4147,3968,4148,3969,3970,4150,4149],
    "RMUX44":[5415,5595,5414,5594,5413,5593,5412,5411,5591,5592],
    "RMUX45":[3975,4155,3974,4154,3973,4153,3972,3971,4151,4152],
    "RMUX46":[5405,5585,5404,5584,5403,5583,5402,5401,5581,5582],
    "RMUX47":[3965,4145,3964,4144,3963,4143,3962,3961,4141,4142],
    "RMUX48":[6485,6665,6484,6664,6483,6663,6482,6481,6661,6662],
    "RMUX49":[7925,8105,7924,8104,7923,8103,7922,7921,8101,8102],
    "RMUX50":[6486,6666,6487,6667,6488,6668,6489,6490,6670,6669],
    "RMUX51":[7926,8106,7927,8107,7928,8108,7929,7930,8110,8109],
    "RMUX52":[6495,6675,6494,6674,6493,6673,6492,6491,6671,6672],
    "RMUX53":[7935,8115,7934,8114,7933,8113,7932,7931,8111,8112],
    "RMUX54":[6845,7025,6844,7024,6843,7023,6842,6841,7021,7022],
    "RMUX55":[8285,8465,8284,8464,8283,8463,8282,8281,8461,8462],
    "RMUX56":[6846,7026,6847,7027,6848,7028,6849,6850,7030,7029],
    "RMUX57":[8286,8466,8287,8467,8288,8468,8289,8290,8470,8469],
    "RMUX58":[6855,7035,6854,7034,6853,7033,6852,6851,7031,7032],
    "RMUX59":[8295,8475,8294,8474,8293,8473,8292,8291,8471,8472],
    "RMUX60":[8646,8826,8647,8827,8648,8828,8649,8650,8830,8829],
    "RMUX61":[7206,7386,7207,7387,7208,7388,7209,7210,7390,7389],
    "RMUX62":[8655,8835,8654,8834,8653,8833,8652,8651,8831,8832],
    "RMUX63":[7215,7395,7214,7394,7213,7393,7212,7211,7391,7392],
    "RMUX64":[8645,8825,8644,8824,8643,8823,8642,8641,8821,8822],
    "RMUX65":[7205,7385,7204,7384,7203,7383,7202,7201,7381,7382],
    "RMUX66":[9006,9186,9007,9187,9008,9188,9009,9010,9190,9189],
    "RMUX67":[7566,7746,7567,7747,7568,7748,7569,7570,7750,7749],
    "RMUX68":[9015,9195,9014,9194,9013,9193,9012,9011,9191,9192],
    "RMUX69":[7575,7755,7574,7754,7573,7753,7572,7571,7751,7752],
    "RMUX70":[9005,9185,9004,9184,9003,9183,9002,9001,9181,9182],
    "RMUX71":[7565,7745,7564,7744,7563,7743,7562,7561,7741,7742],
    "RMUX72":[9365,9545,9364,9544,9363,9543,9362,9361,9541,9542],
    "RMUX73":[10805,10985,10804,10984,10803,10983,10802,10801,10981,10982],
    "RMUX74":[9366,9546,9367,9547,9368,9548,9369,9370,9550,9549],
    "RMUX75":[10806,10986,10807,10987,10808,10988,10809,10810,10990,10989],
    "RMUX76":[9375,9555,9374,9554,9373,9553,9372,9371,9551,9552],
    "RMUX77":[10815,10995,10814,10994,10813,10993,10812,10811,10991,10992],
    "RMUX78":[9725,9905,9724,9904,9723,9903,9722,9721,9901,9902],
    "RMUX79":[11165,11345,11164,11344,11163,11343,11162,11161,11341,11342],
    "RMUX80":[9726,9906,9727,9907,9728,9908,9729,9730,9910,9909],
    "RMUX81":[11166,11346,11167,11347,11168,11348,11169,11170,11350,11349],
    "RMUX82":[9735,9915,9734,9914,9733,9913,9732,9731,9911,9912],
    "RMUX83":[11175,11355,11174,11354,11173,11353,11172,11171,11351,11352],
    "RMUX84":[11526,11706,11527,11707,11528,11708,11529,11530,11710,11709],
    "RMUX85":[10086,10266,10087,10267,10088,10268,10089,10090,10270,10269],
    "RMUX86":[11535,11715,11534,11714,11533,11713,11532,11531,11711,11712],
    "RMUX87":[10095,10275,10094,10274,10093,10273,10092,10091,10271,10272],
    "RMUX88":[11525,11705,11524,11704,11523,11703,11522,11521,11701,11702],
    "RMUX89":[10085,10265,10084,10264,10083,10263,10082,10081,10261,10262],
    "RMUX90":[11886,12066,11887,12067,11888,12068,11889,11890,12070,12069],
    "RMUX91":[10446,10626,10447,10627,10448,10628,10449,10450,10630,10629],
    "RMUX92":[11895,12075,11894,12074,11893,12073,11892,11891,12071,12072],
    "RMUX93":[10455,10635,10454,10634,10453,10633,10452,10451,10631,10632],
    "RMUX94":[11885,12065,11884,12064,11883,12063,11882,11881,12061,12062],
    "RMUX95":[10445,10625,10444,10624,10443,10623,10442,10441,10621,10622],

    "RSEN_DLY":[2374,4174],

    "SeamMUX00":[5763,5764,5765,5766,5767,5768],
    "SeamMUX01":[6303,6304,6305,6306,6307,6308],
    "SeamMUX02":[5769,5770,5771,5772,5773,5774],
    "SeamMUX03":[6309,6310,6311,6312,6313,6314],
    "SeamMUX04":[4680,4860,5040,5220,5400,5580],
    "SeamMUX05":[7380,7200,7020,6840,6660,6480],

    "SELOUT_A":[5254],
    "SELOUT_B":[7055],
    "SEL_WRITHU_A":[1655],
    "SEL_WRITHU_B":[10654],
    "TileAsyncMUX00":[5790,5970,5971,5791],
    "TileAsyncMUX01":[5974,5973,5972,5975],
    "TileClkEnMUX00":[6154,6153,6152,6155],
    "TileClkEnMUX01":[6330,6150,6151,6331],
    "TileClkMUX00":[5794,5793,5792,5795],
    "TileClkMUX01":[6334,6333,6332,6335],

    "TMUX00":[388,568,389,569],
    "TMUX01":[390,391,571,570],
    "TMUX02":[1108,1288,1109,1289],
    "TMUX03":[1110,1111,1291,1290],
    "TMUX04":[1468,1648,1469,1649],
    "TMUX05":[1470,1471,1651,1650],
    "TMUX06":[2188,2368,2189,2369],
    "TMUX07":[2190,2191,2371,2370],
    "TMUX08":[3268,3448,3269,3449],
    "TMUX09":[3270,3271,3451,3450],
    "TMUX10":[3988,4168,3989,4169],
    "TMUX11":[3990,3991,4171,4170],
    "TMUX12":[4348,4528,4349,4529],
    "TMUX13":[4350,4351,4531,4530],
    "TMUX14":[5068,5248,5069,5249],
    "TMUX15":[5070,5071,5251,5250],
    "TMUX16":[6868,7048,6869,7049],
    "TMUX17":[6870,6871,7051,7050],
    "TMUX18":[7588,7768,7589,7769],
    "TMUX19":[7590,7591,7771,7770],
    "TMUX20":[7948,8128,7949,8129],
    "TMUX21":[7950,7951,8131,8130],
    "TMUX22":[8668,8848,8669,8849],
    "TMUX23":[8670,8671,8851,8850],
    "TMUX24":[9748,9928,9749,9929],
    "TMUX25":[9750,9751,9931,9930],
    "TMUX26":[10468,10648,10469,10649],
    "TMUX27":[10470,10471,10651,10650],
    "TMUX28":[10828,11008,10829,11009],
    "TMUX29":[10830,10831,11011,11010],
    "TMUX30":[11548,11728,11549,11729],
    "TMUX31":[11550,11551,11731,11730],

    "INIT_VAL":[
        36, 44, 52, 60, 68, 76, 84, 92, 100, 108, 116, 124, 132, 140, 148, 156, 164, 172, 37, 45, 53, 61, 69, 77, 85, 93, 101, 109, 117, 125, 133, 141, 149, 157, 165, 173, 38, 46, 54, 62, 70, 78, 86, 94, 102, 110, 118, 126, 134, 142, 150, 158, 166, 174, 39, 47, 55, 63, 71, 79, 87, 95, 103, 111, 
        119, 127, 135, 143, 151, 159, 167, 175, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128, 136, 144, 152, 160, 168, 176, 41, 49, 57, 65, 73, 81, 89, 97, 105, 113, 121, 129, 137, 145, 153, 161, 169, 177, 42, 50, 58, 66, 74, 82, 90, 98, 106, 114, 122, 130, 138, 146, 154, 162, 170, 178, 43, 51, 
        59, 67, 75, 83, 91, 99, 107, 115, 123, 131, 139, 147, 155, 163, 171, 179, 216, 224, 232, 240, 248, 256, 264, 272, 280, 288, 296, 304, 312, 320, 328, 336, 344, 352, 217, 225, 233, 241, 249, 257, 265, 273, 281, 289, 297, 305, 313, 321, 329, 337, 345, 353, 218, 226, 234, 242, 250, 258, 266, 274, 282, 290, 298, 306, 
        314, 322, 330, 338, 346, 354, 219, 227, 235, 243, 251, 259, 267, 275, 283, 291, 299, 307, 315, 323, 331, 339, 347, 355, 220, 228, 236, 244, 252, 260, 268, 276, 284, 292, 300, 308, 316, 324, 332, 340, 348, 356, 221, 229, 237, 245, 253, 261, 269, 277, 285, 293, 301, 309, 317, 325, 333, 341, 349, 357, 222, 230, 238, 246, 
        254, 262, 270, 278, 286, 294, 302, 310, 318, 326, 334, 342, 350, 358, 223, 231, 239, 247, 255, 263, 271, 279, 287, 295, 303, 311, 319, 327, 335, 343, 351, 359, 396, 404, 412, 420, 428, 436, 444, 452, 460, 468, 476, 484, 492, 500, 508, 516, 524, 532, 397, 405, 413, 421, 429, 437, 445, 453, 461, 469, 477, 485, 493, 501, 
        509, 517, 525, 533, 398, 406, 414, 422, 430, 438, 446, 454, 462, 470, 478, 486, 494, 502, 510, 518, 526, 534, 399, 407, 415, 423, 431, 439, 447, 455, 463, 471, 479, 487, 495, 503, 511, 519, 527, 535, 400, 408, 416, 424, 432, 440, 448, 456, 464, 472, 480, 488, 496, 504, 512, 520, 528, 536, 401, 409, 417, 425, 433, 441, 
        449, 457, 465, 473, 481, 489, 497, 505, 513, 521, 529, 537, 402, 410, 418, 426, 434, 442, 450, 458, 466, 474, 482, 490, 498, 506, 514, 522, 530, 538, 403, 411, 419, 427, 435, 443, 451, 459, 467, 475, 483, 491, 499, 507, 515, 523, 531, 539, 576, 584, 592, 600, 608, 616, 624, 632, 640, 648, 656, 664, 672, 680, 688, 696, 
        704, 712, 577, 585, 593, 601, 609, 617, 625, 633, 641, 649, 657, 665, 673, 681, 689, 697, 705, 713, 578, 586, 594, 602, 610, 618, 626, 634, 642, 650, 658, 666, 674, 682, 690, 698, 706, 714, 579, 587, 595, 603, 611, 619, 627, 635, 643, 651, 659, 667, 675, 683, 691, 699, 707, 715, 580, 588, 596, 604, 612, 620, 628, 636, 
        644, 652, 660, 668, 676, 684, 692, 700, 708, 716, 581, 589, 597, 605, 613, 621, 629, 637, 645, 653, 661, 669, 677, 685, 693, 701, 709, 717, 582, 590, 598, 606, 614, 622, 630, 638, 646, 654, 662, 670, 678, 686, 694, 702, 710, 718, 583, 591, 599, 607, 615, 623, 631, 639, 647, 655, 663, 671, 679, 687, 695, 703, 711, 719, 
        756, 764, 772, 780, 788, 796, 804, 812, 820, 828, 836, 844, 852, 860, 868, 876, 884, 892, 757, 765, 773, 781, 789, 797, 805, 813, 821, 829, 837, 845, 853, 861, 869, 877, 885, 893, 758, 766, 774, 782, 790, 798, 806, 814, 822, 830, 838, 846, 854, 862, 870, 878, 886, 894, 759, 767, 775, 783, 791, 799, 807, 815, 823, 831, 
        839, 847, 855, 863, 871, 879, 887, 895, 760, 768, 776, 784, 792, 800, 808, 816, 824, 832, 840, 848, 856, 864, 872, 880, 888, 896, 761, 769, 777, 785, 793, 801, 809, 817, 825, 833, 841, 849, 857, 865, 873, 881, 889, 897, 762, 770, 778, 786, 794, 802, 810, 818, 826, 834, 842, 850, 858, 866, 874, 882, 890, 898, 763, 771, 
        779, 787, 795, 803, 811, 819, 827, 835, 843, 851, 859, 867, 875, 883, 891, 899, 936, 944, 952, 960, 968, 976, 984, 992, 1000, 1008, 1016, 1024, 1032, 1040, 1048, 1056, 1064, 1072, 937, 945, 953, 961, 969, 977, 985, 993, 1001, 1009, 1017, 1025, 1033, 1041, 1049, 1057, 1065, 1073, 938, 946, 954, 962, 970, 978, 986, 994, 1002, 1010, 1018, 1026, 
        1034, 1042, 1050, 1058, 1066, 1074, 939, 947, 955, 963, 971, 979, 987, 995, 1003, 1011, 1019, 1027, 1035, 1043, 1051, 1059, 1067, 1075, 940, 948, 956, 964, 972, 980, 988, 996, 1004, 1012, 1020, 1028, 1036, 1044, 1052, 1060, 1068, 1076, 941, 949, 957, 965, 973, 981, 989, 997, 1005, 1013, 1021, 1029, 1037, 1045, 1053, 1061, 1069, 1077, 942, 950, 958, 966, 
        974, 982, 990, 998, 1006, 1014, 1022, 1030, 1038, 1046, 1054, 1062, 1070, 1078, 943, 951, 959, 967, 975, 983, 991, 999, 1007, 1015, 1023, 1031, 1039, 1047, 1055, 1063, 1071, 1079, 1116, 1124, 1132, 1140, 1148, 1156, 1164, 1172, 1180, 1188, 1196, 1204, 1212, 1220, 1228, 1236, 1244, 1252, 1117, 1125, 1133, 1141, 1149, 1157, 1165, 1173, 1181, 1189, 1197, 1205, 1213, 1221, 
        1229, 1237, 1245, 1253, 1118, 1126, 1134, 1142, 1150, 1158, 1166, 1174, 1182, 1190, 1198, 1206, 1214, 1222, 1230, 1238, 1246, 1254, 1119, 1127, 1135, 1143, 1151, 1159, 1167, 1175, 1183, 1191, 1199, 1207, 1215, 1223, 1231, 1239, 1247, 1255, 1120, 1128, 1136, 1144, 1152, 1160, 1168, 1176, 1184, 1192, 1200, 1208, 1216, 1224, 1232, 1240, 1248, 1256, 1121, 1129, 1137, 1145, 1153, 1161, 
        1169, 1177, 1185, 1193, 1201, 1209, 1217, 1225, 1233, 1241, 1249, 1257, 1122, 1130, 1138, 1146, 1154, 1162, 1170, 1178, 1186, 1194, 1202, 1210, 1218, 1226, 1234, 1242, 1250, 1258, 1123, 1131, 1139, 1147, 1155, 1163, 1171, 1179, 1187, 1195, 1203, 1211, 1219, 1227, 1235, 1243, 1251, 1259, 1296, 1304, 1312, 1320, 1328, 1336, 1344, 1352, 1360, 1368, 1376, 1384, 1392, 1400, 1408, 1416, 
        1424, 1432, 1297, 1305, 1313, 1321, 1329, 1337, 1345, 1353, 1361, 1369, 1377, 1385, 1393, 1401, 1409, 1417, 1425, 1433, 1298, 1306, 1314, 1322, 1330, 1338, 1346, 1354, 1362, 1370, 1378, 1386, 1394, 1402, 1410, 1418, 1426, 1434, 1299, 1307, 1315, 1323, 1331, 1339, 1347, 1355, 1363, 1371, 1379, 1387, 1395, 1403, 1411, 1419, 1427, 1435, 1300, 1308, 1316, 1324, 1332, 1340, 1348, 1356, 
        1364, 1372, 1380, 1388, 1396, 1404, 1412, 1420, 1428, 1436, 1301, 1309, 1317, 1325, 1333, 1341, 1349, 1357, 1365, 1373, 1381, 1389, 1397, 1405, 1413, 1421, 1429, 1437, 1302, 1310, 1318, 1326, 1334, 1342, 1350, 1358, 1366, 1374, 1382, 1390, 1398, 1406, 1414, 1422, 1430, 1438, 1303, 1311, 1319, 1327, 1335, 1343, 1351, 1359, 1367, 1375, 1383, 1391, 1399, 1407, 1415, 1423, 1431, 1439, 
        1476, 1484, 1492, 1500, 1508, 1516, 1524, 1532, 1540, 1548, 1556, 1564, 1572, 1580, 1588, 1596, 1604, 1612, 1477, 1485, 1493, 1501, 1509, 1517, 1525, 1533, 1541, 1549, 1557, 1565, 1573, 1581, 1589, 1597, 1605, 1613, 1478, 1486, 1494, 1502, 1510, 1518, 1526, 1534, 1542, 1550, 1558, 1566, 1574, 1582, 1590, 1598, 1606, 1614, 1479, 1487, 1495, 1503, 1511, 1519, 1527, 1535, 1543, 1551, 
        1559, 1567, 1575, 1583, 1591, 1599, 1607, 1615, 1480, 1488, 1496, 1504, 1512, 1520, 1528, 1536, 1544, 1552, 1560, 1568, 1576, 1584, 1592, 1600, 1608, 1616, 1481, 1489, 1497, 1505, 1513, 1521, 1529, 1537, 1545, 1553, 1561, 1569, 1577, 1585, 1593, 1601, 1609, 1617, 1482, 1490, 1498, 1506, 1514, 1522, 1530, 1538, 1546, 1554, 1562, 1570, 1578, 1586, 1594, 1602, 1610, 1618, 1483, 1491, 
        1499, 1507, 1515, 1523, 1531, 1539, 1547, 1555, 1563, 1571, 1579, 1587, 1595, 1603, 1611, 1619, 1656, 1664, 1672, 1680, 1688, 1696, 1704, 1712, 1720, 1728, 1736, 1744, 1752, 1760, 1768, 1776, 1784, 1792, 1657, 1665, 1673, 1681, 1689, 1697, 1705, 1713, 1721, 1729, 1737, 1745, 1753, 1761, 1769, 1777, 1785, 1793, 1658, 1666, 1674, 1682, 1690, 1698, 1706, 1714, 1722, 1730, 1738, 1746, 
        1754, 1762, 1770, 1778, 1786, 1794, 1659, 1667, 1675, 1683, 1691, 1699, 1707, 1715, 1723, 1731, 1739, 1747, 1755, 1763, 1771, 1779, 1787, 1795, 1660, 1668, 1676, 1684, 1692, 1700, 1708, 1716, 1724, 1732, 1740, 1748, 1756, 1764, 1772, 1780, 1788, 1796, 1661, 1669, 1677, 1685, 1693, 1701, 1709, 1717, 1725, 1733, 1741, 1749, 1757, 1765, 1773, 1781, 1789, 1797, 1662, 1670, 1678, 1686, 
        1694, 1702, 1710, 1718, 1726, 1734, 1742, 1750, 1758, 1766, 1774, 1782, 1790, 1798, 1663, 1671, 1679, 1687, 1695, 1703, 1711, 1719, 1727, 1735, 1743, 1751, 1759, 1767, 1775, 1783, 1791, 1799, 1836, 1844, 1852, 1860, 1868, 1876, 1884, 1892, 1900, 1908, 1916, 1924, 1932, 1940, 1948, 1956, 1964, 1972, 1837, 1845, 1853, 1861, 1869, 1877, 1885, 1893, 1901, 1909, 1917, 1925, 1933, 1941, 
        1949, 1957, 1965, 1973, 1838, 1846, 1854, 1862, 1870, 1878, 1886, 1894, 1902, 1910, 1918, 1926, 1934, 1942, 1950, 1958, 1966, 1974, 1839, 1847, 1855, 1863, 1871, 1879, 1887, 1895, 1903, 1911, 1919, 1927, 1935, 1943, 1951, 1959, 1967, 1975, 1840, 1848, 1856, 1864, 1872, 1880, 1888, 1896, 1904, 1912, 1920, 1928, 1936, 1944, 1952, 1960, 1968, 1976, 1841, 1849, 1857, 1865, 1873, 1881, 
        1889, 1897, 1905, 1913, 1921, 1929, 1937, 1945, 1953, 1961, 1969, 1977, 1842, 1850, 1858, 1866, 1874, 1882, 1890, 1898, 1906, 1914, 1922, 1930, 1938, 1946, 1954, 1962, 1970, 1978, 1843, 1851, 1859, 1867, 1875, 1883, 1891, 1899, 1907, 1915, 1923, 1931, 1939, 1947, 1955, 1963, 1971, 1979, 2016, 2024, 2032, 2040, 2048, 2056, 2064, 2072, 2080, 2088, 2096, 2104, 2112, 2120, 2128, 2136, 
        2144, 2152, 2017, 2025, 2033, 2041, 2049, 2057, 2065, 2073, 2081, 2089, 2097, 2105, 2113, 2121, 2129, 2137, 2145, 2153, 2018, 2026, 2034, 2042, 2050, 2058, 2066, 2074, 2082, 2090, 2098, 2106, 2114, 2122, 2130, 2138, 2146, 2154, 2019, 2027, 2035, 2043, 2051, 2059, 2067, 2075, 2083, 2091, 2099, 2107, 2115, 2123, 2131, 2139, 2147, 2155, 2020, 2028, 2036, 2044, 2052, 2060, 2068, 2076, 
        2084, 2092, 2100, 2108, 2116, 2124, 2132, 2140, 2148, 2156, 2021, 2029, 2037, 2045, 2053, 2061, 2069, 2077, 2085, 2093, 2101, 2109, 2117, 2125, 2133, 2141, 2149, 2157, 2022, 2030, 2038, 2046, 2054, 2062, 2070, 2078, 2086, 2094, 2102, 2110, 2118, 2126, 2134, 2142, 2150, 2158, 2023, 2031, 2039, 2047, 2055, 2063, 2071, 2079, 2087, 2095, 2103, 2111, 2119, 2127, 2135, 2143, 2151, 2159, 
        2196, 2204, 2212, 2220, 2228, 2236, 2244, 2252, 2260, 2268, 2276, 2284, 2292, 2300, 2308, 2316, 2324, 2332, 2197, 2205, 2213, 2221, 2229, 2237, 2245, 2253, 2261, 2269, 2277, 2285, 2293, 2301, 2309, 2317, 2325, 2333, 2198, 2206, 2214, 2222, 2230, 2238, 2246, 2254, 2262, 2270, 2278, 2286, 2294, 2302, 2310, 2318, 2326, 2334, 2199, 2207, 2215, 2223, 2231, 2239, 2247, 2255, 2263, 2271, 
        2279, 2287, 2295, 2303, 2311, 2319, 2327, 2335, 2200, 2208, 2216, 2224, 2232, 2240, 2248, 2256, 2264, 2272, 2280, 2288, 2296, 2304, 2312, 2320, 2328, 2336, 2201, 2209, 2217, 2225, 2233, 2241, 2249, 2257, 2265, 2273, 2281, 2289, 2297, 2305, 2313, 2321, 2329, 2337, 2202, 2210, 2218, 2226, 2234, 2242, 2250, 2258, 2266, 2274, 2282, 2290, 2298, 2306, 2314, 2322, 2330, 2338, 2203, 2211, 
        2219, 2227, 2235, 2243, 2251, 2259, 2267, 2275, 2283, 2291, 2299, 2307, 2315, 2323, 2331, 2339, 2376, 2384, 2392, 2400, 2408, 2416, 2424, 2432, 2440, 2448, 2456, 2464, 2472, 2480, 2488, 2496, 2504, 2512, 2377, 2385, 2393, 2401, 2409, 2417, 2425, 2433, 2441, 2449, 2457, 2465, 2473, 2481, 2489, 2497, 2505, 2513, 2378, 2386, 2394, 2402, 2410, 2418, 2426, 2434, 2442, 2450, 2458, 2466, 
        2474, 2482, 2490, 2498, 2506, 2514, 2379, 2387, 2395, 2403, 2411, 2419, 2427, 2435, 2443, 2451, 2459, 2467, 2475, 2483, 2491, 2499, 2507, 2515, 2380, 2388, 2396, 2404, 2412, 2420, 2428, 2436, 2444, 2452, 2460, 2468, 2476, 2484, 2492, 2500, 2508, 2516, 2381, 2389, 2397, 2405, 2413, 2421, 2429, 2437, 2445, 2453, 2461, 2469, 2477, 2485, 2493, 2501, 2509, 2517, 2382, 2390, 2398, 2406, 
        2414, 2422, 2430, 2438, 2446, 2454, 2462, 2470, 2478, 2486, 2494, 2502, 2510, 2518, 2383, 2391, 2399, 2407, 2415, 2423, 2431, 2439, 2447, 2455, 2463, 2471, 2479, 2487, 2495, 2503, 2511, 2519, 2556, 2564, 2572, 2580, 2588, 2596, 2604, 2612, 2620, 2628, 2636, 2644, 2652, 2660, 2668, 2676, 2684, 2692, 2557, 2565, 2573, 2581, 2589, 2597, 2605, 2613, 2621, 2629, 2637, 2645, 2653, 2661, 
        2669, 2677, 2685, 2693, 2558, 2566, 2574, 2582, 2590, 2598, 2606, 2614, 2622, 2630, 2638, 2646, 2654, 2662, 2670, 2678, 2686, 2694, 2559, 2567, 2575, 2583, 2591, 2599, 2607, 2615, 2623, 2631, 2639, 2647, 2655, 2663, 2671, 2679, 2687, 2695, 2560, 2568, 2576, 2584, 2592, 2600, 2608, 2616, 2624, 2632, 2640, 2648, 2656, 2664, 2672, 2680, 2688, 2696, 2561, 2569, 2577, 2585, 2593, 2601, 
        2609, 2617, 2625, 2633, 2641, 2649, 2657, 2665, 2673, 2681, 2689, 2697, 2562, 2570, 2578, 2586, 2594, 2602, 2610, 2618, 2626, 2634, 2642, 2650, 2658, 2666, 2674, 2682, 2690, 2698, 2563, 2571, 2579, 2587, 2595, 2603, 2611, 2619, 2627, 2635, 2643, 2651, 2659, 2667, 2675, 2683, 2691, 2699, 2736, 2744, 2752, 2760, 2768, 2776, 2784, 2792, 2800, 2808, 2816, 2824, 2832, 2840, 2848, 2856, 
        2864, 2872, 2737, 2745, 2753, 2761, 2769, 2777, 2785, 2793, 2801, 2809, 2817, 2825, 2833, 2841, 2849, 2857, 2865, 2873, 2738, 2746, 2754, 2762, 2770, 2778, 2786, 2794, 2802, 2810, 2818, 2826, 2834, 2842, 2850, 2858, 2866, 2874, 2739, 2747, 2755, 2763, 2771, 2779, 2787, 2795, 2803, 2811, 2819, 2827, 2835, 2843, 2851, 2859, 2867, 2875, 2740, 2748, 2756, 2764, 2772, 2780, 2788, 2796, 
        2804, 2812, 2820, 2828, 2836, 2844, 2852, 2860, 2868, 2876, 2741, 2749, 2757, 2765, 2773, 2781, 2789, 2797, 2805, 2813, 2821, 2829, 2837, 2845, 2853, 2861, 2869, 2877, 2742, 2750, 2758, 2766, 2774, 2782, 2790, 2798, 2806, 2814, 2822, 2830, 2838, 2846, 2854, 2862, 2870, 2878, 2743, 2751, 2759, 2767, 2775, 2783, 2791, 2799, 2807, 2815, 2823, 2831, 2839, 2847, 2855, 2863, 2871, 2879, 
        2916, 2924, 2932, 2940, 2948, 2956, 2964, 2972, 2980, 2988, 2996, 3004, 3012, 3020, 3028, 3036, 3044, 3052, 2917, 2925, 2933, 2941, 2949, 2957, 2965, 2973, 2981, 2989, 2997, 3005, 3013, 3021, 3029, 3037, 3045, 3053, 2918, 2926, 2934, 2942, 2950, 2958, 2966, 2974, 2982, 2990, 2998, 3006, 3014, 3022, 3030, 3038, 3046, 3054, 2919, 2927, 2935, 2943, 2951, 2959, 2967, 2975, 2983, 2991, 
        2999, 3007, 3015, 3023, 3031, 3039, 3047, 3055, 2920, 2928, 2936, 2944, 2952, 2960, 2968, 2976, 2984, 2992, 3000, 3008, 3016, 3024, 3032, 3040, 3048, 3056, 2921, 2929, 2937, 2945, 2953, 2961, 2969, 2977, 2985, 2993, 3001, 3009, 3017, 3025, 3033, 3041, 3049, 3057, 2922, 2930, 2938, 2946, 2954, 2962, 2970, 2978, 2986, 2994, 3002, 3010, 3018, 3026, 3034, 3042, 3050, 3058, 2923, 2931, 
        2939, 2947, 2955, 2963, 2971, 2979, 2987, 2995, 3003, 3011, 3019, 3027, 3035, 3043, 3051, 3059, 3096, 3104, 3112, 3120, 3128, 3136, 3144, 3152, 3160, 3168, 3176, 3184, 3192, 3200, 3208, 3216, 3224, 3232, 3097, 3105, 3113, 3121, 3129, 3137, 3145, 3153, 3161, 3169, 3177, 3185, 3193, 3201, 3209, 3217, 3225, 3233, 3098, 3106, 3114, 3122, 3130, 3138, 3146, 3154, 3162, 3170, 3178, 3186, 
        3194, 3202, 3210, 3218, 3226, 3234, 3099, 3107, 3115, 3123, 3131, 3139, 3147, 3155, 3163, 3171, 3179, 3187, 3195, 3203, 3211, 3219, 3227, 3235, 3100, 3108, 3116, 3124, 3132, 3140, 3148, 3156, 3164, 3172, 3180, 3188, 3196, 3204, 3212, 3220, 3228, 3236, 3101, 3109, 3117, 3125, 3133, 3141, 3149, 3157, 3165, 3173, 3181, 3189, 3197, 3205, 3213, 3221, 3229, 3237, 3102, 3110, 3118, 3126, 
        3134, 3142, 3150, 3158, 3166, 3174, 3182, 3190, 3198, 3206, 3214, 3222, 3230, 3238, 3103, 3111, 3119, 3127, 3135, 3143, 3151, 3159, 3167, 3175, 3183, 3191, 3199, 3207, 3215, 3223, 3231, 3239, 3276, 3284, 3292, 3300, 3308, 3316, 3324, 3332, 3340, 3348, 3356, 3364, 3372, 3380, 3388, 3396, 3404, 3412, 3277, 3285, 3293, 3301, 3309, 3317, 3325, 3333, 3341, 3349, 3357, 3365, 3373, 3381, 
        3389, 3397, 3405, 3413, 3278, 3286, 3294, 3302, 3310, 3318, 3326, 3334, 3342, 3350, 3358, 3366, 3374, 3382, 3390, 3398, 3406, 3414, 3279, 3287, 3295, 3303, 3311, 3319, 3327, 3335, 3343, 3351, 3359, 3367, 3375, 3383, 3391, 3399, 3407, 3415, 3280, 3288, 3296, 3304, 3312, 3320, 3328, 3336, 3344, 3352, 3360, 3368, 3376, 3384, 3392, 3400, 3408, 3416, 3281, 3289, 3297, 3305, 3313, 3321, 
        3329, 3337, 3345, 3353, 3361, 3369, 3377, 3385, 3393, 3401, 3409, 3417, 3282, 3290, 3298, 3306, 3314, 3322, 3330, 3338, 3346, 3354, 3362, 3370, 3378, 3386, 3394, 3402, 3410, 3418, 3283, 3291, 3299, 3307, 3315, 3323, 3331, 3339, 3347, 3355, 3363, 3371, 3379, 3387, 3395, 3403, 3411, 3419, 3456, 3464, 3472, 3480, 3488, 3496, 3504, 3512, 3520, 3528, 3536, 3544, 3552, 3560, 3568, 3576, 
        3584, 3592, 3457, 3465, 3473, 3481, 3489, 3497, 3505, 3513, 3521, 3529, 3537, 3545, 3553, 3561, 3569, 3577, 3585, 3593, 3458, 3466, 3474, 3482, 3490, 3498, 3506, 3514, 3522, 3530, 3538, 3546, 3554, 3562, 3570, 3578, 3586, 3594, 3459, 3467, 3475, 3483, 3491, 3499, 3507, 3515, 3523, 3531, 3539, 3547, 3555, 3563, 3571, 3579, 3587, 3595, 3460, 3468, 3476, 3484, 3492, 3500, 3508, 3516, 
        3524, 3532, 3540, 3548, 3556, 3564, 3572, 3580, 3588, 3596, 3461, 3469, 3477, 3485, 3493, 3501, 3509, 3517, 3525, 3533, 3541, 3549, 3557, 3565, 3573, 3581, 3589, 3597, 3462, 3470, 3478, 3486, 3494, 3502, 3510, 3518, 3526, 3534, 3542, 3550, 3558, 3566, 3574, 3582, 3590, 3598, 3463, 3471, 3479, 3487, 3495, 3503, 3511, 3519, 3527, 3535, 3543, 3551, 3559, 3567, 3575, 3583, 3591, 3599, 
        3636, 3644, 3652, 3660, 3668, 3676, 3684, 3692, 3700, 3708, 3716, 3724, 3732, 3740, 3748, 3756, 3764, 3772, 3637, 3645, 3653, 3661, 3669, 3677, 3685, 3693, 3701, 3709, 3717, 3725, 3733, 3741, 3749, 3757, 3765, 3773, 3638, 3646, 3654, 3662, 3670, 3678, 3686, 3694, 3702, 3710, 3718, 3726, 3734, 3742, 3750, 3758, 3766, 3774, 3639, 3647, 3655, 3663, 3671, 3679, 3687, 3695, 3703, 3711, 
        3719, 3727, 3735, 3743, 3751, 3759, 3767, 3775, 3640, 3648, 3656, 3664, 3672, 3680, 3688, 3696, 3704, 3712, 3720, 3728, 3736, 3744, 3752, 3760, 3768, 3776, 3641, 3649, 3657, 3665, 3673, 3681, 3689, 3697, 3705, 3713, 3721, 3729, 3737, 3745, 3753, 3761, 3769, 3777, 3642, 3650, 3658, 3666, 3674, 3682, 3690, 3698, 3706, 3714, 3722, 3730, 3738, 3746, 3754, 3762, 3770, 3778, 3643, 3651, 
        3659, 3667, 3675, 3683, 3691, 3699, 3707, 3715, 3723, 3731, 3739, 3747, 3755, 3763, 3771, 3779, 3816, 3824, 3832, 3840, 3848, 3856, 3864, 3872, 3880, 3888, 3896, 3904, 3912, 3920, 3928, 3936, 3944, 3952, 3817, 3825, 3833, 3841, 3849, 3857, 3865, 3873, 3881, 3889, 3897, 3905, 3913, 3921, 3929, 3937, 3945, 3953, 3818, 3826, 3834, 3842, 3850, 3858, 3866, 3874, 3882, 3890, 3898, 3906, 
        3914, 3922, 3930, 3938, 3946, 3954, 3819, 3827, 3835, 3843, 3851, 3859, 3867, 3875, 3883, 3891, 3899, 3907, 3915, 3923, 3931, 3939, 3947, 3955, 3820, 3828, 3836, 3844, 3852, 3860, 3868, 3876, 3884, 3892, 3900, 3908, 3916, 3924, 3932, 3940, 3948, 3956, 3821, 3829, 3837, 3845, 3853, 3861, 3869, 3877, 3885, 3893, 3901, 3909, 3917, 3925, 3933, 3941, 3949, 3957, 3822, 3830, 3838, 3846, 
        3854, 3862, 3870, 3878, 3886, 3894, 3902, 3910, 3918, 3926, 3934, 3942, 3950, 3958, 3823, 3831, 3839, 3847, 3855, 3863, 3871, 3879, 3887, 3895, 3903, 3911, 3919, 3927, 3935, 3943, 3951, 3959, 3996, 4004, 4012, 4020, 4028, 4036, 4044, 4052, 4060, 4068, 4076, 4084, 4092, 4100, 4108, 4116, 4124, 4132, 3997, 4005, 4013, 4021, 4029, 4037, 4045, 4053, 4061, 4069, 4077, 4085, 4093, 4101, 
        4109, 4117, 4125, 4133, 3998, 4006, 4014, 4022, 4030, 4038, 4046, 4054, 4062, 4070, 4078, 4086, 4094, 4102, 4110, 4118, 4126, 4134, 3999, 4007, 4015, 4023, 4031, 4039, 4047, 4055, 4063, 4071, 4079, 4087, 4095, 4103, 4111, 4119, 4127, 4135, 4000, 4008, 4016, 4024, 4032, 4040, 4048, 4056, 4064, 4072, 4080, 4088, 4096, 4104, 4112, 4120, 4128, 4136, 4001, 4009, 4017, 4025, 4033, 4041, 
        4049, 4057, 4065, 4073, 4081, 4089, 4097, 4105, 4113, 4121, 4129, 4137, 4002, 4010, 4018, 4026, 4034, 4042, 4050, 4058, 4066, 4074, 4082, 4090, 4098, 4106, 4114, 4122, 4130, 4138, 4003, 4011, 4019, 4027, 4035, 4043, 4051, 4059, 4067, 4075, 4083, 4091, 4099, 4107, 4115, 4123, 4131, 4139, 4176, 4184, 4192, 4200, 4208, 4216, 4224, 4232, 4240, 4248, 4256, 4264, 4272, 4280, 4288, 4296, 
        4304, 4312, 4177, 4185, 4193, 4201, 4209, 4217, 4225, 4233, 4241, 4249, 4257, 4265, 4273, 4281, 4289, 4297, 4305, 4313, 4178, 4186, 4194, 4202, 4210, 4218, 4226, 4234, 4242, 4250, 4258, 4266, 4274, 4282, 4290, 4298, 4306, 4314, 4179, 4187, 4195, 4203, 4211, 4219, 4227, 4235, 4243, 4251, 4259, 4267, 4275, 4283, 4291, 4299, 4307, 4315, 4180, 4188, 4196, 4204, 4212, 4220, 4228, 4236, 
        4244, 4252, 4260, 4268, 4276, 4284, 4292, 4300, 4308, 4316, 4181, 4189, 4197, 4205, 4213, 4221, 4229, 4237, 4245, 4253, 4261, 4269, 4277, 4285, 4293, 4301, 4309, 4317, 4182, 4190, 4198, 4206, 4214, 4222, 4230, 4238, 4246, 4254, 4262, 4270, 4278, 4286, 4294, 4302, 4310, 4318, 4183, 4191, 4199, 4207, 4215, 4223, 4231, 4239, 4247, 4255, 4263, 4271, 4279, 4287, 4295, 4303, 4311, 4319, 
        4356, 4364, 4372, 4380, 4388, 4396, 4404, 4412, 4420, 4428, 4436, 4444, 4452, 4460, 4468, 4476, 4484, 4492, 4357, 4365, 4373, 4381, 4389, 4397, 4405, 4413, 4421, 4429, 4437, 4445, 4453, 4461, 4469, 4477, 4485, 4493, 4358, 4366, 4374, 4382, 4390, 4398, 4406, 4414, 4422, 4430, 4438, 4446, 4454, 4462, 4470, 4478, 4486, 4494, 4359, 4367, 4375, 4383, 4391, 4399, 4407, 4415, 4423, 4431, 
        4439, 4447, 4455, 4463, 4471, 4479, 4487, 4495, 4360, 4368, 4376, 4384, 4392, 4400, 4408, 4416, 4424, 4432, 4440, 4448, 4456, 4464, 4472, 4480, 4488, 4496, 4361, 4369, 4377, 4385, 4393, 4401, 4409, 4417, 4425, 4433, 4441, 4449, 4457, 4465, 4473, 4481, 4489, 4497, 4362, 4370, 4378, 4386, 4394, 4402, 4410, 4418, 4426, 4434, 4442, 4450, 4458, 4466, 4474, 4482, 4490, 4498, 4363, 4371, 
        4379, 4387, 4395, 4403, 4411, 4419, 4427, 4435, 4443, 4451, 4459, 4467, 4475, 4483, 4491, 4499, 4536, 4544, 4552, 4560, 4568, 4576, 4584, 4592, 4600, 4608, 4616, 4624, 4632, 4640, 4648, 4656, 4664, 4672, 4537, 4545, 4553, 4561, 4569, 4577, 4585, 4593, 4601, 4609, 4617, 4625, 4633, 4641, 4649, 4657, 4665, 4673, 4538, 4546, 4554, 4562, 4570, 4578, 4586, 4594, 4602, 4610, 4618, 4626, 
        4634, 4642, 4650, 4658, 4666, 4674, 4539, 4547, 4555, 4563, 4571, 4579, 4587, 4595, 4603, 4611, 4619, 4627, 4635, 4643, 4651, 4659, 4667, 4675, 4540, 4548, 4556, 4564, 4572, 4580, 4588, 4596, 4604, 4612, 4620, 4628, 4636, 4644, 4652, 4660, 4668, 4676, 4541, 4549, 4557, 4565, 4573, 4581, 4589, 4597, 4605, 4613, 4621, 4629, 4637, 4645, 4653, 4661, 4669, 4677, 4542, 4550, 4558, 4566, 
        4574, 4582, 4590, 4598, 4606, 4614, 4622, 4630, 4638, 4646, 4654, 4662, 4670, 4678, 4543, 4551, 4559, 4567, 4575, 4583, 4591, 4599, 4607, 4615, 4623, 4631, 4639, 4647, 4655, 4663, 4671, 4679, 4716, 4724, 4732, 4740, 4748, 4756, 4764, 4772, 4780, 4788, 4796, 4804, 4812, 4820, 4828, 4836, 4844, 4852, 4717, 4725, 4733, 4741, 4749, 4757, 4765, 4773, 4781, 4789, 4797, 4805, 4813, 4821, 
        4829, 4837, 4845, 4853, 4718, 4726, 4734, 4742, 4750, 4758, 4766, 4774, 4782, 4790, 4798, 4806, 4814, 4822, 4830, 4838, 4846, 4854, 4719, 4727, 4735, 4743, 4751, 4759, 4767, 4775, 4783, 4791, 4799, 4807, 4815, 4823, 4831, 4839, 4847, 4855, 4720, 4728, 4736, 4744, 4752, 4760, 4768, 4776, 4784, 4792, 4800, 4808, 4816, 4824, 4832, 4840, 4848, 4856, 4721, 4729, 4737, 4745, 4753, 4761, 
        4769, 4777, 4785, 4793, 4801, 4809, 4817, 4825, 4833, 4841, 4849, 4857, 4722, 4730, 4738, 4746, 4754, 4762, 4770, 4778, 4786, 4794, 4802, 4810, 4818, 4826, 4834, 4842, 4850, 4858, 4723, 4731, 4739, 4747, 4755, 4763, 4771, 4779, 4787, 4795, 4803, 4811, 4819, 4827, 4835, 4843, 4851, 4859, 4896, 4904, 4912, 4920, 4928, 4936, 4944, 4952, 4960, 4968, 4976, 4984, 4992, 5000, 5008, 5016, 
        5024, 5032, 4897, 4905, 4913, 4921, 4929, 4937, 4945, 4953, 4961, 4969, 4977, 4985, 4993, 5001, 5009, 5017, 5025, 5033, 4898, 4906, 4914, 4922, 4930, 4938, 4946, 4954, 4962, 4970, 4978, 4986, 4994, 5002, 5010, 5018, 5026, 5034, 4899, 4907, 4915, 4923, 4931, 4939, 4947, 4955, 4963, 4971, 4979, 4987, 4995, 5003, 5011, 5019, 5027, 5035, 4900, 4908, 4916, 4924, 4932, 4940, 4948, 4956, 
        4964, 4972, 4980, 4988, 4996, 5004, 5012, 5020, 5028, 5036, 4901, 4909, 4917, 4925, 4933, 4941, 4949, 4957, 4965, 4973, 4981, 4989, 4997, 5005, 5013, 5021, 5029, 5037, 4902, 4910, 4918, 4926, 4934, 4942, 4950, 4958, 4966, 4974, 4982, 4990, 4998, 5006, 5014, 5022, 5030, 5038, 4903, 4911, 4919, 4927, 4935, 4943, 4951, 4959, 4967, 4975, 4983, 4991, 4999, 5007, 5015, 5023, 5031, 5039, 
        5076, 5084, 5092, 5100, 5108, 5116, 5124, 5132, 5140, 5148, 5156, 5164, 5172, 5180, 5188, 5196, 5204, 5212, 5077, 5085, 5093, 5101, 5109, 5117, 5125, 5133, 5141, 5149, 5157, 5165, 5173, 5181, 5189, 5197, 5205, 5213, 5078, 5086, 5094, 5102, 5110, 5118, 5126, 5134, 5142, 5150, 5158, 5166, 5174, 5182, 5190, 5198, 5206, 5214, 5079, 5087, 5095, 5103, 5111, 5119, 5127, 5135, 5143, 5151, 
        5159, 5167, 5175, 5183, 5191, 5199, 5207, 5215, 5080, 5088, 5096, 5104, 5112, 5120, 5128, 5136, 5144, 5152, 5160, 5168, 5176, 5184, 5192, 5200, 5208, 5216, 5081, 5089, 5097, 5105, 5113, 5121, 5129, 5137, 5145, 5153, 5161, 5169, 5177, 5185, 5193, 5201, 5209, 5217, 5082, 5090, 5098, 5106, 5114, 5122, 5130, 5138, 5146, 5154, 5162, 5170, 5178, 5186, 5194, 5202, 5210, 5218, 5083, 5091, 
        5099, 5107, 5115, 5123, 5131, 5139, 5147, 5155, 5163, 5171, 5179, 5187, 5195, 5203, 5211, 5219, 5256, 5264, 5272, 5280, 5288, 5296, 5304, 5312, 5320, 5328, 5336, 5344, 5352, 5360, 5368, 5376, 5384, 5392, 5257, 5265, 5273, 5281, 5289, 5297, 5305, 5313, 5321, 5329, 5337, 5345, 5353, 5361, 5369, 5377, 5385, 5393, 5258, 5266, 5274, 5282, 5290, 5298, 5306, 5314, 5322, 5330, 5338, 5346, 
        5354, 5362, 5370, 5378, 5386, 5394, 5259, 5267, 5275, 5283, 5291, 5299, 5307, 5315, 5323, 5331, 5339, 5347, 5355, 5363, 5371, 5379, 5387, 5395, 5260, 5268, 5276, 5284, 5292, 5300, 5308, 5316, 5324, 5332, 5340, 5348, 5356, 5364, 5372, 5380, 5388, 5396, 5261, 5269, 5277, 5285, 5293, 5301, 5309, 5317, 5325, 5333, 5341, 5349, 5357, 5365, 5373, 5381, 5389, 5397, 5262, 5270, 5278, 5286, 
        5294, 5302, 5310, 5318, 5326, 5334, 5342, 5350, 5358, 5366, 5374, 5382, 5390, 5398, 5263, 5271, 5279, 5287, 5295, 5303, 5311, 5319, 5327, 5335, 5343, 5351, 5359, 5367, 5375, 5383, 5391, 5399, 5436, 5444, 5452, 5460, 5468, 5476, 5484, 5492, 5500, 5508, 5516, 5524, 5532, 5540, 5548, 5556, 5564, 5572, 5437, 5445, 5453, 5461, 5469, 5477, 5485, 5493, 5501, 5509, 5517, 5525, 5533, 5541, 
        5549, 5557, 5565, 5573, 5438, 5446, 5454, 5462, 5470, 5478, 5486, 5494, 5502, 5510, 5518, 5526, 5534, 5542, 5550, 5558, 5566, 5574, 5439, 5447, 5455, 5463, 5471, 5479, 5487, 5495, 5503, 5511, 5519, 5527, 5535, 5543, 5551, 5559, 5567, 5575, 5440, 5448, 5456, 5464, 5472, 5480, 5488, 5496, 5504, 5512, 5520, 5528, 5536, 5544, 5552, 5560, 5568, 5576, 5441, 5449, 5457, 5465, 5473, 5481, 
        5489, 5497, 5505, 5513, 5521, 5529, 5537, 5545, 5553, 5561, 5569, 5577, 5442, 5450, 5458, 5466, 5474, 5482, 5490, 5498, 5506, 5514, 5522, 5530, 5538, 5546, 5554, 5562, 5570, 5578, 5443, 5451, 5459, 5467, 5475, 5483, 5491, 5499, 5507, 5515, 5523, 5531, 5539, 5547, 5555, 5563, 5571, 5579, 5616, 5624, 5632, 5640, 5648, 5656, 5664, 5672, 5680, 5688, 5696, 5704, 5712, 5720, 5728, 5736, 
        5744, 5752, 5617, 5625, 5633, 5641, 5649, 5657, 5665, 5673, 5681, 5689, 5697, 5705, 5713, 5721, 5729, 5737, 5745, 5753, 5618, 5626, 5634, 5642, 5650, 5658, 5666, 5674, 5682, 5690, 5698, 5706, 5714, 5722, 5730, 5738, 5746, 5754, 5619, 5627, 5635, 5643, 5651, 5659, 5667, 5675, 5683, 5691, 5699, 5707, 5715, 5723, 5731, 5739, 5747, 5755, 5620, 5628, 5636, 5644, 5652, 5660, 5668, 5676, 
        5684, 5692, 5700, 5708, 5716, 5724, 5732, 5740, 5748, 5756, 5621, 5629, 5637, 5645, 5653, 5661, 5669, 5677, 5685, 5693, 5701, 5709, 5717, 5725, 5733, 5741, 5749, 5757, 5622, 5630, 5638, 5646, 5654, 5662, 5670, 5678, 5686, 5694, 5702, 5710, 5718, 5726, 5734, 5742, 5750, 5758, 5623, 5631, 5639, 5647, 5655, 5663, 5671, 5679, 5687, 5695, 5703, 5711, 5719, 5727, 5735, 5743, 5751, 5759, 
        6516, 6524, 6532, 6540, 6548, 6556, 6564, 6572, 6580, 6588, 6596, 6604, 6612, 6620, 6628, 6636, 6644, 6652, 6517, 6525, 6533, 6541, 6549, 6557, 6565, 6573, 6581, 6589, 6597, 6605, 6613, 6621, 6629, 6637, 6645, 6653, 6518, 6526, 6534, 6542, 6550, 6558, 6566, 6574, 6582, 6590, 6598, 6606, 6614, 6622, 6630, 6638, 6646, 6654, 6519, 6527, 6535, 6543, 6551, 6559, 6567, 6575, 6583, 6591, 
        6599, 6607, 6615, 6623, 6631, 6639, 6647, 6655, 6520, 6528, 6536, 6544, 6552, 6560, 6568, 6576, 6584, 6592, 6600, 6608, 6616, 6624, 6632, 6640, 6648, 6656, 6521, 6529, 6537, 6545, 6553, 6561, 6569, 6577, 6585, 6593, 6601, 6609, 6617, 6625, 6633, 6641, 6649, 6657, 6522, 6530, 6538, 6546, 6554, 6562, 6570, 6578, 6586, 6594, 6602, 6610, 6618, 6626, 6634, 6642, 6650, 6658, 6523, 6531, 
        6539, 6547, 6555, 6563, 6571, 6579, 6587, 6595, 6603, 6611, 6619, 6627, 6635, 6643, 6651, 6659, 6696, 6704, 6712, 6720, 6728, 6736, 6744, 6752, 6760, 6768, 6776, 6784, 6792, 6800, 6808, 6816, 6824, 6832, 6697, 6705, 6713, 6721, 6729, 6737, 6745, 6753, 6761, 6769, 6777, 6785, 6793, 6801, 6809, 6817, 6825, 6833, 6698, 6706, 6714, 6722, 6730, 6738, 6746, 6754, 6762, 6770, 6778, 6786, 
        6794, 6802, 6810, 6818, 6826, 6834, 6699, 6707, 6715, 6723, 6731, 6739, 6747, 6755, 6763, 6771, 6779, 6787, 6795, 6803, 6811, 6819, 6827, 6835, 6700, 6708, 6716, 6724, 6732, 6740, 6748, 6756, 6764, 6772, 6780, 6788, 6796, 6804, 6812, 6820, 6828, 6836, 6701, 6709, 6717, 6725, 6733, 6741, 6749, 6757, 6765, 6773, 6781, 6789, 6797, 6805, 6813, 6821, 6829, 6837, 6702, 6710, 6718, 6726, 
        6734, 6742, 6750, 6758, 6766, 6774, 6782, 6790, 6798, 6806, 6814, 6822, 6830, 6838, 6703, 6711, 6719, 6727, 6735, 6743, 6751, 6759, 6767, 6775, 6783, 6791, 6799, 6807, 6815, 6823, 6831, 6839, 6876, 6884, 6892, 6900, 6908, 6916, 6924, 6932, 6940, 6948, 6956, 6964, 6972, 6980, 6988, 6996, 7004, 7012, 6877, 6885, 6893, 6901, 6909, 6917, 6925, 6933, 6941, 6949, 6957, 6965, 6973, 6981, 
        6989, 6997, 7005, 7013, 6878, 6886, 6894, 6902, 6910, 6918, 6926, 6934, 6942, 6950, 6958, 6966, 6974, 6982, 6990, 6998, 7006, 7014, 6879, 6887, 6895, 6903, 6911, 6919, 6927, 6935, 6943, 6951, 6959, 6967, 6975, 6983, 6991, 6999, 7007, 7015, 6880, 6888, 6896, 6904, 6912, 6920, 6928, 6936, 6944, 6952, 6960, 6968, 6976, 6984, 6992, 7000, 7008, 7016, 6881, 6889, 6897, 6905, 6913, 6921, 
        6929, 6937, 6945, 6953, 6961, 6969, 6977, 6985, 6993, 7001, 7009, 7017, 6882, 6890, 6898, 6906, 6914, 6922, 6930, 6938, 6946, 6954, 6962, 6970, 6978, 6986, 6994, 7002, 7010, 7018, 6883, 6891, 6899, 6907, 6915, 6923, 6931, 6939, 6947, 6955, 6963, 6971, 6979, 6987, 6995, 7003, 7011, 7019, 7056, 7064, 7072, 7080, 7088, 7096, 7104, 7112, 7120, 7128, 7136, 7144, 7152, 7160, 7168, 7176, 
        7184, 7192, 7057, 7065, 7073, 7081, 7089, 7097, 7105, 7113, 7121, 7129, 7137, 7145, 7153, 7161, 7169, 7177, 7185, 7193, 7058, 7066, 7074, 7082, 7090, 7098, 7106, 7114, 7122, 7130, 7138, 7146, 7154, 7162, 7170, 7178, 7186, 7194, 7059, 7067, 7075, 7083, 7091, 7099, 7107, 7115, 7123, 7131, 7139, 7147, 7155, 7163, 7171, 7179, 7187, 7195, 7060, 7068, 7076, 7084, 7092, 7100, 7108, 7116, 
        7124, 7132, 7140, 7148, 7156, 7164, 7172, 7180, 7188, 7196, 7061, 7069, 7077, 7085, 7093, 7101, 7109, 7117, 7125, 7133, 7141, 7149, 7157, 7165, 7173, 7181, 7189, 7197, 7062, 7070, 7078, 7086, 7094, 7102, 7110, 7118, 7126, 7134, 7142, 7150, 7158, 7166, 7174, 7182, 7190, 7198, 7063, 7071, 7079, 7087, 7095, 7103, 7111, 7119, 7127, 7135, 7143, 7151, 7159, 7167, 7175, 7183, 7191, 7199, 
        7236, 7244, 7252, 7260, 7268, 7276, 7284, 7292, 7300, 7308, 7316, 7324, 7332, 7340, 7348, 7356, 7364, 7372, 7237, 7245, 7253, 7261, 7269, 7277, 7285, 7293, 7301, 7309, 7317, 7325, 7333, 7341, 7349, 7357, 7365, 7373, 7238, 7246, 7254, 7262, 7270, 7278, 7286, 7294, 7302, 7310, 7318, 7326, 7334, 7342, 7350, 7358, 7366, 7374, 7239, 7247, 7255, 7263, 7271, 7279, 7287, 7295, 7303, 7311, 
        7319, 7327, 7335, 7343, 7351, 7359, 7367, 7375, 7240, 7248, 7256, 7264, 7272, 7280, 7288, 7296, 7304, 7312, 7320, 7328, 7336, 7344, 7352, 7360, 7368, 7376, 7241, 7249, 7257, 7265, 7273, 7281, 7289, 7297, 7305, 7313, 7321, 7329, 7337, 7345, 7353, 7361, 7369, 7377, 7242, 7250, 7258, 7266, 7274, 7282, 7290, 7298, 7306, 7314, 7322, 7330, 7338, 7346, 7354, 7362, 7370, 7378, 7243, 7251, 
        7259, 7267, 7275, 7283, 7291, 7299, 7307, 7315, 7323, 7331, 7339, 7347, 7355, 7363, 7371, 7379, 7416, 7424, 7432, 7440, 7448, 7456, 7464, 7472, 7480, 7488, 7496, 7504, 7512, 7520, 7528, 7536, 7544, 7552, 7417, 7425, 7433, 7441, 7449, 7457, 7465, 7473, 7481, 7489, 7497, 7505, 7513, 7521, 7529, 7537, 7545, 7553, 7418, 7426, 7434, 7442, 7450, 7458, 7466, 7474, 7482, 7490, 7498, 7506, 
        7514, 7522, 7530, 7538, 7546, 7554, 7419, 7427, 7435, 7443, 7451, 7459, 7467, 7475, 7483, 7491, 7499, 7507, 7515, 7523, 7531, 7539, 7547, 7555, 7420, 7428, 7436, 7444, 7452, 7460, 7468, 7476, 7484, 7492, 7500, 7508, 7516, 7524, 7532, 7540, 7548, 7556, 7421, 7429, 7437, 7445, 7453, 7461, 7469, 7477, 7485, 7493, 7501, 7509, 7517, 7525, 7533, 7541, 7549, 7557, 7422, 7430, 7438, 7446, 
        7454, 7462, 7470, 7478, 7486, 7494, 7502, 7510, 7518, 7526, 7534, 7542, 7550, 7558, 7423, 7431, 7439, 7447, 7455, 7463, 7471, 7479, 7487, 7495, 7503, 7511, 7519, 7527, 7535, 7543, 7551, 7559, 7596, 7604, 7612, 7620, 7628, 7636, 7644, 7652, 7660, 7668, 7676, 7684, 7692, 7700, 7708, 7716, 7724, 7732, 7597, 7605, 7613, 7621, 7629, 7637, 7645, 7653, 7661, 7669, 7677, 7685, 7693, 7701, 
        7709, 7717, 7725, 7733, 7598, 7606, 7614, 7622, 7630, 7638, 7646, 7654, 7662, 7670, 7678, 7686, 7694, 7702, 7710, 7718, 7726, 7734, 7599, 7607, 7615, 7623, 7631, 7639, 7647, 7655, 7663, 7671, 7679, 7687, 7695, 7703, 7711, 7719, 7727, 7735, 7600, 7608, 7616, 7624, 7632, 7640, 7648, 7656, 7664, 7672, 7680, 7688, 7696, 7704, 7712, 7720, 7728, 7736, 7601, 7609, 7617, 7625, 7633, 7641, 
        7649, 7657, 7665, 7673, 7681, 7689, 7697, 7705, 7713, 7721, 7729, 7737, 7602, 7610, 7618, 7626, 7634, 7642, 7650, 7658, 7666, 7674, 7682, 7690, 7698, 7706, 7714, 7722, 7730, 7738, 7603, 7611, 7619, 7627, 7635, 7643, 7651, 7659, 7667, 7675, 7683, 7691, 7699, 7707, 7715, 7723, 7731, 7739, 7776, 7784, 7792, 7800, 7808, 7816, 7824, 7832, 7840, 7848, 7856, 7864, 7872, 7880, 7888, 7896, 
        7904, 7912, 7777, 7785, 7793, 7801, 7809, 7817, 7825, 7833, 7841, 7849, 7857, 7865, 7873, 7881, 7889, 7897, 7905, 7913, 7778, 7786, 7794, 7802, 7810, 7818, 7826, 7834, 7842, 7850, 7858, 7866, 7874, 7882, 7890, 7898, 7906, 7914, 7779, 7787, 7795, 7803, 7811, 7819, 7827, 7835, 7843, 7851, 7859, 7867, 7875, 7883, 7891, 7899, 7907, 7915, 7780, 7788, 7796, 7804, 7812, 7820, 7828, 7836, 
        7844, 7852, 7860, 7868, 7876, 7884, 7892, 7900, 7908, 7916, 7781, 7789, 7797, 7805, 7813, 7821, 7829, 7837, 7845, 7853, 7861, 7869, 7877, 7885, 7893, 7901, 7909, 7917, 7782, 7790, 7798, 7806, 7814, 7822, 7830, 7838, 7846, 7854, 7862, 7870, 7878, 7886, 7894, 7902, 7910, 7918, 7783, 7791, 7799, 7807, 7815, 7823, 7831, 7839, 7847, 7855, 7863, 7871, 7879, 7887, 7895, 7903, 7911, 7919, 
        7956, 7964, 7972, 7980, 7988, 7996, 8004, 8012, 8020, 8028, 8036, 8044, 8052, 8060, 8068, 8076, 8084, 8092, 7957, 7965, 7973, 7981, 7989, 7997, 8005, 8013, 8021, 8029, 8037, 8045, 8053, 8061, 8069, 8077, 8085, 8093, 7958, 7966, 7974, 7982, 7990, 7998, 8006, 8014, 8022, 8030, 8038, 8046, 8054, 8062, 8070, 8078, 8086, 8094, 7959, 7967, 7975, 7983, 7991, 7999, 8007, 8015, 8023, 8031, 
        8039, 8047, 8055, 8063, 8071, 8079, 8087, 8095, 7960, 7968, 7976, 7984, 7992, 8000, 8008, 8016, 8024, 8032, 8040, 8048, 8056, 8064, 8072, 8080, 8088, 8096, 7961, 7969, 7977, 7985, 7993, 8001, 8009, 8017, 8025, 8033, 8041, 8049, 8057, 8065, 8073, 8081, 8089, 8097, 7962, 7970, 7978, 7986, 7994, 8002, 8010, 8018, 8026, 8034, 8042, 8050, 8058, 8066, 8074, 8082, 8090, 8098, 7963, 7971, 
        7979, 7987, 7995, 8003, 8011, 8019, 8027, 8035, 8043, 8051, 8059, 8067, 8075, 8083, 8091, 8099, 8136, 8144, 8152, 8160, 8168, 8176, 8184, 8192, 8200, 8208, 8216, 8224, 8232, 8240, 8248, 8256, 8264, 8272, 8137, 8145, 8153, 8161, 8169, 8177, 8185, 8193, 8201, 8209, 8217, 8225, 8233, 8241, 8249, 8257, 8265, 8273, 8138, 8146, 8154, 8162, 8170, 8178, 8186, 8194, 8202, 8210, 8218, 8226, 
        8234, 8242, 8250, 8258, 8266, 8274, 8139, 8147, 8155, 8163, 8171, 8179, 8187, 8195, 8203, 8211, 8219, 8227, 8235, 8243, 8251, 8259, 8267, 8275, 8140, 8148, 8156, 8164, 8172, 8180, 8188, 8196, 8204, 8212, 8220, 8228, 8236, 8244, 8252, 8260, 8268, 8276, 8141, 8149, 8157, 8165, 8173, 8181, 8189, 8197, 8205, 8213, 8221, 8229, 8237, 8245, 8253, 8261, 8269, 8277, 8142, 8150, 8158, 8166, 
        8174, 8182, 8190, 8198, 8206, 8214, 8222, 8230, 8238, 8246, 8254, 8262, 8270, 8278, 8143, 8151, 8159, 8167, 8175, 8183, 8191, 8199, 8207, 8215, 8223, 8231, 8239, 8247, 8255, 8263, 8271, 8279, 8316, 8324, 8332, 8340, 8348, 8356, 8364, 8372, 8380, 8388, 8396, 8404, 8412, 8420, 8428, 8436, 8444, 8452, 8317, 8325, 8333, 8341, 8349, 8357, 8365, 8373, 8381, 8389, 8397, 8405, 8413, 8421, 
        8429, 8437, 8445, 8453, 8318, 8326, 8334, 8342, 8350, 8358, 8366, 8374, 8382, 8390, 8398, 8406, 8414, 8422, 8430, 8438, 8446, 8454, 8319, 8327, 8335, 8343, 8351, 8359, 8367, 8375, 8383, 8391, 8399, 8407, 8415, 8423, 8431, 8439, 8447, 8455, 8320, 8328, 8336, 8344, 8352, 8360, 8368, 8376, 8384, 8392, 8400, 8408, 8416, 8424, 8432, 8440, 8448, 8456, 8321, 8329, 8337, 8345, 8353, 8361, 
        8369, 8377, 8385, 8393, 8401, 8409, 8417, 8425, 8433, 8441, 8449, 8457, 8322, 8330, 8338, 8346, 8354, 8362, 8370, 8378, 8386, 8394, 8402, 8410, 8418, 8426, 8434, 8442, 8450, 8458, 8323, 8331, 8339, 8347, 8355, 8363, 8371, 8379, 8387, 8395, 8403, 8411, 8419, 8427, 8435, 8443, 8451, 8459, 8496, 8504, 8512, 8520, 8528, 8536, 8544, 8552, 8560, 8568, 8576, 8584, 8592, 8600, 8608, 8616, 
        8624, 8632, 8497, 8505, 8513, 8521, 8529, 8537, 8545, 8553, 8561, 8569, 8577, 8585, 8593, 8601, 8609, 8617, 8625, 8633, 8498, 8506, 8514, 8522, 8530, 8538, 8546, 8554, 8562, 8570, 8578, 8586, 8594, 8602, 8610, 8618, 8626, 8634, 8499, 8507, 8515, 8523, 8531, 8539, 8547, 8555, 8563, 8571, 8579, 8587, 8595, 8603, 8611, 8619, 8627, 8635, 8500, 8508, 8516, 8524, 8532, 8540, 8548, 8556, 
        8564, 8572, 8580, 8588, 8596, 8604, 8612, 8620, 8628, 8636, 8501, 8509, 8517, 8525, 8533, 8541, 8549, 8557, 8565, 8573, 8581, 8589, 8597, 8605, 8613, 8621, 8629, 8637, 8502, 8510, 8518, 8526, 8534, 8542, 8550, 8558, 8566, 8574, 8582, 8590, 8598, 8606, 8614, 8622, 8630, 8638, 8503, 8511, 8519, 8527, 8535, 8543, 8551, 8559, 8567, 8575, 8583, 8591, 8599, 8607, 8615, 8623, 8631, 8639, 
        8676, 8684, 8692, 8700, 8708, 8716, 8724, 8732, 8740, 8748, 8756, 8764, 8772, 8780, 8788, 8796, 8804, 8812, 8677, 8685, 8693, 8701, 8709, 8717, 8725, 8733, 8741, 8749, 8757, 8765, 8773, 8781, 8789, 8797, 8805, 8813, 8678, 8686, 8694, 8702, 8710, 8718, 8726, 8734, 8742, 8750, 8758, 8766, 8774, 8782, 8790, 8798, 8806, 8814, 8679, 8687, 8695, 8703, 8711, 8719, 8727, 8735, 8743, 8751, 
        8759, 8767, 8775, 8783, 8791, 8799, 8807, 8815, 8680, 8688, 8696, 8704, 8712, 8720, 8728, 8736, 8744, 8752, 8760, 8768, 8776, 8784, 8792, 8800, 8808, 8816, 8681, 8689, 8697, 8705, 8713, 8721, 8729, 8737, 8745, 8753, 8761, 8769, 8777, 8785, 8793, 8801, 8809, 8817, 8682, 8690, 8698, 8706, 8714, 8722, 8730, 8738, 8746, 8754, 8762, 8770, 8778, 8786, 8794, 8802, 8810, 8818, 8683, 8691, 
        8699, 8707, 8715, 8723, 8731, 8739, 8747, 8755, 8763, 8771, 8779, 8787, 8795, 8803, 8811, 8819, 8856, 8864, 8872, 8880, 8888, 8896, 8904, 8912, 8920, 8928, 8936, 8944, 8952, 8960, 8968, 8976, 8984, 8992, 8857, 8865, 8873, 8881, 8889, 8897, 8905, 8913, 8921, 8929, 8937, 8945, 8953, 8961, 8969, 8977, 8985, 8993, 8858, 8866, 8874, 8882, 8890, 8898, 8906, 8914, 8922, 8930, 8938, 8946, 
        8954, 8962, 8970, 8978, 8986, 8994, 8859, 8867, 8875, 8883, 8891, 8899, 8907, 8915, 8923, 8931, 8939, 8947, 8955, 8963, 8971, 8979, 8987, 8995, 8860, 8868, 8876, 8884, 8892, 8900, 8908, 8916, 8924, 8932, 8940, 8948, 8956, 8964, 8972, 8980, 8988, 8996, 8861, 8869, 8877, 8885, 8893, 8901, 8909, 8917, 8925, 8933, 8941, 8949, 8957, 8965, 8973, 8981, 8989, 8997, 8862, 8870, 8878, 8886, 
        8894, 8902, 8910, 8918, 8926, 8934, 8942, 8950, 8958, 8966, 8974, 8982, 8990, 8998, 8863, 8871, 8879, 8887, 8895, 8903, 8911, 8919, 8927, 8935, 8943, 8951, 8959, 8967, 8975, 8983, 8991, 8999, 9036, 9044, 9052, 9060, 9068, 9076, 9084, 9092, 9100, 9108, 9116, 9124, 9132, 9140, 9148, 9156, 9164, 9172, 9037, 9045, 9053, 9061, 9069, 9077, 9085, 9093, 9101, 9109, 9117, 9125, 9133, 9141, 
        9149, 9157, 9165, 9173, 9038, 9046, 9054, 9062, 9070, 9078, 9086, 9094, 9102, 9110, 9118, 9126, 9134, 9142, 9150, 9158, 9166, 9174, 9039, 9047, 9055, 9063, 9071, 9079, 9087, 9095, 9103, 9111, 9119, 9127, 9135, 9143, 9151, 9159, 9167, 9175, 9040, 9048, 9056, 9064, 9072, 9080, 9088, 9096, 9104, 9112, 9120, 9128, 9136, 9144, 9152, 9160, 9168, 9176, 9041, 9049, 9057, 9065, 9073, 9081, 
        9089, 9097, 9105, 9113, 9121, 9129, 9137, 9145, 9153, 9161, 9169, 9177, 9042, 9050, 9058, 9066, 9074, 9082, 9090, 9098, 9106, 9114, 9122, 9130, 9138, 9146, 9154, 9162, 9170, 9178, 9043, 9051, 9059, 9067, 9075, 9083, 9091, 9099, 9107, 9115, 9123, 9131, 9139, 9147, 9155, 9163, 9171, 9179, 9216, 9224, 9232, 9240, 9248, 9256, 9264, 9272, 9280, 9288, 9296, 9304, 9312, 9320, 9328, 9336, 
        9344, 9352, 9217, 9225, 9233, 9241, 9249, 9257, 9265, 9273, 9281, 9289, 9297, 9305, 9313, 9321, 9329, 9337, 9345, 9353, 9218, 9226, 9234, 9242, 9250, 9258, 9266, 9274, 9282, 9290, 9298, 9306, 9314, 9322, 9330, 9338, 9346, 9354, 9219, 9227, 9235, 9243, 9251, 9259, 9267, 9275, 9283, 9291, 9299, 9307, 9315, 9323, 9331, 9339, 9347, 9355, 9220, 9228, 9236, 9244, 9252, 9260, 9268, 9276, 
        9284, 9292, 9300, 9308, 9316, 9324, 9332, 9340, 9348, 9356, 9221, 9229, 9237, 9245, 9253, 9261, 9269, 9277, 9285, 9293, 9301, 9309, 9317, 9325, 9333, 9341, 9349, 9357, 9222, 9230, 9238, 9246, 9254, 9262, 9270, 9278, 9286, 9294, 9302, 9310, 9318, 9326, 9334, 9342, 9350, 9358, 9223, 9231, 9239, 9247, 9255, 9263, 9271, 9279, 9287, 9295, 9303, 9311, 9319, 9327, 9335, 9343, 9351, 9359, 
        9396, 9404, 9412, 9420, 9428, 9436, 9444, 9452, 9460, 9468, 9476, 9484, 9492, 9500, 9508, 9516, 9524, 9532, 9397, 9405, 9413, 9421, 9429, 9437, 9445, 9453, 9461, 9469, 9477, 9485, 9493, 9501, 9509, 9517, 9525, 9533, 9398, 9406, 9414, 9422, 9430, 9438, 9446, 9454, 9462, 9470, 9478, 9486, 9494, 9502, 9510, 9518, 9526, 9534, 9399, 9407, 9415, 9423, 9431, 9439, 9447, 9455, 9463, 9471, 
        9479, 9487, 9495, 9503, 9511, 9519, 9527, 9535, 9400, 9408, 9416, 9424, 9432, 9440, 9448, 9456, 9464, 9472, 9480, 9488, 9496, 9504, 9512, 9520, 9528, 9536, 9401, 9409, 9417, 9425, 9433, 9441, 9449, 9457, 9465, 9473, 9481, 9489, 9497, 9505, 9513, 9521, 9529, 9537, 9402, 9410, 9418, 9426, 9434, 9442, 9450, 9458, 9466, 9474, 9482, 9490, 9498, 9506, 9514, 9522, 9530, 9538, 9403, 9411, 
        9419, 9427, 9435, 9443, 9451, 9459, 9467, 9475, 9483, 9491, 9499, 9507, 9515, 9523, 9531, 9539, 9576, 9584, 9592, 9600, 9608, 9616, 9624, 9632, 9640, 9648, 9656, 9664, 9672, 9680, 9688, 9696, 9704, 9712, 9577, 9585, 9593, 9601, 9609, 9617, 9625, 9633, 9641, 9649, 9657, 9665, 9673, 9681, 9689, 9697, 9705, 9713, 9578, 9586, 9594, 9602, 9610, 9618, 9626, 9634, 9642, 9650, 9658, 9666, 
        9674, 9682, 9690, 9698, 9706, 9714, 9579, 9587, 9595, 9603, 9611, 9619, 9627, 9635, 9643, 9651, 9659, 9667, 9675, 9683, 9691, 9699, 9707, 9715, 9580, 9588, 9596, 9604, 9612, 9620, 9628, 9636, 9644, 9652, 9660, 9668, 9676, 9684, 9692, 9700, 9708, 9716, 9581, 9589, 9597, 9605, 9613, 9621, 9629, 9637, 9645, 9653, 9661, 9669, 9677, 9685, 9693, 9701, 9709, 9717, 9582, 9590, 9598, 9606, 
        9614, 9622, 9630, 9638, 9646, 9654, 9662, 9670, 9678, 9686, 9694, 9702, 9710, 9718, 9583, 9591, 9599, 9607, 9615, 9623, 9631, 9639, 9647, 9655, 9663, 9671, 9679, 9687, 9695, 9703, 9711, 9719, 9756, 9764, 9772, 9780, 9788, 9796, 9804, 9812, 9820, 9828, 9836, 9844, 9852, 9860, 9868, 9876, 9884, 9892, 9757, 9765, 9773, 9781, 9789, 9797, 9805, 9813, 9821, 9829, 9837, 9845, 9853, 9861, 
        9869, 9877, 9885, 9893, 9758, 9766, 9774, 9782, 9790, 9798, 9806, 9814, 9822, 9830, 9838, 9846, 9854, 9862, 9870, 9878, 9886, 9894, 9759, 9767, 9775, 9783, 9791, 9799, 9807, 9815, 9823, 9831, 9839, 9847, 9855, 9863, 9871, 9879, 9887, 9895, 9760, 9768, 9776, 9784, 9792, 9800, 9808, 9816, 9824, 9832, 9840, 9848, 9856, 9864, 9872, 9880, 9888, 9896, 9761, 9769, 9777, 9785, 9793, 9801, 
        9809, 9817, 9825, 9833, 9841, 9849, 9857, 9865, 9873, 9881, 9889, 9897, 9762, 9770, 9778, 9786, 9794, 9802, 9810, 9818, 9826, 9834, 9842, 9850, 9858, 9866, 9874, 9882, 9890, 9898, 9763, 9771, 9779, 9787, 9795, 9803, 9811, 9819, 9827, 9835, 9843, 9851, 9859, 9867, 9875, 9883, 9891, 9899, 9936, 9944, 9952, 9960, 9968, 9976, 9984, 9992, 10000, 10008, 10016, 10024, 10032, 10040, 10048, 10056, 
        10064, 10072, 9937, 9945, 9953, 9961, 9969, 9977, 9985, 9993, 10001, 10009, 10017, 10025, 10033, 10041, 10049, 10057, 10065, 10073, 9938, 9946, 9954, 9962, 9970, 9978, 9986, 9994, 10002, 10010, 10018, 10026, 10034, 10042, 10050, 10058, 10066, 10074, 9939, 9947, 9955, 9963, 9971, 9979, 9987, 9995, 10003, 10011, 10019, 10027, 10035, 10043, 10051, 10059, 10067, 10075, 9940, 9948, 9956, 9964, 9972, 9980, 9988, 9996, 
        10004, 10012, 10020, 10028, 10036, 10044, 10052, 10060, 10068, 10076, 9941, 9949, 9957, 9965, 9973, 9981, 9989, 9997, 10005, 10013, 10021, 10029, 10037, 10045, 10053, 10061, 10069, 10077, 9942, 9950, 9958, 9966, 9974, 9982, 9990, 9998, 10006, 10014, 10022, 10030, 10038, 10046, 10054, 10062, 10070, 10078, 9943, 9951, 9959, 9967, 9975, 9983, 9991, 9999, 10007, 10015, 10023, 10031, 10039, 10047, 10055, 10063, 10071, 10079, 
        10116, 10124, 10132, 10140, 10148, 10156, 10164, 10172, 10180, 10188, 10196, 10204, 10212, 10220, 10228, 10236, 10244, 10252, 10117, 10125, 10133, 10141, 10149, 10157, 10165, 10173, 10181, 10189, 10197, 10205, 10213, 10221, 10229, 10237, 10245, 10253, 10118, 10126, 10134, 10142, 10150, 10158, 10166, 10174, 10182, 10190, 10198, 10206, 10214, 10222, 10230, 10238, 10246, 10254, 10119, 10127, 10135, 10143, 10151, 10159, 10167, 10175, 10183, 10191, 
        10199, 10207, 10215, 10223, 10231, 10239, 10247, 10255, 10120, 10128, 10136, 10144, 10152, 10160, 10168, 10176, 10184, 10192, 10200, 10208, 10216, 10224, 10232, 10240, 10248, 10256, 10121, 10129, 10137, 10145, 10153, 10161, 10169, 10177, 10185, 10193, 10201, 10209, 10217, 10225, 10233, 10241, 10249, 10257, 10122, 10130, 10138, 10146, 10154, 10162, 10170, 10178, 10186, 10194, 10202, 10210, 10218, 10226, 10234, 10242, 10250, 10258, 10123, 10131, 
        10139, 10147, 10155, 10163, 10171, 10179, 10187, 10195, 10203, 10211, 10219, 10227, 10235, 10243, 10251, 10259, 10296, 10304, 10312, 10320, 10328, 10336, 10344, 10352, 10360, 10368, 10376, 10384, 10392, 10400, 10408, 10416, 10424, 10432, 10297, 10305, 10313, 10321, 10329, 10337, 10345, 10353, 10361, 10369, 10377, 10385, 10393, 10401, 10409, 10417, 10425, 10433, 10298, 10306, 10314, 10322, 10330, 10338, 10346, 10354, 10362, 10370, 10378, 10386, 
        10394, 10402, 10410, 10418, 10426, 10434, 10299, 10307, 10315, 10323, 10331, 10339, 10347, 10355, 10363, 10371, 10379, 10387, 10395, 10403, 10411, 10419, 10427, 10435, 10300, 10308, 10316, 10324, 10332, 10340, 10348, 10356, 10364, 10372, 10380, 10388, 10396, 10404, 10412, 10420, 10428, 10436, 10301, 10309, 10317, 10325, 10333, 10341, 10349, 10357, 10365, 10373, 10381, 10389, 10397, 10405, 10413, 10421, 10429, 10437, 10302, 10310, 10318, 10326, 
        10334, 10342, 10350, 10358, 10366, 10374, 10382, 10390, 10398, 10406, 10414, 10422, 10430, 10438, 10303, 10311, 10319, 10327, 10335, 10343, 10351, 10359, 10367, 10375, 10383, 10391, 10399, 10407, 10415, 10423, 10431, 10439, 10476, 10484, 10492, 10500, 10508, 10516, 10524, 10532, 10540, 10548, 10556, 10564, 10572, 10580, 10588, 10596, 10604, 10612, 10477, 10485, 10493, 10501, 10509, 10517, 10525, 10533, 10541, 10549, 10557, 10565, 10573, 10581, 
        10589, 10597, 10605, 10613, 10478, 10486, 10494, 10502, 10510, 10518, 10526, 10534, 10542, 10550, 10558, 10566, 10574, 10582, 10590, 10598, 10606, 10614, 10479, 10487, 10495, 10503, 10511, 10519, 10527, 10535, 10543, 10551, 10559, 10567, 10575, 10583, 10591, 10599, 10607, 10615, 10480, 10488, 10496, 10504, 10512, 10520, 10528, 10536, 10544, 10552, 10560, 10568, 10576, 10584, 10592, 10600, 10608, 10616, 10481, 10489, 10497, 10505, 10513, 10521, 
        10529, 10537, 10545, 10553, 10561, 10569, 10577, 10585, 10593, 10601, 10609, 10617, 10482, 10490, 10498, 10506, 10514, 10522, 10530, 10538, 10546, 10554, 10562, 10570, 10578, 10586, 10594, 10602, 10610, 10618, 10483, 10491, 10499, 10507, 10515, 10523, 10531, 10539, 10547, 10555, 10563, 10571, 10579, 10587, 10595, 10603, 10611, 10619, 10656, 10664, 10672, 10680, 10688, 10696, 10704, 10712, 10720, 10728, 10736, 10744, 10752, 10760, 10768, 10776, 
        10784, 10792, 10657, 10665, 10673, 10681, 10689, 10697, 10705, 10713, 10721, 10729, 10737, 10745, 10753, 10761, 10769, 10777, 10785, 10793, 10658, 10666, 10674, 10682, 10690, 10698, 10706, 10714, 10722, 10730, 10738, 10746, 10754, 10762, 10770, 10778, 10786, 10794, 10659, 10667, 10675, 10683, 10691, 10699, 10707, 10715, 10723, 10731, 10739, 10747, 10755, 10763, 10771, 10779, 10787, 10795, 10660, 10668, 10676, 10684, 10692, 10700, 10708, 10716, 
        10724, 10732, 10740, 10748, 10756, 10764, 10772, 10780, 10788, 10796, 10661, 10669, 10677, 10685, 10693, 10701, 10709, 10717, 10725, 10733, 10741, 10749, 10757, 10765, 10773, 10781, 10789, 10797, 10662, 10670, 10678, 10686, 10694, 10702, 10710, 10718, 10726, 10734, 10742, 10750, 10758, 10766, 10774, 10782, 10790, 10798, 10663, 10671, 10679, 10687, 10695, 10703, 10711, 10719, 10727, 10735, 10743, 10751, 10759, 10767, 10775, 10783, 10791, 10799, 
        10836, 10844, 10852, 10860, 10868, 10876, 10884, 10892, 10900, 10908, 10916, 10924, 10932, 10940, 10948, 10956, 10964, 10972, 10837, 10845, 10853, 10861, 10869, 10877, 10885, 10893, 10901, 10909, 10917, 10925, 10933, 10941, 10949, 10957, 10965, 10973, 10838, 10846, 10854, 10862, 10870, 10878, 10886, 10894, 10902, 10910, 10918, 10926, 10934, 10942, 10950, 10958, 10966, 10974, 10839, 10847, 10855, 10863, 10871, 10879, 10887, 10895, 10903, 10911, 
        10919, 10927, 10935, 10943, 10951, 10959, 10967, 10975, 10840, 10848, 10856, 10864, 10872, 10880, 10888, 10896, 10904, 10912, 10920, 10928, 10936, 10944, 10952, 10960, 10968, 10976, 10841, 10849, 10857, 10865, 10873, 10881, 10889, 10897, 10905, 10913, 10921, 10929, 10937, 10945, 10953, 10961, 10969, 10977, 10842, 10850, 10858, 10866, 10874, 10882, 10890, 10898, 10906, 10914, 10922, 10930, 10938, 10946, 10954, 10962, 10970, 10978, 10843, 10851, 
        10859, 10867, 10875, 10883, 10891, 10899, 10907, 10915, 10923, 10931, 10939, 10947, 10955, 10963, 10971, 10979, 11016, 11024, 11032, 11040, 11048, 11056, 11064, 11072, 11080, 11088, 11096, 11104, 11112, 11120, 11128, 11136, 11144, 11152, 11017, 11025, 11033, 11041, 11049, 11057, 11065, 11073, 11081, 11089, 11097, 11105, 11113, 11121, 11129, 11137, 11145, 11153, 11018, 11026, 11034, 11042, 11050, 11058, 11066, 11074, 11082, 11090, 11098, 11106, 
        11114, 11122, 11130, 11138, 11146, 11154, 11019, 11027, 11035, 11043, 11051, 11059, 11067, 11075, 11083, 11091, 11099, 11107, 11115, 11123, 11131, 11139, 11147, 11155, 11020, 11028, 11036, 11044, 11052, 11060, 11068, 11076, 11084, 11092, 11100, 11108, 11116, 11124, 11132, 11140, 11148, 11156, 11021, 11029, 11037, 11045, 11053, 11061, 11069, 11077, 11085, 11093, 11101, 11109, 11117, 11125, 11133, 11141, 11149, 11157, 11022, 11030, 11038, 11046, 
        11054, 11062, 11070, 11078, 11086, 11094, 11102, 11110, 11118, 11126, 11134, 11142, 11150, 11158, 11023, 11031, 11039, 11047, 11055, 11063, 11071, 11079, 11087, 11095, 11103, 11111, 11119, 11127, 11135, 11143, 11151, 11159, 11196, 11204, 11212, 11220, 11228, 11236, 11244, 11252, 11260, 11268, 11276, 11284, 11292, 11300, 11308, 11316, 11324, 11332, 11197, 11205, 11213, 11221, 11229, 11237, 11245, 11253, 11261, 11269, 11277, 11285, 11293, 11301, 
        11309, 11317, 11325, 11333, 11198, 11206, 11214, 11222, 11230, 11238, 11246, 11254, 11262, 11270, 11278, 11286, 11294, 11302, 11310, 11318, 11326, 11334, 11199, 11207, 11215, 11223, 11231, 11239, 11247, 11255, 11263, 11271, 11279, 11287, 11295, 11303, 11311, 11319, 11327, 11335, 11200, 11208, 11216, 11224, 11232, 11240, 11248, 11256, 11264, 11272, 11280, 11288, 11296, 11304, 11312, 11320, 11328, 11336, 11201, 11209, 11217, 11225, 11233, 11241, 
        11249, 11257, 11265, 11273, 11281, 11289, 11297, 11305, 11313, 11321, 11329, 11337, 11202, 11210, 11218, 11226, 11234, 11242, 11250, 11258, 11266, 11274, 11282, 11290, 11298, 11306, 11314, 11322, 11330, 11338, 11203, 11211, 11219, 11227, 11235, 11243, 11251, 11259, 11267, 11275, 11283, 11291, 11299, 11307, 11315, 11323, 11331, 11339, 11376, 11384, 11392, 11400, 11408, 11416, 11424, 11432, 11440, 11448, 11456, 11464, 11472, 11480, 11488, 11496, 
        11504, 11512, 11377, 11385, 11393, 11401, 11409, 11417, 11425, 11433, 11441, 11449, 11457, 11465, 11473, 11481, 11489, 11497, 11505, 11513, 11378, 11386, 11394, 11402, 11410, 11418, 11426, 11434, 11442, 11450, 11458, 11466, 11474, 11482, 11490, 11498, 11506, 11514, 11379, 11387, 11395, 11403, 11411, 11419, 11427, 11435, 11443, 11451, 11459, 11467, 11475, 11483, 11491, 11499, 11507, 11515, 11380, 11388, 11396, 11404, 11412, 11420, 11428, 11436, 
        11444, 11452, 11460, 11468, 11476, 11484, 11492, 11500, 11508, 11516, 11381, 11389, 11397, 11405, 11413, 11421, 11429, 11437, 11445, 11453, 11461, 11469, 11477, 11485, 11493, 11501, 11509, 11517, 11382, 11390, 11398, 11406, 11414, 11422, 11430, 11438, 11446, 11454, 11462, 11470, 11478, 11486, 11494, 11502, 11510, 11518, 11383, 11391, 11399, 11407, 11415, 11423, 11431, 11439, 11447, 11455, 11463, 11471, 11479, 11487, 11495, 11503, 11511, 11519, 
        11556, 11564, 11572, 11580, 11588, 11596, 11604, 11612, 11620, 11628, 11636, 11644, 11652, 11660, 11668, 11676, 11684, 11692, 11557, 11565, 11573, 11581, 11589, 11597, 11605, 11613, 11621, 11629, 11637, 11645, 11653, 11661, 11669, 11677, 11685, 11693, 11558, 11566, 11574, 11582, 11590, 11598, 11606, 11614, 11622, 11630, 11638, 11646, 11654, 11662, 11670, 11678, 11686, 11694, 11559, 11567, 11575, 11583, 11591, 11599, 11607, 11615, 11623, 11631, 
        11639, 11647, 11655, 11663, 11671, 11679, 11687, 11695, 11560, 11568, 11576, 11584, 11592, 11600, 11608, 11616, 11624, 11632, 11640, 11648, 11656, 11664, 11672, 11680, 11688, 11696, 11561, 11569, 11577, 11585, 11593, 11601, 11609, 11617, 11625, 11633, 11641, 11649, 11657, 11665, 11673, 11681, 11689, 11697, 11562, 11570, 11578, 11586, 11594, 11602, 11610, 11618, 11626, 11634, 11642, 11650, 11658, 11666, 11674, 11682, 11690, 11698, 11563, 11571, 
        11579, 11587, 11595, 11603, 11611, 11619, 11627, 11635, 11643, 11651, 11659, 11667, 11675, 11683, 11691, 11699, 11736, 11744, 11752, 11760, 11768, 11776, 11784, 11792, 11800, 11808, 11816, 11824, 11832, 11840, 11848, 11856, 11864, 11872, 11737, 11745, 11753, 11761, 11769, 11777, 11785, 11793, 11801, 11809, 11817, 11825, 11833, 11841, 11849, 11857, 11865, 11873, 11738, 11746, 11754, 11762, 11770, 11778, 11786, 11794, 11802, 11810, 11818, 11826, 
        11834, 11842, 11850, 11858, 11866, 11874, 11739, 11747, 11755, 11763, 11771, 11779, 11787, 11795, 11803, 11811, 11819, 11827, 11835, 11843, 11851, 11859, 11867, 11875, 11740, 11748, 11756, 11764, 11772, 11780, 11788, 11796, 11804, 11812, 11820, 11828, 11836, 11844, 11852, 11860, 11868, 11876, 11741, 11749, 11757, 11765, 11773, 11781, 11789, 11797, 11805, 11813, 11821, 11829, 11837, 11845, 11853, 11861, 11869, 11877, 11742, 11750, 11758, 11766, 
        11774, 11782, 11790, 11798, 11806, 11814, 11822, 11830, 11838, 11846, 11854, 11862, 11870, 11878, 11743, 11751, 11759, 11767, 11775, 11783, 11791, 11799, 11807, 11815, 11823, 11831, 11839, 11847, 11855, 11863, 11871, 11879, 11916, 11924, 11932, 11940, 11948, 11956, 11964, 11972, 11980, 11988, 11996, 12004, 12012, 12020, 12028, 12036, 12044, 12052, 11917, 11925, 11933, 11941, 11949, 11957, 11965, 11973, 11981, 11989, 11997, 12005, 12013, 12021, 
        12029, 12037, 12045, 12053, 11918, 11926, 11934, 11942, 11950, 11958, 11966, 11974, 11982, 11990, 11998, 12006, 12014, 12022, 12030, 12038, 12046, 12054, 11919, 11927, 11935, 11943, 11951, 11959, 11967, 11975, 11983, 11991, 11999, 12007, 12015, 12023, 12031, 12039, 12047, 12055, 11920, 11928, 11936, 11944, 11952, 11960, 11968, 11976, 11984, 11992, 12000, 12008, 12016, 12024, 12032, 12040, 12048, 12056, 11921, 11929, 11937, 11945, 11953, 11961, 
        11969, 11977, 11985, 11993, 12001, 12009, 12017, 12025, 12033, 12041, 12049, 12057, 11922, 11930, 11938, 11946, 11954, 11962, 11970, 11978, 11986, 11994, 12002, 12010, 12018, 12026, 12034, 12042, 12050, 12058, 11923, 11931, 11939, 11947, 11955, 11963, 11971, 11979, 11987, 11995, 12003, 12011, 12019, 12027, 12035, 12043, 12051, 12059, 12096, 12104, 12112, 12120, 12128, 12136, 12144, 12152, 12160, 12168, 12176, 12184, 12192, 12200, 12208, 12216, 
        12224, 12232, 12097, 12105, 12113, 12121, 12129, 12137, 12145, 12153, 12161, 12169, 12177, 12185, 12193, 12201, 12209, 12217, 12225, 12233, 12098, 12106, 12114, 12122, 12130, 12138, 12146, 12154, 12162, 12170, 12178, 12186, 12194, 12202, 12210, 12218, 12226, 12234, 12099, 12107, 12115, 12123, 12131, 12139, 12147, 12155, 12163, 12171, 12179, 12187, 12195, 12203, 12211, 12219, 12227, 12235, 12100, 12108, 12116, 12124, 12132, 12140, 12148, 12156, 
        12164, 12172, 12180, 12188, 12196, 12204, 12212, 12220, 12228, 12236, 12101, 12109, 12117, 12125, 12133, 12141, 12149, 12157, 12165, 12173, 12181, 12189, 12197, 12205, 12213, 12221, 12229, 12237, 12102, 12110, 12118, 12126, 12134, 12142, 12150, 12158, 12166, 12174, 12182, 12190, 12198, 12206, 12214, 12222, 12230, 12238, 12103, 12111, 12119, 12127, 12135, 12143, 12151, 12159, 12167, 12175, 12183, 12191, 12199, 12207, 12215, 12223, 12231, 12239,
    ], # end INIT_VAL
}))


InstallTile(Tile('alta_io_E4_G5', 'IOTILE', columns=20, rows=68, slices=0, values={
    'ENA_REG_MODE':[300,380,540,740,860],
    'GCLKDMUX':[360,320,520,480,720,620,840,800,1000,960],
    'INPUTMUX':[400,440,880,920],
    'IOMUX0':[210,170,209,169,207,208,168,167,166,206,230,270,229,269,227,228,268,267,266,226,330,290,329,289,327,328,288,287,286,326],
    'IOMUX1':[350,390,349,389,347,348,388,387,386,346,450,410,449,409,447,448,408,407,406,446,470,510,469,509,467,468,508,507,506,466],
    'IOMUX2':[570,530,569,529,567,568,528,527,526,566,590,630,589,629,587,588,628,627,626,586,770,730,769,729,767,768,728,727,726,766],
    'IOMUX3':[790,830,789,829,787,788,828,827,826,786,890,850,889,849,887,888,848,847,846,886,910,950,909,949,907,908,948,947,946,906],
    'IOMUX4':[1010,970,1009,969,1007,1008,968,967,966,1006,1030,1070,1029,1069,1027,1028,1068,1067,1066,1026,1130,1090,1129,1089,1127,1128,1088,1087,1086,1126],
    'SEAMMUX0':[332,333,334,335,336,337,392,393,394,395,396,397,412,413,414,415,416,417],
    'SEAMMUX1':[472,473,474,475,476,477,492,493,494,495,496,497,552,553,554,555,556,557],
    'SEAMMUX2':[572,573,574,575,576,577,632,633,634,635,636,637,732,733,734,735,736,737],
    'SEAMMUX3':[792,793,794,795,796,797,812,813,814,815,816,817,872,873,874,875,876,877],
    'SEAMMUX4':[892,893,894,895,896,897,952,953,954,955,956,957,972,973,974,975,976,977],
}))

InstallTile(Tile('alta_io_E6_T2', 'IOTILE', columns=20, rows=68, slices=0, values={
    'CTRLMUX0':[328,348,329,349,330,350,368,388,369,389,370,390],
    'CTRLMUX1':[408,428,409,429,410,430,448,468,449,469,450,470],
    'CTRLMUX2':[327,347,326,346,325,345,367,387,366,386,365,385],
    'CTRLMUX3':[407,427,406,426,405,425,447,467,446,466,445,465],
    'CTRLMUX4':[887,907,886,906,885,905,927,947,926,946,925,945],
    'CTRLMUX5':[967,987,966,986,965,985,1007,1027,1006,1026,1005,1025],
    'DPCLK_DLY':[602,603,742,743],
    'INDA_DELAY':[121,120,141,321,320,341,521,520,541,881,880,901,1081,1080,1101,1281,1280,1301],
    'INPUTMUX0':[3,43],
    'INPUTMUX1':[203,243],
    'INPUTMUX2':[363,403],
    'INPUTMUX3':[883,923],
    'INPUTMUX4':[963,1003],
    'INPUTMUX5':[1163,1203],
    'INREG_DELAY':[140,160,161,340,360,361,540,560,561,900,920,921,1100,1120,1121,1300,1320,1321],
    'IN_ASYNC_MODE':[0,200,400,760,960,1160],
    'IN_POWERUP':[21,221,421,781,981,1181],
    'IN_SYNC_MODE':[1,201,401,761,961,1161],
    'IOMUX0':[8,28,9,29,10,30,31,48,68,49,69,50,70,71,88,108,89,109,90,110,111,128,148,129,149,130,150,151,168,188,169,189,170,190,191,208,228,209,229,210,230,231],
    'IOMUX1':[248,268,249,269,250,270,271,288,308,289,309,290,310,311,7,27,6,26,5,25,24,47,67,46,66,45,65,64,87,107,86,106,85,105,104,127,147,126,146,125,145,144],
    'IOMUX2':[167,187,166,186,165,185,184,207,227,206,226,205,225,224,247,267,246,266,245,265,264,287,307,286,306,285,305,304,1048,1068,1049,1069,1050,1070,1071,1088,1108,1089,1109,1090,1110,1111],
    'IOMUX3':[1128,1148,1129,1149,1130,1150,1151,1168,1188,1169,1189,1170,1190,1191,1208,1228,1209,1229,1210,1230,1231,1248,1268,1249,1269,1250,1270,1271,1288,1308,1289,1309,1290,1310,1311,1328,1348,1329,1349,1330,1350,1351],
    'IOMUX4':[1047,1067,1046,1066,1045,1065,1064,1087,1107,1086,1106,1085,1105,1104,1127,1147,1126,1146,1125,1145,1144,1167,1187,1166,1186,1165,1185,1184,1207,1227,1206,1226,1205,1225,1224,1247,1267,1246,1266,1245,1265,1264],
    'IOMUX5':[1287,1307,1286,1306,1285,1305,1304,1327,1347,1326,1346,1325,1345,1344,888,908,889,909,890,910,911,928,948,929,949,930,950,951,968,988,969,989,970,990,991,1008,1028,1009,1029,1010,1030,1031],
    'OE_ASYNC_MODE':[80,280,480,840,1040,1240],
    'OE_POWERUP':[101,301,501,861,1061,1261],
    'OE_REG_MODE':[60,260,460,820,1020,1220],
    'OE_SYNC_MODE':[81,281,481,841,1041,1241],
    'OUTDELAY':[180,380,580,940,1140,1340],
    'OUT_ASYNC_MODE':[40,240,440,800,1000,1200],
    'OUT_POWERUP':[61,261,461,821,1021,1221],
    'OUT_REG_MODE':[100,300,500,860,1060,1260],
    'OUT_SYNC_MODE':[41,241,441,801,1001,1201],
    'RMUX0':[16,36,17,37,18,38,19,56,76,57,77,58,78,59,96,116,97,117,98,118,99,136,156,137,157,138,158,139,176,196,177,197,178,198,179,216,236,217,237,218,238,219,256,276,257,277,258,278,259,296,316,297,317,298,318,299],
    'RMUX1':[336,356,337,357,338,358,339,376,396,377,397,378,398,379,416,436,417,437,418,438,419,456,476,457,477,458,478,459,255,275,254,274,253,273,252,295,315,294,314,293,313,292,335,355,334,354,333,353,332,375,395,374,394,373,393,372],
    'RMUX2':[415,435,414,434,413,433,412,455,475,454,474,453,473,452,895,915,894,914,893,913,892,935,955,934,954,933,953,932,975,995,974,994,973,993,972,1015,1035,1014,1034,1013,1033,1012,1055,1075,1054,1074,1053,1073,1052,1095,1115,1094,1114,1093,1113,1092],
    'RMUX3':[896,916,897,917,898,918,899,936,956,937,957,938,958,939,976,996,977,997,978,998,979,1016,1036,1017,1037,1018,1038,1019,1056,1076,1057,1077,1058,1078,1059,1096,1116,1097,1117,1098,1118,1099,1136,1156,1137,1157,1138,1158,1139,1176,1196,1177,1197,1178,1198,1179],
    'RMUX4':[1216,1236,1217,1237,1218,1238,1219,1256,1276,1257,1277,1258,1278,1259,1296,1316,1297,1317,1298,1318,1299,1336,1356,1337,1357,1338,1358,1339,15,35,14,34,13,33,12,55,75,54,74,53,73,52,95,115,94,114,93,113,92,135,155,134,154,133,153,132],
    'RMUX5':[175,195,174,194,173,193,172,215,235,214,234,213,233,212,1135,1155,1134,1154,1133,1153,1132,1175,1195,1174,1194,1173,1193,1172,1215,1235,1214,1234,1213,1233,1212,1255,1275,1254,1274,1253,1273,1252,1295,1315,1294,1314,1293,1313,1292,1335,1355,1334,1354,1333,1353,1332],
    'SEAMMUX':[492,493,494,495,496,497,491,490,489,488,487,486,552,553,554,555,556,557,551,550,549,548,547,546,572,573,574,575,576,577,571,570,569,568,567,566,792,793,794,795,796,797,791,790,789,788,787,786,812,813,814,815,816,817,811,810,809,808,807,806,872,873,874,875,876,877,871,870,869,868,867,866],
    'TILECLKMUX':[482,483,484,502,503,485,522,523,545,542,543,544,562,563,564,582,583,565,762,763,785,782,783,784,802,803,804,822,823,805,842,843,865,862,863,864],
}))

InstallTile(Tile('alta_io_E6', 'IOTILE', columns=20, rows=68, slices=0, values={
    'CTRLMUX0':[328,348,329,349,330,350,368,388,369,389,370,390],
    'CTRLMUX1':[408,428,409,429,410,430,448,468,449,469,450,470],
    'CTRLMUX2':[327,347,326,346,325,345,367,387,366,386,365,385],
    'CTRLMUX3':[407,427,406,426,405,425,447,467,446,466,445,465],
    'CTRLMUX4':[887,907,886,906,885,905,927,947,926,946,925,945],
    'CTRLMUX5':[967,987,966,986,965,985,1007,1027,1006,1026,1005,1025],
    'INDA_DELAY':[121,120,141,321,320,341,521,520,541,881,880,901,1081,1080,1101,1281,1280,1301],
    'INPUTMUX0':[3,43],
    'INPUTMUX1':[203,243],
    'INPUTMUX2':[363,403],
    'INPUTMUX3':[883,923],
    'INPUTMUX4':[963,1003],
    'INPUTMUX5':[1163,1203],
    'INREG_DELAY':[140,160,161,340,360,361,540,560,561,900,920,921,1100,1120,1121,1300,1320,1321],
    'IN_ASYNC_MODE':[0,200,400,760,960,1160],
    'IN_POWERUP':[21,221,421,781,981,1181],
    'IN_SYNC_MODE':[1,201,401,761,961,1161],
    'IOMUX0':[8,28,9,29,10,30,31,48,68,49,69,50,70,71,88,108,89,109,90,110,111,128,148,129,149,130,150,151,168,188,169,189,170,190,191,208,228,209,229,210,230,231],
    'IOMUX1':[248,268,249,269,250,270,271,288,308,289,309,290,310,311,7,27,6,26,5,25,24,47,67,46,66,45,65,64,87,107,86,106,85,105,104,127,147,126,146,125,145,144],
    'IOMUX2':[167,187,166,186,165,185,184,207,227,206,226,205,225,224,247,267,246,266,245,265,264,287,307,286,306,285,305,304,1048,1068,1049,1069,1050,1070,1071,1088,1108,1089,1109,1090,1110,1111],
    'IOMUX3':[1128,1148,1129,1149,1130,1150,1151,1168,1188,1169,1189,1170,1190,1191,1208,1228,1209,1229,1210,1230,1231,1248,1268,1249,1269,1250,1270,1271,1288,1308,1289,1309,1290,1310,1311,1328,1348,1329,1349,1330,1350,1351],
    'IOMUX4':[1047,1067,1046,1066,1045,1065,1064,1087,1107,1086,1106,1085,1105,1104,1127,1147,1126,1146,1125,1145,1144,1167,1187,1166,1186,1165,1185,1184,1207,1227,1206,1226,1205,1225,1224,1247,1267,1246,1266,1245,1265,1264],
    'IOMUX5':[1287,1307,1286,1306,1285,1305,1304,1327,1347,1326,1346,1325,1345,1344,888,908,889,909,890,910,911,928,948,929,949,930,950,951,968,988,969,989,970,990,991,1008,1028,1009,1029,1010,1030,1031],
    'OE_ASYNC_MODE':[80,280,480,840,1040,1240],
    'OE_POWERUP':[101,301,501,861,1061,1261],
    'OE_REG_MODE':[60,260,460,820,1020,1220],
    'OE_SYNC_MODE':[81,281,481,841,1041,1241],
    'OUTDELAY':[180,380,580,940,1140,1340],
    'OUT_ASYNC_MODE':[40,240,440,800,1000,1200],
    'OUT_POWERUP':[61,261,461,821,1021,1221],
    'OUT_REG_MODE':[100,300,500,860,1060,1260],
    'OUT_SYNC_MODE':[41,241,441,801,1001,1201],
    'RMUX0':[16,36,17,37,18,38,19,56,76,57,77,58,78,59,96,116,97,117,98,118,99,136,156,137,157,138,158,139,176,196,177,197,178,198,179,216,236,217,237,218,238,219,256,276,257,277,258,278,259,296,316,297,317,298,318,299],
    'RMUX1':[336,356,337,357,338,358,339,376,396,377,397,378,398,379,416,436,417,437,418,438,419,456,476,457,477,458,478,459,255,275,254,274,253,273,252,295,315,294,314,293,313,292,335,355,334,354,333,353,332,375,395,374,394,373,393,372],
    'RMUX2':[415,435,414,434,413,433,412,455,475,454,474,453,473,452,895,915,894,914,893,913,892,935,955,934,954,933,953,932,975,995,974,994,973,993,972,1015,1035,1014,1034,1013,1033,1012,1055,1075,1054,1074,1053,1073,1052,1095,1115,1094,1114,1093,1113,1092],
    'RMUX3':[896,916,897,917,898,918,899,936,956,937,957,938,958,939,976,996,977,997,978,998,979,1016,1036,1017,1037,1018,1038,1019,1056,1076,1057,1077,1058,1078,1059,1096,1116,1097,1117,1098,1118,1099,1136,1156,1137,1157,1138,1158,1139,1176,1196,1177,1197,1178,1198,1179],
    'RMUX4':[1216,1236,1217,1237,1218,1238,1219,1256,1276,1257,1277,1258,1278,1259,1296,1316,1297,1317,1298,1318,1299,1336,1356,1337,1357,1338,1358,1339,15,35,14,34,13,33,12,55,75,54,74,53,73,52,95,115,94,114,93,113,92,135,155,134,154,133,153,132],
    'RMUX5':[175,195,174,194,173,193,172,215,235,214,234,213,233,212,1135,1155,1134,1154,1133,1153,1132,1175,1195,1174,1194,1173,1193,1172,1215,1235,1214,1234,1213,1233,1212,1255,1275,1254,1274,1253,1273,1252,1295,1315,1294,1314,1293,1313,1292,1335,1355,1334,1354,1333,1353,1332],
    'SEAMMUX':[492,493,494,495,496,497,491,490,489,488,487,486,552,553,554,555,556,557,551,550,549,548,547,546,572,573,574,575,576,577,571,570,569,568,567,566,792,793,794,795,796,797,791,790,789,788,787,786,812,813,814,815,816,817,811,810,809,808,807,806,872,873,874,875,876,877,871,870,869,868,867,866],
    'TILECLKMUX':[482,483,484,502,503,485,522,523,545,542,543,544,562,563,564,582,583,565,762,763,785,782,783,784,802,803,804,822,823,805,842,843,865,862,863,864],
}))

InstallTile(Tile('alta_io_N4_T2', 'IOTILE', columns=34, rows=22, slices=0, values={
    'CTRLMUX0':[342,376,341,375,340,374,410,444,409,443,408,442],
    'CTRLMUX1':[349,383,348,382,347,381,417,451,416,450,415,449],
    'CTRLMUX2':[343,377,344,378,345,379,411,445,412,446,413,447],
    'CTRLMUX3':[350,384,351,385,352,386,418,452,419,453,420,454],
    'DPCLK_DLY':[16,50,22,56],
    'INDA_DELAY':[5,4,3,39,38,37,21,20,19,55,54,53],
    'INPUTMUX0':[27,61],
    'INPUTMUX1':[33,32],
    'INPUTMUX2':[62,28],
    'INPUTMUX3':[67,66],
    'INREG_DELAY':[7,8,9,41,42,43,24,23,25,59,58,57],
    'IN_ASYNC_MODE':[96,100,742,746],
    'IN_POWERUP':[129,135,707,713],
    'IN_SYNC_MODE':[95,101,741,747],
    'IOMUX0':[86,120,85,119,84,118,117,154,188,153,187,152,186,185,698,732,697,731,696,730,729,630,664,629,663,628,662,661,222,256,221,255,220,254,253,290,324,289,323,288,322,321],
    'IOMUX1':[562,596,561,595,560,594,593,494,528,493,527,492,526,525,223,257,224,258,225,259,260,291,325,292,326,293,327,328,563,597,564,598,565,599,600,495,529,496,530,497,531,532],
    'IOMUX2':[87,121,88,122,89,123,124,155,189,156,190,157,191,192,699,733,700,734,701,735,736,631,665,632,666,633,667,668,94,128,93,127,92,126,125,162,196,161,195,160,194,193],
    'IOMUX3':[706,740,705,739,704,738,737,638,672,637,671,636,670,669,230,264,229,263,228,262,261,298,332,297,331,296,330,329,570,604,569,603,568,602,601,502,536,501,535,500,534,533],
    'OE_ASYNC_MODE':[232,236,606,610],
    'OE_POWERUP':[265,271,571,577],
    'OE_REG_MODE':[198,202,640,644],
    'OE_SYNC_MODE':[231,237,605,611],
    'OUTDELAY':[15,49,26,60],
    'OUT_ASYNC_MODE':[164,168,674,678],
    'OUT_POWERUP':[197,203,639,645],
    'OUT_REG_MODE':[266,270,572,576],
    'OUT_SYNC_MODE':[163,169,673,679],
    'RMUX0':[70,104,69,68,103,102,138,172,137,136,171,170,206,240,205,204,239,238,274,308,273,272,307,306,682,716,681,680,715,714,614,648,613,612,647,646,546,580,545,544,579,578,478,512,477,476,511,510],
    'RMUX1':[71,105,72,73,106,107,139,173,140,141,174,175,207,241,208,209,242,243,275,309,276,277,310,311,683,717,684,685,718,719,615,649,616,617,650,651,547,581,548,549,582,583,479,513,480,481,514,515],
    'RMUX2':[77,111,76,75,110,109,145,179,144,143,178,177,213,247,212,211,246,245,281,315,280,279,314,313,689,723,688,687,722,721,621,655,620,619,654,653,553,587,552,551,586,585,485,519,484,483,518,517],
    'RMUX3':[78,112,79,80,113,114,146,180,147,148,181,182,214,248,215,216,249,250,282,316,283,284,317,318,690,724,691,692,725,726,622,656,623,624,657,658,554,588,555,556,589,590,486,520,487,488,521,522],
    'SEAMMUX':[355,356,357,358,359,360,457,458,459,460,461,462,389,390,391,392,393,394,423,424,425,426,427,428,363,364,365,366,367,368,465,466,467,468,469,470,397,398,399,400,401,402,431,432,433,434,435,436],
    'TILECLKMUX':[299,300,407,537,538,441,305,304,373,543,542,475,333,334,406,503,504,440,339,338,372,509,508,474],
}))

InstallTile(Tile('alta_io_N4', 'IOTILE', columns=34, rows=22, slices=0, values={
    'CTRLMUX0':[342,376,341,375,340,374,410,444,409,443,408,442],
    'CTRLMUX1':[349,383,348,382,347,381,417,451,416,450,415,449],
    'CTRLMUX2':[343,377,344,378,345,379,411,445,412,446,413,447],
    'CTRLMUX3':[350,384,351,385,352,386,418,452,419,453,420,454],
    'INDA_DELAY':[5,4,3,39,38,37,21,20,19,55,54,53],
    'INPUTMUX0':[27,61],
    'INPUTMUX1':[33,32],
    'INPUTMUX2':[62,28],
    'INPUTMUX3':[67,66],
    'INREG_DELAY':[7,8,9,41,42,43,24,23,25,59,58,57],
    'IN_ASYNC_MODE':[96,100,742,746],
    'IN_POWERUP':[129,135,707,713],
    'IN_SYNC_MODE':[95,101,741,747],
    'IOMUX0':[86,120,85,119,84,118,117,154,188,153,187,152,186,185,698,732,697,731,696,730,729,630,664,629,663,628,662,661,222,256,221,255,220,254,253,290,324,289,323,288,322,321],
    'IOMUX1':[562,596,561,595,560,594,593,494,528,493,527,492,526,525,223,257,224,258,225,259,260,291,325,292,326,293,327,328,563,597,564,598,565,599,600,495,529,496,530,497,531,532],
    'IOMUX2':[87,121,88,122,89,123,124,155,189,156,190,157,191,192,699,733,700,734,701,735,736,631,665,632,666,633,667,668,94,128,93,127,92,126,125,162,196,161,195,160,194,193],
    'IOMUX3':[706,740,705,739,704,738,737,638,672,637,671,636,670,669,230,264,229,263,228,262,261,298,332,297,331,296,330,329,570,604,569,603,568,602,601,502,536,501,535,500,534,533],
    'OE_ASYNC_MODE':[232,236,606,610],
    'OE_POWERUP':[265,271,571,577],
    'OE_REG_MODE':[198,202,640,644],
    'OE_SYNC_MODE':[231,237,605,611],
    'OUTDELAY':[15,49,26,60],
    'OUT_ASYNC_MODE':[164,168,674,678],
    'OUT_POWERUP':[197,203,639,645],
    'OUT_REG_MODE':[266,270,572,576],
    'OUT_SYNC_MODE':[163,169,673,679],
    'RMUX0':[70,104,69,68,103,102,138,172,137,136,171,170,206,240,205,204,239,238,274,308,273,272,307,306,682,716,681,680,715,714,614,648,613,612,647,646,546,580,545,544,579,578,478,512,477,476,511,510],
    'RMUX1':[71,105,72,73,106,107,139,173,140,141,174,175,207,241,208,209,242,243,275,309,276,277,310,311,683,717,684,685,718,719,615,649,616,617,650,651,547,581,548,549,582,583,479,513,480,481,514,515],
    'RMUX2':[77,111,76,75,110,109,145,179,144,143,178,177,213,247,212,211,246,245,281,315,280,279,314,313,689,723,688,687,722,721,621,655,620,619,654,653,553,587,552,551,586,585,485,519,484,483,518,517],
    'RMUX3':[78,112,79,80,113,114,146,180,147,148,181,182,214,248,215,216,249,250,282,316,283,284,317,318,690,724,691,692,725,726,622,656,623,624,657,658,554,588,555,556,589,590,486,520,487,488,521,522],
    'SEAMMUX':[355,356,357,358,359,360,457,458,459,460,461,462,389,390,391,392,393,394,423,424,425,426,427,428,363,364,365,366,367,368,465,466,467,468,469,470,397,398,399,400,401,402,431,432,433,434,435,436],
    'TILECLKMUX':[299,300,407,537,538,441,305,304,373,543,542,475,333,334,406,503,504,440,339,338,372,509,508,474],
}))

InstallTile(Tile('alta_io_S4_T2', 'IOTILE', columns=34, rows=22, slices=0, values={
    'CTRLMUX0':[376,342,375,341,374,340,308,274,307,273,306,272],
    'CTRLMUX1':[383,349,382,348,381,347,315,281,314,280,313,279],
    'CTRLMUX2':[377,343,378,344,379,345,309,275,310,276,311,277],
    'CTRLMUX3':[384,350,385,351,386,352,316,282,317,283,318,284],
    'DPCLK_DLY':[730,696,736,702],
    'INDA_DELAY':[719,718,717,685,684,683,735,734,733,701,700,699],
    'INPUTMUX0':[741,707],
    'INPUTMUX1':[747,746],
    'INPUTMUX2':[708,742],
    'INPUTMUX3':[713,712],
    'INREG_DELAY':[721,722,723,687,688,689,738,737,739,705,704,703],
    'IN_ASYNC_MODE':[674,678,28,32],
    'IN_POWERUP':[639,645,61,67],
    'IN_SYNC_MODE':[673,679,27,33],
    'IOMUX0':[664,630,663,629,662,628,627,596,562,595,561,594,560,559,52,18,51,17,50,16,15,120,86,119,85,118,84,83,528,494,527,493,526,492,491,460,426,459,425,458,424,423],
    'IOMUX1':[188,154,187,153,186,152,151,256,222,255,221,254,220,219,529,495,530,496,531,497,498,461,427,462,428,463,429,430,189,155,190,156,191,157,158,257,223,258,224,259,225,226],
    'IOMUX2':[665,631,666,632,667,633,634,597,563,598,564,599,565,566,53,19,54,20,55,21,22,121,87,122,88,123,89,90,672,638,671,637,670,636,635,604,570,603,569,602,568,567],
    'IOMUX3':[60,26,59,25,58,24,23,128,94,127,93,126,92,91,536,502,535,501,534,500,499,468,434,467,433,466,432,431,196,162,195,161,194,160,159,264,230,263,229,262,228,227],
    'OE_ASYNC_MODE':[538,542,164,168],
    'OE_POWERUP':[503,509,197,203],
    'OE_REG_MODE':[572,576,130,134],
    'OE_SYNC_MODE':[537,543,163,169],
    'OUTDELAY':[729,695,740,706],
    'OUT_ASYNC_MODE':[606,610,96,100],
    'OUT_POWERUP':[571,577,129,135],
    'OUT_REG_MODE':[504,508,198,202],
    'OUT_SYNC_MODE':[605,611,95,101],
    'RMUX0':[648,614,647,646,613,612,580,546,579,578,545,544,512,478,511,510,477,476,444,410,443,442,409,408,36,2,35,34,1,0,104,70,103,102,69,68,172,138,171,170,137,136,240,206,239,238,205,204],
    'RMUX1':[649,615,650,651,616,617,581,547,582,583,548,549,513,479,514,515,480,481,445,411,446,447,412,413,37,3,38,39,4,5,105,71,106,107,72,73,173,139,174,175,140,141,241,207,242,243,208,209],
    'RMUX2':[655,621,654,653,620,619,587,553,586,585,552,551,519,485,518,517,484,483,451,417,450,449,416,415,43,9,42,41,8,7,111,77,110,109,76,75,179,145,178,177,144,143,247,213,246,245,212,211],
    'RMUX3':[656,622,657,658,623,624,588,554,589,590,555,556,520,486,521,522,487,488,452,418,453,454,419,420,44,10,45,46,11,12,112,78,113,114,79,80,180,146,181,182,147,148,248,214,249,250,215,216],
    'SEAMMUX':[389,390,391,392,393,394,287,288,289,290,291,292,355,356,357,358,359,360,321,322,323,324,325,326,397,398,399,400,401,402,295,296,297,298,299,300,363,364,365,366,367,368,329,330,331,332,333,334],
    'TILECLKMUX':[469,470,373,231,232,339,475,474,407,237,236,305,435,436,372,265,266,338,441,440,406,271,270,304],
}))

InstallTile(Tile('alta_io_S4', 'IOTILE', columns=34, rows=22, slices=0, values={
    'CTRLMUX0':[376,342,375,341,374,340,308,274,307,273,306,272],
    'CTRLMUX1':[383,349,382,348,381,347,315,281,314,280,313,279],
    'CTRLMUX2':[377,343,378,344,379,345,309,275,310,276,311,277],
    'CTRLMUX3':[384,350,385,351,386,352,316,282,317,283,318,284],
    'INDA_DELAY':[719,718,717,685,684,683,735,734,733,701,700,699],
    'INPUTMUX0':[741,707],
    'INPUTMUX1':[747,746],
    'INPUTMUX2':[708,742],
    'INPUTMUX3':[713,712],
    'INREG_DELAY':[721,722,723,687,688,689,738,737,739,705,704,703],
    'IN_ASYNC_MODE':[674,678,28,32],
    'IN_POWERUP':[639,645,61,67],
    'IN_SYNC_MODE':[673,679,27,33],
    'IOMUX0':[664,630,663,629,662,628,627,596,562,595,561,594,560,559,52,18,51,17,50,16,15,120,86,119,85,118,84,83,528,494,527,493,526,492,491,460,426,459,425,458,424,423],
    'IOMUX1':[188,154,187,153,186,152,151,256,222,255,221,254,220,219,529,495,530,496,531,497,498,461,427,462,428,463,429,430,189,155,190,156,191,157,158,257,223,258,224,259,225,226],
    'IOMUX2':[665,631,666,632,667,633,634,597,563,598,564,599,565,566,53,19,54,20,55,21,22,121,87,122,88,123,89,90,672,638,671,637,670,636,635,604,570,603,569,602,568,567],
    'IOMUX3':[60,26,59,25,58,24,23,128,94,127,93,126,92,91,536,502,535,501,534,500,499,468,434,467,433,466,432,431,196,162,195,161,194,160,159,264,230,263,229,262,228,227],
    'OE_ASYNC_MODE':[538,542,164,168],
    'OE_POWERUP':[503,509,197,203],
    'OE_REG_MODE':[572,576,130,134],
    'OE_SYNC_MODE':[537,543,163,169],
    'OUTDELAY':[729,695,740,706],
    'OUT_ASYNC_MODE':[606,610,96,100],
    'OUT_POWERUP':[571,577,129,135],
    'OUT_REG_MODE':[504,508,198,202],
    'OUT_SYNC_MODE':[605,611,95,101],
    'RMUX0':[648,614,647,646,613,612,580,546,579,578,545,544,512,478,511,510,477,476,444,410,443,442,409,408,36,2,35,34,1,0,104,70,103,102,69,68,172,138,171,170,137,136,240,206,239,238,205,204],
    'RMUX1':[649,615,650,651,616,617,581,547,582,583,548,549,513,479,514,515,480,481,445,411,446,447,412,413,37,3,38,39,4,5,105,71,106,107,72,73,173,139,174,175,140,141,241,207,242,243,208,209],
    'RMUX2':[655,621,654,653,620,619,587,553,586,585,552,551,519,485,518,517,484,483,451,417,450,449,416,415,43,9,42,41,8,7,111,77,110,109,76,75,179,145,178,177,144,143,247,213,246,245,212,211],
    'RMUX3':[656,622,657,658,623,624,588,554,589,590,555,556,520,486,521,522,487,488,452,418,453,454,419,420,44,10,45,46,11,12,112,78,113,114,79,80,180,146,181,182,147,148,248,214,249,250,215,216],
    'SEAMMUX':[389,390,391,392,393,394,287,288,289,290,291,292,355,356,357,358,359,360,321,322,323,324,325,326,397,398,399,400,401,402,295,296,297,298,299,300,363,364,365,366,367,368,329,330,331,332,333,334],
    'TILECLKMUX':[469,470,373,231,232,339,475,474,407,237,236,305,435,436,372,265,266,338,441,440,406,271,270,304],
}))

InstallTile(Tile('alta_io_W4_G5', 'IOTILE', columns=20, rows=68, slices=0, values={
    'ENA_REG_MODE':[300,380,540,740,860],
    'GCLKDMUX':[360,320,520,480,720,620,840,800,1000,960],
    'INPUTMUX':[400,440,880,920],
    'IOMUX0':[210,170,209,169,207,208,168,167,166,206,230,270,229,269,227,228,268,267,266,226,330,290,329,289,327,328,288,287,286,326],
    'IOMUX1':[350,390,349,389,347,348,388,387,386,346,450,410,449,409,447,448,408,407,406,446,470,510,469,509,467,468,508,507,506,466],
    'IOMUX2':[570,530,569,529,567,568,528,527,526,566,590,630,589,629,587,588,628,627,626,586,770,730,769,729,767,768,728,727,726,766],
    'IOMUX3':[790,830,789,829,787,788,828,827,826,786,890,850,889,849,887,888,848,847,846,886,910,950,909,949,907,908,948,947,946,906],
    'IOMUX4':[1010,970,1009,969,1007,1008,968,967,966,1006,1030,1070,1029,1069,1027,1028,1068,1067,1066,1026,1130,1090,1129,1089,1127,1128,1088,1087,1086,1126],
    'SEAMMUX0':[332,333,334,335,336,337,392,393,394,395,396,397,412,413,414,415,416,417],
    'SEAMMUX1':[472,473,474,475,476,477,492,493,494,495,496,497,552,553,554,555,556,557],
    'SEAMMUX2':[572,573,574,575,576,577,632,633,634,635,636,637,732,733,734,735,736,737],
    'SEAMMUX3':[792,793,794,795,796,797,812,813,814,815,816,817,872,873,874,875,876,877],
    'SEAMMUX4':[892,893,894,895,896,897,952,953,954,955,956,957,972,973,974,975,976,977],
}))

InstallTile(Tile('alta_io_W6_T2', 'IOTILE', columns=20, rows=68, slices=0, values={
    'CTRLMUX0':[328,348,329,349,330,350,368,388,369,389,370,390],
    'CTRLMUX1':[408,428,409,429,410,430,448,468,449,469,450,470],
    'CTRLMUX2':[327,347,326,346,325,345,367,387,366,386,365,385],
    'CTRLMUX3':[407,427,406,426,405,425,447,467,446,466,445,465],
    'CTRLMUX4':[887,907,886,906,885,905,927,947,926,946,925,945],
    'CTRLMUX5':[967,987,966,986,965,985,1007,1027,1006,1026,1005,1025],
    'DPCLK_DLY':[602,603,742,743],
    'INDA_DELAY':[121,120,141,321,320,341,521,520,541,881,880,901,1081,1080,1101,1281,1280,1301],
    'INPUTMUX0':[3,43],
    'INPUTMUX1':[203,243],
    'INPUTMUX2':[363,403],
    'INPUTMUX3':[883,923],
    'INPUTMUX4':[963,1003],
    'INPUTMUX5':[1163,1203],
    'INREG_DELAY':[140,160,161,340,360,361,540,560,561,900,920,921,1100,1120,1121,1300,1320,1321],
    'IN_ASYNC_MODE':[0,200,400,760,960,1160],
    'IN_POWERUP':[21,221,421,781,981,1181],
    'IN_SYNC_MODE':[1,201,401,761,961,1161],
    'IOMUX0':[8,28,9,29,10,30,31,48,68,49,69,50,70,71,88,108,89,109,90,110,111,128,148,129,149,130,150,151,168,188,169,189,170,190,191,208,228,209,229,210,230,231],
    'IOMUX1':[248,268,249,269,250,270,271,288,308,289,309,290,310,311,7,27,6,26,5,25,24,47,67,46,66,45,65,64,87,107,86,106,85,105,104,127,147,126,146,125,145,144],
    'IOMUX2':[167,187,166,186,165,185,184,207,227,206,226,205,225,224,247,267,246,266,245,265,264,287,307,286,306,285,305,304,1048,1068,1049,1069,1050,1070,1071,1088,1108,1089,1109,1090,1110,1111],
    'IOMUX3':[1128,1148,1129,1149,1130,1150,1151,1168,1188,1169,1189,1170,1190,1191,1208,1228,1209,1229,1210,1230,1231,1248,1268,1249,1269,1250,1270,1271,1288,1308,1289,1309,1290,1310,1311,1328,1348,1329,1349,1330,1350,1351],
    'IOMUX4':[1047,1067,1046,1066,1045,1065,1064,1087,1107,1086,1106,1085,1105,1104,1127,1147,1126,1146,1125,1145,1144,1167,1187,1166,1186,1165,1185,1184,1207,1227,1206,1226,1205,1225,1224,1247,1267,1246,1266,1245,1265,1264],
    'IOMUX5':[1287,1307,1286,1306,1285,1305,1304,1327,1347,1326,1346,1325,1345,1344,888,908,889,909,890,910,911,928,948,929,949,930,950,951,968,988,969,989,970,990,991,1008,1028,1009,1029,1010,1030,1031],
    'OE_ASYNC_MODE':[80,280,480,840,1040,1240],
    'OE_POWERUP':[101,301,501,861,1061,1261],
    'OE_REG_MODE':[60,260,460,820,1020,1220],
    'OE_SYNC_MODE':[81,281,481,841,1041,1241],
    'OUTDELAY':[180,380,580,940,1140,1340],
    'OUT_ASYNC_MODE':[40,240,440,800,1000,1200],
    'OUT_POWERUP':[61,261,461,821,1021,1221],
    'OUT_REG_MODE':[100,300,500,860,1060,1260],
    'OUT_SYNC_MODE':[41,241,441,801,1001,1201],
    'RMUX0':[16,36,17,37,18,38,19,56,76,57,77,58,78,59,96,116,97,117,98,118,99,136,156,137,157,138,158,139,176,196,177,197,178,198,179,216,236,217,237,218,238,219,256,276,257,277,258,278,259,296,316,297,317,298,318,299],
    'RMUX1':[336,356,337,357,338,358,339,376,396,377,397,378,398,379,416,436,417,437,418,438,419,456,476,457,477,458,478,459,255,275,254,274,253,273,252,295,315,294,314,293,313,292,335,355,334,354,333,353,332,375,395,374,394,373,393,372],
    'RMUX2':[415,435,414,434,413,433,412,455,475,454,474,453,473,452,895,915,894,914,893,913,892,935,955,934,954,933,953,932,975,995,974,994,973,993,972,1015,1035,1014,1034,1013,1033,1012,1055,1075,1054,1074,1053,1073,1052,1095,1115,1094,1114,1093,1113,1092],
    'RMUX3':[896,916,897,917,898,918,899,936,956,937,957,938,958,939,976,996,977,997,978,998,979,1016,1036,1017,1037,1018,1038,1019,1056,1076,1057,1077,1058,1078,1059,1096,1116,1097,1117,1098,1118,1099,1136,1156,1137,1157,1138,1158,1139,1176,1196,1177,1197,1178,1198,1179],
    'RMUX4':[1216,1236,1217,1237,1218,1238,1219,1256,1276,1257,1277,1258,1278,1259,1296,1316,1297,1317,1298,1318,1299,1336,1356,1337,1357,1338,1358,1339,15,35,14,34,13,33,12,55,75,54,74,53,73,52,95,115,94,114,93,113,92,135,155,134,154,133,153,132],
    'RMUX5':[175,195,174,194,173,193,172,215,235,214,234,213,233,212,1135,1155,1134,1154,1133,1153,1132,1175,1195,1174,1194,1173,1193,1172,1215,1235,1214,1234,1213,1233,1212,1255,1275,1254,1274,1253,1273,1252,1295,1315,1294,1314,1293,1313,1292,1335,1355,1334,1354,1333,1353,1332],
    'SEAMMUX':[492,493,494,495,496,497,491,490,489,488,487,486,552,553,554,555,556,557,551,550,549,548,547,546,572,573,574,575,576,577,571,570,569,568,567,566,792,793,794,795,796,797,791,790,789,788,787,786,812,813,814,815,816,817,811,810,809,808,807,806,872,873,874,875,876,877,871,870,869,868,867,866],
    'TILECLKMUX':[482,483,484,502,503,485,522,523,545,542,543,544,562,563,564,582,583,565,762,763,785,782,783,784,802,803,804,822,823,805,842,843,865,862,863,864],
}))

InstallTile(Tile('alta_io_W6', 'IOTILE', columns=20, rows=68, slices=0, values={
    'CTRLMUX0':[328,348,329,349,330,350,368,388,369,389,370,390],
    'CTRLMUX1':[408,428,409,429,410,430,448,468,449,469,450,470],
    'CTRLMUX2':[327,347,326,346,325,345,367,387,366,386,365,385],
    'CTRLMUX3':[407,427,406,426,405,425,447,467,446,466,445,465],
    'CTRLMUX4':[887,907,886,906,885,905,927,947,926,946,925,945],
    'CTRLMUX5':[967,987,966,986,965,985,1007,1027,1006,1026,1005,1025],
    'INDA_DELAY':[121,120,141,321,320,341,521,520,541,881,880,901,1081,1080,1101,1281,1280,1301],
    'INPUTMUX0':[3,43],
    'INPUTMUX1':[203,243],
    'INPUTMUX2':[363,403],
    'INPUTMUX3':[883,923],
    'INPUTMUX4':[963,1003],
    'INPUTMUX5':[1163,1203],
    'INREG_DELAY':[140,160,161,340,360,361,540,560,561,900,920,921,1100,1120,1121,1300,1320,1321],
    'IN_ASYNC_MODE':[0,200,400,760,960,1160],
    'IN_POWERUP':[21,221,421,781,981,1181],
    'IN_SYNC_MODE':[1,201,401,761,961,1161],
    'IOMUX0':[8,28,9,29,10,30,31,48,68,49,69,50,70,71,88,108,89,109,90,110,111,128,148,129,149,130,150,151,168,188,169,189,170,190,191,208,228,209,229,210,230,231],
    'IOMUX1':[248,268,249,269,250,270,271,288,308,289,309,290,310,311,7,27,6,26,5,25,24,47,67,46,66,45,65,64,87,107,86,106,85,105,104,127,147,126,146,125,145,144],
    'IOMUX2':[167,187,166,186,165,185,184,207,227,206,226,205,225,224,247,267,246,266,245,265,264,287,307,286,306,285,305,304,1048,1068,1049,1069,1050,1070,1071,1088,1108,1089,1109,1090,1110,1111],
    'IOMUX3':[1128,1148,1129,1149,1130,1150,1151,1168,1188,1169,1189,1170,1190,1191,1208,1228,1209,1229,1210,1230,1231,1248,1268,1249,1269,1250,1270,1271,1288,1308,1289,1309,1290,1310,1311,1328,1348,1329,1349,1330,1350,1351],
    'IOMUX4':[1047,1067,1046,1066,1045,1065,1064,1087,1107,1086,1106,1085,1105,1104,1127,1147,1126,1146,1125,1145,1144,1167,1187,1166,1186,1165,1185,1184,1207,1227,1206,1226,1205,1225,1224,1247,1267,1246,1266,1245,1265,1264],
    'IOMUX5':[1287,1307,1286,1306,1285,1305,1304,1327,1347,1326,1346,1325,1345,1344,888,908,889,909,890,910,911,928,948,929,949,930,950,951,968,988,969,989,970,990,991,1008,1028,1009,1029,1010,1030,1031],
    'OE_ASYNC_MODE':[80,280,480,840,1040,1240],
    'OE_POWERUP':[101,301,501,861,1061,1261],
    'OE_REG_MODE':[60,260,460,820,1020,1220],
    'OE_SYNC_MODE':[81,281,481,841,1041,1241],
    'OUTDELAY':[180,380,580,940,1140,1340],
    'OUT_ASYNC_MODE':[40,240,440,800,1000,1200],
    'OUT_POWERUP':[61,261,461,821,1021,1221],
    'OUT_REG_MODE':[100,300,500,860,1060,1260],
    'OUT_SYNC_MODE':[41,241,441,801,1001,1201],
    'RMUX0':[16,36,17,37,18,38,19,56,76,57,77,58,78,59,96,116,97,117,98,118,99,136,156,137,157,138,158,139,176,196,177,197,178,198,179,216,236,217,237,218,238,219,256,276,257,277,258,278,259,296,316,297,317,298,318,299],
    'RMUX1':[336,356,337,357,338,358,339,376,396,377,397,378,398,379,416,436,417,437,418,438,419,456,476,457,477,458,478,459,255,275,254,274,253,273,252,295,315,294,314,293,313,292,335,355,334,354,333,353,332,375,395,374,394,373,393,372],
    'RMUX2':[415,435,414,434,413,433,412,455,475,454,474,453,473,452,895,915,894,914,893,913,892,935,955,934,954,933,953,932,975,995,974,994,973,993,972,1015,1035,1014,1034,1013,1033,1012,1055,1075,1054,1074,1053,1073,1052,1095,1115,1094,1114,1093,1113,1092],
    'RMUX3':[896,916,897,917,898,918,899,936,956,937,957,938,958,939,976,996,977,997,978,998,979,1016,1036,1017,1037,1018,1038,1019,1056,1076,1057,1077,1058,1078,1059,1096,1116,1097,1117,1098,1118,1099,1136,1156,1137,1157,1138,1158,1139,1176,1196,1177,1197,1178,1198,1179],
    'RMUX4':[1216,1236,1217,1237,1218,1238,1219,1256,1276,1257,1277,1258,1278,1259,1296,1316,1297,1317,1298,1318,1299,1336,1356,1337,1357,1338,1358,1339,15,35,14,34,13,33,12,55,75,54,74,53,73,52,95,115,94,114,93,113,92,135,155,134,154,133,153,132],
    'RMUX5':[175,195,174,194,173,193,172,215,235,214,234,213,233,212,1135,1155,1134,1154,1133,1153,1132,1175,1195,1174,1194,1173,1193,1172,1215,1235,1214,1234,1213,1233,1212,1255,1275,1254,1274,1253,1273,1252,1295,1315,1294,1314,1293,1313,1292,1335,1355,1334,1354,1333,1353,1332],
    'SEAMMUX':[492,493,494,495,496,497,491,490,489,488,487,486,552,553,554,555,556,557,551,550,549,548,547,546,572,573,574,575,576,577,571,570,569,568,567,566,792,793,794,795,796,797,791,790,789,788,787,786,812,813,814,815,816,817,811,810,809,808,807,806,872,873,874,875,876,877,871,870,869,868,867,866],
    'TILECLKMUX':[482,483,484,502,503,485,522,523,545,542,543,544,562,563,564,582,583,565,762,763,785,782,783,784,802,803,804,822,823,805,842,843,865,862,863,864],
}))

InstallTile(Tile('UFM', 'UFMTILE', columns=34, rows=8, slices=0, values={
    'BBMUXN0':[139,173,138,172,137,136,171,170,105],
    'BBMUXN1':[37,3,36,2,35,34,1,0,71],
    'BBMUXN2':[142,176,143,177,144,145,178,179,108],
    'BBMUXN3':[40,6,41,7,42,43,8,9,74],
    'BBMUXN4':[149,183,148,182,147,146,181,180,115],
    'BBMUXN5':[47,13,46,12,45,44,11,10,81],
    'BBMUXN6':[153,187,154,188,155,156,189,190,119],
    'CONSTMUX':[254],
    'GDRVMUX':[49,15,52,18,50,16,53,19,51,17,54,20],
    'SeamMUX':[238,239,240,241,204,205,206,207,247,246,245,244,213,212,211,210,248,249,250,251,214,215,216,217,258,257,256,255],
}))

# These are pseudo tiles.  The bits are handled in ConfigChains.  Here for wire/routing purposes.
InstallTile(Tile('Clkdis', 'ClkdisTILE', columns=0, rows=0, slices=0, values={}))
InstallTile(Tile('PLL', 'PLLTILE', columns=0, rows=0, slices=0, values={}))

#
# For AG16K
# 
InstallTile(Tile('alta_io_N4_G5', 'IOTILE', columns=40, rows=24, slices=0, values={
    'ENA_REG_MODE':[116,117,436,437,756],
    'GCLKDMUX':[276,277,316,317,596,597,636,637,916,917],
    'INDA_DELAY':[157,36,37,156,77,76,32,31,71,33,73,72],
    'INPUTMUX':[91,99,106,113],
    'IOMUX0':[219,299,218,298,216,217,297,296,295,215,419,339,418,338,416,417,337,336,335,415,459,539,458,538,456,457,537,536,535,455],
    'IOMUX1':[819,739,818,738,816,817,737,736,735,815,859,939,858,938,856,857,937,936,935,855,226,306,225,305,223,224,304,303,302,222],
    'IOMUX2':[426,346,425,345,423,424,344,343,342,422,466,546,465,545,463,464,544,543,542,462,826,746,825,745,823,824,744,743,742,822],
    'IOMUX3':[866,946,865,945,863,864,944,943,942,862,233,313,232,312,230,231,311,310,309,229,433,353,432,352,430,431,351,350,349,429],
    'IOMUX4':[473,553,472,552,470,471,551,550,549,469,833,753,832,752,830,831,751,750,749,829,873,953,872,952,870,871,951,950,949,869],
    'SEAMMUX0':[360,361,362,363,364,365,366,367,368,369,370,371,400,401,402,403,404,405],
    'SEAMMUX1':[406,407,408,409,410,411,520,521,522,523,524,525,526,527,528,529,530,531],
    'SEAMMUX2':[560,561,562,563,564,565,566,567,568,569,570,571,680,681,682,683,684,685],
    'SEAMMUX3':[686,687,688,689,690,691,720,721,722,723,724,725,726,727,728,729,730,731],
    'SEAMMUX4':[840,841,842,843,844,845,846,847,848,849,850,851,880,881,882,883,884,885],
}))

InstallTile(Tile('alta_io_S4_G5', 'IOTILE', columns=40, rows=24, slices=0, values={
    'ENA_REG_MODE':[876,877,556,557,236],
    'GCLKDMUX':[716,717,676,677,396,397,356,357,76,77],
    'INDA_DELAY':[837,956,957,836,917,916,952,951,911,953,913,912],
    'INPUTMUX':[851,859,866,873],
    'IOMUX0':[739,659,738,658,736,737,657,656,655,735,539,619,538,618,536,537,617,616,615,535,499,419,498,418,496,497,417,416,415,495],
    'IOMUX1':[139,219,138,218,136,137,217,216,215,135,99,19,98,18,96,97,17,16,15,95,746,666,745,665,743,744,664,663,662,742],
    'IOMUX2':[546,626,545,625,543,544,624,623,622,542,506,426,505,425,503,504,424,423,422,502,146,226,145,225,143,144,224,223,222,142],
    'IOMUX3':[106,26,105,25,103,104,24,23,22,102,753,673,752,672,750,751,671,670,669,749,553,633,552,632,550,551,631,630,629,549],
    'IOMUX4':[513,433,512,432,510,511,431,430,429,509,153,233,152,232,150,151,231,230,229,149,113,33,112,32,110,111,31,30,29,109],
    'SEAMMUX0':[560,561,562,563,564,565,566,567,568,569,570,571,520,521,522,523,524,525],
    'SEAMMUX1':[526,527,528,529,530,531,400,401,402,403,404,405,406,407,408,409,410,411],
    'SEAMMUX2':[360,361,362,363,364,365,366,367,368,369,370,371,240,241,242,243,244,245],
    'SEAMMUX3':[246,247,248,249,250,251,200,201,202,203,204,205,206,207,208,209,210,211],
    'SEAMMUX4':[80,81,82,83,84,85,86,87,88,89,90,91,40,41,42,43,44,45],
}))
