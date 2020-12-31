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
    extra = {}
    lzwCompressed = False
    
    def __init__(self, name, device_id, rows, columns, floorplan, aliases, packages, configChainClasses, lzwCompressed = False, extra={}):
        global chips
        assert len(floorplan) == rows * columns
        self.name = name
        self.device_id = device_id
        self.rows = rows
        self.columns = columns
        self.floorplan = floorplan
        self.aliases = aliases
        self.packages = packages
        self.extra = extra
        
        configChain = []
        for ccClass in configChainClasses:
            if ccClass is None:
                configChain.append(None)
            else:
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
        name = self.floorplan[index]
        if name is None:
            return None
        if name in self.aliases:
            name = self.aliases[name]
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

AddChip(Chip('AG1200LP', 0x00120010, 10, 14, floorplan=[
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
], aliases={
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
}, packages={
    'AG1KLPQ48': [
        {'name':'PIN_1',   'type':'IO','tile':(2, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_2',   'type':'IO','tile':(1, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_3',   'type':'IO','tile':(0, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_4',   'type':'IO','tile':(0, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_5',   'type':'IO','tile':(1, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_6',   'type':'IO','tile':(6, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_9',   'type':'IO','tile':(7, 1),'index':0,'iobank':'2','attrs':['SINGLE_D3']},   
        {'name':'PIN_11',  'type':'IO','tile':(2, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_12',  'type':'IO','tile':(2, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_13',  'type':'IO','tile':(4, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      # was globalBuffer
        {'name':'PIN_14',  'type':'IO','tile':(4, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_15',  'type':'IO','tile':(5, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      # was globalBuffer
        {'name':'PIN_16',  'type':'IO','tile':(5, 1),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_17',  'type':'IO','tile':(5, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_18',  'type':'IO','tile':(5, 1),'index':3,'iobank':'2','attrs':['SINGLE']},      # was globalBuffer
        {'name':'PIN_19',  'type':'IO','tile':(6, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_20',  'type':'IO','tile':(6, 1),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_22',  'type':'IO','tile':(6, 1),'index':2,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'PIN_23',  'type':'IO','tile':(6, 1),'index':3,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'PIN_25',  'type':'IO','tile':(9, 0),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_26',  'type':'IO','tile':(9, 0),'index':3,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_27',  'type':'IO','tile':(11,0),'index':1,'iobank':'0','attrs':['SINGLE_D1']},   # SPI SDO
        {'name':'PIN_29',  'type':'IO','tile':(12,0),'index':0,'iobank':'0','attrs':['SINGLE_D2']},   # SPI SS
        {'name':'PIN_31',  'type':'IO','tile':(12,0),'index':2,'iobank':'0','attrs':['SINGLE_D2']},   # SPI SCK
        {'name':'PIN_32',  'type':'IO','tile':(11,0),'index':3,'iobank':'0','attrs':['SINGLE_D0']},   # SPI SDI
        {'name':'PIN_33',  'type':'IO','tile':(8, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_34',  'type':'IO','tile':(11,9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_35',  'type':'IO','tile':(9, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_36',  'type':'IO','tile':(9, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_37',  'type':'IO','tile':(8, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_38',  'type':'IO','tile':(7, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_39',  'type':'IO','tile':(7, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_40',  'type':'IO','tile':(6, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_41',  'type':'IO','tile':(5, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_42',  'type':'IO','tile':(5, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_43',  'type':'IO','tile':(5, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_44',  'type':'IO','tile':(5, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_45',  'type':'IO','tile':(4, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_46',  'type':'IO','tile':(4, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_48',  'type':'IO','tile':(2, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      

        {'name':'CDONE',   'type':'IO','tile':(7, 1),'index':1,'iobank':'2','attrs':['DEDICATE_OUT']},
        {'name':'CRESET_B','type':'IO','tile':(7, 1),'index':2,'iobank':'2','attrs':['DEDICATE_IN']}, 
        {'name':'POR_TEST','type':'IO','tile':(9, 9),'index':0,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'TCK',     'type':'IO','tile':(7, 9),'index':2,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'TDI',     'type':'IO','tile':(7, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'TDO',     'type':'IO','tile':(8, 9),'index':2,'iobank':'0','attrs':['DEDICATE_OUT']},
        {'name':'TMS',     'type':'IO','tile':(8, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
    ],
    'AG1280Q48': [
        {'name':'PIN_1',    'type':'IO','tile':(2, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_2',    'type':'IO','tile':(1, 9),'index':3,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_3',    'type':'IO','tile':(0, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_4',    'type':'IO','tile':(0, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_5',    'type':'IO','tile':(1, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_6',    'type':'IO','tile':(6, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_9',    'type':'IO','tile':(7, 1),'index':0,'iobank':'2','attrs':['SINGLE_D3']},   
        {'name':'PIN_11',   'type':'IO','tile':(2, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_12',   'type':'IO','tile':(2, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_13',   'type':'IO','tile':(4, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_14',   'type':'IO','tile':(4, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_15',   'type':'IO','tile':(5, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_16',   'type':'IO','tile':(5, 1),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_17',   'type':'IO','tile':(5, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_18',   'type':'IO','tile':(5, 1),'index':3,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_19',   'type':'IO','tile':(6, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_20',   'type':'IO','tile':(6, 1),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_22',   'type':'IO','tile':(6, 1),'index':2,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'PIN_23',   'type':'IO','tile':(6, 1),'index':3,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'PIN_25',   'type':'IO','tile':(9, 0),'index':3,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_41',   'type':'IO','tile':(6, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_42',   'type':'IO','tile':(5, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_43',   'type':'IO','tile':(5, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_44',   'type':'IO','tile':(5, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_45',   'type':'IO','tile':(4, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_46',   'type':'IO','tile':(4, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_48',   'type':'IO','tile':(2, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      

        {'name':'NC_14',    'type':'IO','tile':(9, 0),'index':1,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_16_SDO','type':'IO','tile':(11,0),'index':1,'iobank':'0','attrs':['SINGLE_D1']},   
        {'name':'NC_17_SDI','type':'IO','tile':(11,0),'index':3,'iobank':'0','attrs':['SINGLE_D0']},   
        {'name':'NC_18_SS', 'type':'IO','tile':(12,0),'index':0,'iobank':'0','attrs':['SINGLE_D2']},   
        {'name':'NC_19_SCK','type':'IO','tile':(12,0),'index':2,'iobank':'0','attrs':['SINGLE_D2']},   
        {'name':'NC_21',    'type':'IO','tile':(9, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_29',    'type':'IO','tile':(5, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   

        {'name':'CDONE',    'type':'IO','tile':(7, 1),'index':1,'iobank':'2','attrs':['DEDICATE_OUT']},
        {'name':'CRESET_B', 'type':'IO','tile':(7, 1),'index':2,'iobank':'2','attrs':['DEDICATE_IN']}, 
        {'name':'DATAOUT',  'type':'IO','tile':(9, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'INT_TCK',  'type':'IO','tile':(7, 9),'index':2,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'INT_TDI',  'type':'IO','tile':(7, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'INT_TDO',  'type':'IO','tile':(8, 9),'index':2,'iobank':'0','attrs':['DEDICATE_OUT']},
        {'name':'INT_TMS',  'type':'IO','tile':(8, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'POR_TEST', 'type':'IO','tile':(9, 9),'index':0,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'TCK',      'type':'IO','tile':(7, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TDI',      'type':'IO','tile':(7, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TDO',      'type':'IO','tile':(8, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TMS',      'type':'IO','tile':(8, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'nCS',      'type':'IO','tile':(11,9),'index':1,'iobank':'0','attrs':['SINGLE']},      
    ],
    'AG1280Q32': [
        {'name':'PIN_1',       'type':'IO','tile':(0, 9),'index':2,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_2',       'type':'IO','tile':(0, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_3',       'type':'IO','tile':(1, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'PIN_6',       'type':'IO','tile':(7, 1),'index':0,'iobank':'2','attrs':['SINGLE_D3']},   
        {'name':'PIN_8',       'type':'IO','tile':(2, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_9',       'type':'IO','tile':(2, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_10',      'type':'IO','tile':(4, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_11',      'type':'IO','tile':(4, 1),'index':2,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_12',      'type':'IO','tile':(5, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_13',      'type':'IO','tile':(6, 1),'index':0,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_14',      'type':'IO','tile':(6, 1),'index':1,'iobank':'2','attrs':['SINGLE']},      
        {'name':'PIN_31',      'type':'IO','tile':(5, 9),'index':0,'iobank':'0','attrs':['SINGLE']},      

        {'name':'NC_6',        'type':'IO','tile':(5, 1),'index':1,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_7',        'type':'IO','tile':(5, 1),'index':2,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_8',        'type':'IO','tile':(5, 1),'index':3,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_11_CBSEL0','type':'IO','tile':(6, 1),'index':2,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'NC_12_CBSEL1','type':'IO','tile':(6, 1),'index':3,'iobank':'2','attrs':['SINGLE_D0']},   
        {'name':'NC_14',       'type':'IO','tile':(9, 0),'index':1,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_15',       'type':'IO','tile':(9, 0),'index':3,'iobank':'2','attrs':['NC_SINGLE']},   
        {'name':'NC_16_SDO',   'type':'IO','tile':(11,0),'index':1,'iobank':'0','attrs':['SINGLE_D1']},   
        {'name':'NC_17_SDI',   'type':'IO','tile':(11,0),'index':3,'iobank':'0','attrs':['SINGLE_D0']},   
        {'name':'NC_18_SS',    'type':'IO','tile':(12,0),'index':0,'iobank':'0','attrs':['SINGLE_D2']},   
        {'name':'NC_19_SCK',   'type':'IO','tile':(12,0),'index':2,'iobank':'0','attrs':['SINGLE_D2']},   
        {'name':'NC_21',       'type':'IO','tile':(9, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_27',       'type':'IO','tile':(6, 9),'index':2,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_28_GB',    'type':'IO','tile':(6, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_29',       'type':'IO','tile':(5, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_30',       'type':'IO','tile':(5, 9),'index':2,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_31',       'type':'IO','tile':(5, 9),'index':1,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_33',       'type':'IO','tile':(4, 9),'index':2,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_34_GB',    'type':'IO','tile':(4, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_35',       'type':'IO','tile':(2, 9),'index':2,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_36',       'type':'IO','tile':(2, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'NC_37',       'type':'IO','tile':(1, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   

        {'name':'CDONE',       'type':'IO','tile':(7, 1),'index':1,'iobank':'2','attrs':['DEDICATE_OUT']},
        {'name':'CRESET_B',    'type':'IO','tile':(7, 1),'index':2,'iobank':'2','attrs':['DEDICATE_IN']}, 
        {'name':'DATAOUT',     'type':'IO','tile':(9, 9),'index':1,'iobank':'0','attrs':['SINGLE']},      
        {'name':'INT_TCK',     'type':'IO','tile':(7, 9),'index':2,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'INT_TDI',     'type':'IO','tile':(7, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'INT_TDO',     'type':'IO','tile':(8, 9),'index':2,'iobank':'0','attrs':['DEDICATE_OUT']},
        {'name':'INT_TMS',     'type':'IO','tile':(8, 9),'index':1,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'POR_TEST',    'type':'IO','tile':(9, 9),'index':0,'iobank':'0','attrs':['DEDICATE_IN']}, 
        {'name':'TCK',         'type':'IO','tile':(7, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TDI',         'type':'IO','tile':(7, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TDO',         'type':'IO','tile':(8, 9),'index':3,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'TMS',         'type':'IO','tile':(8, 9),'index':0,'iobank':'0','attrs':['NC_SINGLE']},   
        {'name':'nCS',         'type':'IO','tile':(11,9),'index':1,'iobank':'0','attrs':['SINGLE']},      
    ],
}, configChainClasses=[
    ConfigChainRIO, ConfigChainPLLX
], extra={
    'chain_io_order': [
        (6, 1, 3), (7, 1, 0), (9, 0, 1), (9, 0, 3), (11, 0, 1), (11, 0, 3), (12, 0, 0), (12, 0, 2),
        (11, 9, 1), (9, 9, 3), (9, 9, 1), (8, 9, 3), (8, 9, 0), (7, 9, 3), (7, 9, 0), (6, 9, 2),
        (6, 9, 0), (5, 9, 3), (5, 9, 2), (5, 9, 1), (5, 9, 0), (4, 9, 2), (4, 9, 0), (2, 9, 2),
        (2, 9, 0), (1, 9, 3), (1, 9, 1), (0, 9, 2), (0, 9, 0), (2, 1, 2), (2, 1, 0), (4, 1, 2),
        (4, 1, 0), (5, 1, 0), (5, 1, 1), (5, 1, 2), (5, 1, 3), (6, 1, 0), (6, 1, 1), (6, 1, 2),
    ]
}))

AddChip(Chip('AG10K', 0x01000001, 25, 41, floorplan=[
    None,  'IOS0', 'IOS0', 'IOS1', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,    'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,  'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,  'IOS0', 'IOS0', 'IOS1', 'IOS0', 'IOS0', None,   None,
    'PLL' ,'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE2','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW2',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    'UFM', 'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  'UFM',  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW1',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Logic','Logic','Logic','Bram',  'Logic','Logic','Logic','Logic','Logic','Mult','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'ION1', 'ION0', 'ION0', 'ION0', 'ION0', 'Clkdis','ION0', 'ION0', 'ION0', 'ION0', 'ION0', None,  'ION0', 'ION0', 'ION0', 'ION0', 'ION0', None,  'ION0', 'ION0', 'ION1', 'ION0', 'ION0', None,   None, 
], aliases={
	'Logic':   'ALTA_TILE_SRAM_DIST',
    'Bram':    'alta_bram9k',
    'Mult':    'alta_multiplier',
    'Rogic':   'IOTILE_ROUTE',
    'PLL':     'ALTA_PLLV',
    
    'IOS1':    'alta_io_S4_T2',
    'IOS0':    'alta_io_S4',
    
    'ION1':    'alta_io_N4_T2',
    'ION0':    'alta_io_N4',
    
    'IOW0':    'alta_io_W6',
    'IOW1':    'alta_io_W6_T2',
    'IOW2':    'alta_io_W4_G5',

    'IOE0':    'alta_io_E6',
    'IOE1':    'alta_io_E6_T2',
    'IOE2':    'alta_io_E4_G5',
}, packages={
    'AG10KSDE176': [
        {'name':'PIN_1',            'type':'IO','tile':(0, 15),'index':0,'iobank':1,     'attrs':['SINGLE']},
        {'name':'PIN_2',            'type':'IO','tile':(0, 15),'index':1,'iobank':1,     'attrs':['SINGLE']},
        {'name':'PIN_3',            'type':'IO','tile':(0, 15),'index':2,'iobank':1,     'attrs':['SINGLE']},
        {'name':'PIN_4',            'type':'IO','tile':(0, 15),'index':3,'iobank':1,     'attrs':['SINGLE']},
        {'name':'PIN_6',            'type':'IO','tile':(0, 14),'index':1,'iobank':1,     'attrs':['DIFFP']},
        {'name':'PIN_8',            'type':'IO','tile':(0, 14),'index':0,'iobank':1,     'attrs':['DIFFN']}, #D1
        {'name':'PIN_9',            'type':'IO','tile':(0, 14),'index':5,'iobank':1,     'attrs':['DIFFP']}, #D1
        {'name':'PIN_10',           'type':'IO','tile':(0, 14),'index':4,'iobank':1,     'attrs':['DIFFN']},
        {'name':'PIN_13',           'type':'IO','tile':(0, 13),'index':5,'iobank':1,     'attrs':['DIFFP']},
        {'name':'PIN_14',           'type':'IO','tile':(0, 13),'index':4,'iobank':1,     'attrs':['DIFFN']},
        {'name':'PIN_15',           'type':'IO','tile':(0, 12),'index':3,'iobank':1,     'attrs':['SINGLE']}, #D2
        {'name':'PIN_16',           'type':'IO','tile':(0, 12),'index':4,'iobank':1,     'attrs':['SINGLE']}, #D0
        {'name':'PIN_23',           'type':'IO','tile':(0, 11),'index':0,'iobank':1,     'attrs':['DIFFN_IN']},
        {'name':'PIN_24',           'type':'IO','tile':(0, 11),'index':3,'iobank':2,     'attrs':['DIFFP_IN']},
        {'name':'PIN_25',           'type':'IO','tile':(0, 11),'index':2,'iobank':2,     'attrs':['DIFFN_IN']},
        {'name':'PIN_26',           'type':'IO','tile':(0, 9), 'index':1,'iobank':2,     'attrs':['DIFFP']},
        {'name':'PIN_27',           'type':'IO','tile':(0, 9), 'index':0,'iobank':2,     'attrs':['DIFFN']},
        {'name':'PIN_31',           'type':'IO','tile':(0, 4), 'index':2,'iobank':2,     'attrs':['DIFFP']},
        {'name':'PIN_32',           'type':'IO','tile':(0, 4), 'index':1,'iobank':2,     'attrs':['DIFFN']},
        {'name':'PIN_33',           'type':'IO','tile':(0, 3), 'index':0,'iobank':2,     'attrs':['SINGLE']},
        {'name':'PIN_34',           'type':'IO','tile':(0, 3), 'index':2,'iobank':2,     'attrs':['DIFFP']},
        {'name':'PIN_35',           'type':'IO','tile':(0, 3), 'index':1,'iobank':2,     'attrs':['DIFFN']},
        {'name':'PIN_36',           'type':'IO','tile':(0, 3), 'index':4,'iobank':2,     'attrs':['SINGLE']},
        {'name':'PIN_37',           'type':'IO','tile':(0, 3), 'index':5,'iobank':2,     'attrs':['SINGLE']},
        {'name':'PIN_38',           'type':'IO','tile':(0, 2), 'index':0,'iobank':2,     'attrs':['SINGLE']},
        {'name':'PIN_39',           'type':'IO','tile':(0, 2), 'index':1,'iobank':2,     'attrs':['SINGLE']},
        {'name':'PIN_40',           'type':'IO','tile':(0, 2), 'index':3,'iobank':2,     'attrs':['DIFFP']},
        {'name':'PIN_42',           'type':'IO','tile':(0, 2), 'index':2,'iobank':2,     'attrs':['DIFFN']},
        {'name':'PIN_46',           'type':'IO','tile':(1, 0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_47',           'type':'IO','tile':(1, 0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_48',           'type':'IO','tile':(1, 0), 'index':3,'iobank':3,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_49',           'type':'IO','tile':(1, 0), 'index':2,'iobank':3,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_50',           'type':'IO','tile':(3, 0), 'index':2,'iobank':3,     'attrs':['SINGLE']},
        {'name':'PIN_52',           'type':'IO','tile':(5, 0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_53',           'type':'IO','tile':(5, 0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_56',           'type':'IO','tile':(9, 0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_57',           'type':'IO','tile':(9, 0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_58',           'type':'IO','tile':(9, 0), 'index':3,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_59',           'type':'IO','tile':(9, 0), 'index':2,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_60',           'type':'IO','tile':(11,0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_61',           'type':'IO','tile':(11,0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_62',           'type':'IO','tile':(11,0), 'index':2,'iobank':3,     'attrs':['SINGLE']}, 
        {'name':'PIN_63',           'type':'IO','tile':(13,0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_64',           'type':'IO','tile':(13,0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_65',           'type':'IO','tile':(13,0), 'index':3,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_67',           'type':'IO','tile':(13,0), 'index':2,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_70',           'type':'IO','tile':(22,0), 'index':0,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_72',           'type':'IO','tile':(22,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_74',           'type':'IO','tile':(24,0), 'index':1,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_75',           'type':'IO','tile':(24,0), 'index':0,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_76',           'type':'IO','tile':(24,0), 'index':2,'iobank':4,     'attrs':['SINGLE']}, 
        {'name':'PIN_77',           'type':'IO','tile':(26,0), 'index':0,'iobank':4,     'attrs':['SINGLE']}, 
        {'name':'PIN_78',           'type':'IO','tile':(26,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_79',           'type':'IO','tile':(26,0), 'index':1,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_80',           'type':'IO','tile':(36,0), 'index':0,'iobank':4,     'attrs':['SINGLE']},
        {'name':'PIN_81',           'type':'IO','tile':(36,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_83',           'type':'IO','tile':(37,0), 'index':0,'iobank':4,     'attrs':['SINGLE']}, 
        {'name':'PIN_85',           'type':'IO','tile':(37,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_86',           'type':'IO','tile':(37,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_87',           'type':'IO','tile':(38,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_88',           'type':'IO','tile':(38,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_89',           'type':'IO','tile':(40,2), 'index':1,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_90',           'type':'IO','tile':(40,2), 'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_91',           'type':'IO','tile':(40,3), 'index':1,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_92',           'type':'IO','tile':(40,3), 'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_93',           'type':'IO','tile':(40,4), 'index':1,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_94',           'type':'IO','tile':(40,4), 'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_95',           'type':'IO','tile':(40,5), 'index':1,'iobank':5,     'attrs':['DIFFN']},
        {'name':'PIN_96',           'type':'IO','tile':(40,5), 'index':0,'iobank':5,     'attrs':['DIFFP']},
        {'name':'PIN_98',           'type':'IO','tile':(40,6), 'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_100',          'type':'IO','tile':(40,7), 'index':2,'iobank':5,     'attrs':['DIFFN']},
        {'name':'PIN_101',          'type':'IO','tile':(40,7), 'index':1,'iobank':5,     'attrs':['DIFFP']},
        {'name':'PIN_102',          'type':'IO','tile':(40,7), 'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_103',          'type':'IO','tile':(40,8), 'index':2,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_104',          'type':'IO','tile':(40,8), 'index':1,'iobank':5,     'attrs':['DIFFN']},
        {'name':'PIN_106',          'type':'IO','tile':(40,8), 'index':0,'iobank':5,     'attrs':['DIFFP']},
        {'name':'PIN_107',          'type':'IO','tile':(40,9), 'index':5,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_108',          'type':'IO','tile':(40,10),'index':1,'iobank':5,     'attrs':['DIFFN']},
        {'name':'PIN_109',          'type':'IO','tile':(40,10),'index':0,'iobank':5,     'attrs':['DIFFP']},
        {'name':'PIN_110',          'type':'IO','tile':(40,11),'index':0,'iobank':5,     'attrs':['SINGLE']},
        {'name':'PIN_111',          'type':'IO','tile':(40,12),'index':3,'iobank':5,     'attrs':['DIFFN_IN']},
        {'name':'PIN_112',          'type':'IO','tile':(40,12),'index':2,'iobank':5,     'attrs':['DIFFP_IN']},
        {'name':'PIN_114',          'type':'IO','tile':(40,12),'index':1,'iobank':6,     'attrs':['DIFFN_IN']},
        {'name':'PIN_115',          'type':'IO','tile':(40,12),'index':0,'iobank':6,     'attrs':['DIFFP_IN']},
        {'name':'PIN_119',          'type':'IO','tile':(40,17),'index':1,'iobank':6,     'attrs':['DIFFP']},
        {'name':'PIN_120',          'type':'IO','tile':(40,18),'index':5,'iobank':6,     'attrs':['DIFFN']}, # D3
        {'name':'PIN_122',          'type':'IO','tile':(40,18),'index':4,'iobank':6,     'attrs':['DIFFP']},
        {'name':'PIN_124',          'type':'IO','tile':(40,18),'index':2,'iobank':6,     'attrs':['SINGLE']},
        {'name':'PIN_125',          'type':'IO','tile':(40,19),'index':2,'iobank':6,     'attrs':['SINGLE']},
        {'name':'PIN_126',          'type':'IO','tile':(40,19),'index':1,'iobank':6,     'attrs':['DIFFN']},
        {'name':'PIN_128',          'type':'IO','tile':(40,19),'index':0,'iobank':6,     'attrs':['DIFFP']},
        {'name':'PIN_129',          'type':'IO','tile':(40,20),'index':2,'iobank':6,     'attrs':['SINGLE']},
        {'name':'PIN_130',          'type':'IO','tile':(40,20),'index':1,'iobank':6,     'attrs':['DIFFN']},
        {'name':'PIN_134',          'type':'IO','tile':(38,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_135',          'type':'IO','tile':(38,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_136',          'type':'IO','tile':(36,24),'index':3,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_137',          'type':'IO','tile':(36,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_139',          'type':'IO','tile':(36,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_140',          'type':'IO','tile':(32,24),'index':0,'iobank':7,     'attrs':['SINGLE']}, 
        {'name':'PIN_142',          'type':'IO','tile':(31,24),'index':3,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_143',          'type':'IO','tile':(31,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_144',          'type':'IO','tile':(31,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_146',          'type':'IO','tile':(29,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'PIN_148',          'type':'IO','tile':(29,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'PIN_151',          'type':'IO','tile':(26,24),'index':0,'iobank':7,     'attrs':['SINGLE']},
        {'name':'PIN_152',          'type':'IO','tile':(25,24),'index':3,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_153',          'type':'IO','tile':(25,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_154',          'type':'IO','tile':(23,24),'index':3,'iobank':8,     'attrs':['SINGLE']},
        {'name':'PIN_156',          'type':'IO','tile':(23,24),'index':2,'iobank':8,     'attrs':['SINGLE']},
        {'name':'PIN_157',          'type':'IO','tile':(23,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_158',          'type':'IO','tile':(23,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_159',          'type':'IO','tile':(22,24),'index':3,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_160',          'type':'IO','tile':(22,24),'index':2,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_162',          'type':'IO','tile':(22,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_163',          'type':'IO','tile':(22,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_165',          'type':'IO','tile':(19,24),'index':3,'iobank':8,     'attrs':['SINGLE']},
        {'name':'PIN_166',          'type':'IO','tile':(19,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_168',          'type':'IO','tile':(19,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_170',          'type':'IO','tile':(18,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_171',          'type':'IO','tile':(17,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_172',          'type':'IO','tile':(16,24),'index':3,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_173',          'type':'IO','tile':(16,24),'index':2,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_175',          'type':'IO','tile':(16,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_176',          'type':'IO','tile':(16,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},

        {'name':'SDRAM_A0',         'type':'IO','tile':(26,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_A1',         'type':'IO','tile':(29,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_A2',         'type':'IO','tile':(29,24),'index':3,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_A3',         'type':'IO','tile':(30,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_A4',         'type':'IO','tile':(19,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_A5',         'type':'IO','tile':(19,0), 'index':0,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_A6',         'type':'IO','tile':(19,0), 'index':1,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_A7',         'type':'IO','tile':(17,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_A8',         'type':'IO','tile':(17,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_A9',         'type':'IO','tile':(17,0), 'index':0,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_A10',        'type':'IO','tile':(26,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_BA0',        'type':'IO','tile':(25,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_BA1',        'type':'IO','tile':(25,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_CAS',        'type':'IO','tile':(15,0), 'index':3,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_CKE',        'type':'IO','tile':(15,0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_CLK',        'type':'IO','tile':(20,24),'index':2,'iobank':8,     'attrs':['SINGLE']},
        {'name':'SDRAM_CS',         'type':'IO','tile':(17,0), 'index':1,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_DQ0',        'type':'IO','tile':(0, 5), 'index':0,'iobank':2,     'attrs':['DIFFN']},
        {'name':'SDRAM_DQ1',        'type':'IO','tile':(0, 5), 'index':1,'iobank':2,     'attrs':['DIFFP']},
        {'name':'SDRAM_DQ2',        'type':'IO','tile':(0, 7), 'index':0,'iobank':2,     'attrs':['DIFFN']},
        {'name':'SDRAM_DQ3',        'type':'IO','tile':(0, 7), 'index':1,'iobank':2,     'attrs':['DIFFP']},
        {'name':'SDRAM_DQ4',        'type':'IO','tile':(0, 9), 'index':3,'iobank':2,     'attrs':['SINGLE']},
        {'name':'SDRAM_DQ5',        'type':'IO','tile':(7, 0), 'index':1,'iobank':3,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_DQ6',        'type':'IO','tile':(7, 0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_DQ7',        'type':'IO','tile':(7, 0), 'index':2,'iobank':3,     'attrs':['SINGLE']}, 
        {'name':'SDRAM_DQ8',        'type':'IO','tile':(20,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ9',        'type':'IO','tile':(19,24),'index':2,'iobank':8,     'attrs':['SINGLE']},
        {'name':'SDRAM_DQ10',       'type':'IO','tile':(18,24),'index':3,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_DQ11',       'type':'IO','tile':(18,24),'index':2,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ12',       'type':'IO','tile':(18,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ13',       'type':'IO','tile':(17,24),'index':0,'iobank':8,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ14',       'type':'IO','tile':(0, 12),'index':1,'iobank':1,     'attrs':['DIFFN']},
        {'name':'SDRAM_DQ15',       'type':'IO','tile':(0, 14),'index':2,'iobank':1,     'attrs':['SINGLE']},
        {'name':'SDRAM_DQ16',       'type':'IO','tile':(40,9), 'index':3,'iobank':5,     'attrs':['DIFFN']},
        {'name':'SDRAM_DQ17',       'type':'IO','tile':(40,9), 'index':2,'iobank':5,     'attrs':['DIFFP']},
        {'name':'SDRAM_DQ18',       'type':'IO','tile':(40,11),'index':2,'iobank':5,     'attrs':['DIFFN']},
        {'name':'SDRAM_DQ19',       'type':'IO','tile':(40,11),'index':1,'iobank':5,     'attrs':['DIFFP']},
        {'name':'SDRAM_DQ20',       'type':'IO','tile':(36,0), 'index':3,'iobank':4,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ21',       'type':'IO','tile':(26,0), 'index':3,'iobank':4,     'attrs':['SINGLE']}, 
        {'name':'SDRAM_DQ22',       'type':'IO','tile':(22,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_DQ23',       'type':'IO','tile':(22,0), 'index':1,'iobank':4,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_DQ24',       'type':'IO','tile':(30,24),'index':2,'iobank':7,     'attrs':['SINGLE']}, 
        {'name':'SDRAM_DQ25',       'type':'IO','tile':(31,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']}, 
        {'name':'SDRAM_DQ26',       'type':'IO','tile':(32,24),'index':1,'iobank':7,     'attrs':['SINGLE']}, 
        {'name':'SDRAM_DQ27',       'type':'IO','tile':(34,24),'index':2,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'SDRAM_DQ28',       'type':'IO','tile':(34,24),'index':3,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_DQ29',       'type':'IO','tile':(36,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_DQ30',       'type':'IO','tile':(40,17),'index':0,'iobank':6,     'attrs':['SINGLE']},
        {'name':'SDRAM_DQ31',       'type':'IO','tile':(40,20),'index':0,'iobank':6,     'attrs':['DIFFP']},
        {'name':'SDRAM_DQM0',       'type':'IO','tile':(7, 0), 'index':3,'iobank':3,     'attrs':['SINGLE']}, 
        {'name':'SDRAM_DQM1',       'type':'IO','tile':(20,24),'index':1,'iobank':8,     'attrs':['PSEUDO_DIFFN']},
        {'name':'SDRAM_DQM2',       'type':'IO','tile':(19,0), 'index':2,'iobank':4,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_DQM3',       'type':'IO','tile':(30,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_RAS',        'type':'IO','tile':(15,0), 'index':2,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 
        {'name':'SDRAM_WE',         'type':'IO','tile':(15,0), 'index':0,'iobank':3,     'attrs':['PSEUDO_DIFFN']}, 

        {'name':'CONF_DONE',        'type':'IO','tile':(40,13),'index':2,'iobank':6,     'attrs':['DEDICATE_OPENDRAIN']}, 
        {'name':'MSEL0',            'type':'IO','tile':(40,13),'index':1,                'attrs':['VCCINT','DEDICATE_IN']}, 
        {'name':'MSEL1',            'type':'IO','tile':(40,13),'index':0,                'attrs':['VCCINT','DEDICATE_IN']}, 
        {'name':'MSEL2',            'type':'IO','tile':(40,14),'index':0,                'attrs':['VCCINT','DEDICATE_IN']}, 
        {'name':'TDI',              'type':'IO','tile':(0, 17),'index':1,'iobank':1,     'attrs':['DEDICATE_IN']},
        {'name':'TCK',              'type':'IO','tile':(0, 17),'index':2,'iobank':1,     'attrs':['DEDICATE_IN']},
        {'name':'TMS',              'type':'IO','tile':(0, 17),'index':3,'iobank':1,     'attrs':['DEDICATE_IN']},
        {'name':'TDO',              'type':'IO','tile':(0, 17),'index':4,'iobank':1,     'attrs':['DEDICATE_OUT']},
        {'name':'NC_10',            'type':'IO','tile':(0, 13),'index':2,'iobank':1,     'attrs':['SINGLE']},
        {'name':'NC_119N_INIT_DONE','type':'IO','tile':(40,17),'index':2,'iobank':6,     'attrs':['DIFFN']}, # D3
        {'name':'NC_13P_DPCLK0',    'type':'IO','tile':(0, 12),'index':2,'iobank':1,     'attrs':['DIFFP']},
        {'name':'NC_17P_CLK0',      'type':'IO','tile':(0, 11),'index':1,'iobank':1,     'attrs':['DIFFP_IN']},
        {'name':'PIN_PLLOUT_FBN0',  'type':'IO','tile':(5, 0), 'index':2,'iobank':3,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_PLLOUT_FBN1',  'type':'IO','tile':(34,24),'index':1,'iobank':7,     'attrs':['PSEUDO_DIFFN']},
        {'name':'PIN_PLLOUT_FBP0',  'type':'IO','tile':(5, 0), 'index':3,'iobank':3,     'attrs':['PSEUDO_DIFFP']},
        {'name':'PIN_PLLOUT_FBP1',  'type':'IO','tile':(34,24),'index':0,'iobank':7,     'attrs':['PSEUDO_DIFFP']},
        {'name':'POR_TEST',         'type':'IO','tile':(0, 13),'index':3,'iobank':2,     'attrs':['DEDICATE_IN']}, 
        {'name':'nCE',              'type':'IO','tile':(0, 17),'index':5,'iobank':1,     'attrs':['DEDICATE_IN']}, 
        {'name':'nCONFIG',          'type':'IO','tile':(0, 17),'index':0,'iobank':1,     'attrs':['DEDICATE_IN']}, 
        {'name':'nSTATUS',          'type':'IO','tile':(0, 13),'index':0,'iobank':1,     'attrs':['DEDICATE_OPENDRAIN']}, 
    ]
}, configChainClasses=[
    ConfigChainDIO,
    ConfigChainPLLV,
    ConfigChainPLLV,
    ConfigChainClkDis_25x48,
    ConfigChainMCU1,
], lzwCompressed=True,
extra={
    'chain_io_order': [
        (0,11,2), (0,11,3), (0,9,0), (0,9,1), (0,9,3), (0,7,0), (0,7,1), (0,5,0), (0,5,1), (0,4,1), (0,4,2), (0,3,0), (0,3,1), (0,3,2), (0,3,4), (0,3,5),
        (0,2,0), (0,2,1), (0,2,2), (0,2,3), (1,0,0), (1,0,1), (1,0,2), (1,0,3), (3,0,2), (5,0,0), (5,0,1), (5,0,2), (5,0,3), (7,0,0), (7,0,1), (7,0,2),
        (7,0,3), (9,0,0), (9,0,1), (9,0,2), (9,0,3), (11,0,0), (11,0,1), (11,0,2), (13,0,0), (13,0,1), (13,0,2), (13,0,3), (15,0,0), (15,0,1), (15,0,2), (15,0,3),
        (17,0,0), (17,0,1), (17,0,2), (17,0,3), (19,0,0), (19,0,1), (19,0,2), (19,0,3), (22,0,0), (22,0,1), (22,0,2), (22,0,3), (24,0,0), (24,0,1), (24,0,2), (26,0,0),
        (26,0,1), (26,0,2), (26,0,3), (36,0,0), (36,0,2), (36,0,3), (37,0,0), (37,0,2), (37,0,3), (38,0,2), (38,0,3), (40,2,1), (40,2,0), (40,3,1), (40,3,0), (40,4,1),
        (40,4,0), (40,5,1), (40,5,0), (40,6,0), (40,7,2), (40,7,1), (40,7,0), (40,8,2), (40,8,1), (40,8,0), (40,9,5), (40,9,3), (40,9,2), (40,10,1), (40,10,0), (40,11,2),
        (40,11,1), (40,11,0), (40,12,3), (40,12,2), (40,12,1), (40,12,0), (40,17,2), (40,17,1), (40,17,0), (40,18,5), (40,18,4), (40,18,2), (40,19,2), (40,19,1), (40,19,0), (40,20,2),
        (40,20,1), (40,20,0), (38,24,1), (38,24,0), (36,24,3), (36,24,2), (36,24,1), (36,24,0), (34,24,3), (34,24,2), (34,24,1), (34,24,0), (32,24,1), (32,24,0), (31,24,3), (31,24,2),
        (31,24,1), (31,24,0), (30,24,2), (30,24,1), (30,24,0), (29,24,3), (29,24,2), (29,24,1), (29,24,0), (26,24,2), (26,24,1), (26,24,0), (25,24,3), (25,24,2), (25,24,1), (25,24,0),
        (23,24,3), (23,24,2), (23,24,1), (23,24,0), (22,24,3), (22,24,2), (22,24,1), (22,24,0), (20,24,2), (20,24,1), (20,24,0), (19,24,3), (19,24,2), (19,24,1), (19,24,0), (18,24,3),
        (18,24,2), (18,24,1), (18,24,0), (17,24,1), (17,24,0), (16,24,3), (16,24,2), (16,24,1), (16,24,0), (0,15,0), (0,15,1), (0,15,2), (0,15,3), (0,14,0), (0,14,1), (0,14,2),
        (0,14,4), (0,14,5), (0,13,2), (0,13,4), (0,13,5), (0,12,1), (0,12,2), (0,12,3), (0,12,4), (0,11,0), (0,11,1),
    ]
}))

AddChip(Chip('AG15K', 0x01500010, 30, 50, floorplan=[
    None,  'UFM',  'IOS0', 'IOS0', 'IOS0', 'IOS1', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,  'IOS1', 'IOS0', 'IOS1', 'IOS0', None,    'IOS0', 'IOS0', 'IOS2', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,  'IOS1', 'IOS0', 'IOS0', 'IOS0', 'IOS1', 'IOS0', 'IOS0', 'IOS0', 'IOS0', None,    'IOS1', 'IOS0', 'IOS0', 'IOS0', 'IOS0', 'UFM',  None,   None, 
    'PLL', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    'UFM', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','UFM',
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW1', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE2','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW1', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'IOE0','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW2', 
    'IOE1','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'PLL', 'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    'UFM', 'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  'UFM',  'UFM',  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW1', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'UFM',  'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW0', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','IOW1', 
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'Logic','Logic','Bram','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Logic','Bram','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Logic','Mult',  'Logic','Logic','Logic','Logic','Logic','Logic','Rogic','PLL',
    None,  None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   None,   'ION0', 'ION1', None,  'ION0', 'ION0', 'ION0', 'ION0', 'Clkdis','ION1', 'ION0', 'ION0', 'ION1', 'ION0', 'ION2', 'ION1', None,  'ION0', 'ION0', 'ION1', 'ION0', 'ION0', 'ION0', 'ION0', 'ION0', 'ION0', 'Clkdis','ION0', 'ION0', 'ION1', 'ION0', 'UFM',  'UFM',  None,   None, 
], aliases={
	'Logic':   'ALTA_TILE_SRAM_DIST',
    'Bram':    'alta_bram9k',
    'Mult':    'alta_multiplier',
    'PLL':     'ALTA_PLLV',

    'ION0':    'alta_io_N4',
    'ION1':    'alta_io_N4_T2',
    'ION2':    'alta_io_N4_G5',

    'IOW0':    'alta_io_W6',
    'IOW1':    'alta_io_W6_T2',
    'IOW2':    'alta_io_W4_G5',

    'IOS0':    'alta_io_S4',
    'IOS1':    'alta_io_S4_T2',
    'IOS2':    'alta_io_S4_G5',
    
    'IOE0':    'alta_io_E6',
    'IOE1':    'alta_io_E6_T2',
    'IOE2':    'alta_io_E4_G5',
}, packages={
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
}, configChainClasses=[
    None, # ConfigChainDIO
    ConfigChainPLLVE,
    ConfigChainPLLVE,
    ConfigChainPLLVE,
    ConfigChainPLLVE,
    ConfigChainClkDis_29x60,
    ConfigChainClkDis_29x60,
    ConfigChainMCU2,
], lzwCompressed=True,
extra={
    'chain_io_order': [
        (0,16,4) (0,16,5) (0,15,0) (0,15,1) (0,15,2) (0,15,3) (0,15,4) (0,14,0) (0,14,1) (0,14,2) (0,14,3) (0,14,4) (0,14,5) (0,13,1) (0,13,2) (0,13,3)
        (0,13,4) (0,13,5) (0,12,0) (0,12,1) (0,12,2) (0,12,3) (0,11,2) (0,11,3) (0,10,0) (0,10,1) (0,10,2) (0,10,3) (0,9,0) (0,9,2) (0,9,3) (0,8,1)
        (0,8,2) (0,6,0) (0,5,0) (0,5,1) (0,5,5) (0,4,0) (0,4,2) (0,4,3) (0,3,2) (0,3,3) (2,0,0) (2,0,1) (3,0,0) (3,0,1) (3,0,3) (5,0,2)
        (5,0,3) (6,0,0) (6,0,1) (6,0,2) (6,0,3) (11,0,0) (11,0,1) (15,0,0) (15,0,1) (15,0,2) (15,0,3) (19,0,0) (19,0,1) (19,0,2) (20,0,0) (20,0,1)
        (20,0,2) (20,0,3) (21,0,0) (21,0,1) (21,0,2) (21,0,3) (22,0,0) (22,0,1) (24,0,0) (24,0,1) (24,0,2) (24,0,3) (25,0,0) (25,0,1) (25,0,2) (25,0,3)
        (26,0,0) (26,0,1) (26,0,2) (26,0,3) (27,0,0) (27,0,1) (28,0,0) (28,0,1) (28,0,2) (28,0,3) (32,0,2) (32,0,3) (33,0,0) (33,0,1) (33,0,2) (33,0,3)
        (34,0,0) (34,0,1) (34,0,2) (34,0,3) (36,0,2) (36,0,3) (37,0,0) (39,0,0) (39,0,1) (39,0,2) (39,0,3) (40,0,0) (40,0,1) (40,0,2) (40,0,3) (42,0,2)
        (42,0,3) (43,0,0) (43,0,1) (43,0,2) (43,0,3) (44,0,0) (44,0,1) (45,0,2) (45,0,3) (49,3,3) (49,3,2) (49,3,1) (49,3,0) (49,4,5) (49,4,4) (49,4,2)
        (49,4,1) (49,5,3) (49,5,2) (49,5,1) (49,5,0) (49,6,0) (49,7,3) (49,7,2) (49,9,3) (49,9,2) (49,10,0) (49,11,3) (49,11,2) (49,13,3) (49,13,2) (49,13,1)
        (49,13,0) (49,14,5) (49,14,4) (49,14,3) (49,14,2) (49,15,3) (49,15,2) (49,15,1) (49,15,0) (49,17,5) (49,17,4) (49,18,5) (49,18,4) (49,18,0) (49,19,3) (49,19,2)
        (49,19,1) (49,19,0) (49,20,2) (49,20,1) (49,23,5) (49,24,5) (49,24,4) (49,26,5) (49,26,4) (49,27,2) (49,27,1) (45,29,2) (45,29,1) (44,29,3) (44,29,2) (44,29,1)
        (43,29,1) (43,29,0) (42,29,3) (42,29,2) (42,29,1) (42,29,0) (39,29,3) (39,29,2) (39,29,1) (39,29,0) (38,29,3) (38,29,2) (37,29,3) (37,29,2) (37,29,1) (37,29,0)
        (35,29,3) (34,29,3) (34,29,2) (34,29,1) (34,29,0) (33,29,3) (33,29,2) (33,29,1) (33,29,0) (32,29,3) (32,29,2) (30,29,3) (30,29,2) (30,29,1) (30,29,0) (29,29,3)
        (29,29,2) (29,29,1) (29,29,0) (28,29,3) (28,29,2) (27,29,2) (27,29,1) (26,29,3) (26,29,2) (26,29,1) (26,29,0) (25,29,3) (25,29,2) (25,29,1) (25,29,0) (24,29,3)
        (24,29,2) (24,29,1) (22,29,3) (22,29,2) (22,29,1) (22,29,0) (21,29,3) (21,29,2) (21,29,1) (21,29,0) (20,29,3) (20,29,2) (20,29,1) (20,29,0) (19,29,2) (19,29,1)
        (19,29,0) (17,29,3) (17,29,2) (16,29,3) (16,29,2) (16,29,1) (16,29,0) (0,16,0) (0,16,1) (0,16,2) (0,16,3)
    ]
}))
