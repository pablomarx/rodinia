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
wire	AsyncReset_X1009_Y1001_GND;
wire	[31:0] counter;
//wire	counter[0];
wire	\counter[0]_inv ;
//wire	counter[10];
//wire	counter[11];
//wire	counter[12];
//wire	counter[13];
//wire	counter[14];
//wire	counter[15];
//wire	counter[16];
//wire	counter[17];
//wire	counter[18];
//wire	counter[19];
//wire	counter[1];
//wire	counter[20];
//wire	counter[21];
//wire	counter[22];
//wire	counter[23];
//wire	counter[24];
//wire	counter[25];
//wire	counter[26];
//wire	counter[27];
//wire	counter[28];
//wire	counter[29];
//wire	counter[2];
//wire	counter[30];
//wire	counter[31];
//wire	counter[3];
//wire	counter[4];
//wire	counter[5];
//wire	counter[6];
//wire	counter[7];
//wire	counter[8];
//wire	counter[9];
wire	[35:0] data;
//wire	data[0];
//wire	data[10];
//wire	data[11];
//wire	data[12];
//wire	data[13];
//wire	data[14];
//wire	data[15];
//wire	data[16];
//wire	data[17];
//wire	data[18];
//wire	data[19];
//wire	data[1];
//wire	data[20];
//wire	data[21];
//wire	data[22];
//wire	data[23];
//wire	data[24];
//wire	data[25];
//wire	data[26];
//wire	data[27];
//wire	data[28];
//wire	data[29];
//wire	data[2];
//wire	data[30];
//wire	data[31];
//wire	data[32];
//wire	data[33];
//wire	data[34];
//wire	data[35];
//wire	data[3];
//wire	data[4];
//wire	data[5];
//wire	data[6];
//wire	data[7];
//wire	data[8];
//wire	data[9];
wire	\gnd~I_int ;
wire	[35:0] \mem.doutb ;
//wire	\mem.doutb [0];
//wire	\mem.doutb [10];
//wire	\mem.doutb [11];
//wire	\mem.doutb [12];
//wire	\mem.doutb [13];
//wire	\mem.doutb [14];
//wire	\mem.doutb [15];
//wire	\mem.doutb [16];
//wire	\mem.doutb [17];
//wire	\mem.doutb [18];
//wire	\mem.doutb [19];
//wire	\mem.doutb [1];
//wire	\mem.doutb [20];
//wire	\mem.doutb [21];
//wire	\mem.doutb [22];
//wire	\mem.doutb [23];
//wire	\mem.doutb [24];
//wire	\mem.doutb [25];
//wire	\mem.doutb [26];
//wire	\mem.doutb [27];
//wire	\mem.doutb [28];
//wire	\mem.doutb [29];
//wire	\mem.doutb [2];
//wire	\mem.doutb [30];
//wire	\mem.doutb [31];
//wire	\mem.doutb [32];
//wire	\mem.doutb [33];
//wire	\mem.doutb [34];
//wire	\mem.doutb [35];
//wire	\mem.doutb [3];
//wire	\mem.doutb [4];
//wire	\mem.doutb [5];
//wire	\mem.doutb [6];
//wire	\mem.doutb [7];
//wire	\mem.doutb [8];
//wire	\mem.doutb [9];
wire	[31:0] syn__00_;
//wire	syn__00_[0];
//wire	syn__00_[10];
//wire	syn__00_[11];
//wire	syn__00_[12];
//wire	syn__00_[13];
//wire	syn__00_[14];
//wire	syn__00_[15];
//wire	syn__00_[16];
//wire	syn__00_[17];
//wire	syn__00_[18];
//wire	syn__00_[19];
//wire	syn__00_[1];
//wire	syn__00_[20];
//wire	syn__00_[21];
//wire	syn__00_[22];
//wire	syn__00_[23];
//wire	syn__00_[24];
//wire	syn__00_[25];
//wire	syn__00_[26];
//wire	syn__00_[27];
//wire	syn__00_[28];
//wire	syn__00_[29];
//wire	syn__00_[2];
//wire	syn__00_[30];
//wire	syn__00_[31];
//wire	syn__00_[3];
//wire	syn__00_[4];
//wire	syn__00_[5];
//wire	syn__00_[6];
//wire	syn__00_[7];
//wire	syn__00_[8];
//wire	syn__00_[9];
wire	syn__01_;
wire	syn__02_;
wire	syn__02__X1009_Y1001_SIG_VCC;

assign vcc = 1'b1;
assign gnd = 1'b0;

alta_asyncctrl asyncreset_ctrl_X1009_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1009_Y1001_GND));
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_x = 2;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_y = 2;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam asyncreset_ctrl_X1009_Y1001_N0.AsyncCtrlMux = 2'b00;

alta_clkenctrl clken_ctrl_X1009_Y1001_N0(
	.ClkIn(syn__02_),
	.ClkEn(),
	.ClkOut(syn__02__X1009_Y1001_SIG_VCC));
defparam clken_ctrl_X1009_Y1001_N0.coord_x = 2;
defparam clken_ctrl_X1009_Y1001_N0.coord_y = 2;
defparam clken_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1009_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1009_Y1001_N0.ClkEnMux = 2'b01;

alta_slice \gnd~I (
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\gnd~I_int ),
	.Cout(),
	.Q());
defparam \gnd~I .coord_x = 2;
defparam \gnd~I .coord_y = 2;
defparam \gnd~I .coord_z = 7;
defparam \gnd~I .mask = 16'h0000;
defparam \gnd~I .modeMux = 1'b0;
defparam \gnd~I .FeedbackMux = 1'b0;
defparam \gnd~I .ShiftMux = 1'b0;
defparam \gnd~I .BypassEn = 1'b0;
defparam \gnd~I .CarryEnb = 1'b1;

alta_bram \mem.ram_inst (
	.DataInA({\gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int }),
	.DataInB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.AddressA({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, counter[6], counter[5], counter[4], counter[3], counter[2], counter[1], counter[0]}),
	.AddressB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int }),
	.DataOutA({data[17], data[16], data[15], data[14], data[13], data[12], data[11], data[10], data[9], data[8], data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0]}),
	.DataOutB({\mem.doutb [17], \mem.doutb [16], \mem.doutb [15], \mem.doutb [14], \mem.doutb [13], \mem.doutb [12], \mem.doutb [11], \mem.doutb [10], \mem.doutb [9], \mem.doutb [8], \mem.doutb [7], \mem.doutb [6], \mem.doutb [5], \mem.doutb [4], \mem.doutb [3], \mem.doutb [2], \mem.doutb [1], \mem.doutb [0]}),
	.Clk0(syn__02_),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(gnd),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(gnd),
	.WeRenB(gnd));
defparam \mem.ram_inst .coord_x = 3;
defparam \mem.ram_inst .coord_y = 2;
defparam \mem.ram_inst .coord_z = 0;
defparam \mem.ram_inst .CLKMODE = 1'b0;
defparam \mem.ram_inst .PORTA_WIDTH = 4'b0000;
defparam \mem.ram_inst .PORTB_WIDTH = 4'b0000;
defparam \mem.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \mem.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \mem.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \mem.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \mem.ram_inst .PORTA_OUTREG = 1'b0;
defparam \mem.ram_inst .PORTB_OUTREG = 1'b0;
defparam \mem.ram_inst .PORTB_READONLY = 1'b1;
defparam \mem.ram_inst .INIT_VAL = 4608'hF70A825CA74B2DE9EF0D77A973D13517857AD2B60AC1F6D468A97E57DC84305F5C444CC1AD08FA8CC8EC839A57D6A58F1F49916EA3015C6970698DE2215AC5D1779CCAB6FFF7F630494953941150FA26DA2455DEA0288EE9003ADF11AD2186EA58E16E618610F99D614D5EC815F6DCEB6BC5F2A8C9823B2A0330C325EE1035BF65490321DD7A6F6173FE38204C86B4F2D71E40A4F554AAA572BA8E4A93652DADA229BB1FB959930B2BDBE7950B69234219E233C5B0D99732948C5B810305E7734FC29270768687C32B36A91C631BB73816FE6EE45E1B0CCE6794A2D331FDD83D1F9B491444324E1E7F6B6622AE71383E98427A3E5EE2B411F67C63ECF702CC3631FB44BF046E208D857DC556E717351E1A60BE83CFCBCC509D58F16D8544FA0604EEE66FCC6110350859CC95C86949286A81ADDF3FB88F2BE190DCFBB5343F35ABCF6890EFCF2063D7137324356A0AD23EF44CCE89FD36038BF5FE999DB49B20ED733C4DBE4247D4D83A6ADA678E40D4E0EA12C2837F1D7BAABA2FF2C8C06BD5B13E4395371741FBC08B5B36784D3C180208A68C548F327D219A3A9E6C15D00727B2CD82A6172005FA2C394C2F4F9405D3B42E529713712DFA77620090F69CFD7D309D882CC8921FAFB0E4A4F9F79AC6D04EFB96F8AB5DD1C0D4DE5BC4320518CB3DAE391C977A73E70DDA5F96EC156B9608CFFCD99DAE35E58C8BEE6D3E918A05E386B07C8FC1C1B5C54D6D57908B72A3796DA218F6EF4A48E81FDBBDCA0E721E9F2120301C6EBC4CC51FC6A41A914EEA1476525472A5D9880080747BF85007;

