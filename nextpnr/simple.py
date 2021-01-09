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
        pairs = [('alta_clkenctrl', 'ClkIn', 'ClkOut', 'ClkEn'), ('alta_asyncctrl', 'Din', 'Dout'), ('alta_syncctrl', 'Din', 'Dout')]
        for a_pair in pairs:
            base = "%s%02i:" % (a_pair[0], z)
            input = a_pair[1]
            output = a_pair[2]
            
            inname = base + input
            src = tile_name+":"+inname
            addWire(row, col, src, inname)
        
            outname = base + output
            dest = tile_name+":"+outname
            addWire(row, col, dest, outname)
            createAlias(src, dest, row, col)

            for index in range(3, len(a_pair)):
                remainder = a_pair[index]
                aname = base + remainder
                dest = tile_name+":"+aname
                addWire(row, col, dest, aname)
    
    for z in range(0, tile.slices):
        slice_name = "alta_slice%02i" % z
        
        belname = tile_name + ":" + slice_name
        ctx.addBel(name=belname, type="GENERIC_SLICE", loc=Loc(col, row, z), gb=False)

        clkinstance = "ClkMUX%02i" % (z)
        clkname = tile_name + ":" + clkinstance
        #addWire(row, col, clkname, clkinstance) # should've been created in new wire creator
        ctx.addBelInput(bel=belname, name="CLK", wire=clkname)

        for k, n in [('A', 'I[0]'), ('B', 'I[1]'),
                       ('C', 'I[2]'), ('D', 'I[3]')]:
            inpname = "%s:%s" % (belname, k)
            addWire(row, col, inpname, k)
            ctx.addBelInput(bel=belname, name=n, wire=inpname)

        qname = belname + ":Q"
        addWire(row, col, qname, "Q")
        ctx.addBelOutput(bel=belname, name="Q", wire=qname)

        fname = belname + ":LutOut"
        addWire(row, col, fname, "LutOut")
        ctx.addBelOutput(bel=belname, name="F", wire=fname)

# This would be an alta_rio in AGM speak
def createIOTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    tile_name = nameForTile(tile, row, col)
    
    for z in range(0, tile.slices):
        belname = "%s:alta_rio%02i" % (tile_name, z)
        gb = "GclkDMUX00" in tile.values
        #print("Creating bel: %s" % belname)
        ctx.addBel(name=belname, type="GENERIC_IOB", loc=Loc(col, row, z), gb=gb)
        
        regs = ['combout', 'regout', 'paddataout']
        oname = None
        for reg_name in regs:
            name = "alta_ioreg%02i:%s" % (z, reg_name)
            wire = "%s:%s" % (tile_name, name)
            addWire(row, col, wire)
            if reg_name == 'combout':
                oname = wire
            
        ios = ['combout']
        for io_name in ios:
            name = "alta_io%02i:%s" % (z, io_name)
            wire = "%s:%s" % (tile_name, name)
            addWire(row, col, wire)
        
        iname = "%s:IOMUX%02i" % (tile_name, z)
        oename = "%s:oe%02i" % (tile_name, z)
        
        # iname and oname wires are already created
        addWire(row, col, oename)
        
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
        createAlias(src, dest, row, col)

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
    
    for an_input in ['clkin', 'clkfb', 'pllen', 'resetn']:
        wire = "%s:%s" % (wire_base, an_input)
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=an_input, wire=wire)

    for an_output in ['lock']:
        wire = "%s:%s" % (wire_base, an_output)
        addWire(row, col, wire)
        ctx.addBelOutput(bel=belname, name=an_output, wire=wire)

def createUFMTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))

    ctx.addBel(name=belname, type="alta_boot", loc=Loc(col, row, 0), gb=False)
    wire_prefix = "%s:alta_boot00" % (belname)
    
    inputs = ["i_osc_enb", "i_boot", "im_vector_sel"]
    for an_input in inputs:
        wire = "%s:%s" % (wire_prefix, an_input)
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=an_input, wire=wire)
    
    outputs = ["o_osc"]
    for an_output in outputs:
        wire = "%s:%s" % (wire_prefix, an_output)
        addWire(row, col, wire)
        ctx.addBelOutput(bel=belname, name=an_output, wire=wire)

    for gdd in range(0, 8):
        wire_prefix = "%s:alta_ufm_gddd%02i" % (belname, gdd)
        inname = "in" 
        src = wire_prefix+":"+inname
        addWire(row, col, src, inname)
    
        outname = "out" 
        dest = wire_prefix+":"+outname
        addWire(row, col, dest, outname)
        createAlias(src, dest, row, col)
        
    wire_prefix = "%s:alta_io_gclk00" % (belname)
    inname = "in" 
    src = wire_prefix+":"+inname
    addWire(row, col, src, inname)
    
    outname = "out" 
    dest = wire_prefix+":"+outname
    addWire(row, col, dest, outname)
    createAlias(src, dest, row, col)


def createBRAMTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_BRAM", loc=Loc(col, row, 0), gb=False)
    
    wire_base = belname + ":alta_bram00:"
    for base in ["Clk", "ClkEn", "AsyncReset"]:
        for port in range(0, 2):
            pin = "%s%i"  % (base, port)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    for pin in ["WeRenA", "WeRenB"]:
        wire = wire_base + pin
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    for address in ["AddressA", "AddressB"]:
        for bit in range(0, 12):
            pin = "%s[%i]" % (address, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
            
    for data in ['DataOutA', 'DataOutB']:
        for bit in range(0, 18):
            pin = "%s[%i]" % (data, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelOutput(bel=belname, name=pin, wire=wire)

    for data in ['DataInA', 'DataInB']:
        for bit in range(0, 18):
            pin = "%s[%i]" % (data, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelOutput(bel=belname, name=pin, wire=wire)

def createPIP(pip_name, pip_type, wire_src, wire_dest, delay, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    #print("createPIP(%s, %s, %s, %s, %s, %s, %s)" % (pip_name, pip_type, wire_src, wire_dest, delay, row, col))
    try:
        ctx.addPip(
            name=pip_name, type=pip_type, srcWire=wire_src, dstWire=wire_dest,
            delay=ctx.getDelayFromNS(delay), loc=Loc(col, row, 0))
    except IndexError as e:
        print("createPIP: name=%s => %s" % (pip_name, e))
        pass
    except AssertionError as e:
        print("createPIP: name=%s => %s" % (pip_name, e))
        pass

def createAlias(src, dest, row, col):
    createPIP("%s <= %s" % (src, dest), "alias", src, dest, 0, row, col)
    

def addWire(row, col, name, typ=""):
    #print("addWire(%s, %s, %s, %s)" % (row, col, name, typ))
    assert row < chip.rows
    assert col < chip.columns 
    try:
        ctx.addWire(name=name, type=typ, y=row, x=col)
    except AssertionError as e:
        print("addWire: name=%s, y=%i, x=%i => %s" % (name, row, col, e))
        pass

#
# Create wires and BELs
#
print("Creating wires and BELs")
for row in range(0, chip.rows):
    for col in range(0, chip.columns):
        tile = chip.tile_at(col, row)
        if tile is None:
            continue
        
        ttype = tile.type
        pseudos = tile.pseudos
        for prefix in pseudos:
            count = pseudos[prefix]
            for num in range(0, count):
                key = "%s%02i" % (prefix, num)
                addWire(row, col, "%s(%02i,%02i):%s" % (ttype, col, row, key), "O0")

        for key in tile.values:
            if not "MUX" in key:
                continue

            addWire(row, col, "%s(%02i,%02i):%s" % (ttype, col, row, key), "O0")
        
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

print("Creating PIPs")
def wire_enumerator(wire):
    source = wire.source
    dest = wire.dest
    
    assert source.row < chip.rows
    assert dest.row < chip.rows
    assert source.col < chip.columns
    assert dest.col < chip.columns
    
    createPIP(wire.name, wire.wire_type, source.name, dest.name, wire.delay, dest.row, dest.col)

chip.wire_db.enumerate_all_wires(wire_enumerator)
