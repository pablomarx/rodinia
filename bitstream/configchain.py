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

class ConfigChain:
    def __init__(self, chip, name, fields, aliases={}):
        self.chip = chip
        self.name = name
        self.fields = fields
        self.aliases = aliases
        
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
            key = self.aliases[key]
        
        offset = self.offset_for_field_named(key)
        if offset == None:
            return False
        
        for idx in range(len(value)):
            bits[offset] = value[idx]
            offset += 1
        return True
    
    def decode(self, bits):
        result = { '__NAME': self.name }
        idx = 0
        for field in self.fields:
            name = field[0]
            length = field[1]
            value = bits[idx:idx+length]
            result[name] = bits_to_string(value, prefix=True)
            idx += length
        
        return result
        
class ConfigChainPLLX(ConfigChain):
    def __init__(self, chip):
        fields = [
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
        aliases = {
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
        ConfigChain.__init__(self, chip, 'PLLX', fields, aliases)
    
    def encode(self, chip, tile, row, col, key, value, bits):
        # XXX: ugly hack. router emits 0 to hook up to I0
        # but we need a 1 to activate 
        if key.startswith("SinkMUXPseudo"):
            value = bits_invert(value)
        key = self.aliases[key]
        super().encode(chip, tile, row, col, key, value, bits)

class ConfigChainPLLV(ConfigChain):
    def __init__(self, chip, package=None):
        fields = [
            ('CFG_PLL_EN_FLAG', 1), 
            ('CFG_RLPF', 2),      
            ('CFG_RVI', 2),       
            ('CFG_RREF', 2),      
            ('CFG_CP', 3),        
            ('CFG_P', 3),
            ('CFG_P', 3),
            ('CFG_SELCLK_G1', 3), 
            ('CFG_SELCLK_G2', 3), 
            ('CFG_SELCLK_G3', 3), 
            ('CFG_SELCLK_G4', 3), 
            ('CFG_SELCLK_G5', 3), 
            ('CFG_SELCLK_M', 3),  
            ('CFG_PLLFB_DLY', 3), 
            ('CFG_FEEDBACK_MODE', 1),
            ('CFG_P', 2),
            ('CFG_CLK_EN1', 1),   
            ('CFG_CLK_EN2', 1),   
            ('CFG_CLK_EN3', 1),   
            ('CFG_CLK_EN4', 1),   
            ('CFG_CLK_EN5', 1),   
            ('CFG_CASCADE', 4),   
            ('CFG_BYPASS', 5),    
            ('CFG_EN_DUTYTRIM', 5), 
            ('CFG_DIVNUM_HG1', 8),
            ('CFG_DIVNUM_LG1', 8),
            ('CFG_DIVNUM_HG2', 8),
            ('CFG_DIVNUM_LG2', 8),
            ('CFG_DIVNUM_HG3', 8),
            ('CFG_DIVNUM_LG3', 8),
            ('CFG_DIVNUM_HG4', 8),
            ('CFG_DIVNUM_LG4', 8),
            ('CFG_DIVNUM_HG5', 8),
            ('CFG_DIVNUM_LG5', 8),
            ('CFG_DLYNUM_G1', 8), 
            ('CFG_DLYNUM_G2', 8), 
            ('CFG_DLYNUM_G3', 8), 
            ('CFG_DLYNUM_G4', 8), 
            ('CFG_DLYNUM_G5', 8), 
            ('CFG_DLYNUM_M', 8),  
            ('CFG_DIVNUM_M', 9),  
            ('CFG_DIVNUM_N', 9),  
            ('CFG_EN_DUTYTRIM_M', 1),
            ('CFG_EN_PLLOUTP', 1),
            ('CFG_EN_PLLOUTN', 1),
        ]
        ConfigChain.__init__(self, chip, 'PLLV', fields)

class ConfigChainPLLVE(ConfigChain):
    def __init__(self, chip, package=None):
        fields = [
            ('CFG_REG_CTRL', 2),
            ('CFG_PLL_EN_FLAG', 2),
            ('CFG_PllClkFbMUX', 2),
            ('CFG_PLLFB_DLY', 2),
            ('CFG_PllClkInMUX', 2),
            ('CFG_PllSeamMUX', 2),
            ('CFG_FEEDBACK_MODE', 2),
            ('CFG_ENB_PLLOUTN', 2),
            ('CFG_ENB_PLLOUTP', 2),
            ('CFG_SELCLK_M', 2),
            ('CFG_DLYNUM_M', 2),
            ('CFG_SELCLK_G0', 2),
            ('CFG_CLK_EN0', 2),
            ('CFG_DLYNUM_G0', 2),
            ('CFG_CASCADE0', 2),
            ('CFG_SELCLK_G1', 2),
            ('CFG_CLK_EN1', 2),
            ('CFG_DLYNUM_G1', 2),
            ('CFG_CASCADE1', 2),
            ('CFG_SELCLK_G2', 2),
            ('CFG_CLK_EN2', 2),
            ('CFG_DLYNUM_G2', 2),
            ('CFG_CASCADE2', 2),
            ('CFG_SELCLK_G3', 2),
            ('CFG_CLK_EN3', 2),
            ('CFG_DLYNUM_G3', 2),
            ('CFG_CASCADE3', 2),
            ('CFG_SELCLK_G4', 2),
            ('CFG_CLK_EN4', 2),
            ('CFG_DLYNUM_G4', 2),
            ('CFG_DIVNUM_LG4', 2),
            ('CFG_EN_DUTYTRIM_G4', 2),
            ('CFG_DIVNUM_HG4', 2),
            ('CFG_BYPASS_G4', 2),
            ('CFG_DIVNUM_LG3', 2),
            ('CFG_EN_DUTYTRIM_G3', 2),
            ('CFG_DIVNUM_HG3', 2),
            ('CFG_BYPASS_G3', 2),
            ('CFG_DIVNUM_LG2', 2),
            ('CFG_EN_DUTYTRIM_G2', 2),
            ('CFG_DIVNUM_HG2', 2),
            ('CFG_BYPASS_G2', 2),
            ('CFG_DIVNUM_LG1', 2),
            ('CFG_EN_DUTYTRIM_G1', 2),
            ('CFG_DIVNUM_HG1', 2),
            ('CFG_BYPASS_G1', 2),
            ('CFG_DIVNUM_LG0', 2),
            ('CFG_EN_DUTYTRIM_G0', 2),
            ('CFG_DIVNUM_HG0', 2),
            ('CFG_BYPASS_G0', 2),
            ('CFG_DIVNUM_LM', 2),
            ('CFG_EN_DUTYTRIM_M', 2),
            ('CFG_DIVNUM_HM', 2),
            ('CFG_BYPASS_M', 2),
            ('CFG_DIVNUM_LN', 2),
            ('CFG_EN_DUTYTRIM_N', 2),
            ('CFG_DIVNUM_HN', 2),
            ('CFG_BYPASS_N', 2),
            ('CFG_ICP', 2),
            ('CFG_DUMMY', 2),
            ('CFG_POST_SCALE_COUNTER', 2),
            ('CFG_RLPF', 2),
            ('CFG_RREF', 2),
            ('CFG_RVI', 2),
            ('CFG_IVCO', 2),
        ]
        ConfigChain.__init__(self, chip, 'PLLVE', fields)

# Seen in AG10K bitstreams
class ConfigChainMCU1(ConfigChain):
    def __init__(self, chip, package=None):
        fields = [
            ('CFG_MCU_EN_FLAG', 1),
            ('CFG_MCU_ADDR', 24),
        ]
        ConfigChain.__init__(self, chip, 'MCU1', fields)

# Seen in AG16K bitstreams
class ConfigChainMCU2(ConfigChain):
    def __init__(self, chip, package=None):
        fields = [
            ('CFG_MCU_EN_FLAG', 1),
            ('CFG_MCU_CLK_FREQ', 8),
            ('CFG_MCU_ADDR', 24),
            ('CFG_BOOT_DELAY', 1),
        ]
        ConfigChain.__init__(self, chip, 'MCU2', fields)

# Seen in AG10K bitstreams
class ConfigChainClkDis_25x48(ConfigChain):
    def __init__(self, chip, package=None):
        fields = []
        for num in range(11, -1, -1):
            fields.append(('CFG_GclkDMUX%02i' % num, 48))
        for num in range(24, 11, -1):
            fields.append(('CFG_GclkDMUX%02i' % num, 48))
        ConfigChain.__init__(self, chip, 'zCLKDIS', fields)

# Seen in AG16K bitstreams
class ConfigChainClkDis_29x60(ConfigChain):
    def __init__(self, chip, package=None):
        fields = []
        for num in range(14, -1, -1):
            fields.append(('CFG_GclkDMUX%02i' % num, 48))
        for num in range(28, 14, -1):
            fields.append(('CFG_GclkDMUX%02i' % num, 48))
        ConfigChain.__init__(self, chip, 'zCLKDIS', fields)

class ConfigChainRIO:
    def __init__(self, chip, package=None):
        io_order = chip.extra['chain_io_order']
        
        # Kludge... use the package with the most external pins...
        if package == None:
            packages = chip.packages
            most_ext_pins = 0
            for package_name in packages:
                a_package = packages[package_name]
                ext_pins = [pin for pin in a_package if pin['name'].startswith('PIN_')]
                if len(ext_pins) > most_ext_pins:
                    package = a_package
                    most_ext_pins = len(ext_pins)

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
        for io_coord in io_order:
            name = None
            for pin in package:
                if 'tile' in pin and pin['tile'] == io_coord[:2] and pin['index'] == io_coord[2]:
                    name = pin['name']
                    break
            if name == None:
                name = 'IO%i_%i_%i' % io_coord
            
            for value in base:
                chain_name = value[0]
                chain_length = value[1]
                fields.append((name + '_' + chain_name, chain_length))
        
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
        result = { '__NAME': 'ALTA_RIO' }
        idx = 0
        for field in self.fields:
            name = field[0]
            length = field[1]
            value = bits[idx:idx+length]
            result[name] = bits_to_string(value, prefix=True)
            idx += length
        
        return result

class ConfigChainDIO(ConfigChain):
    def __init__(self, chip, package=None):
        io_order = chip.extra['chain_io_order']
        
        packages = chip.packages
        package_names = list(packages.keys())
        package = packages[package_names[0]]
        
        attrs = {
            'DIFFN_IN': [
                ('CFG_TRI_INPUT', 1)
            ],
            'DIFFP_IN': [
                ('CFG_LVDS_SEL_CUA', 2),
                ('CFG_LVDS_IN_EN', 1),
                ('CFG_TRI_INPUT', 1)
            ],
            'DIFFN': [
                ('CFG_KEEP', 2),
                ('CFG_PDRCTRL', 4),
                ('CFG_OPEN_DRAIN', 1),
                ('CFG_SLR', 1),
                ('CFG_PULL_UP', 1),
                ('CFG_TRI_INPUT', 1),
            ],
            'DIFFP': [
                ('CFG_LVDS_IN_EN', 1),
                ('CFG_LVDS_IREF', 10),
                ('CFG_LVDS_SEL_CUA', 2),
                ('CFG_LVDS_OUT_EN', 1),
                ('CFG_KEEP', 2),
                ('CFG_PDRCTRL', 4),
                ('CFG_OPEN_DRAIN', 1),
                ('CFG_SLR', 1),
                ('CFG_PULL_UP', 1),
                ('CFG_TRI_INPUT', 1),
            ],
            'PSEUDO_DIFFN': [
                ('CFG_KEEP', 2),
                ('CFG_PDRCTRL', 4),
                ('CFG_OPEN_DRAIN', 1),
                ('CFG_SLR', 1),
                ('CFG_PULL_UP', 1),
                ('CFG_TRI_INPUT', 1),
            ],
            'PSEUDO_DIFFP': [
                ('CFG_LVDS_SEL_CUA', 2),
                ('CFG_LVDS_IN_EN', 1),
                ('CFG_KEEP', 2),
                ('CFG_PDRCTRL', 4),
                ('CFG_OPEN_DRAIN', 1),
                ('CFG_SLR', 1),
                ('CFG_PULL_UP', 1),
                ('CFG_TRI_INPUT', 1),
            ],
            'SINGLE': [
                ('CFG_KEEP', 2),
                ('CFG_PDRCTRL', 4),
                ('CFG_OPEN_DRAIN', 1),
                ('CFG_SLR', 1),
                ('CFG_PULL_UP', 1),
                ('CFG_TRI_INPUT', 1),
            ],
        }
        
        fields = []
        for io_coord in io_order:
            matched = False
            for pin in package:
                if 'tile' in pin and pin['tile'] == io_coord[:2] and pin['index'] == io_coord[2]:
                    for attr_name in attrs:
                        if attr_name in pin['attrs']:
                            for field_pair in attrs[attr_name]:
                                chain_name = field_pair[0]
                                chain_length = field_pair[1]
                                fields.append((pin['name'] + '_' + chain_name, chain_length))
                            matched = True
                            break
                    if matched:
                        break
            assert(matched)
        
        ConfigChain.__init__(self, chip, 'ALTA_DIO', fields)