alta_slice syn__07_(
	.A(counter[2]),
	.B(counter[3]),
	.C(counter[1]),
	.D(counter[0]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__01_),
	.Cout(),
	.Q());
defparam syn__07_.coord_x = 2;
defparam syn__07_.coord_y = 2;
defparam syn__07_.coord_z = 4;
defparam syn__07_.mask = 16'h8000;
defparam syn__07_.modeMux = 1'b0;
defparam syn__07_.FeedbackMux = 1'b0;
defparam syn__07_.ShiftMux = 1'b0;
defparam syn__07_.BypassEn = 1'b0;
defparam syn__07_.CarryEnb = 1'b1;

alta_rio syn__10_(
	.padio(bank0[0]),
	.datain(data[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__10_.coord_x = 2;
defparam syn__10_.coord_y = 9;
defparam syn__10_.coord_z = 0;
defparam syn__10_.IN_ASYNC_MODE = 1'b0;
defparam syn__10_.IN_SYNC_MODE = 1'b0;
defparam syn__10_.IN_POWERUP = 1'b0;
defparam syn__10_.OUT_REG_MODE = 1'b0;
defparam syn__10_.OUT_ASYNC_MODE = 1'b0;
defparam syn__10_.OUT_SYNC_MODE = 1'b0;
defparam syn__10_.OUT_POWERUP = 1'b0;
defparam syn__10_.OE_REG_MODE = 1'b0;
defparam syn__10_.OE_ASYNC_MODE = 1'b0;
defparam syn__10_.OE_SYNC_MODE = 1'b0;
defparam syn__10_.OE_POWERUP = 1'b0;
defparam syn__10_.CFG_TRI_INPUT = 1'b0;
defparam syn__10_.CFG_PULL_UP = 1'b0;
defparam syn__10_.CFG_SLR = 1'b0;
defparam syn__10_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__10_.CFG_PDRCTRL = 4'b0010;
defparam syn__10_.CFG_KEEP = 2'b00;
defparam syn__10_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__10_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__10_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__10_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__10_.DPCLK_DELAY = 4'b0000;
defparam syn__10_.OUT_DELAY = 1'b0;
defparam syn__10_.IN_DATA_DELAY = 3'b000;
defparam syn__10_.IN_REG_DELAY = 3'b000;

alta_rio syn__11_(
	.padio(bank0[1]),
	.datain(data[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__11_.coord_x = 1;
defparam syn__11_.coord_y = 9;
defparam syn__11_.coord_z = 3;
defparam syn__11_.IN_ASYNC_MODE = 1'b0;
defparam syn__11_.IN_SYNC_MODE = 1'b0;
defparam syn__11_.IN_POWERUP = 1'b0;
defparam syn__11_.OUT_REG_MODE = 1'b0;
defparam syn__11_.OUT_ASYNC_MODE = 1'b0;
defparam syn__11_.OUT_SYNC_MODE = 1'b0;
defparam syn__11_.OUT_POWERUP = 1'b0;
defparam syn__11_.OE_REG_MODE = 1'b0;
defparam syn__11_.OE_ASYNC_MODE = 1'b0;
defparam syn__11_.OE_SYNC_MODE = 1'b0;
defparam syn__11_.OE_POWERUP = 1'b0;
defparam syn__11_.CFG_TRI_INPUT = 1'b0;
defparam syn__11_.CFG_PULL_UP = 1'b0;
defparam syn__11_.CFG_SLR = 1'b0;
defparam syn__11_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__11_.CFG_PDRCTRL = 4'b0010;
defparam syn__11_.CFG_KEEP = 2'b00;
defparam syn__11_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__11_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__11_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__11_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__11_.DPCLK_DELAY = 4'b0000;
defparam syn__11_.OUT_DELAY = 1'b0;
defparam syn__11_.IN_DATA_DELAY = 3'b000;
defparam syn__11_.IN_REG_DELAY = 3'b000;

alta_rio syn__12_(
	.padio(bank0[2]),
	.datain(data[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__12_.coord_x = 0;
defparam syn__12_.coord_y = 9;
defparam syn__12_.coord_z = 2;
defparam syn__12_.IN_ASYNC_MODE = 1'b0;
defparam syn__12_.IN_SYNC_MODE = 1'b0;
defparam syn__12_.IN_POWERUP = 1'b0;
defparam syn__12_.OUT_REG_MODE = 1'b0;
defparam syn__12_.OUT_ASYNC_MODE = 1'b0;
defparam syn__12_.OUT_SYNC_MODE = 1'b0;
defparam syn__12_.OUT_POWERUP = 1'b0;
defparam syn__12_.OE_REG_MODE = 1'b0;
defparam syn__12_.OE_ASYNC_MODE = 1'b0;
defparam syn__12_.OE_SYNC_MODE = 1'b0;
defparam syn__12_.OE_POWERUP = 1'b0;
defparam syn__12_.CFG_TRI_INPUT = 1'b0;
defparam syn__12_.CFG_PULL_UP = 1'b0;
defparam syn__12_.CFG_SLR = 1'b0;
defparam syn__12_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__12_.CFG_PDRCTRL = 4'b0010;
defparam syn__12_.CFG_KEEP = 2'b00;
defparam syn__12_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__12_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__12_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__12_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__12_.DPCLK_DELAY = 4'b0000;
defparam syn__12_.OUT_DELAY = 1'b0;
defparam syn__12_.IN_DATA_DELAY = 3'b000;
defparam syn__12_.IN_REG_DELAY = 3'b000;

alta_rio syn__13_(
	.padio(bank0[3]),
	.datain(data[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__13_.coord_x = 0;
defparam syn__13_.coord_y = 9;
defparam syn__13_.coord_z = 0;
defparam syn__13_.IN_ASYNC_MODE = 1'b0;
defparam syn__13_.IN_SYNC_MODE = 1'b0;
defparam syn__13_.IN_POWERUP = 1'b0;
defparam syn__13_.OUT_REG_MODE = 1'b0;
defparam syn__13_.OUT_ASYNC_MODE = 1'b0;
defparam syn__13_.OUT_SYNC_MODE = 1'b0;
defparam syn__13_.OUT_POWERUP = 1'b0;
defparam syn__13_.OE_REG_MODE = 1'b0;
defparam syn__13_.OE_ASYNC_MODE = 1'b0;
defparam syn__13_.OE_SYNC_MODE = 1'b0;
defparam syn__13_.OE_POWERUP = 1'b0;
defparam syn__13_.CFG_TRI_INPUT = 1'b0;
defparam syn__13_.CFG_PULL_UP = 1'b0;
defparam syn__13_.CFG_SLR = 1'b0;
defparam syn__13_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__13_.CFG_PDRCTRL = 4'b0010;
defparam syn__13_.CFG_KEEP = 2'b00;
defparam syn__13_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__13_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__13_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__13_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__13_.DPCLK_DELAY = 4'b0000;
defparam syn__13_.OUT_DELAY = 1'b0;
defparam syn__13_.IN_DATA_DELAY = 3'b000;
defparam syn__13_.IN_REG_DELAY = 3'b000;

alta_rio syn__14_(
	.padio(bank0[4]),
	.datain(data[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__14_.coord_x = 1;
defparam syn__14_.coord_y = 9;
defparam syn__14_.coord_z = 1;
defparam syn__14_.IN_ASYNC_MODE = 1'b0;
defparam syn__14_.IN_SYNC_MODE = 1'b0;
defparam syn__14_.IN_POWERUP = 1'b0;
defparam syn__14_.OUT_REG_MODE = 1'b0;
defparam syn__14_.OUT_ASYNC_MODE = 1'b0;
defparam syn__14_.OUT_SYNC_MODE = 1'b0;
defparam syn__14_.OUT_POWERUP = 1'b0;
defparam syn__14_.OE_REG_MODE = 1'b0;
defparam syn__14_.OE_ASYNC_MODE = 1'b0;
defparam syn__14_.OE_SYNC_MODE = 1'b0;
defparam syn__14_.OE_POWERUP = 1'b0;
defparam syn__14_.CFG_TRI_INPUT = 1'b0;
defparam syn__14_.CFG_PULL_UP = 1'b0;
defparam syn__14_.CFG_SLR = 1'b0;
defparam syn__14_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__14_.CFG_PDRCTRL = 4'b0010;
defparam syn__14_.CFG_KEEP = 2'b00;
defparam syn__14_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__14_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__14_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__14_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__14_.DPCLK_DELAY = 4'b0000;
defparam syn__14_.OUT_DELAY = 1'b0;
defparam syn__14_.IN_DATA_DELAY = 3'b000;
defparam syn__14_.IN_REG_DELAY = 3'b000;

alta_rio syn__15_(
	.padio(bank0[5]),
	.datain(data[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__15_.coord_x = 6;
defparam syn__15_.coord_y = 9;
defparam syn__15_.coord_z = 2;
defparam syn__15_.IN_ASYNC_MODE = 1'b0;
defparam syn__15_.IN_SYNC_MODE = 1'b0;
defparam syn__15_.IN_POWERUP = 1'b0;
defparam syn__15_.OUT_REG_MODE = 1'b0;
defparam syn__15_.OUT_ASYNC_MODE = 1'b0;
defparam syn__15_.OUT_SYNC_MODE = 1'b0;
defparam syn__15_.OUT_POWERUP = 1'b0;
defparam syn__15_.OE_REG_MODE = 1'b0;
defparam syn__15_.OE_ASYNC_MODE = 1'b0;
defparam syn__15_.OE_SYNC_MODE = 1'b0;
defparam syn__15_.OE_POWERUP = 1'b0;
defparam syn__15_.CFG_TRI_INPUT = 1'b0;
defparam syn__15_.CFG_PULL_UP = 1'b0;
defparam syn__15_.CFG_SLR = 1'b0;
defparam syn__15_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__15_.CFG_PDRCTRL = 4'b0010;
defparam syn__15_.CFG_KEEP = 2'b00;
defparam syn__15_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__15_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__15_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__15_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__15_.DPCLK_DELAY = 4'b0000;
defparam syn__15_.OUT_DELAY = 1'b0;
defparam syn__15_.IN_DATA_DELAY = 3'b000;
defparam syn__15_.IN_REG_DELAY = 3'b000;

alta_rio syn__16_(
	.padio(bank0[6]),
	.datain(data[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__16_.coord_x = 2;
defparam syn__16_.coord_y = 1;
defparam syn__16_.coord_z = 0;
defparam syn__16_.IN_ASYNC_MODE = 1'b0;
defparam syn__16_.IN_SYNC_MODE = 1'b0;
defparam syn__16_.IN_POWERUP = 1'b0;
defparam syn__16_.OUT_REG_MODE = 1'b0;
defparam syn__16_.OUT_ASYNC_MODE = 1'b0;
defparam syn__16_.OUT_SYNC_MODE = 1'b0;
defparam syn__16_.OUT_POWERUP = 1'b0;
defparam syn__16_.OE_REG_MODE = 1'b0;
defparam syn__16_.OE_ASYNC_MODE = 1'b0;
defparam syn__16_.OE_SYNC_MODE = 1'b0;
defparam syn__16_.OE_POWERUP = 1'b0;
defparam syn__16_.CFG_TRI_INPUT = 1'b0;
defparam syn__16_.CFG_PULL_UP = 1'b0;
defparam syn__16_.CFG_SLR = 1'b0;
defparam syn__16_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__16_.CFG_PDRCTRL = 4'b0010;
defparam syn__16_.CFG_KEEP = 2'b00;
defparam syn__16_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__16_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__16_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__16_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__16_.DPCLK_DELAY = 4'b0000;
defparam syn__16_.OUT_DELAY = 1'b0;
defparam syn__16_.IN_DATA_DELAY = 3'b000;
defparam syn__16_.IN_REG_DELAY = 3'b000;

alta_rio syn__17_(
	.padio(bank0[7]),
	.datain(data[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__17_.coord_x = 2;
defparam syn__17_.coord_y = 1;
defparam syn__17_.coord_z = 2;
defparam syn__17_.IN_ASYNC_MODE = 1'b0;
defparam syn__17_.IN_SYNC_MODE = 1'b0;
defparam syn__17_.IN_POWERUP = 1'b0;
defparam syn__17_.OUT_REG_MODE = 1'b0;
defparam syn__17_.OUT_ASYNC_MODE = 1'b0;
defparam syn__17_.OUT_SYNC_MODE = 1'b0;
defparam syn__17_.OUT_POWERUP = 1'b0;
defparam syn__17_.OE_REG_MODE = 1'b0;
defparam syn__17_.OE_ASYNC_MODE = 1'b0;
defparam syn__17_.OE_SYNC_MODE = 1'b0;
defparam syn__17_.OE_POWERUP = 1'b0;
defparam syn__17_.CFG_TRI_INPUT = 1'b0;
defparam syn__17_.CFG_PULL_UP = 1'b0;
defparam syn__17_.CFG_SLR = 1'b0;
defparam syn__17_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__17_.CFG_PDRCTRL = 4'b0010;
defparam syn__17_.CFG_KEEP = 2'b00;
defparam syn__17_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__17_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__17_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__17_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__17_.DPCLK_DELAY = 4'b0000;
defparam syn__17_.OUT_DELAY = 1'b0;
defparam syn__17_.IN_DATA_DELAY = 3'b000;
defparam syn__17_.IN_REG_DELAY = 3'b000;

alta_rio syn__18_(
	.padio(bank1[0]),
	.datain(data[8]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__18_.coord_x = 4;
defparam syn__18_.coord_y = 1;
defparam syn__18_.coord_z = 0;
defparam syn__18_.IN_ASYNC_MODE = 1'b0;
defparam syn__18_.IN_SYNC_MODE = 1'b0;
defparam syn__18_.IN_POWERUP = 1'b0;
defparam syn__18_.OUT_REG_MODE = 1'b0;
defparam syn__18_.OUT_ASYNC_MODE = 1'b0;
defparam syn__18_.OUT_SYNC_MODE = 1'b0;
defparam syn__18_.OUT_POWERUP = 1'b0;
defparam syn__18_.OE_REG_MODE = 1'b0;
defparam syn__18_.OE_ASYNC_MODE = 1'b0;
defparam syn__18_.OE_SYNC_MODE = 1'b0;
defparam syn__18_.OE_POWERUP = 1'b0;
defparam syn__18_.CFG_TRI_INPUT = 1'b0;
defparam syn__18_.CFG_PULL_UP = 1'b0;
defparam syn__18_.CFG_SLR = 1'b0;
defparam syn__18_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__18_.CFG_PDRCTRL = 4'b0010;
defparam syn__18_.CFG_KEEP = 2'b00;
defparam syn__18_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__18_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__18_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__18_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__18_.DPCLK_DELAY = 4'b0000;
defparam syn__18_.OUT_DELAY = 1'b0;
defparam syn__18_.IN_DATA_DELAY = 3'b000;
defparam syn__18_.IN_REG_DELAY = 3'b000;

alta_rio syn__19_(
	.padio(bank1[1]),
	.datain(data[9]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__19_.coord_x = 4;
defparam syn__19_.coord_y = 1;
defparam syn__19_.coord_z = 2;
defparam syn__19_.IN_ASYNC_MODE = 1'b0;
defparam syn__19_.IN_SYNC_MODE = 1'b0;
defparam syn__19_.IN_POWERUP = 1'b0;
defparam syn__19_.OUT_REG_MODE = 1'b0;
defparam syn__19_.OUT_ASYNC_MODE = 1'b0;
defparam syn__19_.OUT_SYNC_MODE = 1'b0;
defparam syn__19_.OUT_POWERUP = 1'b0;
defparam syn__19_.OE_REG_MODE = 1'b0;
defparam syn__19_.OE_ASYNC_MODE = 1'b0;
defparam syn__19_.OE_SYNC_MODE = 1'b0;
defparam syn__19_.OE_POWERUP = 1'b0;
defparam syn__19_.CFG_TRI_INPUT = 1'b0;
defparam syn__19_.CFG_PULL_UP = 1'b0;
defparam syn__19_.CFG_SLR = 1'b0;
defparam syn__19_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__19_.CFG_PDRCTRL = 4'b0010;
defparam syn__19_.CFG_KEEP = 2'b00;
defparam syn__19_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__19_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__19_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__19_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__19_.DPCLK_DELAY = 4'b0000;
defparam syn__19_.OUT_DELAY = 1'b0;
defparam syn__19_.IN_DATA_DELAY = 3'b000;
defparam syn__19_.IN_REG_DELAY = 3'b000;

alta_rio syn__20_(
	.padio(bank1[2]),
	.datain(data[10]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__20_.coord_x = 5;
defparam syn__20_.coord_y = 1;
defparam syn__20_.coord_z = 0;
defparam syn__20_.IN_ASYNC_MODE = 1'b0;
defparam syn__20_.IN_SYNC_MODE = 1'b0;
defparam syn__20_.IN_POWERUP = 1'b0;
defparam syn__20_.OUT_REG_MODE = 1'b0;
defparam syn__20_.OUT_ASYNC_MODE = 1'b0;
defparam syn__20_.OUT_SYNC_MODE = 1'b0;
defparam syn__20_.OUT_POWERUP = 1'b0;
defparam syn__20_.OE_REG_MODE = 1'b0;
defparam syn__20_.OE_ASYNC_MODE = 1'b0;
defparam syn__20_.OE_SYNC_MODE = 1'b0;
defparam syn__20_.OE_POWERUP = 1'b0;
defparam syn__20_.CFG_TRI_INPUT = 1'b0;
defparam syn__20_.CFG_PULL_UP = 1'b0;
defparam syn__20_.CFG_SLR = 1'b0;
defparam syn__20_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__20_.CFG_PDRCTRL = 4'b0010;
defparam syn__20_.CFG_KEEP = 2'b00;
defparam syn__20_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__20_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__20_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__20_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__20_.DPCLK_DELAY = 4'b0000;
defparam syn__20_.OUT_DELAY = 1'b0;
defparam syn__20_.IN_DATA_DELAY = 3'b000;
defparam syn__20_.IN_REG_DELAY = 3'b000;

alta_rio syn__21_(
	.padio(bank1[3]),
	.datain(data[11]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__21_.coord_x = 5;
defparam syn__21_.coord_y = 1;
defparam syn__21_.coord_z = 1;
defparam syn__21_.IN_ASYNC_MODE = 1'b0;
defparam syn__21_.IN_SYNC_MODE = 1'b0;
defparam syn__21_.IN_POWERUP = 1'b0;
defparam syn__21_.OUT_REG_MODE = 1'b0;
defparam syn__21_.OUT_ASYNC_MODE = 1'b0;
defparam syn__21_.OUT_SYNC_MODE = 1'b0;
defparam syn__21_.OUT_POWERUP = 1'b0;
defparam syn__21_.OE_REG_MODE = 1'b0;
defparam syn__21_.OE_ASYNC_MODE = 1'b0;
defparam syn__21_.OE_SYNC_MODE = 1'b0;
defparam syn__21_.OE_POWERUP = 1'b0;
defparam syn__21_.CFG_TRI_INPUT = 1'b0;
defparam syn__21_.CFG_PULL_UP = 1'b0;
defparam syn__21_.CFG_SLR = 1'b0;
defparam syn__21_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__21_.CFG_PDRCTRL = 4'b0010;
defparam syn__21_.CFG_KEEP = 2'b00;
defparam syn__21_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__21_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__21_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__21_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__21_.DPCLK_DELAY = 4'b0000;
defparam syn__21_.OUT_DELAY = 1'b0;
defparam syn__21_.IN_DATA_DELAY = 3'b000;
defparam syn__21_.IN_REG_DELAY = 3'b000;

alta_rio syn__22_(
	.padio(bank1[4]),
	.datain(data[12]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__22_.coord_x = 5;
defparam syn__22_.coord_y = 1;
defparam syn__22_.coord_z = 2;
defparam syn__22_.IN_ASYNC_MODE = 1'b0;
defparam syn__22_.IN_SYNC_MODE = 1'b0;
defparam syn__22_.IN_POWERUP = 1'b0;
defparam syn__22_.OUT_REG_MODE = 1'b0;
defparam syn__22_.OUT_ASYNC_MODE = 1'b0;
defparam syn__22_.OUT_SYNC_MODE = 1'b0;
defparam syn__22_.OUT_POWERUP = 1'b0;
defparam syn__22_.OE_REG_MODE = 1'b0;
defparam syn__22_.OE_ASYNC_MODE = 1'b0;
defparam syn__22_.OE_SYNC_MODE = 1'b0;
defparam syn__22_.OE_POWERUP = 1'b0;
defparam syn__22_.CFG_TRI_INPUT = 1'b0;
defparam syn__22_.CFG_PULL_UP = 1'b0;
defparam syn__22_.CFG_SLR = 1'b0;
defparam syn__22_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__22_.CFG_PDRCTRL = 4'b0010;
defparam syn__22_.CFG_KEEP = 2'b00;
defparam syn__22_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__22_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__22_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__22_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__22_.DPCLK_DELAY = 4'b0000;
defparam syn__22_.OUT_DELAY = 1'b0;
defparam syn__22_.IN_DATA_DELAY = 3'b000;
defparam syn__22_.IN_REG_DELAY = 3'b000;

alta_rio syn__23_(
	.padio(bank1[5]),
	.datain(data[13]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__23_.coord_x = 5;
defparam syn__23_.coord_y = 1;
defparam syn__23_.coord_z = 3;
defparam syn__23_.IN_ASYNC_MODE = 1'b0;
defparam syn__23_.IN_SYNC_MODE = 1'b0;
defparam syn__23_.IN_POWERUP = 1'b0;
defparam syn__23_.OUT_REG_MODE = 1'b0;
defparam syn__23_.OUT_ASYNC_MODE = 1'b0;
defparam syn__23_.OUT_SYNC_MODE = 1'b0;
defparam syn__23_.OUT_POWERUP = 1'b0;
defparam syn__23_.OE_REG_MODE = 1'b0;
defparam syn__23_.OE_ASYNC_MODE = 1'b0;
defparam syn__23_.OE_SYNC_MODE = 1'b0;
defparam syn__23_.OE_POWERUP = 1'b0;
defparam syn__23_.CFG_TRI_INPUT = 1'b0;
defparam syn__23_.CFG_PULL_UP = 1'b0;
defparam syn__23_.CFG_SLR = 1'b0;
defparam syn__23_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__23_.CFG_PDRCTRL = 4'b0010;
defparam syn__23_.CFG_KEEP = 2'b00;
defparam syn__23_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__23_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__23_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__23_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__23_.DPCLK_DELAY = 4'b0000;
defparam syn__23_.OUT_DELAY = 1'b0;
defparam syn__23_.IN_DATA_DELAY = 3'b000;
defparam syn__23_.IN_REG_DELAY = 3'b000;

alta_rio syn__24_(
	.padio(bank1[6]),
	.datain(data[14]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__24_.coord_x = 6;
defparam syn__24_.coord_y = 1;
defparam syn__24_.coord_z = 0;
defparam syn__24_.IN_ASYNC_MODE = 1'b0;
defparam syn__24_.IN_SYNC_MODE = 1'b0;
defparam syn__24_.IN_POWERUP = 1'b0;
defparam syn__24_.OUT_REG_MODE = 1'b0;
defparam syn__24_.OUT_ASYNC_MODE = 1'b0;
defparam syn__24_.OUT_SYNC_MODE = 1'b0;
defparam syn__24_.OUT_POWERUP = 1'b0;
defparam syn__24_.OE_REG_MODE = 1'b0;
defparam syn__24_.OE_ASYNC_MODE = 1'b0;
defparam syn__24_.OE_SYNC_MODE = 1'b0;
defparam syn__24_.OE_POWERUP = 1'b0;
defparam syn__24_.CFG_TRI_INPUT = 1'b0;
defparam syn__24_.CFG_PULL_UP = 1'b0;
defparam syn__24_.CFG_SLR = 1'b0;
defparam syn__24_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__24_.CFG_PDRCTRL = 4'b0010;
defparam syn__24_.CFG_KEEP = 2'b00;
defparam syn__24_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__24_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__24_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__24_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__24_.DPCLK_DELAY = 4'b0000;
defparam syn__24_.OUT_DELAY = 1'b0;
defparam syn__24_.IN_DATA_DELAY = 3'b000;
defparam syn__24_.IN_REG_DELAY = 3'b000;

alta_rio syn__25_(
	.padio(bank1[7]),
	.datain(data[15]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__25_.coord_x = 6;
defparam syn__25_.coord_y = 1;
defparam syn__25_.coord_z = 1;
defparam syn__25_.IN_ASYNC_MODE = 1'b0;
defparam syn__25_.IN_SYNC_MODE = 1'b0;
defparam syn__25_.IN_POWERUP = 1'b0;
defparam syn__25_.OUT_REG_MODE = 1'b0;
defparam syn__25_.OUT_ASYNC_MODE = 1'b0;
defparam syn__25_.OUT_SYNC_MODE = 1'b0;
defparam syn__25_.OUT_POWERUP = 1'b0;
defparam syn__25_.OE_REG_MODE = 1'b0;
defparam syn__25_.OE_ASYNC_MODE = 1'b0;
defparam syn__25_.OE_SYNC_MODE = 1'b0;
defparam syn__25_.OE_POWERUP = 1'b0;
defparam syn__25_.CFG_TRI_INPUT = 1'b0;
defparam syn__25_.CFG_PULL_UP = 1'b0;
defparam syn__25_.CFG_SLR = 1'b0;
defparam syn__25_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__25_.CFG_PDRCTRL = 4'b0010;
defparam syn__25_.CFG_KEEP = 2'b00;
defparam syn__25_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__25_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__25_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__25_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__25_.DPCLK_DELAY = 4'b0000;
defparam syn__25_.OUT_DELAY = 1'b0;
defparam syn__25_.IN_DATA_DELAY = 3'b000;
defparam syn__25_.IN_REG_DELAY = 3'b000;

alta_rio syn__26_(
	.padio(bank2[0]),
	.datain(data[16]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__26_.coord_x = 6;
defparam syn__26_.coord_y = 1;
defparam syn__26_.coord_z = 2;
defparam syn__26_.IN_ASYNC_MODE = 1'b0;
defparam syn__26_.IN_SYNC_MODE = 1'b0;
defparam syn__26_.IN_POWERUP = 1'b0;
defparam syn__26_.OUT_REG_MODE = 1'b0;
defparam syn__26_.OUT_ASYNC_MODE = 1'b0;
defparam syn__26_.OUT_SYNC_MODE = 1'b0;
defparam syn__26_.OUT_POWERUP = 1'b0;
defparam syn__26_.OE_REG_MODE = 1'b0;
defparam syn__26_.OE_ASYNC_MODE = 1'b0;
defparam syn__26_.OE_SYNC_MODE = 1'b0;
defparam syn__26_.OE_POWERUP = 1'b0;
defparam syn__26_.CFG_TRI_INPUT = 1'b0;
defparam syn__26_.CFG_PULL_UP = 1'b0;
defparam syn__26_.CFG_SLR = 1'b0;
defparam syn__26_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__26_.CFG_PDRCTRL = 4'b0010;
defparam syn__26_.CFG_KEEP = 2'b00;
defparam syn__26_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__26_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__26_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__26_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__26_.DPCLK_DELAY = 4'b0000;
defparam syn__26_.OUT_DELAY = 1'b0;
defparam syn__26_.IN_DATA_DELAY = 3'b000;
defparam syn__26_.IN_REG_DELAY = 3'b000;

alta_rio syn__27_(
	.padio(bank2[1]),
	.datain(data[17]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__27_.coord_x = 6;
defparam syn__27_.coord_y = 1;
defparam syn__27_.coord_z = 3;
defparam syn__27_.IN_ASYNC_MODE = 1'b0;
defparam syn__27_.IN_SYNC_MODE = 1'b0;
defparam syn__27_.IN_POWERUP = 1'b0;
defparam syn__27_.OUT_REG_MODE = 1'b0;
defparam syn__27_.OUT_ASYNC_MODE = 1'b0;
defparam syn__27_.OUT_SYNC_MODE = 1'b0;
defparam syn__27_.OUT_POWERUP = 1'b0;
defparam syn__27_.OE_REG_MODE = 1'b0;
defparam syn__27_.OE_ASYNC_MODE = 1'b0;
defparam syn__27_.OE_SYNC_MODE = 1'b0;
defparam syn__27_.OE_POWERUP = 1'b0;
defparam syn__27_.CFG_TRI_INPUT = 1'b0;
defparam syn__27_.CFG_PULL_UP = 1'b0;
defparam syn__27_.CFG_SLR = 1'b0;
defparam syn__27_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__27_.CFG_PDRCTRL = 4'b0010;
defparam syn__27_.CFG_KEEP = 2'b00;
defparam syn__27_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__27_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__27_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__27_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__27_.DPCLK_DELAY = 4'b0000;
defparam syn__27_.OUT_DELAY = 1'b0;
defparam syn__27_.IN_DATA_DELAY = 3'b000;
defparam syn__27_.IN_REG_DELAY = 3'b000;

alta_rio syn__28_(
	.padio(bank2[2]),
	.datain(data[18]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__28_.coord_x = 9;
defparam syn__28_.coord_y = 0;
defparam syn__28_.coord_z = 1;
defparam syn__28_.IN_ASYNC_MODE = 1'b0;
defparam syn__28_.IN_SYNC_MODE = 1'b0;
defparam syn__28_.IN_POWERUP = 1'b0;
defparam syn__28_.OUT_REG_MODE = 1'b0;
defparam syn__28_.OUT_ASYNC_MODE = 1'b0;
defparam syn__28_.OUT_SYNC_MODE = 1'b0;
defparam syn__28_.OUT_POWERUP = 1'b0;
defparam syn__28_.OE_REG_MODE = 1'b0;
defparam syn__28_.OE_ASYNC_MODE = 1'b0;
defparam syn__28_.OE_SYNC_MODE = 1'b0;
defparam syn__28_.OE_POWERUP = 1'b0;
defparam syn__28_.CFG_TRI_INPUT = 1'b0;
defparam syn__28_.CFG_PULL_UP = 1'b0;
defparam syn__28_.CFG_SLR = 1'b0;
defparam syn__28_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__28_.CFG_PDRCTRL = 4'b0010;
defparam syn__28_.CFG_KEEP = 2'b00;
defparam syn__28_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__28_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__28_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__28_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__28_.DPCLK_DELAY = 4'b0000;
defparam syn__28_.OUT_DELAY = 1'b0;
defparam syn__28_.IN_DATA_DELAY = 3'b000;
defparam syn__28_.IN_REG_DELAY = 3'b000;

alta_rio syn__29_(
	.padio(bank2[3]),
	.datain(data[19]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__29_.coord_x = 9;
defparam syn__29_.coord_y = 0;
defparam syn__29_.coord_z = 3;
defparam syn__29_.IN_ASYNC_MODE = 1'b0;
defparam syn__29_.IN_SYNC_MODE = 1'b0;
defparam syn__29_.IN_POWERUP = 1'b0;
defparam syn__29_.OUT_REG_MODE = 1'b0;
defparam syn__29_.OUT_ASYNC_MODE = 1'b0;
defparam syn__29_.OUT_SYNC_MODE = 1'b0;
defparam syn__29_.OUT_POWERUP = 1'b0;
defparam syn__29_.OE_REG_MODE = 1'b0;
defparam syn__29_.OE_ASYNC_MODE = 1'b0;
defparam syn__29_.OE_SYNC_MODE = 1'b0;
defparam syn__29_.OE_POWERUP = 1'b0;
defparam syn__29_.CFG_TRI_INPUT = 1'b0;
defparam syn__29_.CFG_PULL_UP = 1'b0;
defparam syn__29_.CFG_SLR = 1'b0;
defparam syn__29_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__29_.CFG_PDRCTRL = 4'b0010;
defparam syn__29_.CFG_KEEP = 2'b00;
defparam syn__29_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__29_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__29_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__29_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__29_.DPCLK_DELAY = 4'b0000;
defparam syn__29_.OUT_DELAY = 1'b0;
defparam syn__29_.IN_DATA_DELAY = 3'b000;
defparam syn__29_.IN_REG_DELAY = 3'b000;

alta_rio syn__30_(
	.padio(bank2[4]),
	.datain(data[20]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__30_.coord_x = 8;
defparam syn__30_.coord_y = 9;
defparam syn__30_.coord_z = 0;
defparam syn__30_.IN_ASYNC_MODE = 1'b0;
defparam syn__30_.IN_SYNC_MODE = 1'b0;
defparam syn__30_.IN_POWERUP = 1'b0;
defparam syn__30_.OUT_REG_MODE = 1'b0;
defparam syn__30_.OUT_ASYNC_MODE = 1'b0;
defparam syn__30_.OUT_SYNC_MODE = 1'b0;
defparam syn__30_.OUT_POWERUP = 1'b0;
defparam syn__30_.OE_REG_MODE = 1'b0;
defparam syn__30_.OE_ASYNC_MODE = 1'b0;
defparam syn__30_.OE_SYNC_MODE = 1'b0;
defparam syn__30_.OE_POWERUP = 1'b0;
defparam syn__30_.CFG_TRI_INPUT = 1'b0;
defparam syn__30_.CFG_PULL_UP = 1'b0;
defparam syn__30_.CFG_SLR = 1'b0;
defparam syn__30_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__30_.CFG_PDRCTRL = 4'b0010;
defparam syn__30_.CFG_KEEP = 2'b00;
defparam syn__30_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__30_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__30_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__30_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__30_.DPCLK_DELAY = 4'b0000;
defparam syn__30_.OUT_DELAY = 1'b0;
defparam syn__30_.IN_DATA_DELAY = 3'b000;
defparam syn__30_.IN_REG_DELAY = 3'b000;

alta_rio syn__31_(
	.padio(bank2[5]),
	.datain(data[21]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__31_.coord_x = 11;
defparam syn__31_.coord_y = 9;
defparam syn__31_.coord_z = 1;
defparam syn__31_.IN_ASYNC_MODE = 1'b0;
defparam syn__31_.IN_SYNC_MODE = 1'b0;
defparam syn__31_.IN_POWERUP = 1'b0;
defparam syn__31_.OUT_REG_MODE = 1'b0;
defparam syn__31_.OUT_ASYNC_MODE = 1'b0;
defparam syn__31_.OUT_SYNC_MODE = 1'b0;
defparam syn__31_.OUT_POWERUP = 1'b0;
defparam syn__31_.OE_REG_MODE = 1'b0;
defparam syn__31_.OE_ASYNC_MODE = 1'b0;
defparam syn__31_.OE_SYNC_MODE = 1'b0;
defparam syn__31_.OE_POWERUP = 1'b0;
defparam syn__31_.CFG_TRI_INPUT = 1'b0;
defparam syn__31_.CFG_PULL_UP = 1'b0;
defparam syn__31_.CFG_SLR = 1'b0;
defparam syn__31_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__31_.CFG_PDRCTRL = 4'b0010;
defparam syn__31_.CFG_KEEP = 2'b00;
defparam syn__31_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__31_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__31_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__31_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__31_.DPCLK_DELAY = 4'b0000;
defparam syn__31_.OUT_DELAY = 1'b0;
defparam syn__31_.IN_DATA_DELAY = 3'b000;
defparam syn__31_.IN_REG_DELAY = 3'b000;

alta_rio syn__32_(
	.padio(bank2[6]),
	.datain(data[22]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__32_.coord_x = 9;
defparam syn__32_.coord_y = 9;
defparam syn__32_.coord_z = 3;
defparam syn__32_.IN_ASYNC_MODE = 1'b0;
defparam syn__32_.IN_SYNC_MODE = 1'b0;
defparam syn__32_.IN_POWERUP = 1'b0;
defparam syn__32_.OUT_REG_MODE = 1'b0;
defparam syn__32_.OUT_ASYNC_MODE = 1'b0;
defparam syn__32_.OUT_SYNC_MODE = 1'b0;
defparam syn__32_.OUT_POWERUP = 1'b0;
defparam syn__32_.OE_REG_MODE = 1'b0;
defparam syn__32_.OE_ASYNC_MODE = 1'b0;
defparam syn__32_.OE_SYNC_MODE = 1'b0;
defparam syn__32_.OE_POWERUP = 1'b0;
defparam syn__32_.CFG_TRI_INPUT = 1'b0;
defparam syn__32_.CFG_PULL_UP = 1'b0;
defparam syn__32_.CFG_SLR = 1'b0;
defparam syn__32_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__32_.CFG_PDRCTRL = 4'b0010;
defparam syn__32_.CFG_KEEP = 2'b00;
defparam syn__32_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__32_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__32_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__32_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__32_.DPCLK_DELAY = 4'b0000;
defparam syn__32_.OUT_DELAY = 1'b0;
defparam syn__32_.IN_DATA_DELAY = 3'b000;
defparam syn__32_.IN_REG_DELAY = 3'b000;

alta_rio syn__33_(
	.padio(bank2[7]),
	.datain(data[23]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__33_.coord_x = 9;
defparam syn__33_.coord_y = 9;
defparam syn__33_.coord_z = 1;
defparam syn__33_.IN_ASYNC_MODE = 1'b0;
defparam syn__33_.IN_SYNC_MODE = 1'b0;
defparam syn__33_.IN_POWERUP = 1'b0;
defparam syn__33_.OUT_REG_MODE = 1'b0;
defparam syn__33_.OUT_ASYNC_MODE = 1'b0;
defparam syn__33_.OUT_SYNC_MODE = 1'b0;
defparam syn__33_.OUT_POWERUP = 1'b0;
defparam syn__33_.OE_REG_MODE = 1'b0;
defparam syn__33_.OE_ASYNC_MODE = 1'b0;
defparam syn__33_.OE_SYNC_MODE = 1'b0;
defparam syn__33_.OE_POWERUP = 1'b0;
defparam syn__33_.CFG_TRI_INPUT = 1'b0;
defparam syn__33_.CFG_PULL_UP = 1'b0;
defparam syn__33_.CFG_SLR = 1'b0;
defparam syn__33_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__33_.CFG_PDRCTRL = 4'b0010;
defparam syn__33_.CFG_KEEP = 2'b00;
defparam syn__33_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__33_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__33_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__33_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__33_.DPCLK_DELAY = 4'b0000;
defparam syn__33_.OUT_DELAY = 1'b0;
defparam syn__33_.IN_DATA_DELAY = 3'b000;
defparam syn__33_.IN_REG_DELAY = 3'b000;

alta_rio syn__34_(
	.padio(bank3[0]),
	.datain(data[24]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__34_.coord_x = 8;
defparam syn__34_.coord_y = 9;
defparam syn__34_.coord_z = 3;
defparam syn__34_.IN_ASYNC_MODE = 1'b0;
defparam syn__34_.IN_SYNC_MODE = 1'b0;
defparam syn__34_.IN_POWERUP = 1'b0;
defparam syn__34_.OUT_REG_MODE = 1'b0;
defparam syn__34_.OUT_ASYNC_MODE = 1'b0;
defparam syn__34_.OUT_SYNC_MODE = 1'b0;
defparam syn__34_.OUT_POWERUP = 1'b0;
defparam syn__34_.OE_REG_MODE = 1'b0;
defparam syn__34_.OE_ASYNC_MODE = 1'b0;
defparam syn__34_.OE_SYNC_MODE = 1'b0;
defparam syn__34_.OE_POWERUP = 1'b0;
defparam syn__34_.CFG_TRI_INPUT = 1'b0;
defparam syn__34_.CFG_PULL_UP = 1'b0;
defparam syn__34_.CFG_SLR = 1'b0;
defparam syn__34_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__34_.CFG_PDRCTRL = 4'b0010;
defparam syn__34_.CFG_KEEP = 2'b00;
defparam syn__34_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__34_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__34_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__34_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__34_.DPCLK_DELAY = 4'b0000;
defparam syn__34_.OUT_DELAY = 1'b0;
defparam syn__34_.IN_DATA_DELAY = 3'b000;
defparam syn__34_.IN_REG_DELAY = 3'b000;

alta_rio syn__35_(
	.padio(bank3[1]),
	.datain(data[25]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__35_.coord_x = 7;
defparam syn__35_.coord_y = 9;
defparam syn__35_.coord_z = 3;
defparam syn__35_.IN_ASYNC_MODE = 1'b0;
defparam syn__35_.IN_SYNC_MODE = 1'b0;
defparam syn__35_.IN_POWERUP = 1'b0;
defparam syn__35_.OUT_REG_MODE = 1'b0;
defparam syn__35_.OUT_ASYNC_MODE = 1'b0;
defparam syn__35_.OUT_SYNC_MODE = 1'b0;
defparam syn__35_.OUT_POWERUP = 1'b0;
defparam syn__35_.OE_REG_MODE = 1'b0;
defparam syn__35_.OE_ASYNC_MODE = 1'b0;
defparam syn__35_.OE_SYNC_MODE = 1'b0;
defparam syn__35_.OE_POWERUP = 1'b0;
defparam syn__35_.CFG_TRI_INPUT = 1'b0;
defparam syn__35_.CFG_PULL_UP = 1'b0;
defparam syn__35_.CFG_SLR = 1'b0;
defparam syn__35_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__35_.CFG_PDRCTRL = 4'b0010;
defparam syn__35_.CFG_KEEP = 2'b00;
defparam syn__35_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__35_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__35_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__35_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__35_.DPCLK_DELAY = 4'b0000;
defparam syn__35_.OUT_DELAY = 1'b0;
defparam syn__35_.IN_DATA_DELAY = 3'b000;
defparam syn__35_.IN_REG_DELAY = 3'b000;

alta_rio syn__36_(
	.padio(bank3[2]),
	.datain(data[26]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__36_.coord_x = 7;
defparam syn__36_.coord_y = 9;
defparam syn__36_.coord_z = 0;
defparam syn__36_.IN_ASYNC_MODE = 1'b0;
defparam syn__36_.IN_SYNC_MODE = 1'b0;
defparam syn__36_.IN_POWERUP = 1'b0;
defparam syn__36_.OUT_REG_MODE = 1'b0;
defparam syn__36_.OUT_ASYNC_MODE = 1'b0;
defparam syn__36_.OUT_SYNC_MODE = 1'b0;
defparam syn__36_.OUT_POWERUP = 1'b0;
defparam syn__36_.OE_REG_MODE = 1'b0;
defparam syn__36_.OE_ASYNC_MODE = 1'b0;
defparam syn__36_.OE_SYNC_MODE = 1'b0;
defparam syn__36_.OE_POWERUP = 1'b0;
defparam syn__36_.CFG_TRI_INPUT = 1'b0;
defparam syn__36_.CFG_PULL_UP = 1'b0;
defparam syn__36_.CFG_SLR = 1'b0;
defparam syn__36_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__36_.CFG_PDRCTRL = 4'b0010;
defparam syn__36_.CFG_KEEP = 2'b00;
defparam syn__36_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__36_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__36_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__36_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__36_.DPCLK_DELAY = 4'b0000;
defparam syn__36_.OUT_DELAY = 1'b0;
defparam syn__36_.IN_DATA_DELAY = 3'b000;
defparam syn__36_.IN_REG_DELAY = 3'b000;

alta_rio syn__37_(
	.padio(bank3[3]),
	.datain(data[27]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__37_.coord_x = 6;
defparam syn__37_.coord_y = 9;
defparam syn__37_.coord_z = 0;
defparam syn__37_.IN_ASYNC_MODE = 1'b0;
defparam syn__37_.IN_SYNC_MODE = 1'b0;
defparam syn__37_.IN_POWERUP = 1'b0;
defparam syn__37_.OUT_REG_MODE = 1'b0;
defparam syn__37_.OUT_ASYNC_MODE = 1'b0;
defparam syn__37_.OUT_SYNC_MODE = 1'b0;
defparam syn__37_.OUT_POWERUP = 1'b0;
defparam syn__37_.OE_REG_MODE = 1'b0;
defparam syn__37_.OE_ASYNC_MODE = 1'b0;
defparam syn__37_.OE_SYNC_MODE = 1'b0;
defparam syn__37_.OE_POWERUP = 1'b0;
defparam syn__37_.CFG_TRI_INPUT = 1'b0;
defparam syn__37_.CFG_PULL_UP = 1'b0;
defparam syn__37_.CFG_SLR = 1'b0;
defparam syn__37_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__37_.CFG_PDRCTRL = 4'b0010;
defparam syn__37_.CFG_KEEP = 2'b00;
defparam syn__37_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__37_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__37_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__37_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__37_.DPCLK_DELAY = 4'b0000;
defparam syn__37_.OUT_DELAY = 1'b0;
defparam syn__37_.IN_DATA_DELAY = 3'b000;
defparam syn__37_.IN_REG_DELAY = 3'b000;

alta_rio syn__38_(
	.padio(bank3[4]),
	.datain(data[28]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__38_.coord_x = 5;
defparam syn__38_.coord_y = 9;
defparam syn__38_.coord_z = 3;
defparam syn__38_.IN_ASYNC_MODE = 1'b0;
defparam syn__38_.IN_SYNC_MODE = 1'b0;
defparam syn__38_.IN_POWERUP = 1'b0;
defparam syn__38_.OUT_REG_MODE = 1'b0;
defparam syn__38_.OUT_ASYNC_MODE = 1'b0;
defparam syn__38_.OUT_SYNC_MODE = 1'b0;
defparam syn__38_.OUT_POWERUP = 1'b0;
defparam syn__38_.OE_REG_MODE = 1'b0;
defparam syn__38_.OE_ASYNC_MODE = 1'b0;
defparam syn__38_.OE_SYNC_MODE = 1'b0;
defparam syn__38_.OE_POWERUP = 1'b0;
defparam syn__38_.CFG_TRI_INPUT = 1'b0;
defparam syn__38_.CFG_PULL_UP = 1'b0;
defparam syn__38_.CFG_SLR = 1'b0;
defparam syn__38_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__38_.CFG_PDRCTRL = 4'b0010;
defparam syn__38_.CFG_KEEP = 2'b00;
defparam syn__38_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__38_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__38_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__38_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__38_.DPCLK_DELAY = 4'b0000;
defparam syn__38_.OUT_DELAY = 1'b0;
defparam syn__38_.IN_DATA_DELAY = 3'b000;
defparam syn__38_.IN_REG_DELAY = 3'b000;

alta_rio syn__39_(
	.padio(bank3[5]),
	.datain(data[29]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__39_.coord_x = 5;
defparam syn__39_.coord_y = 9;
defparam syn__39_.coord_z = 2;
defparam syn__39_.IN_ASYNC_MODE = 1'b0;
defparam syn__39_.IN_SYNC_MODE = 1'b0;
defparam syn__39_.IN_POWERUP = 1'b0;
defparam syn__39_.OUT_REG_MODE = 1'b0;
defparam syn__39_.OUT_ASYNC_MODE = 1'b0;
defparam syn__39_.OUT_SYNC_MODE = 1'b0;
defparam syn__39_.OUT_POWERUP = 1'b0;
defparam syn__39_.OE_REG_MODE = 1'b0;
defparam syn__39_.OE_ASYNC_MODE = 1'b0;
defparam syn__39_.OE_SYNC_MODE = 1'b0;
defparam syn__39_.OE_POWERUP = 1'b0;
defparam syn__39_.CFG_TRI_INPUT = 1'b0;
defparam syn__39_.CFG_PULL_UP = 1'b0;
defparam syn__39_.CFG_SLR = 1'b0;
defparam syn__39_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__39_.CFG_PDRCTRL = 4'b0010;
defparam syn__39_.CFG_KEEP = 2'b00;
defparam syn__39_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__39_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__39_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__39_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__39_.DPCLK_DELAY = 4'b0000;
defparam syn__39_.OUT_DELAY = 1'b0;
defparam syn__39_.IN_DATA_DELAY = 3'b000;
defparam syn__39_.IN_REG_DELAY = 3'b000;

alta_rio syn__40_(
	.padio(bank3[6]),
	.datain(data[30]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__40_.coord_x = 5;
defparam syn__40_.coord_y = 9;
defparam syn__40_.coord_z = 1;
defparam syn__40_.IN_ASYNC_MODE = 1'b0;
defparam syn__40_.IN_SYNC_MODE = 1'b0;
defparam syn__40_.IN_POWERUP = 1'b0;
defparam syn__40_.OUT_REG_MODE = 1'b0;
defparam syn__40_.OUT_ASYNC_MODE = 1'b0;
defparam syn__40_.OUT_SYNC_MODE = 1'b0;
defparam syn__40_.OUT_POWERUP = 1'b0;
defparam syn__40_.OE_REG_MODE = 1'b0;
defparam syn__40_.OE_ASYNC_MODE = 1'b0;
defparam syn__40_.OE_SYNC_MODE = 1'b0;
defparam syn__40_.OE_POWERUP = 1'b0;
defparam syn__40_.CFG_TRI_INPUT = 1'b0;
defparam syn__40_.CFG_PULL_UP = 1'b0;
defparam syn__40_.CFG_SLR = 1'b0;
defparam syn__40_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__40_.CFG_PDRCTRL = 4'b0010;
defparam syn__40_.CFG_KEEP = 2'b00;
defparam syn__40_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__40_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__40_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__40_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__40_.DPCLK_DELAY = 4'b0000;
defparam syn__40_.OUT_DELAY = 1'b0;
defparam syn__40_.IN_DATA_DELAY = 3'b000;
defparam syn__40_.IN_REG_DELAY = 3'b000;

alta_rio syn__41_(
	.padio(bank3[7]),
	.datain(data[31]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__41_.coord_x = 5;
defparam syn__41_.coord_y = 9;
defparam syn__41_.coord_z = 0;
defparam syn__41_.IN_ASYNC_MODE = 1'b0;
defparam syn__41_.IN_SYNC_MODE = 1'b0;
defparam syn__41_.IN_POWERUP = 1'b0;
defparam syn__41_.OUT_REG_MODE = 1'b0;
defparam syn__41_.OUT_ASYNC_MODE = 1'b0;
defparam syn__41_.OUT_SYNC_MODE = 1'b0;
defparam syn__41_.OUT_POWERUP = 1'b0;
defparam syn__41_.OE_REG_MODE = 1'b0;
defparam syn__41_.OE_ASYNC_MODE = 1'b0;
defparam syn__41_.OE_SYNC_MODE = 1'b0;
defparam syn__41_.OE_POWERUP = 1'b0;
defparam syn__41_.CFG_TRI_INPUT = 1'b0;
defparam syn__41_.CFG_PULL_UP = 1'b0;
defparam syn__41_.CFG_SLR = 1'b0;
defparam syn__41_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__41_.CFG_PDRCTRL = 4'b0010;
defparam syn__41_.CFG_KEEP = 2'b00;
defparam syn__41_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__41_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__41_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__41_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__41_.DPCLK_DELAY = 4'b0000;
defparam syn__41_.OUT_DELAY = 1'b0;
defparam syn__41_.IN_DATA_DELAY = 3'b000;
defparam syn__41_.IN_REG_DELAY = 3'b000;

alta_rio syn__42_(
	.padio(clk),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(syn__02_),
	.regout());
defparam syn__42_.coord_x = 4;
defparam syn__42_.coord_y = 9;
defparam syn__42_.coord_z = 0;
defparam syn__42_.IN_ASYNC_MODE = 1'b0;
defparam syn__42_.IN_SYNC_MODE = 1'b0;
defparam syn__42_.IN_POWERUP = 1'b0;
defparam syn__42_.OUT_REG_MODE = 1'b0;
defparam syn__42_.OUT_ASYNC_MODE = 1'b0;
defparam syn__42_.OUT_SYNC_MODE = 1'b0;
defparam syn__42_.OUT_POWERUP = 1'b0;
defparam syn__42_.OE_REG_MODE = 1'b0;
defparam syn__42_.OE_ASYNC_MODE = 1'b0;
defparam syn__42_.OE_SYNC_MODE = 1'b0;
defparam syn__42_.OE_POWERUP = 1'b0;
defparam syn__42_.CFG_TRI_INPUT = 1'b0;
defparam syn__42_.CFG_PULL_UP = 1'b0;
defparam syn__42_.CFG_SLR = 1'b0;
defparam syn__42_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__42_.CFG_PDRCTRL = 4'b0010;
defparam syn__42_.CFG_KEEP = 2'b00;
defparam syn__42_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__42_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__42_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__42_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__42_.DPCLK_DELAY = 4'b0000;
defparam syn__42_.OUT_DELAY = 1'b0;
defparam syn__42_.IN_DATA_DELAY = 3'b000;
defparam syn__42_.IN_REG_DELAY = 3'b000;

alta_slice syn__43_(
	.A(),
	.B(),
	.C(vcc),
	.D(),
	.Cin(),
	.Qin(counter[0]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[0]_inv ),
	.Cout(),
	.Q(counter[0]));
defparam syn__43_.coord_x = 2;
defparam syn__43_.coord_y = 2;
defparam syn__43_.coord_z = 5;
defparam syn__43_.mask = 16'h0F0F;
defparam syn__43_.modeMux = 1'b0;
defparam syn__43_.FeedbackMux = 1'b1;
defparam syn__43_.ShiftMux = 1'b0;
defparam syn__43_.BypassEn = 1'b0;
defparam syn__43_.CarryEnb = 1'b1;

alta_slice syn__44_(
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(counter[0]),
	.Cin(),
	.Qin(counter[1]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[1]),
	.Cout(),
	.Q(counter[1]));
defparam syn__44_.coord_x = 2;
defparam syn__44_.coord_y = 2;
defparam syn__44_.coord_z = 0;
defparam syn__44_.mask = 16'h0FF0;
defparam syn__44_.modeMux = 1'b0;
defparam syn__44_.FeedbackMux = 1'b1;
defparam syn__44_.ShiftMux = 1'b0;
defparam syn__44_.BypassEn = 1'b0;
defparam syn__44_.CarryEnb = 1'b1;

alta_slice syn__45_(
	.A(counter[1]),
	.B(vcc),
	.C(vcc),
	.D(counter[0]),
	.Cin(),
	.Qin(counter[2]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[2]),
	.Cout(),
	.Q(counter[2]));
defparam syn__45_.coord_x = 2;
defparam syn__45_.coord_y = 2;
defparam syn__45_.coord_z = 2;
defparam syn__45_.mask = 16'h5AF0;
defparam syn__45_.modeMux = 1'b0;
defparam syn__45_.FeedbackMux = 1'b1;
defparam syn__45_.ShiftMux = 1'b0;
defparam syn__45_.BypassEn = 1'b0;
defparam syn__45_.CarryEnb = 1'b1;

alta_slice syn__46_(
	.A(counter[1]),
	.B(counter[2]),
	.C(vcc),
	.D(counter[0]),
	.Cin(),
	.Qin(counter[3]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[3]),
	.Cout(),
	.Q(counter[3]));
defparam syn__46_.coord_x = 2;
defparam syn__46_.coord_y = 2;
defparam syn__46_.coord_z = 3;
defparam syn__46_.mask = 16'h78F0;
defparam syn__46_.modeMux = 1'b0;
defparam syn__46_.FeedbackMux = 1'b1;
defparam syn__46_.ShiftMux = 1'b0;
defparam syn__46_.BypassEn = 1'b0;
defparam syn__46_.CarryEnb = 1'b1;

alta_slice syn__47_(
	.A(syn__01_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[4]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[4]),
	.Cout(),
	.Q(counter[4]));
defparam syn__47_.coord_x = 2;
defparam syn__47_.coord_y = 2;
defparam syn__47_.coord_z = 1;
defparam syn__47_.mask = 16'h5A5A;
defparam syn__47_.modeMux = 1'b0;
defparam syn__47_.FeedbackMux = 1'b1;
defparam syn__47_.ShiftMux = 1'b0;
defparam syn__47_.BypassEn = 1'b0;
defparam syn__47_.CarryEnb = 1'b1;

alta_slice syn__48_(
	.A(syn__01_),
	.B(vcc),
	.C(vcc),
	.D(counter[4]),
	.Cin(),
	.Qin(counter[5]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[5]),
	.Cout(),
	.Q(counter[5]));
defparam syn__48_.coord_x = 2;
defparam syn__48_.coord_y = 2;
defparam syn__48_.coord_z = 13;
defparam syn__48_.mask = 16'h5AF0;
defparam syn__48_.modeMux = 1'b0;
defparam syn__48_.FeedbackMux = 1'b1;
defparam syn__48_.ShiftMux = 1'b0;
defparam syn__48_.BypassEn = 1'b0;
defparam syn__48_.CarryEnb = 1'b1;

alta_slice syn__49_(
	.A(syn__01_),
	.B(counter[5]),
	.C(vcc),
	.D(counter[4]),
	.Cin(),
	.Qin(counter[6]),
	.Clk(syn__02__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__00_[6]),
	.Cout(),
	.Q(counter[6]));
defparam syn__49_.coord_x = 2;
defparam syn__49_.coord_y = 2;
defparam syn__49_.coord_z = 8;
defparam syn__49_.mask = 16'h78F0;
defparam syn__49_.modeMux = 1'b0;
defparam syn__49_.FeedbackMux = 1'b1;
defparam syn__49_.ShiftMux = 1'b0;
defparam syn__49_.BypassEn = 1'b0;
defparam syn__49_.CarryEnb = 1'b1;

endmodule
