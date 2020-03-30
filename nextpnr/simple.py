#
# Copyright 2020 Steve White
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
import sys
import os

sys.path.append(os.path.join(os.path.join(sys.path[0], '..'), 'bitstream'))

from chips import ChipWithID
from wires import wires_by_tile

chip = ChipWithID(0x00120010)

# This would be an alta_slice in AGM speak
def createLogicTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    # XXX: Figure out how many slices per tile
    tile_name = "LogicTILE(%02i,%02i)" % (col, row)
    #print("Creating %s" % (tile_name))
    for z in range(0, 16):
        slice_name = "alta_slice%02i" % z
        
        belname = tile_name + ":" + slice_name
        clkinstance = "ClkMUX%02i" % (z)
        clkname = tile_name + ":" + clkinstance
        fname = belname + ":LutOut"
        qname = belname + ":Q"

        ctx.addBel(name=belname, type="GENERIC_SLICE", loc=Loc(col, row, z), gb=False)
        addWire(row, col, clkname, clkinstance)
        ctx.addBelInput(bel=belname, name="CLK", wire=clkname)
        for k, n in [('A', 'I[0]'), ('B', 'I[1]'),
                       ('C', 'I[2]'), ('D', 'I[3]')]:
            inpname = "%s:%s" % (belname, k)
            addWire(row, col, inpname, k)
            ctx.addBelInput(bel=belname, name=n, wire=inpname)
        addWire(row, col, qname, "Q")
        ctx.addBelOutput(bel=belname, name="Q", wire=qname)
        addWire(row, col, fname, "LutOut")
        ctx.addBelOutput(bel=belname, name="F", wire=fname)

# This would be an alta_rio in AGM speak
def createIOTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    # XXX: Figure out how many pins this tile has...
    # seems like a max of 4?
    for z in range(0, 4):
        # None of this is remotely correct
        belname = "IOTILE(%02i,%02i,%02i)" % (row, col, z)
        
        # XXX: How to figure out gb? Need to consult chip package??
        ctx.addBel(name=belname, type="GENERIC_IOB", loc=Loc(col, row, z), gb=False)
        
        #print("Creating bel: %s" % belname)
        iname = "%s:alta_io%02i" % (belname, z)
        oname = "%s:alta_ioreg%02i" % (belname, z)
        oename = "%s:oe%02i" % (belname, z)
        
        addWire(row, col, iname)
        addWire(row, col, oename)
        addWire(row, col, oname)
        ctx.addBelInput(bel=belname, name="I", wire=iname)
        ctx.addBelInput(bel=belname, name="EN", wire=oename)
        ctx.addBelOutput(bel=belname, name="O", wire=oname)

def createRogicTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = "RogicTILE(%02i,%02i)" % (col, row)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_ROUTE", loc=Loc(col, row, 0), gb=False)

def createBRAMTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = "BramTILE(%02i,%02i)" % (col, row)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_BRAM", loc=Loc(col, row, 0), gb=False)

def createPIP(pip_name, pip_type, wire_src, wire_dest, delay, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    #print("createPIP(%s, %s, %s, %s, %s, %s, %s)" % (pip_name, pip_type, wire_src, wire_dest, delay, row, col))
    try:
        ctx.addPip(
            name=pip_name, type=pip_type, srcWire=wire_src, dstWire=wire_dest,
            delay=ctx.getDelayFromNS(delay), loc=Loc(col, row, 0))
    except IndexError:
        pass
        #print("Wire not found", gsrcname, gdestname)
    except AssertionError:
        pass
        #print("Wire already exists", gsrcname, gdestname)

def addWire(row, col, name, typ=""):
    #print("addWire(%s, %s, %s, %s)" % (row, col, name, typ))
    assert row < chip.rows
    assert col < chip.columns 
    #print("wire", gname)
    try:
        ctx.addWire(name=name, type=typ, y=row, x=col)
    except AssertionError:
        pass
        #print("duplicate wire")

def shouldProcessTileNamed(tile_name):
    if tile_name == "LogicTILE" or tile_name == "IOTILE" or tile_name == "RogicTILE" or tile_name == "BramTILE":
        return True
    return None

def nameForWire(tile, row, col, config, bits=None):
    assert row < chip.rows
    assert col < chip.columns 
    if tile == "IOTILE": 
        if config.startswith("alta_"):
            slice = int(config[-2:])
            result = "%s(%02i,%02i,%02i):%s" % (tile, row, col, slice, config)
            # print("Rewrote using slice:%s => %s" % (slice, result))
            return result
    elif tile == "LogicTILE":
        if config.startswith("alta_"):
            return "%s(%02i,%02i):%s:%s" % (tile, row, col, config, bits)
    
    return "%s(%02i,%02i):%s" % (tile, row, col, config)

#
# Create Basic Elements
#
print("Creating Basic Elements")
for row in range(0, chip.rows):
    for col in range(0, chip.columns):
        tile = chip.tile_at(col, row)
        if tile is None:
            continue
        
        ttype = tile.type
        if not shouldProcessTileNamed(ttype):
            continue
        
        if ttype == "IOTILE":
            createIOTileBEL(chip, tile, row, col)
        elif ttype == "LogicTILE":
            createLogicTileBEL(chip, tile, row, col)
        elif ttype == "RogicTILE":
            createRogicTileBEL(chip, tile, row, col)
        elif ttype == "BramTILE":
            createBRAMTileBEL(chip, tile, row, col)


#
# Create Programmable Interconnect Points and Wires
# Wire: a fixed physical connection inside the FPGA between Pips and/or Bel pins.
# Pip: Programmable Interconnect Point, a configurable connection in one direction between two wires
#

# e.g. LogicTILE, IOTILE
for dest_tile in wires_by_tile:
    if not shouldProcessTileNamed(dest_tile):
        continue
    print("Creating PIPs and Wires for %s" % dest_tile)
    count = 0
    dest_configs = wires_by_tile[dest_tile]
    # e.g. IMUX34, IMUX35
    for dest_config in dest_configs:           
        dest_bits = dest_configs[dest_config]
        # e.g. I0, I1, I2
        for dest_bit in dest_bits:        
            src_tiles = dest_bits[dest_bit]
            # e.g. LogicTILE, IOTILE
            for src_tile in src_tiles:     
                if shouldProcessTileNamed(src_tile):
                    src_configs = src_tiles[src_tile]
                    # e.g. OMUX01, OMX07
                    for src_config in src_configs:
                        src_bits = src_configs[src_config]
                        # e.g. O0, O1
                        for src_bit in src_bits:
                            connections = src_bits[src_bit]
                            # e.g. [9, 1, 9, 1, "T0", 0.867]
                            for connection in connections: 
                                dest_col = connection[0]
                                dest_row = connection[1]
                                src_col = connection[2]
                                src_row = connection[3]
                                wire_type = connection[4]
                                delay = connection[5]
                                
                                dest_name = nameForWire(dest_tile, dest_row, dest_col, dest_config, dest_bit)
                                src_name = nameForWire(src_tile, src_row, src_col, src_config, src_bit)
                                
                                pip_name = "%s:%s <= %s:%s" % (dest_name, dest_bit, src_name, src_bit)
                                #print(pip_name)
                                
                                addWire(dest_row, dest_col, dest_name, dest_config)
                                addWire(src_row, src_col, src_name, src_config)
                                createPIP(pip_name, wire_type, src_name, dest_name, delay, dest_row, dest_col)
                                count += 1
    print("... created %i PIPs" % count)
