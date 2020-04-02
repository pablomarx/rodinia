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
from wires import enumerate_all_wires

chip = ChipWithID(0x00120010)

def nameForTile(tile, row, col):
    return "%s(%02i,%02i)" % (tile.type, col, row)

# This would be an alta_slice in AGM speak
def createLogicTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    tile_name = nameForTile(tile, row, col)
    #print("Creating %s" % (tile_name))
    for z in range(0, tile.slices):
        slice_name = "alta_slice%02i" % z
        
        belname = tile_name + ":" + slice_name
        fname = belname + ":LutOut"
        qname = belname + ":Q"

        # can't route to ClkMUX##
        # clk input seems to go to TileClkMUX##, CtrlMUX##
        clkinstance = "CtrlMUX%02i" % (0)
        clkname = tile_name + ":" + clkinstance

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
    for z in range(0, tile.slices):
        pin = chip.pin_at(row, col, z)
        if not pin:
            continue
        
        wire_prefix = nameForTile(tile, row, col)
        belname = "%s:alta_rio%02i" % (wire_prefix, z)
        
        gb = 'globalBuffer' in pin
        
        ctx.addBel(name=belname, type="GENERIC_IOB", loc=Loc(col, row, z), gb=gb)
        
        #print("Creating bel: %s" % belname)
        oname = "%s:InputMUX%02i" % (wire_prefix, z)
        iname = "%s:IOMUX%02i" % (wire_prefix, z)
        oename = "%s:oe%02i" % (wire_prefix, z)
        
        addWire(row, col, iname)
        addWire(row, col, oename)
        addWire(row, col, oname)
        ctx.addBelInput(bel=belname, name="I", wire=iname)
        ctx.addBelInput(bel=belname, name="EN", wire=oename)
        ctx.addBelOutput(bel=belname, name="O", wire=oname)

def createRogicTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_ROUTE", loc=Loc(col, row, 0), gb=False)

def createBRAMTileBEL(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
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

print("Creating wires and PIPs")
def wire_enumerator(wire):
    source = wire.source
    dest = wire.dest
    if not shouldProcessTileNamed(source.tile):
        return
    if not shouldProcessTileNamed(dest.tile):
        return

    assert source.row < chip.rows
    assert dest.row < chip.rows
    assert source.col < chip.columns
    assert dest.col < chip.columns
    
    addWire(dest.row, dest.col, dest.name, dest.config)
    addWire(source.row, source.col, source.name, source.config)
    createPIP(wire.name, wire.wire_type, source.name, dest.name, wire.delay, dest.row, dest.col)
                                
enumerate_all_wires(wire_enumerator)
