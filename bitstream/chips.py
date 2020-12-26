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

chips = []

from tiles import TileNamed
from configchain import *

class Chip:
    name = None
    device_id = 0
    rows = 0
    columns = 0
    floorplan = []
    aliases = {}
    packages = {}
    configChain = []
    lzwCompressed = False
    
    def __init__(self, name, device_id, rows, columns, floorplan, aliases, packages, configChainClasses, lzwCompressed = False):
        global chips
        assert len(floorplan) == rows * columns
        self.name = name
        self.device_id = device_id
        self.rows = rows
        self.columns = columns
        self.floorplan = floorplan
        self.aliases = aliases
        self.packages = packages
        
        configChain = []
        for ccClass in configChainClasses:
            configChain.append(ccClass(self))
        self.configChain = configChain
        self.lzwCompressed = lzwCompressed
    
    def pins_in_tile_at(self, x, y):
        result = []
        for pin in self.packages['QFN48']:
            if 'tile' in pin:
                tile = pin['tile']
                if tile[0] == x and tile[1] == y:
                    result.append(pin)
        return result
        
    def tile_at(self, x, y): 
        index = (y * self.columns) + x
        alias = self.floorplan[index]
        if alias is None:
            return None
        name = self.aliases[alias]
        return TileNamed(name)

    def column_width(self, column):
        size = 0
        for row in range(0, self.rows):
            tile = self.tile_at(column, row)
            if tile is not None:
                size = max(size, tile.columns)
        return size

    def max_row_height(self, row):
        result = 0
        for column in range(0, self.columns):
            tile = self.tile_at(column, row)
            if tile is not None:
                result = max(result, tile.rows)
        return result

    def max_row_width(self):
        result = 0
        for column in range(0, self.columns):
            result = result + self.column_width(column)
        return result
        
    def pin_at(self, row, col, slice):
        # XXX: Need to support packages...
        for pkg_name in self.packages:
            pins = self.packages[pkg_name]
            for pin in pins:
                if not "tile" in pin:
                    continue
                tile = pin['tile']
                if tile != (col, row):
                    continue
                if pin['index'] == slice:
                    return pin
        return None

def ChipNamed(name):
    for chip in chips:
        if chip.name == name:
            return chip
    return None
    
def ChipWithID(id):
    for chip in chips:
        if chip.device_id == id:
            return chip
    return None

def AddChip(chip):
    chips.append(chip)

