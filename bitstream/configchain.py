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
from utils import bits_to_string, bits_invert

class ConfigChainPLL:
    def __init__(self, chip):
        self.fields = [
            ('PLL_EN_FLAG',    1),
            ('RLPF',           2),  # ???
            ('PllClkInMUX00',  2),
            ('RVI',            2),  # ???
            ('RREF',           2),  # ???
            ('CP',             3),  # ???
            ('SELCLK_G1',      3),
            ('SELCLK_G2',      3),
            ('PllIntFbMUX00',  2),
            ('DLYNUM_G2',      6),
            ('PllSeamMUX00',   3),  # feeds PllClkFbMUX00
            ('PllSeamMUX01',   3),  # feeds PllClkInMUX00
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
            ('PllClkFbMUX00',  1),
        ]
        self.aliases = {
            'SinkMUXPseudo00': 'PLL_EN_FLAG', # pllen
            # XXX: 1 is resetn. Where to hook up??
            'SinkMUXPseudo02': 'CLK_EN1',     # clkout0en
            'SinkMUXPseudo03': 'CLK_EN2',     # clkout1en
            'SinkMUXPseudo04': 'CLK_EN3',     # clkout2en
            'SinkMUXPseudo05': 'CLK_EN4',     # clkout3en
            # guess based on bit width
            'CLKOUT0_PHASE': 'SELCLK_G1',
            'CLKOUT1_PHASE': 'SELCLK_G2',
            'CLKOUT2_PHASE': 'SELCLK_G3',
            'CLKOUT3_PHASE': 'SELCLK_G4',
            # guess based on Dly/Delay
            'CLKOUT0_DEL': 'DLYNUM_G1',
            'CLKOUT1_DEL': 'DLYNUM_G2',
            'CLKOUT2_DEL': 'DLYNUM_G3',
            'CLKOUT3_DEL': 'DLYNUM_G4',
            # guess based on 6-bit and four items
            'CLKOUT0_DIV': 'M_G1',
            'CLKOUT1_DIV': 'M_G2',
            'CLKOUT2_DIV': 'M_G3',
            'CLKOUT3_DIV': 'M_G4',
            # guesses
            'CLKIN_DIV': 'M_N',
            'CLKFB_DIV': 'M_M',
        }
    
    def empty_bits(self):
        length = 0
        for field in self.fields:
            length += field[1]
        return [0] * length
    
    def format(self, name, bits, chain_id):
        return bits_to_string(bits)
    
    def offset_for_field_named(self, name):
        offset = 0
        for field in self.fields:
            if field[0] == name:
                return offset
            offset += field[1]
        return None
    
    def encode(self, chip, tile, row, col, key, value, bits):
        if key in self.aliases:
            # XXX: ugly hack. router emits 0 to hook up to I0
            # but we need a 1 to activate 
            if key.startswith("SinkMUXPseudo"):
                value = bits_invert(value)
            key = self.aliases[key]
        offset = self.offset_for_field_named(key)
        if offset == None:
            return False
        
        for idx in range(len(value)):
            bits[offset] = value[idx]
            offset += 1
        return True
    
    def decode(self, bits):
        result = { '__NAME': 'PLL' }
        idx = 0
        for field in self.fields:
            name = field[0]
            length = field[1]
            value = bits[idx:idx+length]
            result[name] = bits_to_string(value, prefix=True)
            idx += length
        
        return result
        
class ConfigChainIO:
    def __init__(self, chip, package=None):
        if package == None:
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
            result[name] = bits_to_string(value, prefix=True)
            idx += length
        
        return result