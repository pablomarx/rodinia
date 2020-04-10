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
from operator import itemgetter
import re
from utils import bits_to_string

class ConfigChainPLL:
    def __init__(self, chip):
        self.fields = [
            ('PLL_EN_FLAG',    1),
            ('RLPF',           2),
            ('PllClkInMUX',    2),
            ('RVI',            2),
            ('RREF',           2),
            ('CP',             3),
            ('SELCLK_G1',      3),
            ('SELCLK_G2',      3),
            ('PllIntFbMUX',    2),
            ('DLYNUM_G2',      6),
            ('PllSeamMUX0',    3),
            ('PllSeamMUX1',    3),
            ('M_N',            6),
            ('M_M',            6),
            ('M_G1',           6),
            ('CLK_EN1',        1),
            ('M_G2',           6),
            ('CLK_EN2',        1),
            ('DLYNUM_G1',      6),
            ('DLYNUM_G4',      6),
            ('DLYNUM_G3',      6),
            ('M_G4',           6),
            ('CLK_EN4',        1),
            ('M_G3',           6),
            ('CLK_EN3',        1),
            ('SELCLK_G4',      3),
            ('SELCLK_G3',      3),
            ('PllClkFbMUX',    1)
        ]
    
    def empty_bits(self):
        length = 0
        for field in self.fields:
            length += field[1]
        return [0] * length
    
    def format(self, name, bits, chain_id):
        return bits_to_string(bits)
    
    def encode(self, chip, tile, row, col, key, value, bits):
        return None

    def decode(self, bits):
        result = { '__NAME': 'PLL' }
        idx = 0
        for field in self.fields:
            name = field[0]
            length = field[1]
            value = bits[idx:idx+length]
            result[name] = value
            idx += length
        
        return result
        
class ConfigChainIO:
    def __init__(self, chip):
        package_name = list(chip.packages)[0]
        package = chip.packages[package_name]
        pins = [pin for pin in package if 'configChainIndex' in pin]
        pins = sorted(pins, key=itemgetter('configChainIndex'))
        
        # CFG_KEEP appers to be direction? After changing bank3 to input:
        # 33 _CFG_KEEP: 00
        #  7 _CFG_KEEP: 01
        #
        # Verified OPEN DRAIN via adding the following to the sdc file:
        # set_instance_assignment -name ENABLE_OPEN_DRAIN -to bank3[4] true
        # before:
        # < PIN_41_CFG_OPEN_DRAIN: 0
        # after:
        # > PIN_41_CFG_OPEN_DRAIN: 1
        base = [ ('KEEP', 2), ('PDRCTRL', 2), ('OPEN_DRAIN', 1)]
        fields = []
        for pin in pins:
            for value in base:
                name = value[0]
                length = value[1]
                fields.append((pin['name'] + '_' + name, length))
        self.fields = fields
        
    def empty_bits(self):
        bits = []
        for field in self.fields:
            length = field[1]
            bits += [0] * length
            if not field[0].endswith("OPEN_DRAIN"):
                bits[-1] = 1
        return bits
        
    def format(self, name, bits, chain_id):
        return bits_to_string(bits)
        
    def offset_for_field_named(self, name):
        offset = 0
        for field in self.fields:
            if field[0] == name:
                return offset
            offset += field[1]
        return offset
    
    def encode(self, chip, tile, row, col, key, value, bits):
        if not tile and not row and not col:
            offset = self.offset_for_field_named(key)
            for idx in range(len(value)):
                bits[offset] = value[idx]
                offset += 1
            return True
            
        match = re.match("^alta_rio([0-9]*)\.(INPUT|OUTPUT)_USED$", key)
        if not match:
            return None
        
        comps = match.groups()
        slice = int(comps[0])
        output = (comps[1] == "OUTPUT")
        pin = chip.pin_at(row, col, slice)
        if not pin:
            print("What pin corresponds to tile:%s row:%i col:%i slice:%i ??" % (tile, row, col, slice))
            return None

        offset = self.offset_for_field_named(pin["name"] + "_KEEP")
        bits[offset] = 0
        bits[offset+1] = 0
                
        return True
    
    def decode(self, bits):
        result = { '__NAME': 'I/O' }
        idx = 0
        for field in self.fields:
            name = field[0]
            length = field[1]
            value = bits[idx:idx+length]
            result[name] = value
            idx += length
        
        return result