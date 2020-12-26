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
        chips.append(self)
    
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

Chip('AG1KLP', 0x00120010, 10, 14, [
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
])