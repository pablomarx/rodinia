`timescale 1 ps/ 1 ps

module Blinky(
	clk,
	bank0,
	bank1,
	bank2,
	bank3);
input	clk;
output	[7:0] bank0;
output	[7:0] bank1;
output	[7:0] bank2;
output	[7:0] bank3;

//wire	gnd;
//wire	vcc;
wire	AsyncReset_X1_Y16_GND;
wire	AsyncReset_X1_Y17_GND;
wire	\auto_generated_inst|unknown ;
wire	\auto_generated_inst|~ALTERA_ASDO_DATA1~~ibuf_o ;
wire	\auto_generated_inst|~ALTERA_ASDO_DATA1~~padout ;
wire	\auto_generated_inst|~ALTERA_DATA0~~ibuf_o ;
wire	\auto_generated_inst|~ALTERA_DATA0~~padout ;
wire	\auto_generated_inst|~ALTERA_FLASH_nCE_nCSO~~ibuf_o ;
wire	\auto_generated_inst|~ALTERA_FLASH_nCE_nCSO~~padout ;
wire	\clk~input_o ;
wire	\clk~inputclkctrl_outclk ;
wire	\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ;
wire	\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ;
wire	[31:0] counter;
//wire	counter[0];
wire	\counter[0]~81_combout ;
//wire	counter[10];
wire	\counter[10]~45_combout ;
wire	\counter[10]~46 ;
//wire	counter[11];
wire	\counter[11]~47_combout ;
wire	\counter[11]~48 ;
//wire	counter[12];
wire	\counter[12]~49_combout ;
wire	\counter[12]~50 ;
//wire	counter[13];
wire	\counter[13]~51_combout ;
wire	\counter[13]~52 ;
//wire	counter[14];
wire	\counter[14]~53_combout ;
wire	\counter[14]~54 ;
//wire	counter[15];
wire	\counter[15]~55_combout ;
wire	\counter[15]~56 ;
//wire	counter[16];
wire	\counter[16]~57_combout ;
wire	\counter[16]~58 ;
//wire	counter[17];
wire	\counter[17]~59_combout ;
wire	\counter[17]~60 ;
//wire	counter[18];
wire	\counter[18]~61_combout ;
wire	\counter[18]~62 ;
//wire	counter[19];
wire	\counter[19]~63_combout ;
wire	\counter[19]~64 ;
//wire	counter[1];
wire	\counter[1]~27_combout ;
wire	\counter[1]~28 ;
//wire	counter[20];
wire	\counter[20]~65_combout ;
wire	\counter[20]~66 ;
//wire	counter[21];
wire	\counter[21]~67_combout ;
wire	\counter[21]~68 ;
//wire	counter[22];
wire	\counter[22]~69_combout ;
wire	\counter[22]~70 ;
//wire	counter[23];
wire	\counter[23]~71_combout ;
wire	\counter[23]~72 ;
//wire	counter[24];
wire	\counter[24]~73_combout ;
wire	\counter[24]~74 ;
//wire	counter[25];
wire	\counter[25]~75_combout ;
wire	\counter[25]~76 ;
//wire	counter[26];
wire	\counter[26]~77_combout ;
wire	\counter[26]~78 ;
//wire	counter[27];
wire	\counter[27]~79_combout ;
//wire	counter[28];
//wire	counter[29];
//wire	counter[2];
wire	\counter[2]~29_combout ;
wire	\counter[2]~30 ;
//wire	counter[30];
//wire	counter[31];
//wire	counter[3];
wire	\counter[3]~31_combout ;
wire	\counter[3]~32 ;
//wire	counter[4];
wire	\counter[4]~33_combout ;
wire	\counter[4]~34 ;
//wire	counter[5];
wire	\counter[5]~35_combout ;
wire	\counter[5]~36 ;
//wire	counter[6];
wire	\counter[6]~37_combout ;
wire	\counter[6]~38 ;
//wire	counter[7];
wire	\counter[7]~39_combout ;
wire	\counter[7]~40 ;
//wire	counter[8];
wire	\counter[8]~41_combout ;
wire	\counter[8]~42 ;
//wire	counter[9];
wire	\counter[9]~43_combout ;
wire	\counter[9]~44 ;
tri1	devclrn;
tri1	devoe;
tri1	devpor;
wire	unknown;

assign vcc = 1'b1;
assign gnd = 1'b0;

alta_asyncctrl asyncreset_ctrl_X1_Y16_N0(
	.Din(),
	.Dout(AsyncReset_X1_Y16_GND));
defparam asyncreset_ctrl_X1_Y16_N0.coord_x = 6;
defparam asyncreset_ctrl_X1_Y16_N0.coord_y = 5;
defparam asyncreset_ctrl_X1_Y16_N0.coord_z = 0;
defparam asyncreset_ctrl_X1_Y16_N0.AsyncCtrlMux = 2'b00;

alta_asyncctrl asyncreset_ctrl_X1_Y17_N0(
	.Din(),
	.Dout(AsyncReset_X1_Y17_GND));
defparam asyncreset_ctrl_X1_Y17_N0.coord_x = 6;
defparam asyncreset_ctrl_X1_Y17_N0.coord_y = 6;
defparam asyncreset_ctrl_X1_Y17_N0.coord_z = 0;
defparam asyncreset_ctrl_X1_Y17_N0.AsyncCtrlMux = 2'b00;

alta_rio \bank0[0]~output (
	.padio(bank0[0]),
	.datain(counter[20]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[0]~output .coord_x = 2;
defparam \bank0[0]~output .coord_y = 9;
defparam \bank0[0]~output .coord_z = 0;
defparam \bank0[0]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[0]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[0]~output .IN_POWERUP = 1'b0;
defparam \bank0[0]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[0]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[0]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[0]~output .OUT_POWERUP = 1'b0;
defparam \bank0[0]~output .OE_REG_MODE = 1'b0;
defparam \bank0[0]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[0]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[0]~output .OE_POWERUP = 1'b0;
defparam \bank0[0]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[0]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[0]~output .CFG_SLR = 1'b0;
defparam \bank0[0]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[0]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[0]~output .CFG_KEEP = 2'b00;
defparam \bank0[0]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[0]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[0]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[0]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[0]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[0]~output .OUT_DELAY = 1'b0;
defparam \bank0[0]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[0]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[1]~output (
	.padio(bank0[1]),
	.datain(counter[21]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[1]~output .coord_x = 1;
defparam \bank0[1]~output .coord_y = 9;
defparam \bank0[1]~output .coord_z = 3;
defparam \bank0[1]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[1]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[1]~output .IN_POWERUP = 1'b0;
defparam \bank0[1]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[1]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[1]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[1]~output .OUT_POWERUP = 1'b0;
defparam \bank0[1]~output .OE_REG_MODE = 1'b0;
defparam \bank0[1]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[1]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[1]~output .OE_POWERUP = 1'b0;
defparam \bank0[1]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[1]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[1]~output .CFG_SLR = 1'b0;
defparam \bank0[1]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[1]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[1]~output .CFG_KEEP = 2'b00;
defparam \bank0[1]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[1]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[1]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[1]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[1]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[1]~output .OUT_DELAY = 1'b0;
defparam \bank0[1]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[1]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[2]~output (
	.padio(bank0[2]),
	.datain(counter[22]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[2]~output .coord_x = 0;
defparam \bank0[2]~output .coord_y = 9;
defparam \bank0[2]~output .coord_z = 2;
defparam \bank0[2]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[2]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[2]~output .IN_POWERUP = 1'b0;
defparam \bank0[2]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[2]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[2]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[2]~output .OUT_POWERUP = 1'b0;
defparam \bank0[2]~output .OE_REG_MODE = 1'b0;
defparam \bank0[2]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[2]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[2]~output .OE_POWERUP = 1'b0;
defparam \bank0[2]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[2]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[2]~output .CFG_SLR = 1'b0;
defparam \bank0[2]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[2]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[2]~output .CFG_KEEP = 2'b00;
defparam \bank0[2]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[2]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[2]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[2]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[2]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[2]~output .OUT_DELAY = 1'b0;
defparam \bank0[2]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[2]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[3]~output (
	.padio(bank0[3]),
	.datain(counter[23]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[3]~output .coord_x = 0;
defparam \bank0[3]~output .coord_y = 9;
defparam \bank0[3]~output .coord_z = 0;
defparam \bank0[3]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[3]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[3]~output .IN_POWERUP = 1'b0;
defparam \bank0[3]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[3]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[3]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[3]~output .OUT_POWERUP = 1'b0;
defparam \bank0[3]~output .OE_REG_MODE = 1'b0;
defparam \bank0[3]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[3]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[3]~output .OE_POWERUP = 1'b0;
defparam \bank0[3]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[3]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[3]~output .CFG_SLR = 1'b0;
defparam \bank0[3]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[3]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[3]~output .CFG_KEEP = 2'b00;
defparam \bank0[3]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[3]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[3]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[3]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[3]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[3]~output .OUT_DELAY = 1'b0;
defparam \bank0[3]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[3]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[4]~output (
	.padio(bank0[4]),
	.datain(counter[24]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[4]~output .coord_x = 1;
defparam \bank0[4]~output .coord_y = 9;
defparam \bank0[4]~output .coord_z = 1;
defparam \bank0[4]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[4]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[4]~output .IN_POWERUP = 1'b0;
defparam \bank0[4]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[4]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[4]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[4]~output .OUT_POWERUP = 1'b0;
defparam \bank0[4]~output .OE_REG_MODE = 1'b0;
defparam \bank0[4]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[4]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[4]~output .OE_POWERUP = 1'b0;
defparam \bank0[4]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[4]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[4]~output .CFG_SLR = 1'b0;
defparam \bank0[4]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[4]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[4]~output .CFG_KEEP = 2'b00;
defparam \bank0[4]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[4]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[4]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[4]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[4]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[4]~output .OUT_DELAY = 1'b0;
defparam \bank0[4]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[4]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[5]~output (
	.padio(bank0[5]),
	.datain(counter[25]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[5]~output .coord_x = 6;
defparam \bank0[5]~output .coord_y = 9;
defparam \bank0[5]~output .coord_z = 2;
defparam \bank0[5]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[5]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[5]~output .IN_POWERUP = 1'b0;
defparam \bank0[5]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[5]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[5]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[5]~output .OUT_POWERUP = 1'b0;
defparam \bank0[5]~output .OE_REG_MODE = 1'b0;
defparam \bank0[5]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[5]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[5]~output .OE_POWERUP = 1'b0;
defparam \bank0[5]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[5]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[5]~output .CFG_SLR = 1'b0;
defparam \bank0[5]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[5]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[5]~output .CFG_KEEP = 2'b00;
defparam \bank0[5]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[5]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[5]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[5]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[5]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[5]~output .OUT_DELAY = 1'b0;
defparam \bank0[5]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[5]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[6]~output (
	.padio(bank0[6]),
	.datain(counter[26]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[6]~output .coord_x = 2;
defparam \bank0[6]~output .coord_y = 1;
defparam \bank0[6]~output .coord_z = 0;
defparam \bank0[6]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[6]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[6]~output .IN_POWERUP = 1'b0;
defparam \bank0[6]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[6]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[6]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[6]~output .OUT_POWERUP = 1'b0;
defparam \bank0[6]~output .OE_REG_MODE = 1'b0;
defparam \bank0[6]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[6]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[6]~output .OE_POWERUP = 1'b0;
defparam \bank0[6]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[6]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[6]~output .CFG_SLR = 1'b0;
defparam \bank0[6]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[6]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[6]~output .CFG_KEEP = 2'b00;
defparam \bank0[6]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[6]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[6]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[6]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[6]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[6]~output .OUT_DELAY = 1'b0;
defparam \bank0[6]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[6]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank0[7]~output (
	.padio(bank0[7]),
	.datain(counter[27]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank0[7]~output .coord_x = 2;
defparam \bank0[7]~output .coord_y = 1;
defparam \bank0[7]~output .coord_z = 2;
defparam \bank0[7]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank0[7]~output .IN_SYNC_MODE = 1'b0;
defparam \bank0[7]~output .IN_POWERUP = 1'b0;
defparam \bank0[7]~output .OUT_REG_MODE = 1'b0;
defparam \bank0[7]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank0[7]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank0[7]~output .OUT_POWERUP = 1'b0;
defparam \bank0[7]~output .OE_REG_MODE = 1'b0;
defparam \bank0[7]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank0[7]~output .OE_SYNC_MODE = 1'b0;
defparam \bank0[7]~output .OE_POWERUP = 1'b0;
defparam \bank0[7]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank0[7]~output .CFG_PULL_UP = 1'b0;
defparam \bank0[7]~output .CFG_SLR = 1'b0;
defparam \bank0[7]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank0[7]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank0[7]~output .CFG_KEEP = 2'b00;
defparam \bank0[7]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank0[7]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank0[7]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank0[7]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank0[7]~output .DPCLK_DELAY = 4'b0000;
defparam \bank0[7]~output .OUT_DELAY = 1'b0;
defparam \bank0[7]~output .IN_DATA_DELAY = 3'b000;
defparam \bank0[7]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[0]~output (
	.padio(bank1[0]),
	.datain(counter[20]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[0]~output .coord_x = 4;
defparam \bank1[0]~output .coord_y = 1;
defparam \bank1[0]~output .coord_z = 0;
defparam \bank1[0]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[0]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[0]~output .IN_POWERUP = 1'b0;
defparam \bank1[0]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[0]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[0]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[0]~output .OUT_POWERUP = 1'b0;
defparam \bank1[0]~output .OE_REG_MODE = 1'b0;
defparam \bank1[0]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[0]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[0]~output .OE_POWERUP = 1'b0;
defparam \bank1[0]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[0]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[0]~output .CFG_SLR = 1'b0;
defparam \bank1[0]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[0]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[0]~output .CFG_KEEP = 2'b00;
defparam \bank1[0]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[0]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[0]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[0]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[0]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[0]~output .OUT_DELAY = 1'b0;
defparam \bank1[0]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[0]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[1]~output (
	.padio(bank1[1]),
	.datain(counter[21]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[1]~output .coord_x = 4;
defparam \bank1[1]~output .coord_y = 1;
defparam \bank1[1]~output .coord_z = 2;
defparam \bank1[1]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[1]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[1]~output .IN_POWERUP = 1'b0;
defparam \bank1[1]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[1]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[1]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[1]~output .OUT_POWERUP = 1'b0;
defparam \bank1[1]~output .OE_REG_MODE = 1'b0;
defparam \bank1[1]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[1]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[1]~output .OE_POWERUP = 1'b0;
defparam \bank1[1]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[1]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[1]~output .CFG_SLR = 1'b0;
defparam \bank1[1]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[1]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[1]~output .CFG_KEEP = 2'b00;
defparam \bank1[1]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[1]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[1]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[1]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[1]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[1]~output .OUT_DELAY = 1'b0;
defparam \bank1[1]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[1]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[2]~output (
	.padio(bank1[2]),
	.datain(counter[22]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[2]~output .coord_x = 5;
defparam \bank1[2]~output .coord_y = 1;
defparam \bank1[2]~output .coord_z = 0;
defparam \bank1[2]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[2]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[2]~output .IN_POWERUP = 1'b0;
defparam \bank1[2]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[2]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[2]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[2]~output .OUT_POWERUP = 1'b0;
defparam \bank1[2]~output .OE_REG_MODE = 1'b0;
defparam \bank1[2]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[2]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[2]~output .OE_POWERUP = 1'b0;
defparam \bank1[2]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[2]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[2]~output .CFG_SLR = 1'b0;
defparam \bank1[2]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[2]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[2]~output .CFG_KEEP = 2'b00;
defparam \bank1[2]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[2]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[2]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[2]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[2]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[2]~output .OUT_DELAY = 1'b0;
defparam \bank1[2]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[2]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[3]~output (
	.padio(bank1[3]),
	.datain(counter[23]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[3]~output .coord_x = 5;
defparam \bank1[3]~output .coord_y = 1;
defparam \bank1[3]~output .coord_z = 1;
defparam \bank1[3]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[3]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[3]~output .IN_POWERUP = 1'b0;
defparam \bank1[3]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[3]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[3]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[3]~output .OUT_POWERUP = 1'b0;
defparam \bank1[3]~output .OE_REG_MODE = 1'b0;
defparam \bank1[3]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[3]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[3]~output .OE_POWERUP = 1'b0;
defparam \bank1[3]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[3]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[3]~output .CFG_SLR = 1'b0;
defparam \bank1[3]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[3]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[3]~output .CFG_KEEP = 2'b00;
defparam \bank1[3]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[3]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[3]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[3]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[3]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[3]~output .OUT_DELAY = 1'b0;
defparam \bank1[3]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[3]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[4]~output (
	.padio(bank1[4]),
	.datain(counter[24]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[4]~output .coord_x = 5;
defparam \bank1[4]~output .coord_y = 1;
defparam \bank1[4]~output .coord_z = 2;
defparam \bank1[4]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[4]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[4]~output .IN_POWERUP = 1'b0;
defparam \bank1[4]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[4]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[4]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[4]~output .OUT_POWERUP = 1'b0;
defparam \bank1[4]~output .OE_REG_MODE = 1'b0;
defparam \bank1[4]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[4]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[4]~output .OE_POWERUP = 1'b0;
defparam \bank1[4]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[4]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[4]~output .CFG_SLR = 1'b0;
defparam \bank1[4]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[4]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[4]~output .CFG_KEEP = 2'b00;
defparam \bank1[4]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[4]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[4]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[4]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[4]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[4]~output .OUT_DELAY = 1'b0;
defparam \bank1[4]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[4]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[5]~output (
	.padio(bank1[5]),
	.datain(counter[25]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[5]~output .coord_x = 5;
defparam \bank1[5]~output .coord_y = 1;
defparam \bank1[5]~output .coord_z = 3;
defparam \bank1[5]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[5]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[5]~output .IN_POWERUP = 1'b0;
defparam \bank1[5]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[5]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[5]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[5]~output .OUT_POWERUP = 1'b0;
defparam \bank1[5]~output .OE_REG_MODE = 1'b0;
defparam \bank1[5]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[5]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[5]~output .OE_POWERUP = 1'b0;
defparam \bank1[5]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[5]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[5]~output .CFG_SLR = 1'b0;
defparam \bank1[5]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[5]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[5]~output .CFG_KEEP = 2'b00;
defparam \bank1[5]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[5]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[5]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[5]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[5]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[5]~output .OUT_DELAY = 1'b0;
defparam \bank1[5]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[5]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[6]~output (
	.padio(bank1[6]),
	.datain(counter[26]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[6]~output .coord_x = 6;
defparam \bank1[6]~output .coord_y = 1;
defparam \bank1[6]~output .coord_z = 0;
defparam \bank1[6]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[6]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[6]~output .IN_POWERUP = 1'b0;
defparam \bank1[6]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[6]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[6]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[6]~output .OUT_POWERUP = 1'b0;
defparam \bank1[6]~output .OE_REG_MODE = 1'b0;
defparam \bank1[6]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[6]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[6]~output .OE_POWERUP = 1'b0;
defparam \bank1[6]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[6]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[6]~output .CFG_SLR = 1'b0;
defparam \bank1[6]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[6]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[6]~output .CFG_KEEP = 2'b00;
defparam \bank1[6]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[6]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[6]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[6]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[6]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[6]~output .OUT_DELAY = 1'b0;
defparam \bank1[6]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[6]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank1[7]~output (
	.padio(bank1[7]),
	.datain(counter[27]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank1[7]~output .coord_x = 6;
defparam \bank1[7]~output .coord_y = 1;
defparam \bank1[7]~output .coord_z = 1;
defparam \bank1[7]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank1[7]~output .IN_SYNC_MODE = 1'b0;
defparam \bank1[7]~output .IN_POWERUP = 1'b0;
defparam \bank1[7]~output .OUT_REG_MODE = 1'b0;
defparam \bank1[7]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank1[7]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank1[7]~output .OUT_POWERUP = 1'b0;
defparam \bank1[7]~output .OE_REG_MODE = 1'b0;
defparam \bank1[7]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank1[7]~output .OE_SYNC_MODE = 1'b0;
defparam \bank1[7]~output .OE_POWERUP = 1'b0;
defparam \bank1[7]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank1[7]~output .CFG_PULL_UP = 1'b0;
defparam \bank1[7]~output .CFG_SLR = 1'b0;
defparam \bank1[7]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank1[7]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank1[7]~output .CFG_KEEP = 2'b00;
defparam \bank1[7]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank1[7]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank1[7]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank1[7]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank1[7]~output .DPCLK_DELAY = 4'b0000;
defparam \bank1[7]~output .OUT_DELAY = 1'b0;
defparam \bank1[7]~output .IN_DATA_DELAY = 3'b000;
defparam \bank1[7]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[0]~output (
	.padio(bank2[0]),
	.datain(counter[20]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[0]~output .coord_x = 6;
defparam \bank2[0]~output .coord_y = 1;
defparam \bank2[0]~output .coord_z = 2;
defparam \bank2[0]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[0]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[0]~output .IN_POWERUP = 1'b0;
defparam \bank2[0]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[0]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[0]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[0]~output .OUT_POWERUP = 1'b0;
defparam \bank2[0]~output .OE_REG_MODE = 1'b0;
defparam \bank2[0]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[0]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[0]~output .OE_POWERUP = 1'b0;
defparam \bank2[0]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[0]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[0]~output .CFG_SLR = 1'b0;
defparam \bank2[0]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[0]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[0]~output .CFG_KEEP = 2'b00;
defparam \bank2[0]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[0]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[0]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[0]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[0]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[0]~output .OUT_DELAY = 1'b0;
defparam \bank2[0]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[0]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[1]~output (
	.padio(bank2[1]),
	.datain(counter[21]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[1]~output .coord_x = 6;
defparam \bank2[1]~output .coord_y = 1;
defparam \bank2[1]~output .coord_z = 3;
defparam \bank2[1]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[1]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[1]~output .IN_POWERUP = 1'b0;
defparam \bank2[1]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[1]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[1]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[1]~output .OUT_POWERUP = 1'b0;
defparam \bank2[1]~output .OE_REG_MODE = 1'b0;
defparam \bank2[1]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[1]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[1]~output .OE_POWERUP = 1'b0;
defparam \bank2[1]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[1]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[1]~output .CFG_SLR = 1'b0;
defparam \bank2[1]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[1]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[1]~output .CFG_KEEP = 2'b00;
defparam \bank2[1]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[1]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[1]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[1]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[1]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[1]~output .OUT_DELAY = 1'b0;
defparam \bank2[1]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[1]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[2]~output (
	.padio(bank2[2]),
	.datain(counter[22]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[2]~output .coord_x = 9;
defparam \bank2[2]~output .coord_y = 0;
defparam \bank2[2]~output .coord_z = 1;
defparam \bank2[2]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[2]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[2]~output .IN_POWERUP = 1'b0;
defparam \bank2[2]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[2]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[2]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[2]~output .OUT_POWERUP = 1'b0;
defparam \bank2[2]~output .OE_REG_MODE = 1'b0;
defparam \bank2[2]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[2]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[2]~output .OE_POWERUP = 1'b0;
defparam \bank2[2]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[2]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[2]~output .CFG_SLR = 1'b0;
defparam \bank2[2]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[2]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[2]~output .CFG_KEEP = 2'b00;
defparam \bank2[2]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[2]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[2]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[2]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[2]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[2]~output .OUT_DELAY = 1'b0;
defparam \bank2[2]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[2]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[3]~output (
	.padio(bank2[3]),
	.datain(counter[23]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[3]~output .coord_x = 9;
defparam \bank2[3]~output .coord_y = 0;
defparam \bank2[3]~output .coord_z = 3;
defparam \bank2[3]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[3]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[3]~output .IN_POWERUP = 1'b0;
defparam \bank2[3]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[3]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[3]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[3]~output .OUT_POWERUP = 1'b0;
defparam \bank2[3]~output .OE_REG_MODE = 1'b0;
defparam \bank2[3]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[3]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[3]~output .OE_POWERUP = 1'b0;
defparam \bank2[3]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[3]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[3]~output .CFG_SLR = 1'b0;
defparam \bank2[3]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[3]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[3]~output .CFG_KEEP = 2'b00;
defparam \bank2[3]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[3]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[3]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[3]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[3]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[3]~output .OUT_DELAY = 1'b0;
defparam \bank2[3]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[3]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[4]~output (
	.padio(bank2[4]),
	.datain(counter[24]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[4]~output .coord_x = 8;
defparam \bank2[4]~output .coord_y = 9;
defparam \bank2[4]~output .coord_z = 0;
defparam \bank2[4]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[4]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[4]~output .IN_POWERUP = 1'b0;
defparam \bank2[4]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[4]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[4]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[4]~output .OUT_POWERUP = 1'b0;
defparam \bank2[4]~output .OE_REG_MODE = 1'b0;
defparam \bank2[4]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[4]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[4]~output .OE_POWERUP = 1'b0;
defparam \bank2[4]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[4]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[4]~output .CFG_SLR = 1'b0;
defparam \bank2[4]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[4]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[4]~output .CFG_KEEP = 2'b00;
defparam \bank2[4]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[4]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[4]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[4]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[4]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[4]~output .OUT_DELAY = 1'b0;
defparam \bank2[4]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[4]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[5]~output (
	.padio(bank2[5]),
	.datain(counter[25]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[5]~output .coord_x = 11;
defparam \bank2[5]~output .coord_y = 9;
defparam \bank2[5]~output .coord_z = 1;
defparam \bank2[5]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[5]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[5]~output .IN_POWERUP = 1'b0;
defparam \bank2[5]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[5]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[5]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[5]~output .OUT_POWERUP = 1'b0;
defparam \bank2[5]~output .OE_REG_MODE = 1'b0;
defparam \bank2[5]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[5]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[5]~output .OE_POWERUP = 1'b0;
defparam \bank2[5]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[5]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[5]~output .CFG_SLR = 1'b0;
defparam \bank2[5]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[5]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[5]~output .CFG_KEEP = 2'b00;
defparam \bank2[5]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[5]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[5]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[5]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[5]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[5]~output .OUT_DELAY = 1'b0;
defparam \bank2[5]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[5]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[6]~output (
	.padio(bank2[6]),
	.datain(counter[26]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[6]~output .coord_x = 9;
defparam \bank2[6]~output .coord_y = 9;
defparam \bank2[6]~output .coord_z = 3;
defparam \bank2[6]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[6]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[6]~output .IN_POWERUP = 1'b0;
defparam \bank2[6]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[6]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[6]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[6]~output .OUT_POWERUP = 1'b0;
defparam \bank2[6]~output .OE_REG_MODE = 1'b0;
defparam \bank2[6]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[6]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[6]~output .OE_POWERUP = 1'b0;
defparam \bank2[6]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[6]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[6]~output .CFG_SLR = 1'b0;
defparam \bank2[6]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[6]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[6]~output .CFG_KEEP = 2'b00;
defparam \bank2[6]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[6]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[6]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[6]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[6]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[6]~output .OUT_DELAY = 1'b0;
defparam \bank2[6]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[6]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank2[7]~output (
	.padio(bank2[7]),
	.datain(counter[27]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank2[7]~output .coord_x = 9;
defparam \bank2[7]~output .coord_y = 9;
defparam \bank2[7]~output .coord_z = 1;
defparam \bank2[7]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank2[7]~output .IN_SYNC_MODE = 1'b0;
defparam \bank2[7]~output .IN_POWERUP = 1'b0;
defparam \bank2[7]~output .OUT_REG_MODE = 1'b0;
defparam \bank2[7]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank2[7]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank2[7]~output .OUT_POWERUP = 1'b0;
defparam \bank2[7]~output .OE_REG_MODE = 1'b0;
defparam \bank2[7]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank2[7]~output .OE_SYNC_MODE = 1'b0;
defparam \bank2[7]~output .OE_POWERUP = 1'b0;
defparam \bank2[7]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank2[7]~output .CFG_PULL_UP = 1'b0;
defparam \bank2[7]~output .CFG_SLR = 1'b0;
defparam \bank2[7]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank2[7]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank2[7]~output .CFG_KEEP = 2'b00;
defparam \bank2[7]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank2[7]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank2[7]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank2[7]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank2[7]~output .DPCLK_DELAY = 4'b0000;
defparam \bank2[7]~output .OUT_DELAY = 1'b0;
defparam \bank2[7]~output .IN_DATA_DELAY = 3'b000;
defparam \bank2[7]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[0]~output (
	.padio(bank3[0]),
	.datain(counter[20]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[0]~output .coord_x = 8;
defparam \bank3[0]~output .coord_y = 9;
defparam \bank3[0]~output .coord_z = 3;
defparam \bank3[0]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[0]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[0]~output .IN_POWERUP = 1'b0;
defparam \bank3[0]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[0]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[0]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[0]~output .OUT_POWERUP = 1'b0;
defparam \bank3[0]~output .OE_REG_MODE = 1'b0;
defparam \bank3[0]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[0]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[0]~output .OE_POWERUP = 1'b0;
defparam \bank3[0]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[0]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[0]~output .CFG_SLR = 1'b0;
defparam \bank3[0]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[0]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[0]~output .CFG_KEEP = 2'b00;
defparam \bank3[0]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[0]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[0]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[0]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[0]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[0]~output .OUT_DELAY = 1'b0;
defparam \bank3[0]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[0]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[1]~output (
	.padio(bank3[1]),
	.datain(counter[21]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[1]~output .coord_x = 7;
defparam \bank3[1]~output .coord_y = 9;
defparam \bank3[1]~output .coord_z = 3;
defparam \bank3[1]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[1]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[1]~output .IN_POWERUP = 1'b0;
defparam \bank3[1]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[1]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[1]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[1]~output .OUT_POWERUP = 1'b0;
defparam \bank3[1]~output .OE_REG_MODE = 1'b0;
defparam \bank3[1]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[1]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[1]~output .OE_POWERUP = 1'b0;
defparam \bank3[1]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[1]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[1]~output .CFG_SLR = 1'b0;
defparam \bank3[1]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[1]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[1]~output .CFG_KEEP = 2'b00;
defparam \bank3[1]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[1]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[1]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[1]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[1]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[1]~output .OUT_DELAY = 1'b0;
defparam \bank3[1]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[1]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[2]~output (
	.padio(bank3[2]),
	.datain(counter[22]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[2]~output .coord_x = 7;
defparam \bank3[2]~output .coord_y = 9;
defparam \bank3[2]~output .coord_z = 0;
defparam \bank3[2]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[2]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[2]~output .IN_POWERUP = 1'b0;
defparam \bank3[2]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[2]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[2]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[2]~output .OUT_POWERUP = 1'b0;
defparam \bank3[2]~output .OE_REG_MODE = 1'b0;
defparam \bank3[2]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[2]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[2]~output .OE_POWERUP = 1'b0;
defparam \bank3[2]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[2]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[2]~output .CFG_SLR = 1'b0;
defparam \bank3[2]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[2]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[2]~output .CFG_KEEP = 2'b00;
defparam \bank3[2]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[2]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[2]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[2]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[2]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[2]~output .OUT_DELAY = 1'b0;
defparam \bank3[2]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[2]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[3]~output (
	.padio(bank3[3]),
	.datain(counter[23]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[3]~output .coord_x = 6;
defparam \bank3[3]~output .coord_y = 9;
defparam \bank3[3]~output .coord_z = 0;
defparam \bank3[3]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[3]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[3]~output .IN_POWERUP = 1'b0;
defparam \bank3[3]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[3]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[3]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[3]~output .OUT_POWERUP = 1'b0;
defparam \bank3[3]~output .OE_REG_MODE = 1'b0;
defparam \bank3[3]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[3]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[3]~output .OE_POWERUP = 1'b0;
defparam \bank3[3]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[3]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[3]~output .CFG_SLR = 1'b0;
defparam \bank3[3]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[3]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[3]~output .CFG_KEEP = 2'b00;
defparam \bank3[3]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[3]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[3]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[3]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[3]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[3]~output .OUT_DELAY = 1'b0;
defparam \bank3[3]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[3]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[4]~output (
	.padio(bank3[4]),
	.datain(counter[24]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[4]~output .coord_x = 5;
defparam \bank3[4]~output .coord_y = 9;
defparam \bank3[4]~output .coord_z = 3;
defparam \bank3[4]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[4]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[4]~output .IN_POWERUP = 1'b0;
defparam \bank3[4]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[4]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[4]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[4]~output .OUT_POWERUP = 1'b0;
defparam \bank3[4]~output .OE_REG_MODE = 1'b0;
defparam \bank3[4]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[4]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[4]~output .OE_POWERUP = 1'b0;
defparam \bank3[4]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[4]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[4]~output .CFG_SLR = 1'b0;
defparam \bank3[4]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[4]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[4]~output .CFG_KEEP = 2'b00;
defparam \bank3[4]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[4]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[4]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[4]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[4]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[4]~output .OUT_DELAY = 1'b0;
defparam \bank3[4]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[4]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[5]~output (
	.padio(bank3[5]),
	.datain(counter[25]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[5]~output .coord_x = 5;
defparam \bank3[5]~output .coord_y = 9;
defparam \bank3[5]~output .coord_z = 2;
defparam \bank3[5]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[5]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[5]~output .IN_POWERUP = 1'b0;
defparam \bank3[5]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[5]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[5]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[5]~output .OUT_POWERUP = 1'b0;
defparam \bank3[5]~output .OE_REG_MODE = 1'b0;
defparam \bank3[5]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[5]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[5]~output .OE_POWERUP = 1'b0;
defparam \bank3[5]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[5]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[5]~output .CFG_SLR = 1'b0;
defparam \bank3[5]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[5]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[5]~output .CFG_KEEP = 2'b00;
defparam \bank3[5]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[5]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[5]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[5]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[5]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[5]~output .OUT_DELAY = 1'b0;
defparam \bank3[5]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[5]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[6]~output (
	.padio(bank3[6]),
	.datain(counter[26]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[6]~output .coord_x = 5;
defparam \bank3[6]~output .coord_y = 9;
defparam \bank3[6]~output .coord_z = 1;
defparam \bank3[6]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[6]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[6]~output .IN_POWERUP = 1'b0;
defparam \bank3[6]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[6]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[6]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[6]~output .OUT_POWERUP = 1'b0;
defparam \bank3[6]~output .OE_REG_MODE = 1'b0;
defparam \bank3[6]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[6]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[6]~output .OE_POWERUP = 1'b0;
defparam \bank3[6]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[6]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[6]~output .CFG_SLR = 1'b0;
defparam \bank3[6]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[6]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[6]~output .CFG_KEEP = 2'b00;
defparam \bank3[6]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[6]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[6]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[6]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[6]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[6]~output .OUT_DELAY = 1'b0;
defparam \bank3[6]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[6]~output .IN_REG_DELAY = 3'b000;

alta_rio \bank3[7]~output (
	.padio(bank3[7]),
	.datain(counter[27]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \bank3[7]~output .coord_x = 5;
defparam \bank3[7]~output .coord_y = 9;
defparam \bank3[7]~output .coord_z = 0;
defparam \bank3[7]~output .IN_ASYNC_MODE = 1'b0;
defparam \bank3[7]~output .IN_SYNC_MODE = 1'b0;
defparam \bank3[7]~output .IN_POWERUP = 1'b0;
defparam \bank3[7]~output .OUT_REG_MODE = 1'b0;
defparam \bank3[7]~output .OUT_ASYNC_MODE = 1'b0;
defparam \bank3[7]~output .OUT_SYNC_MODE = 1'b0;
defparam \bank3[7]~output .OUT_POWERUP = 1'b0;
defparam \bank3[7]~output .OE_REG_MODE = 1'b0;
defparam \bank3[7]~output .OE_ASYNC_MODE = 1'b0;
defparam \bank3[7]~output .OE_SYNC_MODE = 1'b0;
defparam \bank3[7]~output .OE_POWERUP = 1'b0;
defparam \bank3[7]~output .CFG_TRI_INPUT = 1'b0;
defparam \bank3[7]~output .CFG_PULL_UP = 1'b0;
defparam \bank3[7]~output .CFG_SLR = 1'b0;
defparam \bank3[7]~output .CFG_OPEN_DRAIN = 1'b0;
defparam \bank3[7]~output .CFG_PDRCTRL = 4'b0010;
defparam \bank3[7]~output .CFG_KEEP = 2'b00;
defparam \bank3[7]~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \bank3[7]~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \bank3[7]~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \bank3[7]~output .CFG_LVDS_IN_EN = 1'b0;
defparam \bank3[7]~output .DPCLK_DELAY = 4'b0000;
defparam \bank3[7]~output .OUT_DELAY = 1'b0;
defparam \bank3[7]~output .IN_DATA_DELAY = 3'b000;
defparam \bank3[7]~output .IN_REG_DELAY = 3'b000;

alta_clkenctrl clken_ctrl_X1_Y16_N0(
	.ClkIn(\clk~inputclkctrl_outclk ),
	.ClkEn(),
	.ClkOut(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ));
defparam clken_ctrl_X1_Y16_N0.coord_x = 6;
defparam clken_ctrl_X1_Y16_N0.coord_y = 5;
defparam clken_ctrl_X1_Y16_N0.coord_z = 0;
defparam clken_ctrl_X1_Y16_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1_Y16_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X1_Y17_N0(
	.ClkIn(\clk~inputclkctrl_outclk ),
	.ClkEn(),
	.ClkOut(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ));
defparam clken_ctrl_X1_Y17_N0.coord_x = 6;
defparam clken_ctrl_X1_Y17_N0.coord_y = 6;
defparam clken_ctrl_X1_Y17_N0.coord_z = 0;
defparam clken_ctrl_X1_Y17_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1_Y17_N0.ClkEnMux = 2'b01;

alta_rio \clk~input (
	.padio(clk),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\clk~input_o ),
	.regout());
defparam \clk~input .coord_x = 4;
defparam \clk~input .coord_y = 9;
defparam \clk~input .coord_z = 0;
defparam \clk~input .IN_ASYNC_MODE = 1'b0;
defparam \clk~input .IN_SYNC_MODE = 1'b0;
defparam \clk~input .IN_POWERUP = 1'b0;
defparam \clk~input .OUT_REG_MODE = 1'b0;
defparam \clk~input .OUT_ASYNC_MODE = 1'b0;
defparam \clk~input .OUT_SYNC_MODE = 1'b0;
defparam \clk~input .OUT_POWERUP = 1'b0;
defparam \clk~input .OE_REG_MODE = 1'b0;
defparam \clk~input .OE_ASYNC_MODE = 1'b0;
defparam \clk~input .OE_SYNC_MODE = 1'b0;
defparam \clk~input .OE_POWERUP = 1'b0;
defparam \clk~input .CFG_TRI_INPUT = 1'b0;
defparam \clk~input .CFG_PULL_UP = 1'b0;
defparam \clk~input .CFG_SLR = 1'b0;
defparam \clk~input .CFG_OPEN_DRAIN = 1'b0;
defparam \clk~input .CFG_PDRCTRL = 4'b0010;
defparam \clk~input .CFG_KEEP = 2'b00;
defparam \clk~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \clk~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \clk~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \clk~input .CFG_LVDS_IN_EN = 1'b0;
defparam \clk~input .DPCLK_DELAY = 4'b0000;
defparam \clk~input .OUT_DELAY = 1'b0;
defparam \clk~input .IN_DATA_DELAY = 3'b000;
defparam \clk~input .IN_REG_DELAY = 3'b000;

alta_io_gclk \clk~inputclkctrl (
	.inclk(\clk~input_o ),
	.outclk(\clk~inputclkctrl_outclk ));
defparam \clk~inputclkctrl .coord_x = 4;
defparam \clk~inputclkctrl .coord_y = 9;
defparam \clk~inputclkctrl .coord_z = 0;

alta_slice \counter[0] (
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[0]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[0]~81_combout ),
	.Cout(),
	.Q(counter[0]));
defparam \counter[0] .coord_x = 6;
defparam \counter[0] .coord_y = 6;
defparam \counter[0] .coord_z = 2;
defparam \counter[0] .mask = 16'h0F0F;
defparam \counter[0] .modeMux = 1'b0;
defparam \counter[0] .FeedbackMux = 1'b1;
defparam \counter[0] .ShiftMux = 1'b0;
defparam \counter[0] .BypassEn = 1'b0;
defparam \counter[0] .CarryEnb = 1'b1;

alta_slice \counter[10] (
	.A(vcc),
	.B(counter[10]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[9]~44 ),
	.Qin(counter[10]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[10]~45_combout ),
	.Cout(\counter[10]~46 ),
	.Q(counter[10]));
defparam \counter[10] .coord_x = 6;
defparam \counter[10] .coord_y = 6;
defparam \counter[10] .coord_z = 12;
defparam \counter[10] .mask = 16'h3C3F;
defparam \counter[10] .modeMux = 1'b1;
defparam \counter[10] .FeedbackMux = 1'b0;
defparam \counter[10] .ShiftMux = 1'b0;
defparam \counter[10] .BypassEn = 1'b0;
defparam \counter[10] .CarryEnb = 1'b0;

alta_slice \counter[11] (
	.A(vcc),
	.B(counter[11]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[10]~46 ),
	.Qin(counter[11]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[11]~47_combout ),
	.Cout(\counter[11]~48 ),
	.Q(counter[11]));
defparam \counter[11] .coord_x = 6;
defparam \counter[11] .coord_y = 6;
defparam \counter[11] .coord_z = 13;
defparam \counter[11] .mask = 16'hC30C;
defparam \counter[11] .modeMux = 1'b1;
defparam \counter[11] .FeedbackMux = 1'b0;
defparam \counter[11] .ShiftMux = 1'b0;
defparam \counter[11] .BypassEn = 1'b0;
defparam \counter[11] .CarryEnb = 1'b0;

alta_slice \counter[12] (
	.A(vcc),
	.B(counter[12]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[11]~48 ),
	.Qin(counter[12]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[12]~49_combout ),
	.Cout(\counter[12]~50 ),
	.Q(counter[12]));
defparam \counter[12] .coord_x = 6;
defparam \counter[12] .coord_y = 6;
defparam \counter[12] .coord_z = 14;
defparam \counter[12] .mask = 16'h3C3F;
defparam \counter[12] .modeMux = 1'b1;
defparam \counter[12] .FeedbackMux = 1'b0;
defparam \counter[12] .ShiftMux = 1'b0;
defparam \counter[12] .BypassEn = 1'b0;
defparam \counter[12] .CarryEnb = 1'b0;

alta_slice \counter[13] (
	.A(vcc),
	.B(counter[13]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[12]~50 ),
	.Qin(counter[13]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[13]~51_combout ),
	.Cout(\counter[13]~52 ),
	.Q(counter[13]));
defparam \counter[13] .coord_x = 6;
defparam \counter[13] .coord_y = 6;
defparam \counter[13] .coord_z = 15;
defparam \counter[13] .mask = 16'hC30C;
defparam \counter[13] .modeMux = 1'b1;
defparam \counter[13] .FeedbackMux = 1'b0;
defparam \counter[13] .ShiftMux = 1'b0;
defparam \counter[13] .BypassEn = 1'b0;
defparam \counter[13] .CarryEnb = 1'b0;

alta_slice \counter[14] (
	.A(vcc),
	.B(counter[14]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[13]~52 ),
	.Qin(counter[14]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[14]~53_combout ),
	.Cout(\counter[14]~54 ),
	.Q(counter[14]));
defparam \counter[14] .coord_x = 6;
defparam \counter[14] .coord_y = 5;
defparam \counter[14] .coord_z = 0;
defparam \counter[14] .mask = 16'h3C3F;
defparam \counter[14] .modeMux = 1'b1;
defparam \counter[14] .FeedbackMux = 1'b0;
defparam \counter[14] .ShiftMux = 1'b0;
defparam \counter[14] .BypassEn = 1'b0;
defparam \counter[14] .CarryEnb = 1'b0;

alta_slice \counter[15] (
	.A(vcc),
	.B(counter[15]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[14]~54 ),
	.Qin(counter[15]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[15]~55_combout ),
	.Cout(\counter[15]~56 ),
	.Q(counter[15]));
defparam \counter[15] .coord_x = 6;
defparam \counter[15] .coord_y = 5;
defparam \counter[15] .coord_z = 1;
defparam \counter[15] .mask = 16'hC30C;
defparam \counter[15] .modeMux = 1'b1;
defparam \counter[15] .FeedbackMux = 1'b0;
defparam \counter[15] .ShiftMux = 1'b0;
defparam \counter[15] .BypassEn = 1'b0;
defparam \counter[15] .CarryEnb = 1'b0;

alta_slice \counter[16] (
	.A(vcc),
	.B(counter[16]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[15]~56 ),
	.Qin(counter[16]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[16]~57_combout ),
	.Cout(\counter[16]~58 ),
	.Q(counter[16]));
defparam \counter[16] .coord_x = 6;
defparam \counter[16] .coord_y = 5;
defparam \counter[16] .coord_z = 2;
defparam \counter[16] .mask = 16'h3C3F;
defparam \counter[16] .modeMux = 1'b1;
defparam \counter[16] .FeedbackMux = 1'b0;
defparam \counter[16] .ShiftMux = 1'b0;
defparam \counter[16] .BypassEn = 1'b0;
defparam \counter[16] .CarryEnb = 1'b0;

alta_slice \counter[17] (
	.A(vcc),
	.B(counter[17]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[16]~58 ),
	.Qin(counter[17]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[17]~59_combout ),
	.Cout(\counter[17]~60 ),
	.Q(counter[17]));
defparam \counter[17] .coord_x = 6;
defparam \counter[17] .coord_y = 5;
defparam \counter[17] .coord_z = 3;
defparam \counter[17] .mask = 16'hC30C;
defparam \counter[17] .modeMux = 1'b1;
defparam \counter[17] .FeedbackMux = 1'b0;
defparam \counter[17] .ShiftMux = 1'b0;
defparam \counter[17] .BypassEn = 1'b0;
defparam \counter[17] .CarryEnb = 1'b0;

alta_slice \counter[18] (
	.A(vcc),
	.B(counter[18]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[17]~60 ),
	.Qin(counter[18]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[18]~61_combout ),
	.Cout(\counter[18]~62 ),
	.Q(counter[18]));
defparam \counter[18] .coord_x = 6;
defparam \counter[18] .coord_y = 5;
defparam \counter[18] .coord_z = 4;
defparam \counter[18] .mask = 16'h3C3F;
defparam \counter[18] .modeMux = 1'b1;
defparam \counter[18] .FeedbackMux = 1'b0;
defparam \counter[18] .ShiftMux = 1'b0;
defparam \counter[18] .BypassEn = 1'b0;
defparam \counter[18] .CarryEnb = 1'b0;

alta_slice \counter[19] (
	.A(vcc),
	.B(counter[19]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[18]~62 ),
	.Qin(counter[19]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[19]~63_combout ),
	.Cout(\counter[19]~64 ),
	.Q(counter[19]));
defparam \counter[19] .coord_x = 6;
defparam \counter[19] .coord_y = 5;
defparam \counter[19] .coord_z = 5;
defparam \counter[19] .mask = 16'hC30C;
defparam \counter[19] .modeMux = 1'b1;
defparam \counter[19] .FeedbackMux = 1'b0;
defparam \counter[19] .ShiftMux = 1'b0;
defparam \counter[19] .BypassEn = 1'b0;
defparam \counter[19] .CarryEnb = 1'b0;

alta_slice \counter[1] (
	.A(counter[0]),
	.B(counter[1]),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[1]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[1]~27_combout ),
	.Cout(\counter[1]~28 ),
	.Q(counter[1]));
defparam \counter[1] .coord_x = 6;
defparam \counter[1] .coord_y = 6;
defparam \counter[1] .coord_z = 3;
defparam \counter[1] .mask = 16'h6688;
defparam \counter[1] .modeMux = 1'b0;
defparam \counter[1] .FeedbackMux = 1'b0;
defparam \counter[1] .ShiftMux = 1'b0;
defparam \counter[1] .BypassEn = 1'b0;
defparam \counter[1] .CarryEnb = 1'b0;

alta_slice \counter[20] (
	.A(vcc),
	.B(counter[20]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[19]~64 ),
	.Qin(counter[20]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[20]~65_combout ),
	.Cout(\counter[20]~66 ),
	.Q(counter[20]));
defparam \counter[20] .coord_x = 6;
defparam \counter[20] .coord_y = 5;
defparam \counter[20] .coord_z = 6;
defparam \counter[20] .mask = 16'h3C3F;
defparam \counter[20] .modeMux = 1'b1;
defparam \counter[20] .FeedbackMux = 1'b0;
defparam \counter[20] .ShiftMux = 1'b0;
defparam \counter[20] .BypassEn = 1'b0;
defparam \counter[20] .CarryEnb = 1'b0;

alta_slice \counter[21] (
	.A(vcc),
	.B(counter[21]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[20]~66 ),
	.Qin(counter[21]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[21]~67_combout ),
	.Cout(\counter[21]~68 ),
	.Q(counter[21]));
defparam \counter[21] .coord_x = 6;
defparam \counter[21] .coord_y = 5;
defparam \counter[21] .coord_z = 7;
defparam \counter[21] .mask = 16'hC30C;
defparam \counter[21] .modeMux = 1'b1;
defparam \counter[21] .FeedbackMux = 1'b0;
defparam \counter[21] .ShiftMux = 1'b0;
defparam \counter[21] .BypassEn = 1'b0;
defparam \counter[21] .CarryEnb = 1'b0;

alta_slice \counter[22] (
	.A(vcc),
	.B(counter[22]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[21]~68 ),
	.Qin(counter[22]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[22]~69_combout ),
	.Cout(\counter[22]~70 ),
	.Q(counter[22]));
defparam \counter[22] .coord_x = 6;
defparam \counter[22] .coord_y = 5;
defparam \counter[22] .coord_z = 8;
defparam \counter[22] .mask = 16'h3C3F;
defparam \counter[22] .modeMux = 1'b1;
defparam \counter[22] .FeedbackMux = 1'b0;
defparam \counter[22] .ShiftMux = 1'b0;
defparam \counter[22] .BypassEn = 1'b0;
defparam \counter[22] .CarryEnb = 1'b0;

alta_slice \counter[23] (
	.A(vcc),
	.B(counter[23]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[22]~70 ),
	.Qin(counter[23]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[23]~71_combout ),
	.Cout(\counter[23]~72 ),
	.Q(counter[23]));
defparam \counter[23] .coord_x = 6;
defparam \counter[23] .coord_y = 5;
defparam \counter[23] .coord_z = 9;
defparam \counter[23] .mask = 16'hC30C;
defparam \counter[23] .modeMux = 1'b1;
defparam \counter[23] .FeedbackMux = 1'b0;
defparam \counter[23] .ShiftMux = 1'b0;
defparam \counter[23] .BypassEn = 1'b0;
defparam \counter[23] .CarryEnb = 1'b0;

alta_slice \counter[24] (
	.A(vcc),
	.B(counter[24]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[23]~72 ),
	.Qin(counter[24]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[24]~73_combout ),
	.Cout(\counter[24]~74 ),
	.Q(counter[24]));
defparam \counter[24] .coord_x = 6;
defparam \counter[24] .coord_y = 5;
defparam \counter[24] .coord_z = 10;
defparam \counter[24] .mask = 16'h3C3F;
defparam \counter[24] .modeMux = 1'b1;
defparam \counter[24] .FeedbackMux = 1'b0;
defparam \counter[24] .ShiftMux = 1'b0;
defparam \counter[24] .BypassEn = 1'b0;
defparam \counter[24] .CarryEnb = 1'b0;

alta_slice \counter[25] (
	.A(vcc),
	.B(counter[25]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[24]~74 ),
	.Qin(counter[25]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[25]~75_combout ),
	.Cout(\counter[25]~76 ),
	.Q(counter[25]));
defparam \counter[25] .coord_x = 6;
defparam \counter[25] .coord_y = 5;
defparam \counter[25] .coord_z = 11;
defparam \counter[25] .mask = 16'hC30C;
defparam \counter[25] .modeMux = 1'b1;
defparam \counter[25] .FeedbackMux = 1'b0;
defparam \counter[25] .ShiftMux = 1'b0;
defparam \counter[25] .BypassEn = 1'b0;
defparam \counter[25] .CarryEnb = 1'b0;

alta_slice \counter[26] (
	.A(vcc),
	.B(counter[26]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[25]~76 ),
	.Qin(counter[26]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[26]~77_combout ),
	.Cout(\counter[26]~78 ),
	.Q(counter[26]));
defparam \counter[26] .coord_x = 6;
defparam \counter[26] .coord_y = 5;
defparam \counter[26] .coord_z = 12;
defparam \counter[26] .mask = 16'h3C3F;
defparam \counter[26] .modeMux = 1'b1;
defparam \counter[26] .FeedbackMux = 1'b0;
defparam \counter[26] .ShiftMux = 1'b0;
defparam \counter[26] .BypassEn = 1'b0;
defparam \counter[26] .CarryEnb = 1'b0;

alta_slice \counter[27] (
	.A(vcc),
	.B(counter[27]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[26]~78 ),
	.Qin(counter[27]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y16_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y16_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[27]~79_combout ),
	.Cout(),
	.Q(counter[27]));
defparam \counter[27] .coord_x = 6;
defparam \counter[27] .coord_y = 5;
defparam \counter[27] .coord_z = 13;
defparam \counter[27] .mask = 16'hC3C3;
defparam \counter[27] .modeMux = 1'b1;
defparam \counter[27] .FeedbackMux = 1'b0;
defparam \counter[27] .ShiftMux = 1'b0;
defparam \counter[27] .BypassEn = 1'b0;
defparam \counter[27] .CarryEnb = 1'b1;

alta_slice \counter[2] (
	.A(vcc),
	.B(counter[2]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[1]~28 ),
	.Qin(counter[2]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[2]~29_combout ),
	.Cout(\counter[2]~30 ),
	.Q(counter[2]));
defparam \counter[2] .coord_x = 6;
defparam \counter[2] .coord_y = 6;
defparam \counter[2] .coord_z = 4;
defparam \counter[2] .mask = 16'h3C3F;
defparam \counter[2] .modeMux = 1'b1;
defparam \counter[2] .FeedbackMux = 1'b0;
defparam \counter[2] .ShiftMux = 1'b0;
defparam \counter[2] .BypassEn = 1'b0;
defparam \counter[2] .CarryEnb = 1'b0;

alta_slice \counter[3] (
	.A(vcc),
	.B(counter[3]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[2]~30 ),
	.Qin(counter[3]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[3]~31_combout ),
	.Cout(\counter[3]~32 ),
	.Q(counter[3]));
defparam \counter[3] .coord_x = 6;
defparam \counter[3] .coord_y = 6;
defparam \counter[3] .coord_z = 5;
defparam \counter[3] .mask = 16'hC30C;
defparam \counter[3] .modeMux = 1'b1;
defparam \counter[3] .FeedbackMux = 1'b0;
defparam \counter[3] .ShiftMux = 1'b0;
defparam \counter[3] .BypassEn = 1'b0;
defparam \counter[3] .CarryEnb = 1'b0;

alta_slice \counter[4] (
	.A(vcc),
	.B(counter[4]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[3]~32 ),
	.Qin(counter[4]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[4]~33_combout ),
	.Cout(\counter[4]~34 ),
	.Q(counter[4]));
defparam \counter[4] .coord_x = 6;
defparam \counter[4] .coord_y = 6;
defparam \counter[4] .coord_z = 6;
defparam \counter[4] .mask = 16'h3C3F;
defparam \counter[4] .modeMux = 1'b1;
defparam \counter[4] .FeedbackMux = 1'b0;
defparam \counter[4] .ShiftMux = 1'b0;
defparam \counter[4] .BypassEn = 1'b0;
defparam \counter[4] .CarryEnb = 1'b0;

alta_slice \counter[5] (
	.A(vcc),
	.B(counter[5]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[4]~34 ),
	.Qin(counter[5]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[5]~35_combout ),
	.Cout(\counter[5]~36 ),
	.Q(counter[5]));
defparam \counter[5] .coord_x = 6;
defparam \counter[5] .coord_y = 6;
defparam \counter[5] .coord_z = 7;
defparam \counter[5] .mask = 16'hC30C;
defparam \counter[5] .modeMux = 1'b1;
defparam \counter[5] .FeedbackMux = 1'b0;
defparam \counter[5] .ShiftMux = 1'b0;
defparam \counter[5] .BypassEn = 1'b0;
defparam \counter[5] .CarryEnb = 1'b0;

alta_slice \counter[6] (
	.A(vcc),
	.B(counter[6]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[5]~36 ),
	.Qin(counter[6]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[6]~37_combout ),
	.Cout(\counter[6]~38 ),
	.Q(counter[6]));
defparam \counter[6] .coord_x = 6;
defparam \counter[6] .coord_y = 6;
defparam \counter[6] .coord_z = 8;
defparam \counter[6] .mask = 16'h3C3F;
defparam \counter[6] .modeMux = 1'b1;
defparam \counter[6] .FeedbackMux = 1'b0;
defparam \counter[6] .ShiftMux = 1'b0;
defparam \counter[6] .BypassEn = 1'b0;
defparam \counter[6] .CarryEnb = 1'b0;

alta_slice \counter[7] (
	.A(vcc),
	.B(counter[7]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[6]~38 ),
	.Qin(counter[7]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[7]~39_combout ),
	.Cout(\counter[7]~40 ),
	.Q(counter[7]));
defparam \counter[7] .coord_x = 6;
defparam \counter[7] .coord_y = 6;
defparam \counter[7] .coord_z = 9;
defparam \counter[7] .mask = 16'hC30C;
defparam \counter[7] .modeMux = 1'b1;
defparam \counter[7] .FeedbackMux = 1'b0;
defparam \counter[7] .ShiftMux = 1'b0;
defparam \counter[7] .BypassEn = 1'b0;
defparam \counter[7] .CarryEnb = 1'b0;

alta_slice \counter[8] (
	.A(vcc),
	.B(counter[8]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[7]~40 ),
	.Qin(counter[8]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[8]~41_combout ),
	.Cout(\counter[8]~42 ),
	.Q(counter[8]));
defparam \counter[8] .coord_x = 6;
defparam \counter[8] .coord_y = 6;
defparam \counter[8] .coord_z = 10;
defparam \counter[8] .mask = 16'h3C3F;
defparam \counter[8] .modeMux = 1'b1;
defparam \counter[8] .FeedbackMux = 1'b0;
defparam \counter[8] .ShiftMux = 1'b0;
defparam \counter[8] .BypassEn = 1'b0;
defparam \counter[8] .CarryEnb = 1'b0;

alta_slice \counter[9] (
	.A(vcc),
	.B(counter[9]),
	.C(vcc),
	.D(vcc),
	.Cin(\counter[8]~42 ),
	.Qin(counter[9]),
	.Clk(\clk~inputclkctrl_outclk_X1_Y17_SIG_VCC ),
	.AsyncReset(AsyncReset_X1_Y17_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[9]~43_combout ),
	.Cout(\counter[9]~44 ),
	.Q(counter[9]));
defparam \counter[9] .coord_x = 6;
defparam \counter[9] .coord_y = 6;
defparam \counter[9] .coord_z = 11;
defparam \counter[9] .mask = 16'hC30C;
defparam \counter[9] .modeMux = 1'b1;
defparam \counter[9] .FeedbackMux = 1'b0;
defparam \counter[9] .ShiftMux = 1'b0;
defparam \counter[9] .BypassEn = 1'b0;
defparam \counter[9] .CarryEnb = 1'b0;

endmodule
