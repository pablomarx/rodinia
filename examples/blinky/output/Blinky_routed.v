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
wire	AsyncReset_X1011_Y1001_GND;
wire	AsyncReset_X1012_Y1001_GND;
wire	[10:0] addr;
//wire	addr[0];
wire	\addr[0]_inv ;
//wire	addr[10];
//wire	addr[1];
//wire	addr[2];
//wire	addr[3];
//wire	addr[4];
//wire	addr[5];
//wire	addr[6];
//wire	addr[7];
//wire	addr[8];
//wire	addr[9];
wire	[14:0] counter;
//wire	counter[0];
wire	\counter[0]_inv ;
//wire	counter[10];
//wire	counter[11];
//wire	counter[12];
//wire	counter[13];
//wire	counter[14];
//wire	counter[1];
//wire	counter[2];
//wire	counter[3];
//wire	counter[4];
//wire	counter[5];
//wire	counter[6];
//wire	counter[7];
//wire	counter[8];
//wire	counter[9];
wire	\gnd~I_int ;
wire	\prom.clka ;
wire	\prom.clka_X1011_Y1001_SIG_VCC ;
wire	[10:0] syn__000_;
//wire	syn__000_[0];
//wire	syn__000_[10];
//wire	syn__000_[1];
//wire	syn__000_[2];
//wire	syn__000_[3];
//wire	syn__000_[4];
//wire	syn__000_[5];
//wire	syn__000_[6];
//wire	syn__000_[7];
//wire	syn__000_[8];
//wire	syn__000_[9];
wire	[14:0] syn__001_;
//wire	syn__001_[0];
//wire	syn__001_[10];
//wire	syn__001_[11];
//wire	syn__001_[12];
//wire	syn__001_[13];
//wire	syn__001_[14];
//wire	syn__001_[1];
//wire	syn__001_[2];
//wire	syn__001_[3];
//wire	syn__001_[4];
//wire	syn__001_[5];
//wire	syn__001_[6];
//wire	syn__001_[7];
//wire	syn__001_[8];
//wire	syn__001_[9];
wire	syn__002_;
wire	syn__003_;
wire	syn__004_;
wire	syn__005_;
wire	syn__006_;
wire	syn__007_;
wire	syn__008_;
wire	syn__009_;
wire	syn__010_;
wire	syn__011_;
wire	syn__012_;
wire	syn__013_;
wire	[7:0] syn__014_;
//wire	syn__014_[0];
//wire	syn__014_[1];
//wire	syn__014_[2];
//wire	syn__014_[3];
//wire	syn__014_[4];
//wire	syn__014_[5];
//wire	syn__014_[6];
//wire	syn__014_[7];
wire	[7:0] syn__015_;
//wire	syn__015_[0];
//wire	syn__015_[1];
//wire	syn__015_[2];
//wire	syn__015_[3];
//wire	syn__015_[4];
//wire	syn__015_[5];
//wire	syn__015_[6];
//wire	syn__015_[7];
wire	[7:0] syn__016_;
//wire	syn__016_[0];
//wire	syn__016_[1];
//wire	syn__016_[2];
//wire	syn__016_[3];
//wire	syn__016_[4];
//wire	syn__016_[5];
//wire	syn__016_[6];
//wire	syn__016_[7];
wire	[7:0] syn__017_;
//wire	syn__017_[0];
//wire	syn__017_[1];
//wire	syn__017_[2];
//wire	syn__017_[3];
//wire	syn__017_[4];
//wire	syn__017_[5];
//wire	syn__017_[6];
//wire	syn__017_[7];
wire	syn__018_;
wire	syn__018__X1009_Y1001_SIG_VCC;
wire	syn__018__X1012_Y1001_SIG_VCC;

assign vcc = 1'b1;
assign gnd = 1'b0;

alta_asyncctrl asyncreset_ctrl_X1009_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1009_Y1001_GND));
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_x = 1;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_y = 6;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam asyncreset_ctrl_X1009_Y1001_N0.AsyncCtrlMux = 2'b00;

alta_asyncctrl asyncreset_ctrl_X1011_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1011_Y1001_GND));
defparam asyncreset_ctrl_X1011_Y1001_N0.coord_x = 2;
defparam asyncreset_ctrl_X1011_Y1001_N0.coord_y = 7;
defparam asyncreset_ctrl_X1011_Y1001_N0.coord_z = 0;
defparam asyncreset_ctrl_X1011_Y1001_N0.AsyncCtrlMux = 2'b00;

alta_asyncctrl asyncreset_ctrl_X1012_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1012_Y1001_GND));
defparam asyncreset_ctrl_X1012_Y1001_N0.coord_x = 2;
defparam asyncreset_ctrl_X1012_Y1001_N0.coord_y = 6;
defparam asyncreset_ctrl_X1012_Y1001_N0.coord_z = 0;
defparam asyncreset_ctrl_X1012_Y1001_N0.AsyncCtrlMux = 2'b00;

alta_clkenctrl clken_ctrl_X1009_Y1001_N0(
	.ClkIn(syn__018_),
	.ClkEn(),
	.ClkOut(syn__018__X1009_Y1001_SIG_VCC));
defparam clken_ctrl_X1009_Y1001_N0.coord_x = 1;
defparam clken_ctrl_X1009_Y1001_N0.coord_y = 6;
defparam clken_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1009_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1009_Y1001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X1011_Y1001_N0(
	.ClkIn(\prom.clka ),
	.ClkEn(),
	.ClkOut(\prom.clka_X1011_Y1001_SIG_VCC ));
defparam clken_ctrl_X1011_Y1001_N0.coord_x = 2;
defparam clken_ctrl_X1011_Y1001_N0.coord_y = 7;
defparam clken_ctrl_X1011_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1011_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1011_Y1001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X1012_Y1001_N0(
	.ClkIn(syn__018_),
	.ClkEn(),
	.ClkOut(syn__018__X1012_Y1001_SIG_VCC));
defparam clken_ctrl_X1012_Y1001_N0.coord_x = 2;
defparam clken_ctrl_X1012_Y1001_N0.coord_y = 6;
defparam clken_ctrl_X1012_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1012_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1012_Y1001_N0.ClkEnMux = 2'b01;

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
defparam \gnd~I .coord_y = 7;
defparam \gnd~I .coord_z = 14;
defparam \gnd~I .mask = 16'h0000;
defparam \gnd~I .modeMux = 1'b0;
defparam \gnd~I .FeedbackMux = 1'b0;
defparam \gnd~I .ShiftMux = 1'b0;
defparam \gnd~I .BypassEn = 1'b0;
defparam \gnd~I .CarryEnb = 1'b1;

alta_bram \prom.ram_inst (
	.DataInA({\gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int }),
	.DataInB({\gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int , \gnd~I_int }),
	.AddressA({addr[10], addr[9], addr[8], addr[7], addr[6], addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], \gnd~I_int }),
	.AddressB({addr[10], addr[9], addr[8], addr[7], addr[6], addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], vcc}),
	.DataOutA({, , syn__015_[7], syn__015_[6], syn__015_[5], syn__015_[4], syn__015_[3], syn__015_[2], syn__015_[1], syn__015_[0], syn__014_[7], syn__014_[6], syn__014_[5], syn__014_[4], syn__014_[3], syn__014_[2], syn__014_[1], syn__014_[0]}),
	.DataOutB({, , syn__017_[7], syn__017_[6], syn__017_[5], syn__017_[4], syn__017_[3], syn__017_[2], syn__017_[1], syn__017_[0], syn__016_[7], syn__016_[6], syn__016_[5], syn__016_[4], syn__016_[3], syn__016_[2], syn__016_[1], syn__016_[0]}),
	.Clk0(\prom.clka ),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(\prom.clka ),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(gnd),
	.WeRenB(gnd));
defparam \prom.ram_inst .coord_x = 3;
defparam \prom.ram_inst .coord_y = 7;
defparam \prom.ram_inst .coord_z = 0;
defparam \prom.ram_inst .CLKMODE = 1'b1;
defparam \prom.ram_inst .PORTA_WIDTH = 4'b1111;
defparam \prom.ram_inst .PORTB_WIDTH = 4'b1111;
defparam \prom.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \prom.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \prom.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \prom.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \prom.ram_inst .PORTA_OUTREG = 1'b1;
defparam \prom.ram_inst .PORTB_OUTREG = 1'b1;
defparam \prom.ram_inst .PORTB_READONLY = 1'b0;
defparam \prom.ram_inst .INIT_VAL = 4608'h00FF00FF00FFFF00FF00000000FF00000000000000FF0000000000000000000000FF000000000000FF00000000000000FF000000FF0000FF0000FF00FF00FF00FF00FF00000000FF0000000000000000000000FF000000FF000000FF000000FF00000000FF00000000FF0000000000FF000000000000FF000000000000FFFF00000000000000FFFF00000000000000FFFF00000000000000000000FFFF0000000000000000000000FFFF00000000000000000000000000FFFFFF00000000000000000000000000000000FFFFFFFF000000000000000000000000000000000000FFFFFFFFFF000000000000000000000000000000000000000000000000FFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000;

alta_slice syn__020_(
	.A(syn__004_),
	.B(counter[13]),
	.C(counter[9]),
	.D(counter[10]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__003_),
	.Cout(),
	.Q());
defparam syn__020_.coord_x = 1;
defparam syn__020_.coord_y = 6;
defparam syn__020_.coord_z = 5;
defparam syn__020_.mask = 16'h0002;
defparam syn__020_.modeMux = 1'b0;
defparam syn__020_.FeedbackMux = 1'b0;
defparam syn__020_.ShiftMux = 1'b0;
defparam syn__020_.BypassEn = 1'b0;
defparam syn__020_.CarryEnb = 1'b1;