AddChip(Chip('AG1200LP', 0x00120010, 10, 14, [
	None,     'PLL',    None,     None,    None,     None,     None,     None,     None,       'IOS2',   None,    'IOS3',   'IOS3',   None,
	'IOS0',   'IOS0',   'IOS0',   None,    'IOS1',   'IOS1',   'IOS1',   'IOS1',   'BOOT_PLL', 'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'LOGIC0', 'LOGIC0', 'LOGIC0', 'BRAM0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0', 'LOGIC0',   'LOGIC0', 'BRAM1', 'LOGIC0', 'LOGIC0', 'ROGIC0',
	'ION0',   'ION0',   'ION0',   None,    'ION1',   'ION1',   'ION1',   'ION1',   'ION1',     'ION1',   None,    'ION2',   'ION2',   None,
], {
	'PLL':      'ALTA_PLLX',
	'BOOT_PLL': 'AG1200_IOTILE_BOOT_PLL',
	'LOGIC0':   'ALTA_TILE_SRAM_DIST',
	'ROGIC0':   'IOTILE_ROUTE',
	'BRAM0':    'ALTA_EMB4K5',
	'BRAM1':    'ALTA_EMB4K5',
	'IOS0':     'AG1200_IOTILE_S4',
	'IOS1':     'AG1200_IOTILE_S4_G1',
	'IOS2':     'AG1200_IOTILE_S4',
	'IOS3':     'AG1200_IOTILE_S4',
	'ION0':     'AG1200_IOTILE_N4',
	'ION1':     'AG1200_IOTILE_N4_G1',
	'ION2':     'AG1200_IOTILE_N4',
}, {
    'AG1KLPQ48': [
        { 'name': 'PIN_1',    'type': 'IO', 'tile': (2,9),  'index': 0, 'configChainIndex': 24},
        { 'name': 'PIN_2',    'type': 'IO', 'tile': (1,9),  'index': 3, 'configChainIndex': 25},
        { 'name': 'PIN_3',    'type': 'IO', 'tile': (0,9),  'index': 2, 'configChainIndex': 27},
        { 'name': 'PIN_4',    'type': 'IO', 'tile': (0,9),  'index': 0, 'configChainIndex': 28},
        { 'name': 'PIN_5',    'type': 'IO', 'tile': (1,9),  'index': 1, 'configChainIndex': 26},
        { 'name': 'PIN_6',    'type': 'IO', 'tile': (6,9),  'index': 2, 'configChainIndex': 15},
        { 'name': 'VDDC',     'type': 'POWER'},
        { 'name': 'GND',      'type': 'POWER'},
        { 'name': 'PIN_9',    'type': 'IO', 'tile': (7,1),  'index': 0, 'configChainIndex': 1},
        { 'name': 'VDDC',     'type': 'POWER'},
        { 'name': 'PIN_11',   'type': 'IO', 'tile': (2,1),  'index': 2, 'configChainIndex': 29},
        { 'name': 'PIN_12',   'type': 'IO', 'tile': (2,1),  'index': 0, 'configChainIndex': 30},
        { 'name': 'PIN_13',   'type': 'IO', 'tile': (4,1),  'index': 2, 'configChainIndex': 31, 'globalBuffer': True}, 
        { 'name': 'PIN_14',   'type': 'IO', 'tile': (4,1),  'index': 0, 'configChainIndex': 32},
        { 'name': 'PIN_15',   'type': 'IO', 'tile': (5,1),  'index': 0, 'configChainIndex': 33, 'globalBuffer': True}, 
        { 'name': 'PIN_16',   'type': 'IO', 'tile': (5,1),  'index': 1, 'configChainIndex': 34},
        { 'name': 'PIN_17',   'type': 'IO', 'tile': (5,1),  'index': 2, 'configChainIndex': 35},
        { 'name': 'PIN_18',   'type': 'IO', 'tile': (5,1),  'index': 3, 'configChainIndex': 36},
        { 'name': 'PIN_19',   'type': 'IO', 'tile': (6,1),  'index': 0, 'configChainIndex': 37, 'globalBuffer': True}, 
        { 'name': 'PIN_20',   'type': 'IO', 'tile': (6,1),  'index': 1, 'configChainIndex': 38},
        { 'name': 'VDDIO2',   'type': 'POWER'},
        { 'name': 'PIN_22',   'type': 'IO', 'tile': (6,1),  'index': 2, 'configChainIndex': 39},
        { 'name': 'PIN_23',   'type': 'IO', 'tile': (6,1),  'index': 3, 'configChainIndex': 0},
        { 'name': 'CDONE',    'type': 'CONFIG'}, 
        { 'name': 'PIN_25',   'type': 'IO', 'tile': (9,0),  'index': 1, 'configChainIndex': 2},
        { 'name': 'PIN_26',   'type': 'IO', 'tile': (9,0),  'index': 3, 'configChainIndex': 3},
        { 'name': 'PIN_27',   'type': 'IO', 'tile': (11,0), 'index': 1, 'configChainIndex': 4}, # SPI SDO
        { 'name': 'VDDSPI',   'type': 'POWER'},
        { 'name': 'PIN_29',   'type': 'IO', 'tile': (12,0), 'index': 0, 'configChainIndex': 6}, # SPI SS
        { 'name': 'CRESET_B', 'type': 'CONFIG'},
        { 'name': 'PIN_31',   'type': 'IO', 'tile': (12,0), 'index': 2, 'configChainIndex': 7}, # SPI SCK
        { 'name': 'PIN_32',   'type': 'IO', 'tile': (11,0), 'index': 3, 'configChainIndex': 5}, # SPI SDI
        { 'name': 'PIN_33',   'type': 'IO', 'tile': (8,9),  'index': 0, 'configChainIndex': 12},
        { 'name': 'PIN_34',   'type': 'IO', 'tile': (11,9), 'index': 1, 'configChainIndex': 8},
        { 'name': 'PIN_35',   'type': 'IO', 'tile': (9,9),  'index': 3, 'configChainIndex': 9},
        { 'name': 'PIN_36',   'type': 'IO', 'tile': (9,9),  'index': 1, 'configChainIndex': 10},
        { 'name': 'PIN_37',   'type': 'IO', 'tile': (8,9),  'index': 3, 'configChainIndex': 11},
        { 'name': 'PIN_38',   'type': 'IO', 'tile': (7,9),  'index': 3, 'configChainIndex': 13},
        { 'name': 'PIN_39',   'type': 'IO', 'tile': (7,9),  'index': 0, 'configChainIndex': 14}, 
        { 'name': 'PIN_40',   'type': 'IO', 'tile': (6,9),  'index': 0, 'configChainIndex': 16}, 
        { 'name': 'PIN_41',   'type': 'IO', 'tile': (5,9),  'index': 3, 'configChainIndex': 17},
        { 'name': 'PIN_42',   'type': 'IO', 'tile': (5,9),  'index': 2, 'configChainIndex': 18},
        { 'name': 'PIN_43',   'type': 'IO', 'tile': (5,9),  'index': 1, 'configChainIndex': 19},
        { 'name': 'PIN_44',   'type': 'IO', 'tile': (5,9),  'index': 0, 'configChainIndex': 20}, 
        { 'name': 'PIN_45',   'type': 'IO', 'tile': (4,9),  'index': 2, 'configChainIndex': 21},
        { 'name': 'PIN_46',   'type': 'IO', 'tile': (4,9),  'index': 0, 'configChainIndex': 22}, 
        { 'name': 'VDDIO',    'type': 'POWER' },
        { 'name': 'PIN_48',   'type': 'IO', 'tile': (2,9),  'index': 2, 'configChainIndex': 23}
    ],
    'AG1280Q48': [
        { 'name' :'PIN_1',     'type': 'IO', 'tile': (2,9),  'index': 0 },
        { 'name' :'PIN_2',     'type': 'IO', 'tile': (1,9),  'index': 3 },
        { 'name' :'PIN_3',     'type': 'IO', 'tile': (0,9),  'index': 2 },
        { 'name' :'PIN_4',     'type': 'IO', 'tile': (0,9),  'index': 0 },
        { 'name' :'PIN_5',     'type': 'IO', 'tile': (1,9),  'index': 1 },
        { 'name' :'PIN_6',     'type': 'IO', 'tile': (6,9),  'index': 2 },
        { 'name' :'PIN_9',     'type': 'IO', 'tile': (7,1),  'index': 0 },
        { 'name' :'PIN_11',    'type': 'IO', 'tile': (2,1),  'index': 0 },
        { 'name' :'PIN_12',    'type': 'IO', 'tile': (2,1),  'index': 2 },
        { 'name' :'PIN_13',    'type': 'IO', 'tile': (4,1),  'index': 0 },
        { 'name' :'PIN_14',    'type': 'IO', 'tile': (4,1),  'index': 2 },
        { 'name' :'PIN_15',    'type': 'IO', 'tile': (5,1),  'index': 0 },
        { 'name' :'PIN_16',    'type': 'IO', 'tile': (5,1),  'index': 1 },
        { 'name' :'PIN_17',    'type': 'IO', 'tile': (5,1),  'index': 2 },
        { 'name' :'PIN_18',    'type': 'IO', 'tile': (5,1),  'index': 3 },
        { 'name' :'PIN_19',    'type': 'IO', 'tile': (6,1),  'index': 0 },
        { 'name' :'PIN_20',    'type': 'IO', 'tile': (6,1),  'index': 1 },
        { 'name' :'PIN_22',    'type': 'IO', 'tile': (6,1),  'index': 2 },
        { 'name' :'PIN_23',    'type': 'IO', 'tile': (6,1),  'index': 3 },
        { 'name' :'PIN_25',    'type': 'IO', 'tile': (9,0),  'index': 3 },
        { 'name' :'PIN_41',    'type': 'IO', 'tile': (6,9),  'index': 0 },
        { 'name' :'PIN_42',    'type': 'IO', 'tile': (5,9),  'index': 2 },
        { 'name' :'PIN_43',    'type': 'IO', 'tile': (5,9),  'index': 1 },
        { 'name' :'PIN_44',    'type': 'IO', 'tile': (5,9),  'index': 0 },
        { 'name' :'PIN_45',    'type': 'IO', 'tile': (4,9),  'index': 2 },
        { 'name' :'PIN_46',    'type': 'IO', 'tile': (4,9),  'index': 0 },
        { 'name' :'PIN_48',    'type': 'IO', 'tile': (2,9),  'index': 2 },
    ],
    'AG1280Q32': [
        { 'name' :'PIN_1',        'type': 'IO', 'tile': (0,9),  'index': 2 },
        { 'name' :'PIN_2',        'type': 'IO', 'tile': (0,9),  'index': 0 },
        { 'name' :'PIN_3',        'type': 'IO', 'tile': (1,9),  'index': 1 },
        { 'name' :'PIN_6',        'type': 'IO', 'tile': (7,1),  'index': 0 },
        { 'name' :'PIN_8',        'type': 'IO', 'tile': (2,1),  'index': 0 },
        { 'name' :'PIN_9',        'type': 'IO', 'tile': (2,1),  'index': 2 },
        { 'name' :'PIN_10',       'type': 'IO', 'tile': (4,1),  'index': 0 },
        { 'name' :'PIN_11',       'type': 'IO', 'tile': (4,1),  'index': 2 },
        { 'name' :'PIN_12',       'type': 'IO', 'tile': (5,1),  'index': 0 },
        { 'name' :'PIN_13',       'type': 'IO', 'tile': (6,1),  'index': 0 },
        { 'name' :'PIN_14',       'type': 'IO', 'tile': (6,1),  'index': 1 },
        { 'name' :'PIN_31',       'type': 'IO', 'tile': (5,9),  'index': 0 },
    ],
}, [
    ConfigChainIO, ConfigChainPLL
]))

