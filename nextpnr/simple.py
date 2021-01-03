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

sys.path.append(os.path.join('..', 'bitstream'))

from chips import ChipWithID

chip_id = None
chip_id_env = 'AGM_DEVICE'

if chip_id_env in os.environ:
    chip_id = os.environ[chip_id_env]
    if chip_id != None:
        try:
            chip_id = int(chip_id, 16)
        except ValueError:
            chip_id = None
        
if chip_id == None:
    chip_id = 0x00120010

chip = ChipWithID(chip_id)

def nameForTile(tile, row, col):
    return "%s(%02i,%02i)" % (tile.type, col, row)

# This would be an alta_slice in AGM speak
def createLogicTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    tile_name = nameForTile(tile, row, col)
    #print("Creating %s" % (tile_name))

    for z in [0,1]:
        inname = "alta_clkenctrl%02i:ClkIn" % (z)
        src = tile_name+":"+inname
        addWire(row, col, src, inname)
        
        outname = "alta_clkenctrl%02i:ClkOut" % (z)
        dest = tile_name+":"+outname
        addWire(row, col, dest, outname)
        createPIP("%s <= %s" % (src, dest), "???", src, dest, 0, row, col)
    
    for z in range(0, tile.slices):
        slice_name = "alta_slice%02i" % z
        
        belname = tile_name + ":" + slice_name
        fname = belname + ":LutOut"
        qname = belname + ":Q"

        clkinstance = "ClkMUX%02i" % (z)
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
def createIOTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    tile_name = nameForTile(tile, row, col)
    
    for z in range(0, tile.slices):
        pin = chip.pin_at(row, col, z)
        if not pin:
            continue
        
        belname = "%s:alta_rio%02i" % (tile_name, z)
        
        gb = 'globalBuffer' in pin
        
        ctx.addBel(name=belname, type="GENERIC_IOB", loc=Loc(col, row, z), gb=gb)
        
        #print("Creating bel: %s" % belname)
        #oname = "%s:InputMUX%02i" % (tile_name, (z*2)+1)
        oname = "%s:alta_ioreg%02i" % (tile_name, z)
        iname = "%s:IOMUX%02i" % (tile_name, z)
        oename = "%s:oe%02i" % (tile_name, z)
        
        addWire(row, col, iname)
        addWire(row, col, oename)
        addWire(row, col, oname)
        ctx.addBelInput(bel=belname, name="I", wire=iname)
        ctx.addBelInput(bel=belname, name="EN", wire=oename)
        ctx.addBelOutput(bel=belname, name="O", wire=oname)
        
    if "GclkDMUX00" in tile.values:
        inname = "alta_io_gclk00:inclk" 
        src = tile_name+":"+inname
        addWire(row, col, src, inname)
        
        outname = "alta_io_gclk00:outclk" 
        dest = tile_name+":"+outname
        addWire(row, col, dest, outname)
        createPIP("%s <= %s" % (src, dest), "???", src, dest, 0, row, col)

def createRogicTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    # Intentionally blank for now

def createPLLTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_PLL", loc=Loc(col, row, 0), gb=False)
    
    wire_base = "%s:alta_pllx00" % (belname)
    for clock in range(0, 4):
        output = "clkout%i" % (clock)
        input = "clkout%ien" % (clock)

        out_wire = "%s:%s" % (wire_base, output)
        addWire(row, col, out_wire)
        
        in_wire = "%s:%s" % (wire_base, input)
        addWire(row, col, in_wire)

        ctx.addBelOutput(bel=belname, name=output, wire=out_wire)
        ctx.addBelInput(bel=belname, name=input, wire=in_wire)
    
    for configs in ('clkin', 'clkfb', 'pllen', 'resetn'):
        pin = configs
        wire = "%s:%s" % (wire_base, pin)
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=pin, wire=wire)

def createUFMTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))

    ctx.addBel(name=belname, type="alta_boot", loc=Loc(col, row, 0), gb=False)
    wire_prefix = "%s:alta_boot00" % (belname)
    
    osc_enb = "i_osc_enb"
    osc_enb_wire = "%s:%s" % (wire_prefix, osc_enb)
    addWire(row, col, osc_enb_wire)
    ctx.addBelInput(bel=belname, name=osc_enb, wire=osc_enb_wire)
    
    osc = "o_osc"
    osc_wire = "%s:%s" % (wire_prefix, osc)
    addWire(row, col, osc_wire)
    ctx.addBelOutput(bel=belname, name=osc, wire=osc_wire)

    for gdd in range(0, 8):
        wire_prefix = "%s:alta_ufm_gddd%02i" % (belname, gdd)
        inname = "in" 
        src = wire_prefix+":"+inname
        addWire(row, col, src, inname)
    
        outname = "out" 
        dest = wire_prefix+":"+outname
        addWire(row, col, dest, outname)
        createPIP("%s <= %s" % (src, dest), "???", src, dest, 0, row, col)
        
    wire_prefix = "%s:alta_io_gclk00" % (belname)
    inname = "in" 
    src = wire_prefix+":"+inname
    addWire(row, col, src, inname)
    
    outname = "out" 
    dest = wire_prefix+":"+outname
    addWire(row, col, dest, outname)
    createPIP("%s <= %s" % (src, dest), "???", src, dest, 0, row, col)


def createBRAMTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_BRAM", loc=Loc(col, row, 0), gb=False)
    
    for base in ("Clk", "ClkEn", "AsyncReset"):
        for port in range(0, 2):
            pin = "%s%i"  % (base, port)
            wire = "%s:alta_bram00:%s" % (belname, pin)
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    for base in ("WeRenA", "WeRenB"):
        wire = "%s:alta_bram00:%s" % (belname, base)
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=base, wire=wire)
    
    for inputs in ("AddressA", range(0, 12)), ("AddressB", range(63, 51, -1)), ("DataInA", range(12, 30)), ("DataInB", range(51, 33, -1)):
        bit = 0
        prefix = inputs[0]
        for imux in inputs[1]:
            pin = "%s[%i]" % (prefix, bit)
            wire = "%s:IMUX%02i" % (belname, imux)
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
            bit += 1
    
    for outputs in ("DataOutA", range(0, 18)), ("DataOutB", range(35, 17, -1)):
        bit = 0
        prefix = outputs[0]
        for bufmux in outputs[1]:
            pin = "%s[%i]" % (prefix, bit)
            wire = "%s:BufMUX%02i" % (belname, bufmux)
            addWire(row, col, wire)
            ctx.addBelOutput(bel=belname, name=pin, wire=wire)
            bit += 1

def createPIP(pip_name, pip_type, wire_src, wire_dest, delay, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    #print("createPIP(%s, %s, %s, %s, %s, %s, %s)" % (pip_name, pip_type, wire_src, wire_dest, delay, row, col))
    try:
        ctx.addPip(
            name=pip_name, type=pip_type, srcWire=wire_src, dstWire=wire_dest,
            delay=ctx.getDelayFromNS(delay), loc=Loc(col, row, 0))
    except IndexError:
        print("createPIP: Wire not found", wire_src, wire_dest)
        pass
    except AssertionError:
        #print("createPIP: Wire already exists", wire_src, wire_dest)
        pass

def addWire(row, col, name, typ=""):
    #print("addWire(%s, %s, %s, %s)" % (row, col, name, typ))
    assert row < chip.rows
    assert col < chip.columns 
    try:
        ctx.addWire(name=name, type=typ, y=row, x=col)
    except AssertionError:
        #print("addWire: duplicate wire name=%s, type=%s, y=%i, x=%i" % (name, typ, row, col))
        pass

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
        
        if ttype == "IOTILE":
            createIOTile(chip, tile, row, col)
        elif ttype == "LogicTILE":
            createLogicTile(chip, tile, row, col)
        elif ttype == "RogicTILE":
            createRogicTile(chip, tile, row, col)
        elif ttype == "BramTILE":
            createBRAMTile(chip, tile, row, col)
        elif ttype == "PLLTILE":
            createPLLTile(chip, tile, row, col)
        elif ttype == "UFMTILE":
            createUFMTile(chip, tile, row, col)

#
# Create Programmable Interconnect Points and Wires
# Wire: a fixed physical connection inside the FPGA between Pips and/or Bel pins.
# Pip: Programmable Interconnect Point, a configurable connection in one direction between two wires
#

print("Creating wires and PIPs")
def wire_enumerator(wire):
    source = wire.source
    dest = wire.dest
    
    assert source.row < chip.rows
    assert dest.row < chip.rows
    assert source.col < chip.columns
    assert dest.col < chip.columns
    
    if source.row == dest.row and source.col == dest.col and source.tile == "BramTILE":
        if source.config.startswith("alta_bram00"):
            if source.bit.startswith("Data") or source.bit.startswith("Address"):
                return
        elif dest.config.startswith("alta_bram00"):
            if dest.bit.startswith("Data") or dest.bit.startswith("Address"):
                return
    
    addWire(dest.row, dest.col, dest.name, dest.config)
    addWire(source.row, source.col, source.name, source.config)
    createPIP(wire.name, wire.wire_type, source.name, dest.name, wire.delay, dest.row, dest.col)

chip.wire_db.enumerate_all_wires(wire_enumerator)