alta_slice syn__021_(
	.A(counter[2]),
	.B(counter[3]),
	.C(counter[0]),
	.D(counter[1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__004_),
	.Cout(),
	.Q());
defparam syn__021_.coord_x = 1;
defparam syn__021_.coord_y = 6;
defparam syn__021_.coord_z = 4;
defparam syn__021_.mask = 16'h0001;
defparam syn__021_.modeMux = 1'b0;
defparam syn__021_.FeedbackMux = 1'b0;
defparam syn__021_.ShiftMux = 1'b0;
defparam syn__021_.BypassEn = 1'b0;
defparam syn__021_.CarryEnb = 1'b1;

alta_slice syn__022_(
	.A(counter[4]),
	.B(counter[5]),
	.C(counter[6]),
	.D(counter[7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__005_),
	.Cout(),
	.Q());
defparam syn__022_.coord_x = 1;
defparam syn__022_.coord_y = 6;
defparam syn__022_.coord_z = 0;
defparam syn__022_.mask = 16'h0001;
defparam syn__022_.modeMux = 1'b0;
defparam syn__022_.FeedbackMux = 1'b0;
defparam syn__022_.ShiftMux = 1'b0;
defparam syn__022_.BypassEn = 1'b0;
defparam syn__022_.CarryEnb = 1'b1;

alta_slice syn__023_(
	.A(counter[8]),
	.B(counter[14]),
	.C(counter[12]),
	.D(counter[11]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__006_),
	.Cout(),
	.Q());
defparam syn__023_.coord_x = 2;
defparam syn__023_.coord_y = 6;
defparam syn__023_.coord_z = 0;
defparam syn__023_.mask = 16'h0001;
defparam syn__023_.modeMux = 1'b0;
defparam syn__023_.FeedbackMux = 1'b0;
defparam syn__023_.ShiftMux = 1'b0;
defparam syn__023_.BypassEn = 1'b0;
defparam syn__023_.CarryEnb = 1'b1;

alta_slice syn__028_(
	.A(counter[2]),
	.B(counter[3]),
	.C(counter[0]),
	.D(counter[1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__007_),
	.Cout(),
	.Q());
defparam syn__028_.coord_x = 1;
defparam syn__028_.coord_y = 6;
defparam syn__028_.coord_z = 14;
defparam syn__028_.mask = 16'h8000;
defparam syn__028_.modeMux = 1'b0;
defparam syn__028_.FeedbackMux = 1'b0;
defparam syn__028_.ShiftMux = 1'b0;
defparam syn__028_.BypassEn = 1'b0;
defparam syn__028_.CarryEnb = 1'b1;

alta_slice syn__032_(
	.A(counter[6]),
	.B(counter[5]),
	.C(syn__007_),
	.D(counter[4]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__008_),
	.Cout(),
	.Q());
defparam syn__032_.coord_x = 1;
defparam syn__032_.coord_y = 6;
defparam syn__032_.coord_z = 6;
defparam syn__032_.mask = 16'h8000;
defparam syn__032_.modeMux = 1'b0;
defparam syn__032_.FeedbackMux = 1'b0;
defparam syn__032_.ShiftMux = 1'b0;
defparam syn__032_.BypassEn = 1'b0;
defparam syn__032_.CarryEnb = 1'b1;

alta_slice syn__036_(
	.A(counter[9]),
	.B(counter[8]),
	.C(syn__008_),
	.D(counter[7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__009_),
	.Cout(),
	.Q());
defparam syn__036_.coord_x = 1;
defparam syn__036_.coord_y = 6;
defparam syn__036_.coord_z = 9;
defparam syn__036_.mask = 16'h8000;
defparam syn__036_.modeMux = 1'b0;
defparam syn__036_.FeedbackMux = 1'b0;
defparam syn__036_.ShiftMux = 1'b0;
defparam syn__036_.BypassEn = 1'b0;
defparam syn__036_.CarryEnb = 1'b1;

alta_slice syn__040_(
	.A(counter[12]),
	.B(counter[10]),
	.C(counter[11]),
	.D(syn__009_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__010_),
	.Cout(),
	.Q());
defparam syn__040_.coord_x = 2;
defparam syn__040_.coord_y = 6;
defparam syn__040_.coord_z = 6;
defparam syn__040_.mask = 16'h8000;
defparam syn__040_.modeMux = 1'b0;
defparam syn__040_.FeedbackMux = 1'b0;
defparam syn__040_.ShiftMux = 1'b0;
defparam syn__040_.BypassEn = 1'b0;
defparam syn__040_.CarryEnb = 1'b1;

alta_slice syn__046_(
	.A(addr[2]),
	.B(addr[3]),
	.C(addr[0]),
	.D(addr[1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__011_),
	.Cout(),
	.Q());
defparam syn__046_.coord_x = 2;
defparam syn__046_.coord_y = 7;
defparam syn__046_.coord_z = 4;
defparam syn__046_.mask = 16'h8000;
defparam syn__046_.modeMux = 1'b0;
defparam syn__046_.FeedbackMux = 1'b0;
defparam syn__046_.ShiftMux = 1'b0;
defparam syn__046_.BypassEn = 1'b0;
defparam syn__046_.CarryEnb = 1'b1;

alta_slice syn__050_(
	.A(syn__011_),
	.B(addr[6]),
	.C(addr[5]),
	.D(addr[4]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__012_),
	.Cout(),
	.Q());
defparam syn__050_.coord_x = 2;
defparam syn__050_.coord_y = 7;
defparam syn__050_.coord_z = 0;
defparam syn__050_.mask = 16'h8000;
defparam syn__050_.modeMux = 1'b0;
defparam syn__050_.FeedbackMux = 1'b0;
defparam syn__050_.ShiftMux = 1'b0;
defparam syn__050_.BypassEn = 1'b0;
defparam syn__050_.CarryEnb = 1'b1;

alta_slice syn__054_(
	.A(addr[8]),
	.B(addr[9]),
	.C(syn__012_),
	.D(addr[7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__013_),
	.Cout(),
	.Q());
defparam syn__054_.coord_x = 2;
defparam syn__054_.coord_y = 7;
defparam syn__054_.coord_z = 8;
defparam syn__054_.mask = 16'h8000;
defparam syn__054_.modeMux = 1'b0;
defparam syn__054_.FeedbackMux = 1'b0;
defparam syn__054_.ShiftMux = 1'b0;
defparam syn__054_.BypassEn = 1'b0;
defparam syn__054_.CarryEnb = 1'b1;

alta_rio syn__055_(
	.padio(bank0[0]),
	.datain(syn__014_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__055_.coord_x = 2;
defparam syn__055_.coord_y = 9;
defparam syn__055_.coord_z = 0;
defparam syn__055_.IN_ASYNC_MODE = 1'b0;
defparam syn__055_.IN_SYNC_MODE = 1'b0;
defparam syn__055_.IN_POWERUP = 1'b0;
defparam syn__055_.OUT_REG_MODE = 1'b0;
defparam syn__055_.OUT_ASYNC_MODE = 1'b0;
defparam syn__055_.OUT_SYNC_MODE = 1'b0;
defparam syn__055_.OUT_POWERUP = 1'b0;
defparam syn__055_.OE_REG_MODE = 1'b0;
defparam syn__055_.OE_ASYNC_MODE = 1'b0;
defparam syn__055_.OE_SYNC_MODE = 1'b0;
defparam syn__055_.OE_POWERUP = 1'b0;
defparam syn__055_.CFG_TRI_INPUT = 1'b0;
defparam syn__055_.CFG_PULL_UP = 1'b0;
defparam syn__055_.CFG_SLR = 1'b0;
defparam syn__055_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__055_.CFG_PDRCTRL = 4'b0010;
defparam syn__055_.CFG_KEEP = 2'b00;
defparam syn__055_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__055_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__055_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__055_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__055_.DPCLK_DELAY = 4'b0000;
defparam syn__055_.OUT_DELAY = 1'b0;
defparam syn__055_.IN_DATA_DELAY = 3'b000;
defparam syn__055_.IN_REG_DELAY = 3'b000;

alta_rio syn__056_(
	.padio(bank0[1]),
	.datain(syn__014_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__056_.coord_x = 1;
defparam syn__056_.coord_y = 9;
defparam syn__056_.coord_z = 3;
defparam syn__056_.IN_ASYNC_MODE = 1'b0;
defparam syn__056_.IN_SYNC_MODE = 1'b0;
defparam syn__056_.IN_POWERUP = 1'b0;
defparam syn__056_.OUT_REG_MODE = 1'b0;
defparam syn__056_.OUT_ASYNC_MODE = 1'b0;
defparam syn__056_.OUT_SYNC_MODE = 1'b0;
defparam syn__056_.OUT_POWERUP = 1'b0;
defparam syn__056_.OE_REG_MODE = 1'b0;
defparam syn__056_.OE_ASYNC_MODE = 1'b0;
defparam syn__056_.OE_SYNC_MODE = 1'b0;
defparam syn__056_.OE_POWERUP = 1'b0;
defparam syn__056_.CFG_TRI_INPUT = 1'b0;
defparam syn__056_.CFG_PULL_UP = 1'b0;
defparam syn__056_.CFG_SLR = 1'b0;
defparam syn__056_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__056_.CFG_PDRCTRL = 4'b0010;
defparam syn__056_.CFG_KEEP = 2'b00;
defparam syn__056_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__056_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__056_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__056_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__056_.DPCLK_DELAY = 4'b0000;
defparam syn__056_.OUT_DELAY = 1'b0;
defparam syn__056_.IN_DATA_DELAY = 3'b000;
defparam syn__056_.IN_REG_DELAY = 3'b000;

alta_rio syn__057_(
	.padio(bank0[2]),
	.datain(syn__014_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__057_.coord_x = 0;
defparam syn__057_.coord_y = 9;
defparam syn__057_.coord_z = 2;
defparam syn__057_.IN_ASYNC_MODE = 1'b0;
defparam syn__057_.IN_SYNC_MODE = 1'b0;
defparam syn__057_.IN_POWERUP = 1'b0;
defparam syn__057_.OUT_REG_MODE = 1'b0;
defparam syn__057_.OUT_ASYNC_MODE = 1'b0;
defparam syn__057_.OUT_SYNC_MODE = 1'b0;
defparam syn__057_.OUT_POWERUP = 1'b0;
defparam syn__057_.OE_REG_MODE = 1'b0;
defparam syn__057_.OE_ASYNC_MODE = 1'b0;
defparam syn__057_.OE_SYNC_MODE = 1'b0;
defparam syn__057_.OE_POWERUP = 1'b0;
defparam syn__057_.CFG_TRI_INPUT = 1'b0;
defparam syn__057_.CFG_PULL_UP = 1'b0;
defparam syn__057_.CFG_SLR = 1'b0;
defparam syn__057_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__057_.CFG_PDRCTRL = 4'b0010;
defparam syn__057_.CFG_KEEP = 2'b00;
defparam syn__057_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__057_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__057_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__057_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__057_.DPCLK_DELAY = 4'b0000;
defparam syn__057_.OUT_DELAY = 1'b0;
defparam syn__057_.IN_DATA_DELAY = 3'b000;
defparam syn__057_.IN_REG_DELAY = 3'b000;

alta_rio syn__058_(
	.padio(bank0[3]),
	.datain(syn__014_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__058_.coord_x = 0;
defparam syn__058_.coord_y = 9;
defparam syn__058_.coord_z = 0;
defparam syn__058_.IN_ASYNC_MODE = 1'b0;
defparam syn__058_.IN_SYNC_MODE = 1'b0;
defparam syn__058_.IN_POWERUP = 1'b0;
defparam syn__058_.OUT_REG_MODE = 1'b0;
defparam syn__058_.OUT_ASYNC_MODE = 1'b0;
defparam syn__058_.OUT_SYNC_MODE = 1'b0;
defparam syn__058_.OUT_POWERUP = 1'b0;
defparam syn__058_.OE_REG_MODE = 1'b0;
defparam syn__058_.OE_ASYNC_MODE = 1'b0;
defparam syn__058_.OE_SYNC_MODE = 1'b0;
defparam syn__058_.OE_POWERUP = 1'b0;
defparam syn__058_.CFG_TRI_INPUT = 1'b0;
defparam syn__058_.CFG_PULL_UP = 1'b0;
defparam syn__058_.CFG_SLR = 1'b0;
defparam syn__058_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__058_.CFG_PDRCTRL = 4'b0010;
defparam syn__058_.CFG_KEEP = 2'b00;
defparam syn__058_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__058_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__058_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__058_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__058_.DPCLK_DELAY = 4'b0000;
defparam syn__058_.OUT_DELAY = 1'b0;
defparam syn__058_.IN_DATA_DELAY = 3'b000;
defparam syn__058_.IN_REG_DELAY = 3'b000;

alta_rio syn__059_(
	.padio(bank0[4]),
	.datain(syn__014_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__059_.coord_x = 1;
defparam syn__059_.coord_y = 9;
defparam syn__059_.coord_z = 1;
defparam syn__059_.IN_ASYNC_MODE = 1'b0;
defparam syn__059_.IN_SYNC_MODE = 1'b0;
defparam syn__059_.IN_POWERUP = 1'b0;
defparam syn__059_.OUT_REG_MODE = 1'b0;
defparam syn__059_.OUT_ASYNC_MODE = 1'b0;
defparam syn__059_.OUT_SYNC_MODE = 1'b0;
defparam syn__059_.OUT_POWERUP = 1'b0;
defparam syn__059_.OE_REG_MODE = 1'b0;
defparam syn__059_.OE_ASYNC_MODE = 1'b0;
defparam syn__059_.OE_SYNC_MODE = 1'b0;
defparam syn__059_.OE_POWERUP = 1'b0;
defparam syn__059_.CFG_TRI_INPUT = 1'b0;
defparam syn__059_.CFG_PULL_UP = 1'b0;
defparam syn__059_.CFG_SLR = 1'b0;
defparam syn__059_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__059_.CFG_PDRCTRL = 4'b0010;
defparam syn__059_.CFG_KEEP = 2'b00;
defparam syn__059_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__059_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__059_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__059_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__059_.DPCLK_DELAY = 4'b0000;
defparam syn__059_.OUT_DELAY = 1'b0;
defparam syn__059_.IN_DATA_DELAY = 3'b000;
defparam syn__059_.IN_REG_DELAY = 3'b000;

alta_rio syn__060_(
	.padio(bank0[5]),
	.datain(syn__014_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__060_.coord_x = 6;
defparam syn__060_.coord_y = 9;
defparam syn__060_.coord_z = 2;
defparam syn__060_.IN_ASYNC_MODE = 1'b0;
defparam syn__060_.IN_SYNC_MODE = 1'b0;
defparam syn__060_.IN_POWERUP = 1'b0;
defparam syn__060_.OUT_REG_MODE = 1'b0;
defparam syn__060_.OUT_ASYNC_MODE = 1'b0;
defparam syn__060_.OUT_SYNC_MODE = 1'b0;
defparam syn__060_.OUT_POWERUP = 1'b0;
defparam syn__060_.OE_REG_MODE = 1'b0;
defparam syn__060_.OE_ASYNC_MODE = 1'b0;
defparam syn__060_.OE_SYNC_MODE = 1'b0;
defparam syn__060_.OE_POWERUP = 1'b0;
defparam syn__060_.CFG_TRI_INPUT = 1'b0;
defparam syn__060_.CFG_PULL_UP = 1'b0;
defparam syn__060_.CFG_SLR = 1'b0;
defparam syn__060_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__060_.CFG_PDRCTRL = 4'b0010;
defparam syn__060_.CFG_KEEP = 2'b00;
defparam syn__060_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__060_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__060_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__060_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__060_.DPCLK_DELAY = 4'b0000;
defparam syn__060_.OUT_DELAY = 1'b0;
defparam syn__060_.IN_DATA_DELAY = 3'b000;
defparam syn__060_.IN_REG_DELAY = 3'b000;

alta_rio syn__061_(
	.padio(bank0[6]),
	.datain(syn__014_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__061_.coord_x = 2;
defparam syn__061_.coord_y = 1;
defparam syn__061_.coord_z = 0;
defparam syn__061_.IN_ASYNC_MODE = 1'b0;
defparam syn__061_.IN_SYNC_MODE = 1'b0;
defparam syn__061_.IN_POWERUP = 1'b0;
defparam syn__061_.OUT_REG_MODE = 1'b0;
defparam syn__061_.OUT_ASYNC_MODE = 1'b0;
defparam syn__061_.OUT_SYNC_MODE = 1'b0;
defparam syn__061_.OUT_POWERUP = 1'b0;
defparam syn__061_.OE_REG_MODE = 1'b0;
defparam syn__061_.OE_ASYNC_MODE = 1'b0;
defparam syn__061_.OE_SYNC_MODE = 1'b0;
defparam syn__061_.OE_POWERUP = 1'b0;
defparam syn__061_.CFG_TRI_INPUT = 1'b0;
defparam syn__061_.CFG_PULL_UP = 1'b0;
defparam syn__061_.CFG_SLR = 1'b0;
defparam syn__061_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__061_.CFG_PDRCTRL = 4'b0010;
defparam syn__061_.CFG_KEEP = 2'b00;
defparam syn__061_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__061_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__061_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__061_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__061_.DPCLK_DELAY = 4'b0000;
defparam syn__061_.OUT_DELAY = 1'b0;
defparam syn__061_.IN_DATA_DELAY = 3'b000;
defparam syn__061_.IN_REG_DELAY = 3'b000;

alta_rio syn__062_(
	.padio(bank0[7]),
	.datain(syn__014_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__062_.coord_x = 2;
defparam syn__062_.coord_y = 1;
defparam syn__062_.coord_z = 2;
defparam syn__062_.IN_ASYNC_MODE = 1'b0;
defparam syn__062_.IN_SYNC_MODE = 1'b0;
defparam syn__062_.IN_POWERUP = 1'b0;
defparam syn__062_.OUT_REG_MODE = 1'b0;
defparam syn__062_.OUT_ASYNC_MODE = 1'b0;
defparam syn__062_.OUT_SYNC_MODE = 1'b0;
defparam syn__062_.OUT_POWERUP = 1'b0;
defparam syn__062_.OE_REG_MODE = 1'b0;
defparam syn__062_.OE_ASYNC_MODE = 1'b0;
defparam syn__062_.OE_SYNC_MODE = 1'b0;
defparam syn__062_.OE_POWERUP = 1'b0;
defparam syn__062_.CFG_TRI_INPUT = 1'b0;
defparam syn__062_.CFG_PULL_UP = 1'b0;
defparam syn__062_.CFG_SLR = 1'b0;
defparam syn__062_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__062_.CFG_PDRCTRL = 4'b0010;
defparam syn__062_.CFG_KEEP = 2'b00;
defparam syn__062_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__062_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__062_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__062_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__062_.DPCLK_DELAY = 4'b0000;
defparam syn__062_.OUT_DELAY = 1'b0;
defparam syn__062_.IN_DATA_DELAY = 3'b000;
defparam syn__062_.IN_REG_DELAY = 3'b000;

alta_rio syn__063_(
	.padio(bank1[0]),
	.datain(syn__015_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__063_.coord_x = 4;
defparam syn__063_.coord_y = 1;
defparam syn__063_.coord_z = 0;
defparam syn__063_.IN_ASYNC_MODE = 1'b0;
defparam syn__063_.IN_SYNC_MODE = 1'b0;
defparam syn__063_.IN_POWERUP = 1'b0;
defparam syn__063_.OUT_REG_MODE = 1'b0;
defparam syn__063_.OUT_ASYNC_MODE = 1'b0;
defparam syn__063_.OUT_SYNC_MODE = 1'b0;
defparam syn__063_.OUT_POWERUP = 1'b0;
defparam syn__063_.OE_REG_MODE = 1'b0;
defparam syn__063_.OE_ASYNC_MODE = 1'b0;
defparam syn__063_.OE_SYNC_MODE = 1'b0;
defparam syn__063_.OE_POWERUP = 1'b0;
defparam syn__063_.CFG_TRI_INPUT = 1'b0;
defparam syn__063_.CFG_PULL_UP = 1'b0;
defparam syn__063_.CFG_SLR = 1'b0;
defparam syn__063_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__063_.CFG_PDRCTRL = 4'b0010;
defparam syn__063_.CFG_KEEP = 2'b00;
defparam syn__063_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__063_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__063_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__063_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__063_.DPCLK_DELAY = 4'b0000;
defparam syn__063_.OUT_DELAY = 1'b0;
defparam syn__063_.IN_DATA_DELAY = 3'b000;
defparam syn__063_.IN_REG_DELAY = 3'b000;

alta_rio syn__064_(
	.padio(bank1[1]),
	.datain(syn__015_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__064_.coord_x = 4;
defparam syn__064_.coord_y = 1;
defparam syn__064_.coord_z = 2;
defparam syn__064_.IN_ASYNC_MODE = 1'b0;
defparam syn__064_.IN_SYNC_MODE = 1'b0;
defparam syn__064_.IN_POWERUP = 1'b0;
defparam syn__064_.OUT_REG_MODE = 1'b0;
defparam syn__064_.OUT_ASYNC_MODE = 1'b0;
defparam syn__064_.OUT_SYNC_MODE = 1'b0;
defparam syn__064_.OUT_POWERUP = 1'b0;
defparam syn__064_.OE_REG_MODE = 1'b0;
defparam syn__064_.OE_ASYNC_MODE = 1'b0;
defparam syn__064_.OE_SYNC_MODE = 1'b0;
defparam syn__064_.OE_POWERUP = 1'b0;
defparam syn__064_.CFG_TRI_INPUT = 1'b0;
defparam syn__064_.CFG_PULL_UP = 1'b0;
defparam syn__064_.CFG_SLR = 1'b0;
defparam syn__064_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__064_.CFG_PDRCTRL = 4'b0010;
defparam syn__064_.CFG_KEEP = 2'b00;
defparam syn__064_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__064_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__064_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__064_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__064_.DPCLK_DELAY = 4'b0000;
defparam syn__064_.OUT_DELAY = 1'b0;
defparam syn__064_.IN_DATA_DELAY = 3'b000;
defparam syn__064_.IN_REG_DELAY = 3'b000;

alta_rio syn__065_(
	.padio(bank1[2]),
	.datain(syn__015_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__065_.coord_x = 5;
defparam syn__065_.coord_y = 1;
defparam syn__065_.coord_z = 0;
defparam syn__065_.IN_ASYNC_MODE = 1'b0;
defparam syn__065_.IN_SYNC_MODE = 1'b0;
defparam syn__065_.IN_POWERUP = 1'b0;
defparam syn__065_.OUT_REG_MODE = 1'b0;
defparam syn__065_.OUT_ASYNC_MODE = 1'b0;
defparam syn__065_.OUT_SYNC_MODE = 1'b0;
defparam syn__065_.OUT_POWERUP = 1'b0;
defparam syn__065_.OE_REG_MODE = 1'b0;
defparam syn__065_.OE_ASYNC_MODE = 1'b0;
defparam syn__065_.OE_SYNC_MODE = 1'b0;
defparam syn__065_.OE_POWERUP = 1'b0;
defparam syn__065_.CFG_TRI_INPUT = 1'b0;
defparam syn__065_.CFG_PULL_UP = 1'b0;
defparam syn__065_.CFG_SLR = 1'b0;
defparam syn__065_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__065_.CFG_PDRCTRL = 4'b0010;
defparam syn__065_.CFG_KEEP = 2'b00;
defparam syn__065_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__065_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__065_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__065_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__065_.DPCLK_DELAY = 4'b0000;
defparam syn__065_.OUT_DELAY = 1'b0;
defparam syn__065_.IN_DATA_DELAY = 3'b000;
defparam syn__065_.IN_REG_DELAY = 3'b000;

alta_rio syn__066_(
	.padio(bank1[3]),
	.datain(syn__015_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__066_.coord_x = 5;
defparam syn__066_.coord_y = 1;
defparam syn__066_.coord_z = 1;
defparam syn__066_.IN_ASYNC_MODE = 1'b0;
defparam syn__066_.IN_SYNC_MODE = 1'b0;
defparam syn__066_.IN_POWERUP = 1'b0;
defparam syn__066_.OUT_REG_MODE = 1'b0;
defparam syn__066_.OUT_ASYNC_MODE = 1'b0;
defparam syn__066_.OUT_SYNC_MODE = 1'b0;
defparam syn__066_.OUT_POWERUP = 1'b0;
defparam syn__066_.OE_REG_MODE = 1'b0;
defparam syn__066_.OE_ASYNC_MODE = 1'b0;
defparam syn__066_.OE_SYNC_MODE = 1'b0;
defparam syn__066_.OE_POWERUP = 1'b0;
defparam syn__066_.CFG_TRI_INPUT = 1'b0;
defparam syn__066_.CFG_PULL_UP = 1'b0;
defparam syn__066_.CFG_SLR = 1'b0;
defparam syn__066_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__066_.CFG_PDRCTRL = 4'b0010;
defparam syn__066_.CFG_KEEP = 2'b00;
defparam syn__066_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__066_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__066_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__066_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__066_.DPCLK_DELAY = 4'b0000;
defparam syn__066_.OUT_DELAY = 1'b0;
defparam syn__066_.IN_DATA_DELAY = 3'b000;
defparam syn__066_.IN_REG_DELAY = 3'b000;

alta_rio syn__067_(
	.padio(bank1[4]),
	.datain(syn__015_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__067_.coord_x = 5;
defparam syn__067_.coord_y = 1;
defparam syn__067_.coord_z = 2;
defparam syn__067_.IN_ASYNC_MODE = 1'b0;
defparam syn__067_.IN_SYNC_MODE = 1'b0;
defparam syn__067_.IN_POWERUP = 1'b0;
defparam syn__067_.OUT_REG_MODE = 1'b0;
defparam syn__067_.OUT_ASYNC_MODE = 1'b0;
defparam syn__067_.OUT_SYNC_MODE = 1'b0;
defparam syn__067_.OUT_POWERUP = 1'b0;
defparam syn__067_.OE_REG_MODE = 1'b0;
defparam syn__067_.OE_ASYNC_MODE = 1'b0;
defparam syn__067_.OE_SYNC_MODE = 1'b0;
defparam syn__067_.OE_POWERUP = 1'b0;
defparam syn__067_.CFG_TRI_INPUT = 1'b0;
defparam syn__067_.CFG_PULL_UP = 1'b0;
defparam syn__067_.CFG_SLR = 1'b0;
defparam syn__067_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__067_.CFG_PDRCTRL = 4'b0010;
defparam syn__067_.CFG_KEEP = 2'b00;
defparam syn__067_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__067_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__067_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__067_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__067_.DPCLK_DELAY = 4'b0000;
defparam syn__067_.OUT_DELAY = 1'b0;
defparam syn__067_.IN_DATA_DELAY = 3'b000;
defparam syn__067_.IN_REG_DELAY = 3'b000;

alta_rio syn__068_(
	.padio(bank1[5]),
	.datain(syn__015_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__068_.coord_x = 5;
defparam syn__068_.coord_y = 1;
defparam syn__068_.coord_z = 3;
defparam syn__068_.IN_ASYNC_MODE = 1'b0;
defparam syn__068_.IN_SYNC_MODE = 1'b0;
defparam syn__068_.IN_POWERUP = 1'b0;
defparam syn__068_.OUT_REG_MODE = 1'b0;
defparam syn__068_.OUT_ASYNC_MODE = 1'b0;
defparam syn__068_.OUT_SYNC_MODE = 1'b0;
defparam syn__068_.OUT_POWERUP = 1'b0;
defparam syn__068_.OE_REG_MODE = 1'b0;
defparam syn__068_.OE_ASYNC_MODE = 1'b0;
defparam syn__068_.OE_SYNC_MODE = 1'b0;
defparam syn__068_.OE_POWERUP = 1'b0;
defparam syn__068_.CFG_TRI_INPUT = 1'b0;
defparam syn__068_.CFG_PULL_UP = 1'b0;
defparam syn__068_.CFG_SLR = 1'b0;
defparam syn__068_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__068_.CFG_PDRCTRL = 4'b0010;
defparam syn__068_.CFG_KEEP = 2'b00;
defparam syn__068_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__068_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__068_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__068_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__068_.DPCLK_DELAY = 4'b0000;
defparam syn__068_.OUT_DELAY = 1'b0;
defparam syn__068_.IN_DATA_DELAY = 3'b000;
defparam syn__068_.IN_REG_DELAY = 3'b000;

alta_rio syn__069_(
	.padio(bank1[6]),
	.datain(syn__015_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__069_.coord_x = 6;
defparam syn__069_.coord_y = 1;
defparam syn__069_.coord_z = 0;
defparam syn__069_.IN_ASYNC_MODE = 1'b0;
defparam syn__069_.IN_SYNC_MODE = 1'b0;
defparam syn__069_.IN_POWERUP = 1'b0;
defparam syn__069_.OUT_REG_MODE = 1'b0;
defparam syn__069_.OUT_ASYNC_MODE = 1'b0;
defparam syn__069_.OUT_SYNC_MODE = 1'b0;
defparam syn__069_.OUT_POWERUP = 1'b0;
defparam syn__069_.OE_REG_MODE = 1'b0;
defparam syn__069_.OE_ASYNC_MODE = 1'b0;
defparam syn__069_.OE_SYNC_MODE = 1'b0;
defparam syn__069_.OE_POWERUP = 1'b0;
defparam syn__069_.CFG_TRI_INPUT = 1'b0;
defparam syn__069_.CFG_PULL_UP = 1'b0;
defparam syn__069_.CFG_SLR = 1'b0;
defparam syn__069_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__069_.CFG_PDRCTRL = 4'b0010;
defparam syn__069_.CFG_KEEP = 2'b00;
defparam syn__069_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__069_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__069_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__069_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__069_.DPCLK_DELAY = 4'b0000;
defparam syn__069_.OUT_DELAY = 1'b0;
defparam syn__069_.IN_DATA_DELAY = 3'b000;
defparam syn__069_.IN_REG_DELAY = 3'b000;

alta_rio syn__070_(
	.padio(bank1[7]),
	.datain(syn__015_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__070_.coord_x = 6;
defparam syn__070_.coord_y = 1;
defparam syn__070_.coord_z = 1;
defparam syn__070_.IN_ASYNC_MODE = 1'b0;
defparam syn__070_.IN_SYNC_MODE = 1'b0;
defparam syn__070_.IN_POWERUP = 1'b0;
defparam syn__070_.OUT_REG_MODE = 1'b0;
defparam syn__070_.OUT_ASYNC_MODE = 1'b0;
defparam syn__070_.OUT_SYNC_MODE = 1'b0;
defparam syn__070_.OUT_POWERUP = 1'b0;
defparam syn__070_.OE_REG_MODE = 1'b0;
defparam syn__070_.OE_ASYNC_MODE = 1'b0;
defparam syn__070_.OE_SYNC_MODE = 1'b0;
defparam syn__070_.OE_POWERUP = 1'b0;
defparam syn__070_.CFG_TRI_INPUT = 1'b0;
defparam syn__070_.CFG_PULL_UP = 1'b0;
defparam syn__070_.CFG_SLR = 1'b0;
defparam syn__070_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__070_.CFG_PDRCTRL = 4'b0010;
defparam syn__070_.CFG_KEEP = 2'b00;
defparam syn__070_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__070_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__070_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__070_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__070_.DPCLK_DELAY = 4'b0000;
defparam syn__070_.OUT_DELAY = 1'b0;
defparam syn__070_.IN_DATA_DELAY = 3'b000;
defparam syn__070_.IN_REG_DELAY = 3'b000;

alta_rio syn__071_(
	.padio(bank2[0]),
	.datain(syn__016_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__071_.coord_x = 6;
defparam syn__071_.coord_y = 1;
defparam syn__071_.coord_z = 2;
defparam syn__071_.IN_ASYNC_MODE = 1'b0;
defparam syn__071_.IN_SYNC_MODE = 1'b0;
defparam syn__071_.IN_POWERUP = 1'b0;
defparam syn__071_.OUT_REG_MODE = 1'b0;
defparam syn__071_.OUT_ASYNC_MODE = 1'b0;
defparam syn__071_.OUT_SYNC_MODE = 1'b0;
defparam syn__071_.OUT_POWERUP = 1'b0;
defparam syn__071_.OE_REG_MODE = 1'b0;
defparam syn__071_.OE_ASYNC_MODE = 1'b0;
defparam syn__071_.OE_SYNC_MODE = 1'b0;
defparam syn__071_.OE_POWERUP = 1'b0;
defparam syn__071_.CFG_TRI_INPUT = 1'b0;
defparam syn__071_.CFG_PULL_UP = 1'b0;
defparam syn__071_.CFG_SLR = 1'b0;
defparam syn__071_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__071_.CFG_PDRCTRL = 4'b0010;
defparam syn__071_.CFG_KEEP = 2'b00;
defparam syn__071_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__071_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__071_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__071_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__071_.DPCLK_DELAY = 4'b0000;
defparam syn__071_.OUT_DELAY = 1'b0;
defparam syn__071_.IN_DATA_DELAY = 3'b000;
defparam syn__071_.IN_REG_DELAY = 3'b000;

alta_rio syn__072_(
	.padio(bank2[1]),
	.datain(syn__016_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__072_.coord_x = 6;
defparam syn__072_.coord_y = 1;
defparam syn__072_.coord_z = 3;
defparam syn__072_.IN_ASYNC_MODE = 1'b0;
defparam syn__072_.IN_SYNC_MODE = 1'b0;
defparam syn__072_.IN_POWERUP = 1'b0;
defparam syn__072_.OUT_REG_MODE = 1'b0;
defparam syn__072_.OUT_ASYNC_MODE = 1'b0;
defparam syn__072_.OUT_SYNC_MODE = 1'b0;
defparam syn__072_.OUT_POWERUP = 1'b0;
defparam syn__072_.OE_REG_MODE = 1'b0;
defparam syn__072_.OE_ASYNC_MODE = 1'b0;
defparam syn__072_.OE_SYNC_MODE = 1'b0;
defparam syn__072_.OE_POWERUP = 1'b0;
defparam syn__072_.CFG_TRI_INPUT = 1'b0;
defparam syn__072_.CFG_PULL_UP = 1'b0;
defparam syn__072_.CFG_SLR = 1'b0;
defparam syn__072_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__072_.CFG_PDRCTRL = 4'b0010;
defparam syn__072_.CFG_KEEP = 2'b00;
defparam syn__072_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__072_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__072_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__072_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__072_.DPCLK_DELAY = 4'b0000;
defparam syn__072_.OUT_DELAY = 1'b0;
defparam syn__072_.IN_DATA_DELAY = 3'b000;
defparam syn__072_.IN_REG_DELAY = 3'b000;

alta_rio syn__073_(
	.padio(bank2[2]),
	.datain(syn__016_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__073_.coord_x = 9;
defparam syn__073_.coord_y = 0;
defparam syn__073_.coord_z = 1;
defparam syn__073_.IN_ASYNC_MODE = 1'b0;
defparam syn__073_.IN_SYNC_MODE = 1'b0;
defparam syn__073_.IN_POWERUP = 1'b0;
defparam syn__073_.OUT_REG_MODE = 1'b0;
defparam syn__073_.OUT_ASYNC_MODE = 1'b0;
defparam syn__073_.OUT_SYNC_MODE = 1'b0;
defparam syn__073_.OUT_POWERUP = 1'b0;
defparam syn__073_.OE_REG_MODE = 1'b0;
defparam syn__073_.OE_ASYNC_MODE = 1'b0;
defparam syn__073_.OE_SYNC_MODE = 1'b0;
defparam syn__073_.OE_POWERUP = 1'b0;
defparam syn__073_.CFG_TRI_INPUT = 1'b0;
defparam syn__073_.CFG_PULL_UP = 1'b0;
defparam syn__073_.CFG_SLR = 1'b0;
defparam syn__073_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__073_.CFG_PDRCTRL = 4'b0010;
defparam syn__073_.CFG_KEEP = 2'b00;
defparam syn__073_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__073_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__073_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__073_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__073_.DPCLK_DELAY = 4'b0000;
defparam syn__073_.OUT_DELAY = 1'b0;
defparam syn__073_.IN_DATA_DELAY = 3'b000;
defparam syn__073_.IN_REG_DELAY = 3'b000;

alta_rio syn__074_(
	.padio(bank2[3]),
	.datain(syn__016_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__074_.coord_x = 9;
defparam syn__074_.coord_y = 0;
defparam syn__074_.coord_z = 3;
defparam syn__074_.IN_ASYNC_MODE = 1'b0;
defparam syn__074_.IN_SYNC_MODE = 1'b0;
defparam syn__074_.IN_POWERUP = 1'b0;
defparam syn__074_.OUT_REG_MODE = 1'b0;
defparam syn__074_.OUT_ASYNC_MODE = 1'b0;
defparam syn__074_.OUT_SYNC_MODE = 1'b0;
defparam syn__074_.OUT_POWERUP = 1'b0;
defparam syn__074_.OE_REG_MODE = 1'b0;
defparam syn__074_.OE_ASYNC_MODE = 1'b0;
defparam syn__074_.OE_SYNC_MODE = 1'b0;
defparam syn__074_.OE_POWERUP = 1'b0;
defparam syn__074_.CFG_TRI_INPUT = 1'b0;
defparam syn__074_.CFG_PULL_UP = 1'b0;
defparam syn__074_.CFG_SLR = 1'b0;
defparam syn__074_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__074_.CFG_PDRCTRL = 4'b0010;
defparam syn__074_.CFG_KEEP = 2'b00;
defparam syn__074_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__074_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__074_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__074_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__074_.DPCLK_DELAY = 4'b0000;
defparam syn__074_.OUT_DELAY = 1'b0;
defparam syn__074_.IN_DATA_DELAY = 3'b000;
defparam syn__074_.IN_REG_DELAY = 3'b000;

alta_rio syn__075_(
	.padio(bank2[4]),
	.datain(syn__016_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__075_.coord_x = 8;
defparam syn__075_.coord_y = 9;
defparam syn__075_.coord_z = 0;
defparam syn__075_.IN_ASYNC_MODE = 1'b0;
defparam syn__075_.IN_SYNC_MODE = 1'b0;
defparam syn__075_.IN_POWERUP = 1'b0;
defparam syn__075_.OUT_REG_MODE = 1'b0;
defparam syn__075_.OUT_ASYNC_MODE = 1'b0;
defparam syn__075_.OUT_SYNC_MODE = 1'b0;
defparam syn__075_.OUT_POWERUP = 1'b0;
defparam syn__075_.OE_REG_MODE = 1'b0;
defparam syn__075_.OE_ASYNC_MODE = 1'b0;
defparam syn__075_.OE_SYNC_MODE = 1'b0;
defparam syn__075_.OE_POWERUP = 1'b0;
defparam syn__075_.CFG_TRI_INPUT = 1'b0;
defparam syn__075_.CFG_PULL_UP = 1'b0;
defparam syn__075_.CFG_SLR = 1'b0;
defparam syn__075_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__075_.CFG_PDRCTRL = 4'b0010;
defparam syn__075_.CFG_KEEP = 2'b00;
defparam syn__075_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__075_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__075_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__075_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__075_.DPCLK_DELAY = 4'b0000;
defparam syn__075_.OUT_DELAY = 1'b0;
defparam syn__075_.IN_DATA_DELAY = 3'b000;
defparam syn__075_.IN_REG_DELAY = 3'b000;

alta_rio syn__076_(
	.padio(bank2[5]),
	.datain(syn__016_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__076_.coord_x = 11;
defparam syn__076_.coord_y = 9;
defparam syn__076_.coord_z = 1;
defparam syn__076_.IN_ASYNC_MODE = 1'b0;
defparam syn__076_.IN_SYNC_MODE = 1'b0;
defparam syn__076_.IN_POWERUP = 1'b0;
defparam syn__076_.OUT_REG_MODE = 1'b0;
defparam syn__076_.OUT_ASYNC_MODE = 1'b0;
defparam syn__076_.OUT_SYNC_MODE = 1'b0;
defparam syn__076_.OUT_POWERUP = 1'b0;
defparam syn__076_.OE_REG_MODE = 1'b0;
defparam syn__076_.OE_ASYNC_MODE = 1'b0;
defparam syn__076_.OE_SYNC_MODE = 1'b0;
defparam syn__076_.OE_POWERUP = 1'b0;
defparam syn__076_.CFG_TRI_INPUT = 1'b0;
defparam syn__076_.CFG_PULL_UP = 1'b0;
defparam syn__076_.CFG_SLR = 1'b0;
defparam syn__076_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__076_.CFG_PDRCTRL = 4'b0010;
defparam syn__076_.CFG_KEEP = 2'b00;
defparam syn__076_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__076_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__076_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__076_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__076_.DPCLK_DELAY = 4'b0000;
defparam syn__076_.OUT_DELAY = 1'b0;
defparam syn__076_.IN_DATA_DELAY = 3'b000;
defparam syn__076_.IN_REG_DELAY = 3'b000;

alta_rio syn__077_(
	.padio(bank2[6]),
	.datain(syn__016_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__077_.coord_x = 9;
defparam syn__077_.coord_y = 9;
defparam syn__077_.coord_z = 3;
defparam syn__077_.IN_ASYNC_MODE = 1'b0;
defparam syn__077_.IN_SYNC_MODE = 1'b0;
defparam syn__077_.IN_POWERUP = 1'b0;
defparam syn__077_.OUT_REG_MODE = 1'b0;
defparam syn__077_.OUT_ASYNC_MODE = 1'b0;
defparam syn__077_.OUT_SYNC_MODE = 1'b0;
defparam syn__077_.OUT_POWERUP = 1'b0;
defparam syn__077_.OE_REG_MODE = 1'b0;
defparam syn__077_.OE_ASYNC_MODE = 1'b0;
defparam syn__077_.OE_SYNC_MODE = 1'b0;
defparam syn__077_.OE_POWERUP = 1'b0;
defparam syn__077_.CFG_TRI_INPUT = 1'b0;
defparam syn__077_.CFG_PULL_UP = 1'b0;
defparam syn__077_.CFG_SLR = 1'b0;
defparam syn__077_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__077_.CFG_PDRCTRL = 4'b0010;
defparam syn__077_.CFG_KEEP = 2'b00;
defparam syn__077_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__077_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__077_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__077_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__077_.DPCLK_DELAY = 4'b0000;
defparam syn__077_.OUT_DELAY = 1'b0;
defparam syn__077_.IN_DATA_DELAY = 3'b000;
defparam syn__077_.IN_REG_DELAY = 3'b000;

alta_rio syn__078_(
	.padio(bank2[7]),
	.datain(syn__016_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__078_.coord_x = 9;
defparam syn__078_.coord_y = 9;
defparam syn__078_.coord_z = 1;
defparam syn__078_.IN_ASYNC_MODE = 1'b0;
defparam syn__078_.IN_SYNC_MODE = 1'b0;
defparam syn__078_.IN_POWERUP = 1'b0;
defparam syn__078_.OUT_REG_MODE = 1'b0;
defparam syn__078_.OUT_ASYNC_MODE = 1'b0;
defparam syn__078_.OUT_SYNC_MODE = 1'b0;
defparam syn__078_.OUT_POWERUP = 1'b0;
defparam syn__078_.OE_REG_MODE = 1'b0;
defparam syn__078_.OE_ASYNC_MODE = 1'b0;
defparam syn__078_.OE_SYNC_MODE = 1'b0;
defparam syn__078_.OE_POWERUP = 1'b0;
defparam syn__078_.CFG_TRI_INPUT = 1'b0;
defparam syn__078_.CFG_PULL_UP = 1'b0;
defparam syn__078_.CFG_SLR = 1'b0;
defparam syn__078_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__078_.CFG_PDRCTRL = 4'b0010;
defparam syn__078_.CFG_KEEP = 2'b00;
defparam syn__078_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__078_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__078_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__078_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__078_.DPCLK_DELAY = 4'b0000;
defparam syn__078_.OUT_DELAY = 1'b0;
defparam syn__078_.IN_DATA_DELAY = 3'b000;
defparam syn__078_.IN_REG_DELAY = 3'b000;

alta_rio syn__079_(
	.padio(bank3[0]),
	.datain(syn__017_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__079_.coord_x = 8;
defparam syn__079_.coord_y = 9;
defparam syn__079_.coord_z = 3;
defparam syn__079_.IN_ASYNC_MODE = 1'b0;
defparam syn__079_.IN_SYNC_MODE = 1'b0;
defparam syn__079_.IN_POWERUP = 1'b0;
defparam syn__079_.OUT_REG_MODE = 1'b0;
defparam syn__079_.OUT_ASYNC_MODE = 1'b0;
defparam syn__079_.OUT_SYNC_MODE = 1'b0;
defparam syn__079_.OUT_POWERUP = 1'b0;
defparam syn__079_.OE_REG_MODE = 1'b0;
defparam syn__079_.OE_ASYNC_MODE = 1'b0;
defparam syn__079_.OE_SYNC_MODE = 1'b0;
defparam syn__079_.OE_POWERUP = 1'b0;
defparam syn__079_.CFG_TRI_INPUT = 1'b0;
defparam syn__079_.CFG_PULL_UP = 1'b0;
defparam syn__079_.CFG_SLR = 1'b0;
defparam syn__079_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__079_.CFG_PDRCTRL = 4'b0010;
defparam syn__079_.CFG_KEEP = 2'b00;
defparam syn__079_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__079_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__079_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__079_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__079_.DPCLK_DELAY = 4'b0000;
defparam syn__079_.OUT_DELAY = 1'b0;
defparam syn__079_.IN_DATA_DELAY = 3'b000;
defparam syn__079_.IN_REG_DELAY = 3'b000;

alta_rio syn__080_(
	.padio(bank3[1]),
	.datain(syn__017_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__080_.coord_x = 7;
defparam syn__080_.coord_y = 9;
defparam syn__080_.coord_z = 3;
defparam syn__080_.IN_ASYNC_MODE = 1'b0;
defparam syn__080_.IN_SYNC_MODE = 1'b0;
defparam syn__080_.IN_POWERUP = 1'b0;
defparam syn__080_.OUT_REG_MODE = 1'b0;
defparam syn__080_.OUT_ASYNC_MODE = 1'b0;
defparam syn__080_.OUT_SYNC_MODE = 1'b0;
defparam syn__080_.OUT_POWERUP = 1'b0;
defparam syn__080_.OE_REG_MODE = 1'b0;
defparam syn__080_.OE_ASYNC_MODE = 1'b0;
defparam syn__080_.OE_SYNC_MODE = 1'b0;
defparam syn__080_.OE_POWERUP = 1'b0;
defparam syn__080_.CFG_TRI_INPUT = 1'b0;
defparam syn__080_.CFG_PULL_UP = 1'b0;
defparam syn__080_.CFG_SLR = 1'b0;
defparam syn__080_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__080_.CFG_PDRCTRL = 4'b0010;
defparam syn__080_.CFG_KEEP = 2'b00;
defparam syn__080_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__080_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__080_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__080_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__080_.DPCLK_DELAY = 4'b0000;
defparam syn__080_.OUT_DELAY = 1'b0;
defparam syn__080_.IN_DATA_DELAY = 3'b000;
defparam syn__080_.IN_REG_DELAY = 3'b000;

alta_rio syn__081_(
	.padio(bank3[2]),
	.datain(syn__017_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__081_.coord_x = 7;
defparam syn__081_.coord_y = 9;
defparam syn__081_.coord_z = 0;
defparam syn__081_.IN_ASYNC_MODE = 1'b0;
defparam syn__081_.IN_SYNC_MODE = 1'b0;
defparam syn__081_.IN_POWERUP = 1'b0;
defparam syn__081_.OUT_REG_MODE = 1'b0;
defparam syn__081_.OUT_ASYNC_MODE = 1'b0;
defparam syn__081_.OUT_SYNC_MODE = 1'b0;
defparam syn__081_.OUT_POWERUP = 1'b0;
defparam syn__081_.OE_REG_MODE = 1'b0;
defparam syn__081_.OE_ASYNC_MODE = 1'b0;
defparam syn__081_.OE_SYNC_MODE = 1'b0;
defparam syn__081_.OE_POWERUP = 1'b0;
defparam syn__081_.CFG_TRI_INPUT = 1'b0;
defparam syn__081_.CFG_PULL_UP = 1'b0;
defparam syn__081_.CFG_SLR = 1'b0;
defparam syn__081_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__081_.CFG_PDRCTRL = 4'b0010;
defparam syn__081_.CFG_KEEP = 2'b00;
defparam syn__081_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__081_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__081_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__081_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__081_.DPCLK_DELAY = 4'b0000;
defparam syn__081_.OUT_DELAY = 1'b0;
defparam syn__081_.IN_DATA_DELAY = 3'b000;
defparam syn__081_.IN_REG_DELAY = 3'b000;

alta_rio syn__082_(
	.padio(bank3[3]),
	.datain(syn__017_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__082_.coord_x = 6;
defparam syn__082_.coord_y = 9;
defparam syn__082_.coord_z = 0;
defparam syn__082_.IN_ASYNC_MODE = 1'b0;
defparam syn__082_.IN_SYNC_MODE = 1'b0;
defparam syn__082_.IN_POWERUP = 1'b0;
defparam syn__082_.OUT_REG_MODE = 1'b0;
defparam syn__082_.OUT_ASYNC_MODE = 1'b0;
defparam syn__082_.OUT_SYNC_MODE = 1'b0;
defparam syn__082_.OUT_POWERUP = 1'b0;
defparam syn__082_.OE_REG_MODE = 1'b0;
defparam syn__082_.OE_ASYNC_MODE = 1'b0;
defparam syn__082_.OE_SYNC_MODE = 1'b0;
defparam syn__082_.OE_POWERUP = 1'b0;
defparam syn__082_.CFG_TRI_INPUT = 1'b0;
defparam syn__082_.CFG_PULL_UP = 1'b0;
defparam syn__082_.CFG_SLR = 1'b0;
defparam syn__082_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__082_.CFG_PDRCTRL = 4'b0010;
defparam syn__082_.CFG_KEEP = 2'b00;
defparam syn__082_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__082_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__082_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__082_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__082_.DPCLK_DELAY = 4'b0000;
defparam syn__082_.OUT_DELAY = 1'b0;
defparam syn__082_.IN_DATA_DELAY = 3'b000;
defparam syn__082_.IN_REG_DELAY = 3'b000;

alta_rio syn__083_(
	.padio(bank3[4]),
	.datain(syn__017_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__083_.coord_x = 5;
defparam syn__083_.coord_y = 9;
defparam syn__083_.coord_z = 3;
defparam syn__083_.IN_ASYNC_MODE = 1'b0;
defparam syn__083_.IN_SYNC_MODE = 1'b0;
defparam syn__083_.IN_POWERUP = 1'b0;
defparam syn__083_.OUT_REG_MODE = 1'b0;
defparam syn__083_.OUT_ASYNC_MODE = 1'b0;
defparam syn__083_.OUT_SYNC_MODE = 1'b0;
defparam syn__083_.OUT_POWERUP = 1'b0;
defparam syn__083_.OE_REG_MODE = 1'b0;
defparam syn__083_.OE_ASYNC_MODE = 1'b0;
defparam syn__083_.OE_SYNC_MODE = 1'b0;
defparam syn__083_.OE_POWERUP = 1'b0;
defparam syn__083_.CFG_TRI_INPUT = 1'b0;
defparam syn__083_.CFG_PULL_UP = 1'b0;
defparam syn__083_.CFG_SLR = 1'b0;
defparam syn__083_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__083_.CFG_PDRCTRL = 4'b0010;
defparam syn__083_.CFG_KEEP = 2'b00;
defparam syn__083_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__083_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__083_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__083_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__083_.DPCLK_DELAY = 4'b0000;
defparam syn__083_.OUT_DELAY = 1'b0;
defparam syn__083_.IN_DATA_DELAY = 3'b000;
defparam syn__083_.IN_REG_DELAY = 3'b000;

alta_rio syn__084_(
	.padio(bank3[5]),
	.datain(syn__017_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__084_.coord_x = 5;
defparam syn__084_.coord_y = 9;
defparam syn__084_.coord_z = 2;
defparam syn__084_.IN_ASYNC_MODE = 1'b0;
defparam syn__084_.IN_SYNC_MODE = 1'b0;
defparam syn__084_.IN_POWERUP = 1'b0;
defparam syn__084_.OUT_REG_MODE = 1'b0;
defparam syn__084_.OUT_ASYNC_MODE = 1'b0;
defparam syn__084_.OUT_SYNC_MODE = 1'b0;
defparam syn__084_.OUT_POWERUP = 1'b0;
defparam syn__084_.OE_REG_MODE = 1'b0;
defparam syn__084_.OE_ASYNC_MODE = 1'b0;
defparam syn__084_.OE_SYNC_MODE = 1'b0;
defparam syn__084_.OE_POWERUP = 1'b0;
defparam syn__084_.CFG_TRI_INPUT = 1'b0;
defparam syn__084_.CFG_PULL_UP = 1'b0;
defparam syn__084_.CFG_SLR = 1'b0;
defparam syn__084_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__084_.CFG_PDRCTRL = 4'b0010;
defparam syn__084_.CFG_KEEP = 2'b00;
defparam syn__084_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__084_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__084_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__084_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__084_.DPCLK_DELAY = 4'b0000;
defparam syn__084_.OUT_DELAY = 1'b0;
defparam syn__084_.IN_DATA_DELAY = 3'b000;
defparam syn__084_.IN_REG_DELAY = 3'b000;

alta_rio syn__085_(
	.padio(bank3[6]),
	.datain(syn__017_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__085_.coord_x = 5;
defparam syn__085_.coord_y = 9;
defparam syn__085_.coord_z = 1;
defparam syn__085_.IN_ASYNC_MODE = 1'b0;
defparam syn__085_.IN_SYNC_MODE = 1'b0;
defparam syn__085_.IN_POWERUP = 1'b0;
defparam syn__085_.OUT_REG_MODE = 1'b0;
defparam syn__085_.OUT_ASYNC_MODE = 1'b0;
defparam syn__085_.OUT_SYNC_MODE = 1'b0;
defparam syn__085_.OUT_POWERUP = 1'b0;
defparam syn__085_.OE_REG_MODE = 1'b0;
defparam syn__085_.OE_ASYNC_MODE = 1'b0;
defparam syn__085_.OE_SYNC_MODE = 1'b0;
defparam syn__085_.OE_POWERUP = 1'b0;
defparam syn__085_.CFG_TRI_INPUT = 1'b0;
defparam syn__085_.CFG_PULL_UP = 1'b0;
defparam syn__085_.CFG_SLR = 1'b0;
defparam syn__085_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__085_.CFG_PDRCTRL = 4'b0010;
defparam syn__085_.CFG_KEEP = 2'b00;
defparam syn__085_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__085_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__085_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__085_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__085_.DPCLK_DELAY = 4'b0000;
defparam syn__085_.OUT_DELAY = 1'b0;
defparam syn__085_.IN_DATA_DELAY = 3'b000;
defparam syn__085_.IN_REG_DELAY = 3'b000;

alta_rio syn__086_(
	.padio(bank3[7]),
	.datain(syn__017_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__086_.coord_x = 5;
defparam syn__086_.coord_y = 9;
defparam syn__086_.coord_z = 0;
defparam syn__086_.IN_ASYNC_MODE = 1'b0;
defparam syn__086_.IN_SYNC_MODE = 1'b0;
defparam syn__086_.IN_POWERUP = 1'b0;
defparam syn__086_.OUT_REG_MODE = 1'b0;
defparam syn__086_.OUT_ASYNC_MODE = 1'b0;
defparam syn__086_.OUT_SYNC_MODE = 1'b0;
defparam syn__086_.OUT_POWERUP = 1'b0;
defparam syn__086_.OE_REG_MODE = 1'b0;
defparam syn__086_.OE_ASYNC_MODE = 1'b0;
defparam syn__086_.OE_SYNC_MODE = 1'b0;
defparam syn__086_.OE_POWERUP = 1'b0;
defparam syn__086_.CFG_TRI_INPUT = 1'b0;
defparam syn__086_.CFG_PULL_UP = 1'b0;
defparam syn__086_.CFG_SLR = 1'b0;
defparam syn__086_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__086_.CFG_PDRCTRL = 4'b0010;
defparam syn__086_.CFG_KEEP = 2'b00;
defparam syn__086_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__086_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__086_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__086_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__086_.DPCLK_DELAY = 4'b0000;
defparam syn__086_.OUT_DELAY = 1'b0;
defparam syn__086_.IN_DATA_DELAY = 3'b000;
defparam syn__086_.IN_REG_DELAY = 3'b000;

alta_rio syn__087_(
	.padio(clk),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(syn__018_),
	.regout());
defparam syn__087_.coord_x = 4;
defparam syn__087_.coord_y = 9;
defparam syn__087_.coord_z = 0;
defparam syn__087_.IN_ASYNC_MODE = 1'b0;
defparam syn__087_.IN_SYNC_MODE = 1'b0;
defparam syn__087_.IN_POWERUP = 1'b0;
defparam syn__087_.OUT_REG_MODE = 1'b0;
defparam syn__087_.OUT_ASYNC_MODE = 1'b0;
defparam syn__087_.OUT_SYNC_MODE = 1'b0;
defparam syn__087_.OUT_POWERUP = 1'b0;
defparam syn__087_.OE_REG_MODE = 1'b0;
defparam syn__087_.OE_ASYNC_MODE = 1'b0;
defparam syn__087_.OE_SYNC_MODE = 1'b0;
defparam syn__087_.OE_POWERUP = 1'b0;
defparam syn__087_.CFG_TRI_INPUT = 1'b0;
defparam syn__087_.CFG_PULL_UP = 1'b0;
defparam syn__087_.CFG_SLR = 1'b0;
defparam syn__087_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__087_.CFG_PDRCTRL = 4'b0010;
defparam syn__087_.CFG_KEEP = 2'b00;
defparam syn__087_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__087_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__087_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__087_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__087_.DPCLK_DELAY = 4'b0000;
defparam syn__087_.OUT_DELAY = 1'b0;
defparam syn__087_.IN_DATA_DELAY = 3'b000;
defparam syn__087_.IN_REG_DELAY = 3'b000;

alta_slice syn__088_(
	.A(syn__008_),
	.B(counter[8]),
	.C(vcc),
	.D(counter[7]),
	.Cin(),
	.Qin(counter[9]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[9]),
	.Cout(),
	.Q(counter[9]));
defparam syn__088_.coord_x = 1;
defparam syn__088_.coord_y = 6;
defparam syn__088_.coord_z = 8;
defparam syn__088_.mask = 16'h78F0;
defparam syn__088_.modeMux = 1'b0;
defparam syn__088_.FeedbackMux = 1'b1;
defparam syn__088_.ShiftMux = 1'b0;
defparam syn__088_.BypassEn = 1'b0;
defparam syn__088_.CarryEnb = 1'b1;

alta_slice syn__089_(
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(syn__009_),
	.Cin(),
	.Qin(counter[10]),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[10]),
	.Cout(),
	.Q(counter[10]));
defparam syn__089_.coord_x = 2;
defparam syn__089_.coord_y = 6;
defparam syn__089_.coord_z = 1;
defparam syn__089_.mask = 16'h0FF0;
defparam syn__089_.modeMux = 1'b0;
defparam syn__089_.FeedbackMux = 1'b1;
defparam syn__089_.ShiftMux = 1'b0;
defparam syn__089_.BypassEn = 1'b0;
defparam syn__089_.CarryEnb = 1'b1;

alta_slice syn__090_(
	.A(vcc),
	.B(counter[10]),
	.C(vcc),
	.D(syn__009_),
	.Cin(),
	.Qin(counter[11]),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[11]),
	.Cout(),
	.Q(counter[11]));
defparam syn__090_.coord_x = 2;
defparam syn__090_.coord_y = 6;
defparam syn__090_.coord_z = 7;
defparam syn__090_.mask = 16'h3CF0;
defparam syn__090_.modeMux = 1'b0;
defparam syn__090_.FeedbackMux = 1'b1;
defparam syn__090_.ShiftMux = 1'b0;
defparam syn__090_.BypassEn = 1'b0;
defparam syn__090_.CarryEnb = 1'b1;

alta_slice syn__091_(
	.A(syn__009_),
	.B(counter[10]),
	.C(vcc),
	.D(counter[11]),
	.Cin(),
	.Qin(counter[12]),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[12]),
	.Cout(),
	.Q(counter[12]));
defparam syn__091_.coord_x = 2;
defparam syn__091_.coord_y = 6;
defparam syn__091_.coord_z = 4;
defparam syn__091_.mask = 16'h78F0;
defparam syn__091_.modeMux = 1'b0;
defparam syn__091_.FeedbackMux = 1'b1;
defparam syn__091_.ShiftMux = 1'b0;
defparam syn__091_.BypassEn = 1'b0;
defparam syn__091_.CarryEnb = 1'b1;

alta_slice syn__092_(
	.A(syn__010_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[13]),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[13]),
	.Cout(),
	.Q(counter[13]));
defparam syn__092_.coord_x = 2;
defparam syn__092_.coord_y = 6;
defparam syn__092_.coord_z = 2;
defparam syn__092_.mask = 16'h5A5A;
defparam syn__092_.modeMux = 1'b0;
defparam syn__092_.FeedbackMux = 1'b1;
defparam syn__092_.ShiftMux = 1'b0;
defparam syn__092_.BypassEn = 1'b0;
defparam syn__092_.CarryEnb = 1'b1;

alta_slice syn__093_(
	.A(syn__010_),
	.B(vcc),
	.C(vcc),
	.D(counter[13]),
	.Cin(),
	.Qin(counter[14]),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[14]),
	.Cout(),
	.Q(counter[14]));
defparam syn__093_.coord_x = 2;
defparam syn__093_.coord_y = 6;
defparam syn__093_.coord_z = 3;
defparam syn__093_.mask = 16'h5AF0;
defparam syn__093_.modeMux = 1'b0;
defparam syn__093_.FeedbackMux = 1'b1;
defparam syn__093_.ShiftMux = 1'b0;
defparam syn__093_.BypassEn = 1'b0;
defparam syn__093_.CarryEnb = 1'b1;

alta_slice syn__094_(
	.A(vcc),
	.B(syn__003_),
	.C(syn__006_),
	.D(syn__005_),
	.Cin(),
	.Qin(\prom.clka ),
	.Clk(syn__018__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__002_),
	.Cout(),
	.Q(\prom.clka ));
defparam syn__094_.coord_x = 2;
defparam syn__094_.coord_y = 6;
defparam syn__094_.coord_z = 5;
defparam syn__094_.mask = 16'hC000;
defparam syn__094_.modeMux = 1'b0;
defparam syn__094_.FeedbackMux = 1'b0;
defparam syn__094_.ShiftMux = 1'b0;
defparam syn__094_.BypassEn = 1'b0;
defparam syn__094_.CarryEnb = 1'b1;

alta_slice syn__095_(
	.A(),
	.B(),
	.C(vcc),
	.D(),
	.Cin(),
	.Qin(addr[0]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\addr[0]_inv ),
	.Cout(),
	.Q(addr[0]));
defparam syn__095_.coord_x = 2;
defparam syn__095_.coord_y = 7;
defparam syn__095_.coord_z = 10;
defparam syn__095_.mask = 16'h0F0F;
defparam syn__095_.modeMux = 1'b0;
defparam syn__095_.FeedbackMux = 1'b1;
defparam syn__095_.ShiftMux = 1'b0;
defparam syn__095_.BypassEn = 1'b0;
defparam syn__095_.CarryEnb = 1'b1;

alta_slice syn__096_(
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(addr[0]),
	.Cin(),
	.Qin(addr[1]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[1]),
	.Cout(),
	.Q(addr[1]));
defparam syn__096_.coord_x = 2;
defparam syn__096_.coord_y = 7;
defparam syn__096_.coord_z = 11;
defparam syn__096_.mask = 16'h0FF0;
defparam syn__096_.modeMux = 1'b0;
defparam syn__096_.FeedbackMux = 1'b1;
defparam syn__096_.ShiftMux = 1'b0;
defparam syn__096_.BypassEn = 1'b0;
defparam syn__096_.CarryEnb = 1'b1;

alta_slice syn__097_(
	.A(addr[0]),
	.B(vcc),
	.C(vcc),
	.D(addr[1]),
	.Cin(),
	.Qin(addr[2]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[2]),
	.Cout(),
	.Q(addr[2]));
defparam syn__097_.coord_x = 2;
defparam syn__097_.coord_y = 7;
defparam syn__097_.coord_z = 5;
defparam syn__097_.mask = 16'h5AF0;
defparam syn__097_.modeMux = 1'b0;
defparam syn__097_.FeedbackMux = 1'b1;
defparam syn__097_.ShiftMux = 1'b0;
defparam syn__097_.BypassEn = 1'b0;
defparam syn__097_.CarryEnb = 1'b1;

alta_slice syn__098_(
	.A(addr[0]),
	.B(addr[2]),
	.C(vcc),
	.D(addr[1]),
	.Cin(),
	.Qin(addr[3]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[3]),
	.Cout(),
	.Q(addr[3]));
defparam syn__098_.coord_x = 2;
defparam syn__098_.coord_y = 7;
defparam syn__098_.coord_z = 7;
defparam syn__098_.mask = 16'h78F0;
defparam syn__098_.modeMux = 1'b0;
defparam syn__098_.FeedbackMux = 1'b1;
defparam syn__098_.ShiftMux = 1'b0;
defparam syn__098_.BypassEn = 1'b0;
defparam syn__098_.CarryEnb = 1'b1;

alta_slice syn__099_(
	.A(syn__011_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(addr[4]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[4]),
	.Cout(),
	.Q(addr[4]));
defparam syn__099_.coord_x = 2;
defparam syn__099_.coord_y = 7;
defparam syn__099_.coord_z = 9;
defparam syn__099_.mask = 16'h5A5A;
defparam syn__099_.modeMux = 1'b0;
defparam syn__099_.FeedbackMux = 1'b1;
defparam syn__099_.ShiftMux = 1'b0;
defparam syn__099_.BypassEn = 1'b0;
defparam syn__099_.CarryEnb = 1'b1;

alta_slice syn__100_(
	.A(syn__011_),
	.B(vcc),
	.C(vcc),
	.D(addr[4]),
	.Cin(),
	.Qin(addr[5]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[5]),
	.Cout(),
	.Q(addr[5]));
defparam syn__100_.coord_x = 2;
defparam syn__100_.coord_y = 7;
defparam syn__100_.coord_z = 12;
defparam syn__100_.mask = 16'h5AF0;
defparam syn__100_.modeMux = 1'b0;
defparam syn__100_.FeedbackMux = 1'b1;
defparam syn__100_.ShiftMux = 1'b0;
defparam syn__100_.BypassEn = 1'b0;
defparam syn__100_.CarryEnb = 1'b1;

alta_slice syn__101_(
	.A(syn__011_),
	.B(addr[5]),
	.C(vcc),
	.D(addr[4]),
	.Cin(),
	.Qin(addr[6]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[6]),
	.Cout(),
	.Q(addr[6]));
defparam syn__101_.coord_x = 2;
defparam syn__101_.coord_y = 7;
defparam syn__101_.coord_z = 13;
defparam syn__101_.mask = 16'h78F0;
defparam syn__101_.modeMux = 1'b0;
defparam syn__101_.FeedbackMux = 1'b1;
defparam syn__101_.ShiftMux = 1'b0;
defparam syn__101_.BypassEn = 1'b0;
defparam syn__101_.CarryEnb = 1'b1;

alta_slice syn__102_(
	.A(syn__012_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(addr[7]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[7]),
	.Cout(),
	.Q(addr[7]));
defparam syn__102_.coord_x = 2;
defparam syn__102_.coord_y = 7;
defparam syn__102_.coord_z = 15;
defparam syn__102_.mask = 16'h5A5A;
defparam syn__102_.modeMux = 1'b0;
defparam syn__102_.FeedbackMux = 1'b1;
defparam syn__102_.ShiftMux = 1'b0;
defparam syn__102_.BypassEn = 1'b0;
defparam syn__102_.CarryEnb = 1'b1;

alta_slice syn__103_(
	.A(syn__012_),
	.B(vcc),
	.C(vcc),
	.D(addr[7]),
	.Cin(),
	.Qin(addr[8]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[8]),
	.Cout(),
	.Q(addr[8]));
defparam syn__103_.coord_x = 2;
defparam syn__103_.coord_y = 7;
defparam syn__103_.coord_z = 2;
defparam syn__103_.mask = 16'h5AF0;
defparam syn__103_.modeMux = 1'b0;
defparam syn__103_.FeedbackMux = 1'b1;
defparam syn__103_.ShiftMux = 1'b0;
defparam syn__103_.BypassEn = 1'b0;
defparam syn__103_.CarryEnb = 1'b1;

alta_slice syn__104_(
	.A(syn__012_),
	.B(addr[8]),
	.C(vcc),
	.D(addr[7]),
	.Cin(),
	.Qin(addr[9]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[9]),
	.Cout(),
	.Q(addr[9]));
defparam syn__104_.coord_x = 2;
defparam syn__104_.coord_y = 7;
defparam syn__104_.coord_z = 3;
defparam syn__104_.mask = 16'h78F0;
defparam syn__104_.modeMux = 1'b0;
defparam syn__104_.FeedbackMux = 1'b1;
defparam syn__104_.ShiftMux = 1'b0;
defparam syn__104_.BypassEn = 1'b0;
defparam syn__104_.CarryEnb = 1'b1;

alta_slice syn__105_(
	.A(syn__013_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(addr[10]),
	.Clk(\prom.clka_X1011_Y1001_SIG_VCC ),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[10]),
	.Cout(),
	.Q(addr[10]));
defparam syn__105_.coord_x = 2;
defparam syn__105_.coord_y = 7;
defparam syn__105_.coord_z = 6;
defparam syn__105_.mask = 16'h5A5A;
defparam syn__105_.modeMux = 1'b0;
defparam syn__105_.FeedbackMux = 1'b1;
defparam syn__105_.ShiftMux = 1'b0;
defparam syn__105_.BypassEn = 1'b0;
defparam syn__105_.CarryEnb = 1'b1;

alta_slice syn__106_(
	.A(),
	.B(),
	.C(vcc),
	.D(),
	.Cin(),
	.Qin(counter[0]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\counter[0]_inv ),
	.Cout(),
	.Q(counter[0]));
defparam syn__106_.coord_x = 1;
defparam syn__106_.coord_y = 6;
defparam syn__106_.coord_z = 2;
defparam syn__106_.mask = 16'h0F0F;
defparam syn__106_.modeMux = 1'b0;
defparam syn__106_.FeedbackMux = 1'b1;
defparam syn__106_.ShiftMux = 1'b0;
defparam syn__106_.BypassEn = 1'b0;
defparam syn__106_.CarryEnb = 1'b1;

alta_slice syn__107_(
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(counter[0]),
	.Cin(),
	.Qin(counter[1]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[1]),
	.Cout(),
	.Q(counter[1]));
defparam syn__107_.coord_x = 1;
defparam syn__107_.coord_y = 6;
defparam syn__107_.coord_z = 3;
defparam syn__107_.mask = 16'h0FF0;
defparam syn__107_.modeMux = 1'b0;
defparam syn__107_.FeedbackMux = 1'b1;
defparam syn__107_.ShiftMux = 1'b0;
defparam syn__107_.BypassEn = 1'b0;
defparam syn__107_.CarryEnb = 1'b1;

alta_slice syn__108_(
	.A(counter[0]),
	.B(vcc),
	.C(vcc),
	.D(counter[1]),
	.Cin(),
	.Qin(counter[2]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[2]),
	.Cout(),
	.Q(counter[2]));
defparam syn__108_.coord_x = 1;
defparam syn__108_.coord_y = 6;
defparam syn__108_.coord_z = 10;
defparam syn__108_.mask = 16'h5AF0;
defparam syn__108_.modeMux = 1'b0;
defparam syn__108_.FeedbackMux = 1'b1;
defparam syn__108_.ShiftMux = 1'b0;
defparam syn__108_.BypassEn = 1'b0;
defparam syn__108_.CarryEnb = 1'b1;

alta_slice syn__109_(
	.A(counter[0]),
	.B(counter[2]),
	.C(vcc),
	.D(counter[1]),
	.Cin(),
	.Qin(counter[3]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[3]),
	.Cout(),
	.Q(counter[3]));
defparam syn__109_.coord_x = 1;
defparam syn__109_.coord_y = 6;
defparam syn__109_.coord_z = 11;
defparam syn__109_.mask = 16'h78F0;
defparam syn__109_.modeMux = 1'b0;
defparam syn__109_.FeedbackMux = 1'b1;
defparam syn__109_.ShiftMux = 1'b0;
defparam syn__109_.BypassEn = 1'b0;
defparam syn__109_.CarryEnb = 1'b1;

alta_slice syn__110_(
	.A(syn__007_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[4]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[4]),
	.Cout(),
	.Q(counter[4]));
defparam syn__110_.coord_x = 1;
defparam syn__110_.coord_y = 6;
defparam syn__110_.coord_z = 1;
defparam syn__110_.mask = 16'h5A5A;
defparam syn__110_.modeMux = 1'b0;
defparam syn__110_.FeedbackMux = 1'b1;
defparam syn__110_.ShiftMux = 1'b0;
defparam syn__110_.BypassEn = 1'b0;
defparam syn__110_.CarryEnb = 1'b1;

alta_slice syn__111_(
	.A(syn__007_),
	.B(vcc),
	.C(vcc),
	.D(counter[4]),
	.Cin(),
	.Qin(counter[5]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[5]),
	.Cout(),
	.Q(counter[5]));
defparam syn__111_.coord_x = 1;
defparam syn__111_.coord_y = 6;
defparam syn__111_.coord_z = 7;
defparam syn__111_.mask = 16'h5AF0;
defparam syn__111_.modeMux = 1'b0;
defparam syn__111_.FeedbackMux = 1'b1;
defparam syn__111_.ShiftMux = 1'b0;
defparam syn__111_.BypassEn = 1'b0;
defparam syn__111_.CarryEnb = 1'b1;

alta_slice syn__112_(
	.A(syn__007_),
	.B(counter[5]),
	.C(vcc),
	.D(counter[4]),
	.Cin(),
	.Qin(counter[6]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[6]),
	.Cout(),
	.Q(counter[6]));
defparam syn__112_.coord_x = 1;
defparam syn__112_.coord_y = 6;
defparam syn__112_.coord_z = 12;
defparam syn__112_.mask = 16'h78F0;
defparam syn__112_.modeMux = 1'b0;
defparam syn__112_.FeedbackMux = 1'b1;
defparam syn__112_.ShiftMux = 1'b0;
defparam syn__112_.BypassEn = 1'b0;
defparam syn__112_.CarryEnb = 1'b1;

alta_slice syn__113_(
	.A(syn__008_),
	.B(vcc),
	.C(vcc),
	.D(vcc),
	.Cin(),
	.Qin(counter[7]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[7]),
	.Cout(),
	.Q(counter[7]));
defparam syn__113_.coord_x = 1;
defparam syn__113_.coord_y = 6;
defparam syn__113_.coord_z = 13;
defparam syn__113_.mask = 16'h5A5A;
defparam syn__113_.modeMux = 1'b0;
defparam syn__113_.FeedbackMux = 1'b1;
defparam syn__113_.ShiftMux = 1'b0;
defparam syn__113_.BypassEn = 1'b0;
defparam syn__113_.CarryEnb = 1'b1;

alta_slice syn__114_(
	.A(syn__008_),
	.B(vcc),
	.C(vcc),
	.D(counter[7]),
	.Cin(),
	.Qin(counter[8]),
	.Clk(syn__018__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_[8]),
	.Cout(),
	.Q(counter[8]));
defparam syn__114_.coord_x = 1;
defparam syn__114_.coord_y = 6;
defparam syn__114_.coord_z = 15;
defparam syn__114_.mask = 16'h5AF0;
defparam syn__114_.modeMux = 1'b0;
defparam syn__114_.FeedbackMux = 1'b1;
defparam syn__114_.ShiftMux = 1'b0;
defparam syn__114_.BypassEn = 1'b0;
defparam syn__114_.CarryEnb = 1'b1;

endmodule