AddChip(Chip('AG10K', 0x01000001, 41, 25, [
    None, 'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   'IO',   None,    'IO',   'IO',   'IO',   'IO',   'IO',   None,  'IO',   'IO',   'IO',   'IO',   'IO',   None,  'IO',   'IO',   'IO',   'IO',   'IO',   None,   None, 
    'PLL','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'IO', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    'UFM','UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, 'UFM',  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IO', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'IO',   'IO',   'IO',   'IO',   'IO',   'Clkdis','IO',   'IO',   'IO',   'IO',   'IO',   None,  'IO',   'IO',   'IO',   'IO',   'IO',   None,  'IO',   'IO',   'IO',   'IO',   'IO',   None,   None, 
], {
    # aliases
	'Logic':   'ALTA_TILE_SRAM_DIST',
    'Bram':    'alta_bram9k',
    'Mult':    'alta_multiplier',
}, {
    # packages
    'AG10KSDE176': [
        
    ]
}, [
    # config chain
], lzwCompressed=True))

AddChip(Chip('AG15K', 0x01500010, 50, 30, [
    None, 'UFM',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  None,  'IOS',  'IOS',  'IOS',  'IOS',  None,    'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  None,  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  None,    'IOS',  'IOS',  'IOS',  'IOS',  'IOS',  'UFM',  None,   None, 
    'PLL','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    'UFM','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','UFM',
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'IOE','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'PLL','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    'UFM','UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, 'UFM',  'UFM',  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW', 
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    None, None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'ION',  'ION',  None,  'ION',  'ION',  'ION',  'ION',  'Clkdis','ION',  'ION',  'ION',  'ION',  'ION',  'ION',  'ION',  None,  'ION',  'ION',  'ION',  'ION',  'ION',  'ION',  'ION',  'ION',  'ION',  'Clkdis','ION',  'ION',  'ION',  'ION',  'UFM',  'UFM',  None,   None, 
], {
    # aliases
	'Logic':   'ALTA_TILE_SRAM_DIST',
    'Bram':    'alta_bram9k',
    'Mult':    'alta_multiplier',
}, {
    # packages
    'AG16KSDE176': [        
        { 'name': 'PIN_1',     'type': 'IO','tile': (16,29),'index': 0,},
        { 'name': 'PIN_2',     'type': 'IO','tile': (0, 16),'index': 1,},
        { 'name': 'PIN_3',     'type': 'IO','tile': (0, 16),'index': 0,},
        { 'name': 'PIN_4',     'type': 'IO','tile': (0, 16),'index': 3,},
        { 'name': 'PIN_6',     'type': 'IO','tile': (0, 16),'index': 2,},
        { 'name': 'PIN_8',     'type': 'IO','tile': (0, 15),'index': 0,},
        { 'name': 'PIN_9',     'type': 'IO','tile': (0, 15),'index': 4,},
        { 'name': 'PIN_10',    'type': 'IO','tile': (0, 15),'index': 3,},
        { 'name': 'PIN_13',    'type': 'IO','tile': (0, 13),'index': 2,},
        { 'name': 'PIN_14',    'type': 'IO','tile': (0, 13),'index': 1,},
        { 'name': 'PIN_15',    'type': 'IO','tile': (0, 13),'index': 4,},
        { 'name': 'PIN_16',    'type': 'IO','tile': (0, 13),'index': 5,},
        { 'name': 'PIN_18',    'type': 'IO','tile': (0, 18),'index': 1,},
        { 'name': 'PIN_19',    'type': 'IO','tile': (0, 18),'index': 2,},
        { 'name': 'PIN_21',    'type': 'IO','tile': (0, 18),'index': 3,},
        { 'name': 'PIN_22',    'type': 'IO','tile': (0, 18),'index': 4,},
        { 'name': 'PIN_23',    'type': 'IO','tile': (0, 12),'index': 0,},
        { 'name': 'PIN_24',    'type': 'IO','tile': (0, 12),'index': 3,},
        { 'name': 'PIN_25',    'type': 'IO','tile': (0, 12),'index': 2,},
        { 'name': 'PIN_26',    'type': 'IO','tile': (0, 10),'index': 1,},
        { 'name': 'PIN_27',    'type': 'IO','tile': (0, 10),'index': 0,},
        { 'name': 'PIN_31',    'type': 'IO','tile': (0, 8), 'index': 2,},
        { 'name': 'PIN_32',    'type': 'IO','tile': (0, 8), 'index': 1,},
        { 'name': 'PIN_33',    'type': 'IO','tile': (0, 6), 'index': 0,},
        { 'name': 'PIN_34',    'type': 'IO','tile': (0, 5), 'index': 1,},
        { 'name': 'PIN_35',    'type': 'IO','tile': (0, 5), 'index': 0,},
        { 'name': 'PIN_36',    'type': 'IO','tile': (0, 5), 'index': 5,},
        { 'name': 'PIN_37',    'type': 'IO','tile': (0, 4), 'index': 0,},
        { 'name': 'PIN_38',    'type': 'IO','tile': (0, 4), 'index': 3,},
        { 'name': 'PIN_39',    'type': 'IO','tile': (0, 4), 'index': 2,},
        { 'name': 'PIN_40',    'type': 'IO','tile': (0, 3), 'index': 3,},
        { 'name': 'PIN_42',    'type': 'IO','tile': (0, 3), 'index': 2,},
        { 'name': 'PIN_46',    'type': 'IO','tile': (2, 0), 'index': 1,},
        { 'name': 'PIN_47',    'type': 'IO','tile': (2, 0), 'index': 0,},
        { 'name': 'PIN_48',    'type': 'IO','tile': (3, 0), 'index': 1,},
        { 'name': 'PIN_49',    'type': 'IO','tile': (3, 0), 'index': 0,},
        { 'name': 'PIN_50',    'type': 'IO','tile': (3, 0), 'index': 3,},
        { 'name': 'PIN_52',    'type': 'IO','tile': (6, 0), 'index': 1,},
        { 'name': 'PIN_53',    'type': 'IO','tile': (6, 0), 'index': 0,},
        { 'name': 'PIN_56',    'type': 'IO','tile': (15,0), 'index': 1,},
        { 'name': 'PIN_57',    'type': 'IO','tile': (15,0), 'index': 0,},
        { 'name': 'PIN_58',    'type': 'IO','tile': (19,0), 'index': 0,},
        { 'name': 'PIN_59',    'type': 'IO','tile': (19,0), 'index': 2,},
        { 'name': 'PIN_60',    'type': 'IO','tile': (20,0), 'index': 1,},
        { 'name': 'PIN_61',    'type': 'IO','tile': (20,0), 'index': 0,},
        { 'name': 'PIN_62',    'type': 'IO','tile': (21,0), 'index': 3,},
        { 'name': 'PIN_63',    'type': 'IO','tile': (21,0), 'index': 2,},
        { 'name': 'PIN_64',    'type': 'IO','tile': (24,0), 'index': 1,},
        { 'name': 'PIN_65',    'type': 'IO','tile': (24,0), 'index': 0,},
        { 'name': 'PIN_67',    'type': 'IO','tile': (25,0), 'index': 2,},
        { 'name': 'PIN_70',    'type': 'IO','tile': (32,0), 'index': 2,},
        { 'name': 'PIN_72',    'type': 'IO','tile': (34,0), 'index': 0,},
        { 'name': 'PIN_74',    'type': 'IO','tile': (34,0), 'index': 3,},
        { 'name': 'PIN_75',    'type': 'IO','tile': (34,0), 'index': 2,},
        { 'name': 'PIN_76',    'type': 'IO','tile': (36,0), 'index': 3,},
        { 'name': 'PIN_77',    'type': 'IO','tile': (36,0), 'index': 2,},
        { 'name': 'PIN_78',    'type': 'IO','tile': (39,0), 'index': 3,},
        { 'name': 'PIN_79',    'type': 'IO','tile': (39,0), 'index': 2,},
        { 'name': 'PIN_80',    'type': 'IO','tile': (40,0), 'index': 0,},
        { 'name': 'PIN_81',    'type': 'IO','tile': (40,0), 'index': 1,},
        { 'name': 'PIN_83',    'type': 'IO','tile': (43,0), 'index': 0,},
        { 'name': 'PIN_85',    'type': 'IO','tile': (43,0), 'index': 3,},
        { 'name': 'PIN_86',    'type': 'IO','tile': (43,0), 'index': 2,},
        { 'name': 'PIN_87',    'type': 'IO','tile': (45,0), 'index': 3,},
        { 'name': 'PIN_88',    'type': 'IO','tile': (45,0), 'index': 2,},
        { 'name': 'PIN_89',    'type': 'IO','tile': (49,3), 'index': 3,},
        { 'name': 'PIN_90',    'type': 'IO','tile': (49,3), 'index': 2,},
        { 'name': 'PIN_91',    'type': 'IO','tile': (49,3), 'index': 1,},
        { 'name': 'PIN_92',    'type': 'IO','tile': (49,3), 'index': 0,},
        { 'name': 'PIN_93',    'type': 'IO','tile': (49,4), 'index': 5,},
        { 'name': 'PIN_94',    'type': 'IO','tile': (49,4), 'index': 4,},
        { 'name': 'PIN_95',    'type': 'IO','tile': (49,4), 'index': 2,},
        { 'name': 'PIN_96',    'type': 'IO','tile': (49,4), 'index': 1,},
        { 'name': 'PIN_98',    'type': 'IO','tile': (49,5), 'index': 1,},
        { 'name': 'PIN_100',   'type': 'IO','tile': (49,5), 'index': 0,},
        { 'name': 'PIN_101',   'type': 'IO','tile': (49,6), 'index': 0,},
        { 'name': 'PIN_102',   'type': 'IO','tile': (49,7), 'index': 3,},
        { 'name': 'PIN_103',   'type': 'IO','tile': (49,7), 'index': 2,},
        { 'name': 'PIN_104',   'type': 'IO','tile': (49,9), 'index': 3,},
        { 'name': 'PIN_106',   'type': 'IO','tile': (49,13),'index': 3,},
        { 'name': 'PIN_107',   'type': 'IO','tile': (49,13),'index': 2,},
        { 'name': 'PIN_108',   'type': 'IO','tile': (49,13),'index': 1,},
        { 'name': 'PIN_109',   'type': 'IO','tile': (49,13),'index': 0,},
        { 'name': 'PIN_110',   'type': 'IO','tile': (49,14),'index': 3,},
        { 'name': 'PIN_111',   'type': 'IO','tile': (49,15),'index': 3,},
        { 'name': 'PIN_112',   'type': 'IO','tile': (49,15),'index': 2,},
        { 'name': 'PIN_114',   'type': 'IO','tile': (49,15),'index': 1,},
        { 'name': 'PIN_115',   'type': 'IO','tile': (49,15),'index': 0,},
        { 'name': 'PIN_119',   'type': 'IO','tile': (49,19),'index': 2,},
        { 'name': 'PIN_120',   'type': 'IO','tile': (49,19),'index': 1,},
        { 'name': 'PIN_122',   'type': 'IO','tile': (49,19),'index': 0,},
        { 'name': 'PIN_124',   'type': 'IO','tile': (49,20),'index': 2,},
        { 'name': 'PIN_125',   'type': 'IO','tile': (49,24),'index': 5,},
        { 'name': 'PIN_126',   'type': 'IO','tile': (49,24),'index': 4,},
        { 'name': 'PIN_128',   'type': 'IO','tile': (49,26),'index': 5,},
        { 'name': 'PIN_129',   'type': 'IO','tile': (49,26),'index': 4,},
        { 'name': 'PIN_130',   'type': 'IO','tile': (49,27),'index': 2,},
        { 'name': 'PIN_134',   'type': 'IO','tile': (45,29),'index': 2,},
        { 'name': 'PIN_135',   'type': 'IO','tile': (45,29),'index': 1,},
        { 'name': 'PIN_136',   'type': 'IO','tile': (43,29),'index': 1,},
        { 'name': 'PIN_137',   'type': 'IO','tile': (43,29),'index': 0,},
        { 'name': 'PIN_139',   'type': 'IO','tile': (42,29),'index': 1,},
        { 'name': 'PIN_140',   'type': 'IO','tile': (42,29),'index': 0,},
        { 'name': 'PIN_142',   'type': 'IO','tile': (34,29),'index': 3,},
        { 'name': 'PIN_143',   'type': 'IO','tile': (34,29),'index': 2,},
        { 'name': 'PIN_144',   'type': 'IO','tile': (34,29),'index': 1,},
        { 'name': 'PIN_146',   'type': 'IO','tile': (34,29),'index': 0,},
        { 'name': 'PIN_148',   'type': 'IO','tile': (33,29),'index': 1,},
        { 'name': 'PIN_151',   'type': 'IO','tile': (30,29),'index': 1,},
        { 'name': 'PIN_152',   'type': 'IO','tile': (30,29),'index': 0,},
        { 'name': 'PIN_153',   'type': 'IO','tile': (27,29),'index': 2,},
        { 'name': 'PIN_154',   'type': 'IO','tile': (27,29),'index': 1,},
        { 'name': 'PIN_156',   'type': 'IO','tile': (26,29),'index': 1,},
        { 'name': 'PIN_157',   'type': 'IO','tile': (25,29),'index': 3,},
        { 'name': 'PIN_158',   'type': 'IO','tile': (25,29),'index': 2,},
        { 'name': 'PIN_159',   'type': 'IO','tile': (24,29),'index': 2,},
        { 'name': 'PIN_160',   'type': 'IO','tile': (24,29),'index': 1,},
        { 'name': 'PIN_162',   'type': 'IO','tile': (21,29),'index': 3,},
        { 'name': 'PIN_163',   'type': 'IO','tile': (21,29),'index': 2,},
        { 'name': 'PIN_165',   'type': 'IO','tile': (21,29),'index': 1,},
        { 'name': 'PIN_166',   'type': 'IO','tile': (21,29),'index': 0,},
        { 'name': 'PIN_168',   'type': 'IO','tile': (20,29),'index': 1,},
        { 'name': 'PIN_170',   'type': 'IO','tile': (20,29),'index': 0,},
        { 'name': 'PIN_171',   'type': 'IO','tile': (19,29),'index': 1,},
        { 'name': 'PIN_172',   'type': 'IO','tile': (19,29),'index': 0,},
        { 'name': 'PIN_173',   'type': 'IO','tile': (17,29),'index': 3,},
        { 'name': 'PIN_175',   'type': 'IO','tile': (17,29),'index': 2,},
        { 'name': 'PIN_176',   'type': 'IO','tile': (16,29),'index': 1,},
        { 'name': 'SDRAM_A0',  'type': 'IO','tile': (32,29),'index': 3,},
        { 'name': 'SDRAM_A1',  'type': 'IO','tile': (33,29),'index': 2,},
        { 'name': 'SDRAM_A2',  'type': 'IO','tile': (33,29),'index': 3,},
        { 'name': 'SDRAM_A3',  'type': 'IO','tile': (37,29),'index': 0,},
        { 'name': 'SDRAM_A4',  'type': 'IO','tile': (33,0), 'index': 2,},
        { 'name': 'SDRAM_A5',  'type': 'IO','tile': (33,0), 'index': 3,},
        { 'name': 'SDRAM_A6',  'type': 'IO','tile': (33,0), 'index': 0,},
        { 'name': 'SDRAM_A7',  'type': 'IO','tile': (33,0), 'index': 1,},
        { 'name': 'SDRAM_A8',  'type': 'IO','tile': (28,0), 'index': 2,},
        { 'name': 'SDRAM_A9',  'type': 'IO','tile': (28,0), 'index': 3,},
        { 'name': 'SDRAM_A10', 'type': 'IO','tile': (32,29),'index': 2,},
        { 'name': 'SDRAM_BA0', 'type': 'IO','tile': (30,29),'index': 3,},
        { 'name': 'SDRAM_BA1', 'type': 'IO','tile': (30,29),'index': 2,},
        { 'name': 'SDRAM_CAS', 'type': 'IO','tile': (25,0), 'index': 3,},
        { 'name': 'SDRAM_CKE', 'type': 'IO','tile': (25,0), 'index': 1,},
        { 'name': 'SDRAM_CLK', 'type': 'IO','tile': (28,29),'index': 3,},
        { 'name': 'SDRAM_CS',  'type': 'IO','tile': (27,0), 'index': 0,},
        { 'name': 'SDRAM_DQ0', 'type': 'IO','tile': (5, 0), 'index': 3,},
        { 'name': 'SDRAM_DQ1', 'type': 'IO','tile': (5, 0), 'index': 2,},
        { 'name': 'SDRAM_DQ2', 'type': 'IO','tile': (11,0), 'index': 1,},
        { 'name': 'SDRAM_DQ3', 'type': 'IO','tile': (11,0), 'index': 0,},
        { 'name': 'SDRAM_DQ4', 'type': 'IO','tile': (15,0), 'index': 3,},
        { 'name': 'SDRAM_DQ5', 'type': 'IO','tile': (15,0), 'index': 2,},
        { 'name': 'SDRAM_DQ6', 'type': 'IO','tile': (20,0), 'index': 2,},
        { 'name': 'SDRAM_DQ7', 'type': 'IO','tile': (21,0), 'index': 1,},
        { 'name': 'SDRAM_DQ8', 'type': 'IO','tile': (25,29),'index': 1,},
        { 'name': 'SDRAM_DQ9', 'type': 'IO','tile': (25,29),'index': 0,},
        { 'name': 'SDRAM_DQ10','type': 'IO','tile': (22,29),'index': 3,},
        { 'name': 'SDRAM_DQ11','type': 'IO','tile': (22,29),'index': 2,},
        { 'name': 'SDRAM_DQ12','type': 'IO','tile': (22,29),'index': 1,},
        { 'name': 'SDRAM_DQ13','type': 'IO','tile': (22,29),'index': 0,},
        { 'name': 'SDRAM_DQ14','type': 'IO','tile': (20,29),'index': 3,},
        { 'name': 'SDRAM_DQ15','type': 'IO','tile': (20,29),'index': 2,},
        { 'name': 'SDRAM_DQ16','type': 'IO','tile': (49,14),'index': 5,},
        { 'name': 'SDRAM_DQ17','type': 'IO','tile': (49,14),'index': 4,},
        { 'name': 'SDRAM_DQ18','type': 'IO','tile': (42,0), 'index': 2,},
        { 'name': 'SDRAM_DQ19','type': 'IO','tile': (42,0), 'index': 3,},
        { 'name': 'SDRAM_DQ20','type': 'IO','tile': (40,0), 'index': 2,},
        { 'name': 'SDRAM_DQ21','type': 'IO','tile': (40,0), 'index': 3,},
        { 'name': 'SDRAM_DQ22','type': 'IO','tile': (39,0), 'index': 0,},
        { 'name': 'SDRAM_DQ23','type': 'IO','tile': (39,0), 'index': 1,},
        { 'name': 'SDRAM_DQ24','type': 'IO','tile': (37,29),'index': 2,},
        { 'name': 'SDRAM_DQ25','type': 'IO','tile': (37,29),'index': 3,},
        { 'name': 'SDRAM_DQ26','type': 'IO','tile': (38,29),'index': 2,},
        { 'name': 'SDRAM_DQ27','type': 'IO','tile': (38,29),'index': 3,},
        { 'name': 'SDRAM_DQ28','type': 'IO','tile': (39,29),'index': 0,},
        { 'name': 'SDRAM_DQ29','type': 'IO','tile': (39,29),'index': 1,},
        { 'name': 'SDRAM_DQ30','type': 'IO','tile': (44,29),'index': 2,},
        { 'name': 'SDRAM_DQ31','type': 'IO','tile': (44,29),'index': 3,},
        { 'name': 'SDRAM_DQM0','type': 'IO','tile': (21,0), 'index': 0,},
        { 'name': 'SDRAM_DQM1','type': 'IO','tile': (26,29),'index': 3,},
        { 'name': 'SDRAM_DQM2','type': 'IO','tile': (34,0), 'index': 1,},
        { 'name': 'SDRAM_DQM3','type': 'IO','tile': (37,29),'index': 1,},
        { 'name': 'SDRAM_RAS', 'type': 'IO','tile': (27,0), 'index': 1,},
        { 'name': 'SDRAM_WE',  'type': 'IO','tile': (25,0), 'index': 0,},
    ] # end AG16KSDE176
}, [
    # config chain
], lzwCompressed=True))
