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
from utils import bits_to_string

class ConfigChainPLL:
    def __init__(self, chip):
        self.fields = [
            ('CFG_PLL_EN_FLAG',    1),
            ('CFG_RLPF',           2),
            ('CFG_PllClkInMUX',    2),
            ('CFG_RVI',            2),
            ('CFG_RREF',           2),
            ('CFG_CP',             3),
            ('CFG_SELCLK_G1',      3),
            ('CFG_SELCLK_G2',      3),
            ('CFG_PllIntFbMUX',    2),
            ('CFG_DLYNUM_G2',      6),
            ('CFG_PllSeamMUX0',    3),
            ('CFG_PllSeamMUX1',    3),
            ('CFG_M_N',            6),
            ('CFG_M_M',            6),
            ('CFG_M_G1',           6),
            ('CFG_CLK_EN1',        1),
            ('CFG_M_G2',           6),
            ('CFG_CLK_EN2',        1),
            ('CFG_DLYNUM_G1',      6),
            ('CFG_DLYNUM_G4',      6),
            ('CFG_DLYNUM_G3',      6),
            ('CFG_M_G4',           6),
            ('CFG_CLK_EN4',        1),
            ('CFG_M_G3',           6),
            ('CFG_CLK_EN3',        1),
            ('CFG_SELCLK_G4',      3),
            ('CFG_SELCLK_G3',      3),
            ('CFG_PllClkFbMUX',    1)
        ]
    
    def format(self, name, bits):
        return bits_to_string(bits)
    
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
        package_name = chip.packages.keys()[0]
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
        base = [ ('CFG_KEEP', 2), ('CFG_PDRCTRL', 2), ('CFG_OPEN_DRAIN', 1)]
        fields = []
        for pin in pins:
            for value in base:
                name = value[0]
                length = value[1]
                fields.append((pin['name'] + '_' + name, length))
        self.fields = fields

    def format(self, name, bits):
        return bits_to_string(bits)

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