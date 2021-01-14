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

from chips import ChipWithID, ChipOrPackageNamed

chip_id_env = 'AGM_DEVICE'

if not chip_id_env in os.environ:
    chip = ChipWithID(0x00120010)
else:
    chip = ChipOrPackageNamed(os.environ[chip_id_env])

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

def createClockIOTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    tile_name = nameForTile(tile, row, col)

    for z in range(0, tile.slices):
        belname = "%s:alta_rio%02i" % (tile_name, z)
        ctx.addBel(name=belname, type="GENERIC_IOB", loc=Loc(col, row, z), gb=True)

        name = "alta_io%02i:combout" % (z)
        wire = "%s:%s" % (tile_name, name)
        addWire(row, col, wire)
        ctx.addBelOutput(bel=belname, name="O", wire=wire)
    
    num_clocks = 5

    for clock in range(0, num_clocks):
        # alta_io_gclk
        inname = "alta_io_gclk%02i:inclk" % clock
        src = tile_name+":"+inname
        addWire(row, col, src, inname)
    
        outname = "alta_io_gclk%02i:outclk" % clock
        dest = tile_name+":"+outname
        addWire(row, col, dest, outname)
        createAlias(src, dest, row, col)
        
        # alta_gclkgen
        inname = "alta_gclkgen%02i:clkin" % clock
        src = tile_name+":"+inname
        addWire(row, col, src, inname)
    
        outname = "alta_gclkgen%02i:clkout" % clock
        dest = tile_name+":"+outname
        addWire(row, col, dest, outname)
        createAlias(src, dest, row, col)

        # alta_gclksel
        inname = "alta_gclksel%02i:clkin" % clock
        src = tile_name+":"+inname
        addWire(row, col, src, inname)
    
        outname = "alta_gclksel%02i:clkout" % clock
        dest = tile_name+":"+outname
        addWire(row, col, dest, outname)
        createAlias(src, dest, row, col)

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
        if tile.name.startswith('AG1200_'):
            count = 1
        else:
            count = 5
        
        for num in range(0, count):
            inname = "alta_io_gclk%02i:inclk" % num
            src = tile_name+":"+inname
            addWire(row, col, src, inname)
        
            outname = "alta_io_gclk%02i:outclk" % num
            dest = tile_name+":"+outname
            addWire(row, col, dest, outname)
            createAlias(src, dest, row, col)
    
    if "T2" in tile.name:
        outname = "alta_dpclkdel00:clkout"
        src = tile_name+":"+outname
        addWire(row, col, src, outname)

def createMultTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    ctx.addBel(name=belname, type="alta_mult", loc=Loc(col, row, 0), gb=False)
    
    wire_base = belname + ":alta_mult00:"
    inputs = ['DataInA0', 'DataInA1', 'DataInB0', 'DataInB1']
    for an_input in inputs:
        for bit in range(0, 9):
            pin = "%s[%i]" % (an_input, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    outputs = ['DataOut0', 'DataOut1']
    for an_output in outputs:
        for bit in range(0, 18):
            pin = "%s[%i]" % (an_output, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelOutput(bel=belname, name=pin, wire=wire)
        
    inputs = ['AsyncReset', 'Clk', 'ClkEn', 'SignA', 'SignB']
    for pin in inputs:
        wire = wire_base + pin
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=pin, wire=wire)
        
def createPLLTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    ctx.addBel(name=belname, type="GENERIC_PLL", loc=Loc(col, row, 0), gb=False)
    
    if tile.name.endswith('PLLX'):
        wire_base = "%s:alta_pllx00" % (belname)
        num_clocks = 4
    else:
        wire_base = "%s:alta_pllv00" % (belname)
        num_clocks = 5
        
    for clock in range(0, num_clocks):
        output = "clkout%i" % (clock)
        input = "clkout%ien" % (clock)

        out_wire = "%s:%s" % (wire_base, output)
        addWire(row, col, out_wire)
        
        in_wire = "%s:%s" % (wire_base, input)
        addWire(row, col, in_wire)

        ctx.addBelOutput(bel=belname, name=output, wire=out_wire)
        ctx.addBelInput(bel=belname, name=input, wire=in_wire)
    
    inputs = ['clkin', 'pllen', 'resetn']
    if tile.name.endswith('PLLX'):
        inputs.append('clkfb')
    
    for an_input in inputs:
        wire = "%s:%s" % (wire_base, an_input)
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=an_input, wire=wire)

    for an_output in ['lock']:
        wire = "%s:%s" % (wire_base, an_output)
        addWire(row, col, wire)
        ctx.addBelOutput(bel=belname, name=an_output, wire=wire)

def createBootTile(chip, tile, row, col):
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

def createMCUTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    #ctx.addBel(name=belname, type="alta_mcu00", loc=Loc(col, row, 0), gb=False)
    
    wires = {
        'CLK': 1, 'EXT_CPU_RST_n': 1, 'EXT_RAM_ADDR': 14, 'EXT_RAM_BYTE_EN': 4, 'EXT_RAM_EN': 1, 'EXT_RAM_RDATA': 32, 'EXT_RAM_WDATA': 32, 'EXT_RAM_WR': 1,
        'FLASH_CS_n': 1, 'FLASH_IO0_SI': 1, 'FLASH_IO0_SI_i': 1, 'FLASH_IO1_SO': 1, 'FLASH_IO1_SO_i': 1, 'FLASH_IO2_WPn': 1, 'FLASH_IO2_WPn_i': 1, 'FLASH_IO3_HOLDn': 1,
        'FLASH_IO3_HOLDn_i': 1, 'FLASH_SCK': 1, 'FLASH_SI_OE': 1, 'FLASH_SO_OE': 1, 'GPIO0_I': 8, 'GPIO0_O': 8, 'GPIO1_I': 8, 'GPIO1_O': 8,
        'GPIO2_I': 8, 'GPIO2_O': 8, 'HADDR_EXT': 32, 'HOLDn_IO3_OE': 1, 'HRDATA_EXT': 32, 'HREADY_IN_EXT': 1, 'HREADY_OUT_EXT': 1, 'HRESP_EXT': 2,
        'HSEL_EXT': 1, 'HSIZE_EXT': 3, 'HTRANS_EXT': 2, 'HWDATA_EXT': 32, 'HWRITE_EXT': 1, 'JTCK': 1, 'JTDI': 1, 'JTDO': 1,
        'JTMS': 1, 'JTRST_n': 1, 'POR_n': 1, 'UART_CTS_n': 1, 'UART_RTS_n': 1, 'UART_RXD': 1, 'UART_TXD': 1, 'WPn_IO2_OE': 1,
        'nGPEN0': 8, 'nGPEN1': 8, 'nGPEN2': 8,
    }
    wire_base = belname + ":alta_mcu00:"
    for key in wires:
        wire = wire_base + key
        addWire(row, col, wire)

def createJTAGTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    #ctx.addBel(name=belname, type="alta_jtag", loc=Loc(col, row, 0), gb=False)

    wire_base = belname + ":alta_jtag00:"
    inputs = ['clkdruser', 'runidleuser', 'shiftuser', 'tckutap', 'tdiutap', 'tdouser', 'tmsutap', 'updateuser', 'usr1user']
    for an_input in inputs:
        wire = wire_base + an_input
        addWire(row, col, wire)

def createBRAMTile(chip, tile, row, col):
    assert row < chip.rows
    assert col < chip.columns 
    belname = nameForTile(tile, row, col)
    #print("Creating %s" % (belname))
    
    if tile.name == "ALTA_EMB4K5":
        wire_base = belname + ":alta_bram00:"
        addr_len = 12
        data_len = 18
        configs = ["WeRenA", "WeRenB"]
        type = "alta_bram"
    else:
        wire_base = belname + ":alta_bram9k00:"
        addr_len = 13
        data_len = 18
        configs = ['WeA', 'WeB', 'ReA', 'ReB', 'ByteEnA', 'ByteEnB', 'AddressStallA', 'AddressStallB']  
        type = "alta_bram9k"      
        
    ctx.addBel(name=belname, type=type, loc=Loc(col, row, 0), gb=False)
    
    for base in ["Clk", "ClkEn", "AsyncReset"]:
        for port in range(0, 2):
            pin = "%s%i"  % (base, port)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    for pin in configs:
        wire = wire_base + pin
        addWire(row, col, wire)
        ctx.addBelInput(bel=belname, name=pin, wire=wire)
    
    for address in ["AddressA", "AddressB"]:
        for bit in range(0, addr_len):
            pin = "%s[%i]" % (address, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelInput(bel=belname, name=pin, wire=wire)
            
    for data in ['DataOutA', 'DataOutB']:
        for bit in range(0, data_len):
            pin = "%s[%i]" % (data, bit)
            wire = wire_base + pin
            addWire(row, col, wire)
            ctx.addBelOutput(bel=belname, name=pin, wire=wire)

    for data in ['DataInA', 'DataInB']:
        for bit in range(0, data_len):
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
            if "G5" in tile.name:
                createClockIOTile(chip, tile, row, col)
            else:
                createIOTile(chip, tile, row, col)
        elif ttype == "LogicTILE":
            createLogicTile(chip, tile, row, col)
        elif ttype == "MultTILE":
            createMultTile(chip, tile, row, col)
        elif ttype == "BramTILE":
            createBRAMTile(chip, tile, row, col)
        elif ttype == "PLLTILE":
            createPLLTile(chip, tile, row, col)
        elif ttype == "UFMTILE":
            if "MCU" in tile.name:
                createMCUTile(chip, tile, row, col)
            elif "JTAG" in tile.name:
                createJTAGTile(chip, tile, row, col)
            elif "BOOT" in tile.name or "boot" in tile.name:
                createBootTile(chip, tile, row, col)

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
