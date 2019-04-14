`timescale 1 ps/ 1 ps

module Top(
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
wire	[31:0] IOaddr;
//wire	IOaddr[0];
//wire	IOaddr[10];
//wire	IOaddr[11];
//wire	IOaddr[12];
//wire	IOaddr[13];
//wire	IOaddr[14];
//wire	IOaddr[15];
//wire	IOaddr[16];
//wire	IOaddr[17];
//wire	IOaddr[18];
//wire	IOaddr[19];
//wire	IOaddr[1];
//wire	IOaddr[20];
//wire	IOaddr[21];
//wire	IOaddr[22];
//wire	IOaddr[23];
//wire	IOaddr[24];
//wire	IOaddr[25];
//wire	IOaddr[26];
//wire	IOaddr[27];
//wire	IOaddr[28];
//wire	IOaddr[29];
//wire	IOaddr[2];
//wire	IOaddr[30];
//wire	IOaddr[31];
//wire	IOaddr[3];
//wire	IOaddr[4];
//wire	IOaddr[5];
//wire	IOaddr[6];
//wire	IOaddr[7];
//wire	IOaddr[8];
//wire	IOaddr[9];
wire	[31:0] IOvalue;
//wire	IOvalue[0];
//wire	IOvalue[10];
//wire	IOvalue[11];
//wire	IOvalue[12];
//wire	IOvalue[13];
//wire	IOvalue[14];
//wire	IOvalue[15];
//wire	IOvalue[16];
//wire	IOvalue[17];
//wire	IOvalue[18];
//wire	IOvalue[19];
//wire	IOvalue[1];
//wire	IOvalue[20];
//wire	IOvalue[21];
//wire	IOvalue[22];
//wire	IOvalue[23];
//wire	IOvalue[24];
//wire	IOvalue[25];
//wire	IOvalue[26];
//wire	IOvalue[27];
//wire	IOvalue[28];
//wire	IOvalue[29];
//wire	IOvalue[2];
//wire	IOvalue[30];
//wire	IOvalue[31];
//wire	IOvalue[3];
//wire	IOvalue[4];
//wire	IOvalue[5];
//wire	IOvalue[6];
//wire	IOvalue[7];
//wire	IOvalue[8];
//wire	IOvalue[9];
wire	[7:0] syn__000_;
//wire	syn__000_[0];
//wire	syn__000_[1];
//wire	syn__000_[2];
//wire	syn__000_[3];
//wire	syn__000_[4];
//wire	syn__000_[5];
//wire	syn__000_[6];
//wire	syn__000_[7];
wire	syn__001_;
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
wire	syn__014_;
wire	syn__015_;
wire	syn__016_;
wire	syn__017_;
wire	syn__018_;
wire	syn__019_;
wire	syn__020_;
wire	syn__021_;
wire	syn__022_;
wire	syn__023_;
wire	syn__024_;
wire	syn__025_;
wire	syn__026_;
wire	syn__027_;
wire	syn__028_;
wire	syn__029_;
wire	syn__030_;
wire	syn__031_;
wire	syn__032_;
wire	syn__033_;
wire	syn__034_;
wire	syn__035_;
wire	syn__036_;
wire	syn__037_;
wire	syn__038_;
wire	syn__039_;
wire	syn__040_;
wire	syn__041_;
wire	syn__042_;
wire	syn__043_;
wire	syn__044_;
wire	syn__045_;
wire	syn__046_;
wire	syn__047_;
wire	syn__048_;
wire	syn__049_;
wire	syn__050_;
wire	syn__051_;
wire	syn__052_;
wire	syn__053_;
wire	syn__054_;
wire	syn__055_;
wire	syn__056_;
wire	syn__057_;
wire	syn__058_;
wire	syn__059_;
wire	syn__060_;
wire	syn__061_;
wire	syn__062_;
wire	syn__063_;
wire	syn__064_;
wire	syn__065_;
wire	syn__066_;
wire	syn__067_;
wire	syn__068_;
wire	syn__069_;
wire	syn__070_;
wire	syn__071_;
wire	syn__072_;
wire	syn__073_;
wire	syn__074_;
wire	syn__075_;
wire	syn__076_;
wire	syn__077_;
wire	syn__078_;
wire	syn__079_;
wire	syn__080_;
wire	syn__081_;
wire	syn__082_;
wire	syn__083_;
wire	syn__084_;
wire	syn__085_;
wire	syn__086_;
wire	syn__087_;
wire	syn__088_;
wire	syn__089_;
wire	syn__090_;
wire	syn__091_;
wire	syn__092_;
wire	syn__093_;
wire	syn__094_;
wire	syn__095_;
wire	syn__096_;
wire	syn__097_;
wire	syn__098_;
wire	syn__099_;
wire	syn__100_;
wire	syn__101_;
wire	syn__102_;
wire	syn__103_;
wire	syn__104_;
wire	syn__105_;
wire	syn__106_;
wire	syn__107_;
wire	syn__108_;
wire	syn__109_;
wire	syn__110_;
wire	syn__111_;
wire	syn__112_;
wire	syn__113_;
wire	syn__114_;
wire	syn__115_;
wire	syn__116_;
wire	syn__117_;
wire	syn__118_;
wire	syn__119_;
wire	syn__120_;
wire	syn__121_;
wire	syn__122_;
wire	syn__123_;
wire	syn__124_;
wire	syn__125_;
wire	syn__126_;
wire	syn__127_;
wire	syn__128_;
wire	syn__129_;
wire	syn__130_;
wire	syn__131_;
wire	syn__132_;
wire	syn__133_;
wire	syn__134_;
wire	syn__135_;
wire	syn__136_;
wire	syn__137_;
wire	syn__138_;
wire	syn__139_;
wire	syn__140_;
wire	syn__141_;
wire	syn__142_;
wire	syn__143_;
wire	syn__144_;
wire	syn__145_;
wire	syn__146_;
wire	syn__147_;
wire	syn__148_;
wire	syn__149_;
wire	syn__150_;
wire	syn__151_;
wire	syn__152_;
wire	syn__153_;
wire	syn__154_;
wire	syn__155_;
wire	syn__156_;
wire	syn__157_;
wire	syn__158_;
wire	syn__159_;
wire	syn__160_;
wire	syn__161_;
wire	syn__162_;
wire	syn__163_;
wire	syn__164_;
wire	syn__165_;
wire	syn__166_;
wire	syn__167_;
wire	syn__168_;
wire	syn__169_;
wire	syn__170_;
wire	syn__171_;
wire	syn__172_;
wire	syn__173_;
wire	syn__174_;
wire	syn__175_;
wire	syn__176_;
wire	syn__177_;
wire	syn__178_;
wire	syn__179_;
wire	syn__180_;
wire	syn__181_;
wire	syn__182_;
wire	syn__183_;
wire	syn__184_;
wire	syn__185_;
wire	syn__186_;
wire	syn__187_;
wire	syn__188_;
wire	syn__189_;
wire	syn__190_;
wire	syn__191_;
wire	syn__192_;
wire	syn__193_;
wire	syn__194_;
wire	syn__195_;
wire	syn__196_;
wire	syn__197_;
wire	syn__198_;
wire	syn__199_;
wire	syn__200_;
wire	syn__201_;
wire	syn__202_;
wire	syn__203_;
wire	syn__204_;
wire	syn__205_;
wire	syn__206_;
wire	syn__207_;
wire	syn__208_;
wire	syn__209_;
wire	syn__210_;
wire	syn__211_;
wire	syn__212_;
wire	syn__213_;
wire	syn__214_;
wire	syn__215_;
wire	syn__216_;
wire	syn__217_;
wire	syn__218_;
wire	syn__219_;
wire	syn__220_;
wire	syn__221_;
wire	syn__222_;
wire	syn__223_;
wire	syn__224_;
wire	syn__225_;
wire	syn__226_;
wire	syn__227_;
wire	syn__228_;
wire	syn__229_;
wire	syn__230_;
wire	syn__231_;
wire	syn__232_;
wire	syn__233_;
wire	syn__234_;
wire	syn__235_;
wire	syn__236_;
wire	syn__237_;
wire	syn__238_;
wire	syn__239_;
wire	syn__240_;
wire	syn__241_;
wire	syn__242_;
wire	syn__243_;
wire	syn__244_;
wire	syn__245_;
wire	syn__246_;
wire	syn__247_;
wire	syn__248_;
wire	syn__249_;
wire	syn__250_;
wire	syn__251_;
wire	syn__252_;
wire	syn__253_;
wire	syn__254_;
wire	syn__255_;
wire	syn__256_;
wire	syn__257_;
wire	syn__258_;
wire	syn__259_;
wire	syn__260_;
wire	syn__261_;
wire	syn__262_;
wire	syn__263_;
wire	syn__264_;
wire	syn__265_;
wire	syn__266_;
wire	syn__267_;
wire	syn__268_;
wire	syn__269_;
wire	syn__270_;
wire	syn__271_;
wire	syn__272_;
wire	syn__273_;
wire	syn__274_;
wire	syn__275_;
wire	syn__276_;
wire	syn__277_;
wire	syn__278_;
wire	syn__279_;
wire	syn__280_;
wire	syn__281_;
wire	syn__282_;
wire	syn__283_;
wire	syn__284_;
wire	syn__285_;
wire	syn__286_;
wire	syn__287_;
wire	syn__288_;
wire	syn__289_;
wire	syn__290_;
wire	syn__291_;
wire	syn__292_;
wire	syn__293_;
wire	syn__294_;
wire	syn__295_;
wire	syn__296_;
wire	syn__297_;
wire	syn__298_;
wire	syn__299_;
wire	syn__300_;
wire	syn__301_;
wire	syn__302_;
wire	syn__303_;
wire	syn__304_;
wire	syn__305_;
wire	syn__306_;
wire	syn__307_;
wire	syn__308_;
wire	syn__309_;
wire	syn__310_;
wire	syn__311_;
wire	syn__312_;
wire	syn__313_;
wire	syn__314_;
wire	syn__315_;
wire	syn__316_;
wire	syn__317_;
wire	syn__318_;
wire	syn__319_;
wire	syn__320_;
wire	syn__321_;
wire	syn__322_;
wire	syn__323_;
wire	syn__324_;
wire	syn__325_;
wire	syn__326_;
wire	syn__327_;
wire	syn__328_;
wire	syn__329_;
wire	syn__330_;
wire	syn__331_;
wire	syn__332_;
wire	syn__333_;
wire	syn__334_;
wire	syn__335_;
wire	syn__336_;
wire	syn__337_;
wire	syn__338_;
wire	syn__339_;
wire	syn__340_;
wire	syn__341_;
wire	syn__342_;
wire	syn__343_;
wire	syn__344_;
wire	syn__345_;
wire	syn__346_;
wire	syn__347_;
wire	syn__348_;
wire	syn__349_;
wire	syn__350_;
wire	syn__351_;
wire	syn__352_;
wire	syn__353_;
wire	syn__354_;
wire	syn__355_;
wire	syn__356_;
wire	syn__357_;
wire	syn__358_;
wire	syn__359_;
wire	syn__360_;
wire	syn__361_;
wire	syn__362_;
wire	[7:0] syn__363_;
//wire	syn__363_[0];
//wire	syn__363_[1];
//wire	syn__363_[2];
//wire	syn__363_[3];
//wire	syn__363_[4];
//wire	syn__363_[5];
//wire	syn__363_[6];
//wire	syn__363_[7];
wire	syn__364_;
wire	syn__364__X1009_Y1001_SIG_VCC;
wire	syn__364__X1011_Y1001_SIG_VCC;
wire	syn__364__X1012_Y1001_SIG_VCC;
wire	[31:0] \tc.DM ;
//wire	\tc.DM [0];
//wire	\tc.DM [10];
//wire	\tc.DM [11];
//wire	\tc.DM [12];
//wire	\tc.DM [13];
//wire	\tc.DM [14];
//wire	\tc.DM [15];
//wire	\tc.DM [16];
//wire	\tc.DM [17];
//wire	\tc.DM [18];
//wire	\tc.DM [19];
//wire	\tc.DM [1];
//wire	\tc.DM [20];
//wire	\tc.DM [21];
//wire	\tc.DM [22];
//wire	\tc.DM [23];
//wire	\tc.DM [24];
//wire	\tc.DM [25];
//wire	\tc.DM [26];
//wire	\tc.DM [27];
//wire	\tc.DM [28];
//wire	\tc.DM [29];
//wire	\tc.DM [2];
//wire	\tc.DM [30];
//wire	\tc.DM [31];
//wire	\tc.DM [3];
//wire	\tc.DM [4];
//wire	\tc.DM [5];
//wire	\tc.DM [6];
//wire	\tc.DM [7];
//wire	\tc.DM [8];
//wire	\tc.DM [9];
wire	[31:0] \tc.IM ;
//wire	\tc.IM [0];
//wire	\tc.IM [10];
//wire	\tc.IM [11];
//wire	\tc.IM [12];
//wire	\tc.IM [13];
//wire	\tc.IM [14];
//wire	\tc.IM [15];
//wire	\tc.IM [16];
//wire	\tc.IM [17];
//wire	\tc.IM [18];
//wire	\tc.IM [19];
//wire	\tc.IM [1];
//wire	\tc.IM [20];
//wire	\tc.IM [21];
//wire	\tc.IM [22];
//wire	\tc.IM [23];
//wire	\tc.IM [24];
//wire	\tc.IM [25];
//wire	\tc.IM [26];
//wire	\tc.IM [27];
//wire	\tc.IM [28];
//wire	\tc.IM [29];
//wire	\tc.IM [2];
//wire	\tc.IM [30];
//wire	\tc.IM [31];
//wire	\tc.IM [3];
//wire	\tc.IM [4];
//wire	\tc.IM [5];
//wire	\tc.IM [6];
//wire	\tc.IM [7];
//wire	\tc.IM [8];
//wire	\tc.IM [9];
wire	[6:0] \tc.PC ;
//wire	\tc.PC [0];
//wire	\tc.PC [1];
//wire	\tc.PC [2];
//wire	\tc.PC [3];
//wire	\tc.PC [4];
//wire	\tc.PC [5];
//wire	\tc.PC [6];
wire	[6:0] \tc.PCmux ;
//wire	\tc.PCmux [0];
//wire	\tc.PCmux [1];
//wire	\tc.PCmux [2];
//wire	\tc.PCmux [3];
//wire	\tc.PCmux [4];
//wire	\tc.PCmux [5];
//wire	\tc.PCmux [6];
wire	[31:0] \tc.WD ;
//wire	\tc.WD [0];
//wire	\tc.WD [10];
//wire	\tc.WD [11];
//wire	\tc.WD [12];
//wire	\tc.WD [13];
//wire	\tc.WD [14];
//wire	\tc.WD [15];
//wire	\tc.WD [16];
//wire	\tc.WD [17];
//wire	\tc.WD [18];
//wire	\tc.WD [19];
//wire	\tc.WD [1];
//wire	\tc.WD [20];
//wire	\tc.WD [21];
//wire	\tc.WD [22];
//wire	\tc.WD [23];
//wire	\tc.WD [24];
//wire	\tc.WD [25];
//wire	\tc.WD [26];
//wire	\tc.WD [27];
//wire	\tc.WD [28];
//wire	\tc.WD [29];
//wire	\tc.WD [2];
//wire	\tc.WD [30];
//wire	\tc.WD [31];
//wire	\tc.WD [3];
//wire	\tc.WD [4];
//wire	\tc.WD [5];
//wire	\tc.WD [6];
//wire	\tc.WD [7];
//wire	\tc.WD [8];
//wire	\tc.WD [9];
wire	\tc.WriteDM ;
wire	\tc.WriteIM ;
wire	[31:0] \tc.dm.douta ;
//wire	\tc.dm.douta [0];
//wire	\tc.dm.douta [10];
//wire	\tc.dm.douta [11];
//wire	\tc.dm.douta [12];
//wire	\tc.dm.douta [13];
//wire	\tc.dm.douta [14];
//wire	\tc.dm.douta [15];
//wire	\tc.dm.douta [16];
//wire	\tc.dm.douta [17];
//wire	\tc.dm.douta [18];
//wire	\tc.dm.douta [19];
//wire	\tc.dm.douta [1];
//wire	\tc.dm.douta [20];
//wire	\tc.dm.douta [21];
//wire	\tc.dm.douta [22];
//wire	\tc.dm.douta [23];
//wire	\tc.dm.douta [24];
//wire	\tc.dm.douta [25];
//wire	\tc.dm.douta [26];
//wire	\tc.dm.douta [27];
//wire	\tc.dm.douta [28];
//wire	\tc.dm.douta [29];
//wire	\tc.dm.douta [2];
//wire	\tc.dm.douta [30];
//wire	\tc.dm.douta [31];
//wire	\tc.dm.douta [3];
//wire	\tc.dm.douta [4];
//wire	\tc.dm.douta [5];
//wire	\tc.dm.douta [6];
//wire	\tc.dm.douta [7];
//wire	\tc.dm.douta [8];
//wire	\tc.dm.douta [9];
wire	[31:0] \tc.im.douta ;
//wire	\tc.im.douta [0];
//wire	\tc.im.douta [10];
//wire	\tc.im.douta [11];
//wire	\tc.im.douta [12];
//wire	\tc.im.douta [13];
//wire	\tc.im.douta [14];
//wire	\tc.im.douta [15];
//wire	\tc.im.douta [16];
//wire	\tc.im.douta [17];
//wire	\tc.im.douta [18];
//wire	\tc.im.douta [19];
//wire	\tc.im.douta [1];
//wire	\tc.im.douta [20];
//wire	\tc.im.douta [21];
//wire	\tc.im.douta [22];
//wire	\tc.im.douta [23];
//wire	\tc.im.douta [24];
//wire	\tc.im.douta [25];
//wire	\tc.im.douta [26];
//wire	\tc.im.douta [27];
//wire	\tc.im.douta [28];
//wire	\tc.im.douta [29];
//wire	\tc.im.douta [2];
//wire	\tc.im.douta [30];
//wire	\tc.im.douta [31];
//wire	\tc.im.douta [3];
//wire	\tc.im.douta [4];
//wire	\tc.im.douta [5];
//wire	\tc.im.douta [6];
//wire	\tc.im.douta [7];
//wire	\tc.im.douta [8];
//wire	\tc.im.douta [9];
wire	[31:0] \tc.rfA.douta ;
//wire	\tc.rfA.douta [0];
//wire	\tc.rfA.douta [10];
//wire	\tc.rfA.douta [11];
//wire	\tc.rfA.douta [12];
//wire	\tc.rfA.douta [13];
//wire	\tc.rfA.douta [14];
//wire	\tc.rfA.douta [15];
//wire	\tc.rfA.douta [16];
//wire	\tc.rfA.douta [17];
//wire	\tc.rfA.douta [18];
//wire	\tc.rfA.douta [19];
//wire	\tc.rfA.douta [1];
//wire	\tc.rfA.douta [20];
//wire	\tc.rfA.douta [21];
//wire	\tc.rfA.douta [22];
//wire	\tc.rfA.douta [23];
//wire	\tc.rfA.douta [24];
//wire	\tc.rfA.douta [25];
//wire	\tc.rfA.douta [26];
//wire	\tc.rfA.douta [27];
//wire	\tc.rfA.douta [28];
//wire	\tc.rfA.douta [29];
//wire	\tc.rfA.douta [2];
//wire	\tc.rfA.douta [30];
//wire	\tc.rfA.douta [31];
//wire	\tc.rfA.douta [3];
//wire	\tc.rfA.douta [4];
//wire	\tc.rfA.douta [5];
//wire	\tc.rfA.douta [6];
//wire	\tc.rfA.douta [7];
//wire	\tc.rfA.douta [8];
//wire	\tc.rfA.douta [9];
wire	[31:0] \tc.rfB.douta ;
//wire	\tc.rfB.douta [0];
//wire	\tc.rfB.douta [10];
//wire	\tc.rfB.douta [11];
//wire	\tc.rfB.douta [12];
//wire	\tc.rfB.douta [13];
//wire	\tc.rfB.douta [14];
//wire	\tc.rfB.douta [15];
//wire	\tc.rfB.douta [16];
//wire	\tc.rfB.douta [17];
//wire	\tc.rfB.douta [18];
//wire	\tc.rfB.douta [19];
//wire	\tc.rfB.douta [1];
//wire	\tc.rfB.douta [20];
//wire	\tc.rfB.douta [21];
//wire	\tc.rfB.douta [22];
//wire	\tc.rfB.douta [23];
//wire	\tc.rfB.douta [24];
//wire	\tc.rfB.douta [25];
//wire	\tc.rfB.douta [26];
//wire	\tc.rfB.douta [27];
//wire	\tc.rfB.douta [28];
//wire	\tc.rfB.douta [29];
//wire	\tc.rfB.douta [2];
//wire	\tc.rfB.douta [30];
//wire	\tc.rfB.douta [31];
//wire	\tc.rfB.douta [3];
//wire	\tc.rfB.douta [4];
//wire	\tc.rfB.douta [5];
//wire	\tc.rfB.douta [6];
//wire	\tc.rfB.douta [7];
//wire	\tc.rfB.douta [8];
//wire	\tc.rfB.douta [9];

assign vcc = 1'b1;
assign gnd = 1'b0;

alta_asyncctrl asyncreset_ctrl_X1009_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1009_Y1001_GND));
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_x = 4;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_y = 8;
defparam asyncreset_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam asyncreset_ctrl_X1009_Y1001_N0.AsyncCtrlMux = 2'b00;

alta_asyncctrl asyncreset_ctrl_X1011_Y1001_N0(
	.Din(),
	.Dout(AsyncReset_X1011_Y1001_GND));
defparam asyncreset_ctrl_X1011_Y1001_N0.coord_x = 1;
defparam asyncreset_ctrl_X1011_Y1001_N0.coord_y = 6;
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
	.ClkIn(syn__364_),
	.ClkEn(),
	.ClkOut(syn__364__X1009_Y1001_SIG_VCC));
defparam clken_ctrl_X1009_Y1001_N0.coord_x = 4;
defparam clken_ctrl_X1009_Y1001_N0.coord_y = 8;
defparam clken_ctrl_X1009_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1009_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1009_Y1001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X1011_Y1001_N0(
	.ClkIn(syn__364_),
	.ClkEn(),
	.ClkOut(syn__364__X1011_Y1001_SIG_VCC));
defparam clken_ctrl_X1011_Y1001_N0.coord_x = 1;
defparam clken_ctrl_X1011_Y1001_N0.coord_y = 6;
defparam clken_ctrl_X1011_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1011_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1011_Y1001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X1012_Y1001_N0(
	.ClkIn(syn__364_),
	.ClkEn(),
	.ClkOut(syn__364__X1012_Y1001_SIG_VCC));
defparam clken_ctrl_X1012_Y1001_N0.coord_x = 2;
defparam clken_ctrl_X1012_Y1001_N0.coord_y = 6;
defparam clken_ctrl_X1012_Y1001_N0.coord_z = 0;
defparam clken_ctrl_X1012_Y1001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X1012_Y1001_N0.ClkEnMux = 2'b01;

alta_slice syn__366_(
	.A(syn__012_),
	.B(syn__002_),
	.C(syn__013_),
	.D(syn__011_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__001_),
	.Cout(),
	.Q());
defparam syn__366_.coord_x = 4;
defparam syn__366_.coord_y = 8;
defparam syn__366_.coord_z = 8;
defparam syn__366_.mask = 16'h8000;
defparam syn__366_.modeMux = 1'b0;
defparam syn__366_.FeedbackMux = 1'b0;
defparam syn__366_.ShiftMux = 1'b0;
defparam syn__366_.BypassEn = 1'b0;
defparam syn__366_.CarryEnb = 1'b1;

alta_slice syn__367_(
	.A(syn__003_),
	.B(syn__006_),
	.C(syn__009_),
	.D(syn__010_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__002_),
	.Cout(),
	.Q());
defparam syn__367_.coord_x = 8;
defparam syn__367_.coord_y = 7;
defparam syn__367_.coord_z = 12;
defparam syn__367_.mask = 16'h8000;
defparam syn__367_.modeMux = 1'b0;
defparam syn__367_.FeedbackMux = 1'b0;
defparam syn__367_.ShiftMux = 1'b0;
defparam syn__367_.BypassEn = 1'b0;
defparam syn__367_.CarryEnb = 1'b1;

alta_slice syn__368_(
	.A(syn__004_),
	.B(IOaddr[10]),
	.C(IOaddr[11]),
	.D(syn__005_),
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
defparam syn__368_.coord_x = 7;
defparam syn__368_.coord_y = 8;
defparam syn__368_.coord_z = 12;
defparam syn__368_.mask = 16'h0200;
defparam syn__368_.modeMux = 1'b0;
defparam syn__368_.FeedbackMux = 1'b0;
defparam syn__368_.ShiftMux = 1'b0;
defparam syn__368_.BypassEn = 1'b0;
defparam syn__368_.CarryEnb = 1'b1;

alta_slice syn__369_(
	.A(IOaddr[13]),
	.B(IOaddr[12]),
	.C(IOaddr[15]),
	.D(IOaddr[14]),
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
defparam syn__369_.coord_x = 6;
defparam syn__369_.coord_y = 7;
defparam syn__369_.coord_z = 1;
defparam syn__369_.mask = 16'h0001;
defparam syn__369_.modeMux = 1'b0;
defparam syn__369_.FeedbackMux = 1'b0;
defparam syn__369_.ShiftMux = 1'b0;
defparam syn__369_.BypassEn = 1'b0;
defparam syn__369_.CarryEnb = 1'b1;

alta_slice syn__370_(
	.A(vcc),
	.B(\tc.IM [24]),
	.C(\tc.IM [2]),
	.D(vcc),
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
defparam syn__370_.coord_x = 4;
defparam syn__370_.coord_y = 7;
defparam syn__370_.coord_z = 8;
defparam syn__370_.mask = 16'h0303;
defparam syn__370_.modeMux = 1'b0;
defparam syn__370_.FeedbackMux = 1'b0;
defparam syn__370_.ShiftMux = 1'b0;
defparam syn__370_.BypassEn = 1'b0;
defparam syn__370_.CarryEnb = 1'b1;

alta_slice syn__371_(
	.A(syn__007_),
	.B(vcc),
	.C(syn__008_),
	.D(vcc),
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
defparam syn__371_.coord_x = 8;
defparam syn__371_.coord_y = 7;
defparam syn__371_.coord_z = 5;
defparam syn__371_.mask = 16'hA0A0;
defparam syn__371_.modeMux = 1'b0;
defparam syn__371_.FeedbackMux = 1'b0;
defparam syn__371_.ShiftMux = 1'b0;
defparam syn__371_.BypassEn = 1'b0;
defparam syn__371_.CarryEnb = 1'b1;

alta_slice syn__372_(
	.A(IOaddr[19]),
	.B(IOaddr[18]),
	.C(IOaddr[17]),
	.D(IOaddr[16]),
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
defparam syn__372_.coord_x = 8;
defparam syn__372_.coord_y = 7;
defparam syn__372_.coord_z = 6;
defparam syn__372_.mask = 16'h0001;
defparam syn__372_.modeMux = 1'b0;
defparam syn__372_.FeedbackMux = 1'b0;
defparam syn__372_.ShiftMux = 1'b0;
defparam syn__372_.BypassEn = 1'b0;
defparam syn__372_.CarryEnb = 1'b1;

alta_slice syn__373_(
	.A(IOaddr[20]),
	.B(IOaddr[21]),
	.C(IOaddr[22]),
	.D(IOaddr[23]),
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
defparam syn__373_.coord_x = 8;
defparam syn__373_.coord_y = 7;
defparam syn__373_.coord_z = 0;
defparam syn__373_.mask = 16'h0001;
defparam syn__373_.modeMux = 1'b0;
defparam syn__373_.FeedbackMux = 1'b0;
defparam syn__373_.ShiftMux = 1'b0;
defparam syn__373_.BypassEn = 1'b0;
defparam syn__373_.CarryEnb = 1'b1;

alta_slice syn__374_(
	.A(IOaddr[28]),
	.B(IOaddr[29]),
	.C(IOaddr[30]),
	.D(IOaddr[31]),
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
defparam syn__374_.coord_x = 8;
defparam syn__374_.coord_y = 7;
defparam syn__374_.coord_z = 2;
defparam syn__374_.mask = 16'h0001;
defparam syn__374_.modeMux = 1'b0;
defparam syn__374_.FeedbackMux = 1'b0;
defparam syn__374_.ShiftMux = 1'b0;
defparam syn__374_.BypassEn = 1'b0;
defparam syn__374_.CarryEnb = 1'b1;

alta_slice syn__375_(
	.A(IOaddr[24]),
	.B(IOaddr[25]),
	.C(IOaddr[26]),
	.D(IOaddr[27]),
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
defparam syn__375_.coord_x = 8;
defparam syn__375_.coord_y = 7;
defparam syn__375_.coord_z = 1;
defparam syn__375_.mask = 16'h0001;
defparam syn__375_.modeMux = 1'b0;
defparam syn__375_.FeedbackMux = 1'b0;
defparam syn__375_.ShiftMux = 1'b0;
defparam syn__375_.BypassEn = 1'b0;
defparam syn__375_.CarryEnb = 1'b1;

alta_slice syn__376_(
	.A(IOaddr[7]),
	.B(IOaddr[9]),
	.C(IOaddr[8]),
	.D(IOaddr[6]),
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
defparam syn__376_.coord_x = 4;
defparam syn__376_.coord_y = 8;
defparam syn__376_.coord_z = 9;
defparam syn__376_.mask = 16'h8000;
defparam syn__376_.modeMux = 1'b0;
defparam syn__376_.FeedbackMux = 1'b0;
defparam syn__376_.ShiftMux = 1'b0;
defparam syn__376_.BypassEn = 1'b0;
defparam syn__376_.CarryEnb = 1'b1;

alta_slice syn__377_(
	.A(IOaddr[3]),
	.B(IOaddr[4]),
	.C(IOaddr[5]),
	.D(IOaddr[2]),
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
defparam syn__377_.coord_x = 4;
defparam syn__377_.coord_y = 8;
defparam syn__377_.coord_z = 12;
defparam syn__377_.mask = 16'h8000;
defparam syn__377_.modeMux = 1'b0;
defparam syn__377_.FeedbackMux = 1'b0;
defparam syn__377_.ShiftMux = 1'b0;
defparam syn__377_.BypassEn = 1'b0;
defparam syn__377_.CarryEnb = 1'b1;

alta_slice syn__378_(
	.A(\tc.IM [0]),
	.B(\tc.IM [1]),
	.C(IOaddr[1]),
	.D(IOaddr[0]),
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
defparam syn__378_.coord_x = 4;
defparam syn__378_.coord_y = 7;
defparam syn__378_.coord_z = 15;
defparam syn__378_.mask = 16'h8000;
defparam syn__378_.modeMux = 1'b0;
defparam syn__378_.FeedbackMux = 1'b0;
defparam syn__378_.ShiftMux = 1'b0;
defparam syn__378_.BypassEn = 1'b0;
defparam syn__378_.CarryEnb = 1'b1;

alta_slice syn__387_(
	.A(syn__015_),
	.B(syn__253_),
	.C(syn__243_),
	.D(\tc.IM [3]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__014_),
	.Cout(),
	.Q());
defparam syn__387_.coord_x = 7;
defparam syn__387_.coord_y = 3;
defparam syn__387_.coord_z = 3;
defparam syn__387_.mask = 16'hCC80;
defparam syn__387_.modeMux = 1'b0;
defparam syn__387_.FeedbackMux = 1'b0;
defparam syn__387_.ShiftMux = 1'b0;
defparam syn__387_.BypassEn = 1'b0;
defparam syn__387_.CarryEnb = 1'b1;

alta_slice syn__388_(
	.A(syn__127_),
	.B(syn__236_),
	.C(syn__016_),
	.D(syn__116_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__015_),
	.Cout(),
	.Q());
defparam syn__388_.coord_x = 6;
defparam syn__388_.coord_y = 3;
defparam syn__388_.coord_z = 10;
defparam syn__388_.mask = 16'h8000;
defparam syn__388_.modeMux = 1'b0;
defparam syn__388_.FeedbackMux = 1'b0;
defparam syn__388_.ShiftMux = 1'b0;
defparam syn__388_.BypassEn = 1'b0;
defparam syn__388_.CarryEnb = 1'b1;

alta_slice syn__389_(
	.A(syn__017_),
	.B(syn__109_),
	.C(syn__104_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__016_),
	.Cout(),
	.Q());
defparam syn__389_.coord_x = 7;
defparam syn__389_.coord_y = 6;
defparam syn__389_.coord_z = 12;
defparam syn__389_.mask = 16'h080C;
defparam syn__389_.modeMux = 1'b0;
defparam syn__389_.FeedbackMux = 1'b0;
defparam syn__389_.ShiftMux = 1'b0;
defparam syn__389_.BypassEn = 1'b0;
defparam syn__389_.CarryEnb = 1'b1;

alta_slice syn__390_(
	.A(syn__018_),
	.B(syn__099_),
	.C(syn__103_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__017_),
	.Cout(),
	.Q());
defparam syn__390_.coord_x = 5;
defparam syn__390_.coord_y = 6;
defparam syn__390_.coord_z = 13;
defparam syn__390_.mask = 16'hCC84;
defparam syn__390_.modeMux = 1'b0;
defparam syn__390_.FeedbackMux = 1'b0;
defparam syn__390_.ShiftMux = 1'b0;
defparam syn__390_.BypassEn = 1'b0;
defparam syn__390_.CarryEnb = 1'b1;

alta_slice syn__391_(
	.A(syn__019_),
	.B(syn__096_),
	.C(syn__097_),
	.D(syn__098_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__018_),
	.Cout(),
	.Q());
defparam syn__391_.coord_x = 5;
defparam syn__391_.coord_y = 6;
defparam syn__391_.coord_z = 14;
defparam syn__391_.mask = 16'h0313;
defparam syn__391_.modeMux = 1'b0;
defparam syn__391_.FeedbackMux = 1'b0;
defparam syn__391_.ShiftMux = 1'b0;
defparam syn__391_.BypassEn = 1'b0;
defparam syn__391_.CarryEnb = 1'b1;

alta_slice syn__392_(
	.A(syn__094_),
	.B(syn__093_),
	.C(syn__020_),
	.D(syn__095_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__019_),
	.Cout(),
	.Q());
defparam syn__392_.coord_x = 5;
defparam syn__392_.coord_y = 6;
defparam syn__392_.coord_z = 2;
defparam syn__392_.mask = 16'h0113;
defparam syn__392_.modeMux = 1'b0;
defparam syn__392_.FeedbackMux = 1'b0;
defparam syn__392_.ShiftMux = 1'b0;
defparam syn__392_.BypassEn = 1'b0;
defparam syn__392_.CarryEnb = 1'b1;

alta_slice syn__393_(
	.A(syn__090_),
	.B(syn__091_),
	.C(syn__021_),
	.D(syn__092_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__020_),
	.Cout(),
	.Q());
defparam syn__393_.coord_x = 5;
defparam syn__393_.coord_y = 6;
defparam syn__393_.coord_z = 4;
defparam syn__393_.mask = 16'h1115;
defparam syn__393_.modeMux = 1'b0;
defparam syn__393_.FeedbackMux = 1'b0;
defparam syn__393_.ShiftMux = 1'b0;
defparam syn__393_.BypassEn = 1'b0;
defparam syn__393_.CarryEnb = 1'b1;

alta_slice syn__394_(
	.A(syn__087_),
	.B(syn__089_),
	.C(syn__022_),
	.D(syn__088_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__021_),
	.Cout(),
	.Q());
defparam syn__394_.coord_x = 5;
defparam syn__394_.coord_y = 4;
defparam syn__394_.coord_z = 2;
defparam syn__394_.mask = 16'h022A;
defparam syn__394_.modeMux = 1'b0;
defparam syn__394_.FeedbackMux = 1'b0;
defparam syn__394_.ShiftMux = 1'b0;
defparam syn__394_.BypassEn = 1'b0;
defparam syn__394_.CarryEnb = 1'b1;

alta_slice syn__395_(
	.A(syn__084_),
	.B(syn__085_),
	.C(syn__023_),
	.D(syn__086_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__022_),
	.Cout(),
	.Q());
defparam syn__395_.coord_x = 5;
defparam syn__395_.coord_y = 5;
defparam syn__395_.coord_z = 0;
defparam syn__395_.mask = 16'h5551;
defparam syn__395_.modeMux = 1'b0;
defparam syn__395_.FeedbackMux = 1'b0;
defparam syn__395_.ShiftMux = 1'b0;
defparam syn__395_.BypassEn = 1'b0;
defparam syn__395_.CarryEnb = 1'b1;

alta_slice syn__396_(
	.A(syn__024_),
	.B(syn__081_),
	.C(syn__083_),
	.D(syn__082_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__023_),
	.Cout(),
	.Q());
defparam syn__396_.coord_x = 5;
defparam syn__396_.coord_y = 5;
defparam syn__396_.coord_z = 10;
defparam syn__396_.mask = 16'h3220;
defparam syn__396_.modeMux = 1'b0;
defparam syn__396_.FeedbackMux = 1'b0;
defparam syn__396_.ShiftMux = 1'b0;
defparam syn__396_.BypassEn = 1'b0;
defparam syn__396_.CarryEnb = 1'b1;

alta_slice syn__397_(
	.A(syn__080_),
	.B(syn__079_),
	.C(syn__025_),
	.D(syn__078_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__024_),
	.Cout(),
	.Q());
defparam syn__397_.coord_x = 5;
defparam syn__397_.coord_y = 5;
defparam syn__397_.coord_z = 6;
defparam syn__397_.mask = 16'hCD04;
defparam syn__397_.modeMux = 1'b0;
defparam syn__397_.FeedbackMux = 1'b0;
defparam syn__397_.ShiftMux = 1'b0;
defparam syn__397_.BypassEn = 1'b0;
defparam syn__397_.CarryEnb = 1'b1;

alta_slice syn__398_(
	.A(syn__075_),
	.B(syn__026_),
	.C(syn__076_),
	.D(syn__077_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__025_),
	.Cout(),
	.Q());
defparam syn__398_.coord_x = 8;
defparam syn__398_.coord_y = 5;
defparam syn__398_.coord_z = 6;
defparam syn__398_.mask = 16'hA0A2;
defparam syn__398_.modeMux = 1'b0;
defparam syn__398_.FeedbackMux = 1'b0;
defparam syn__398_.ShiftMux = 1'b0;
defparam syn__398_.BypassEn = 1'b0;
defparam syn__398_.CarryEnb = 1'b1;

alta_slice syn__399_(
	.A(syn__073_),
	.B(syn__072_),
	.C(syn__027_),
	.D(syn__074_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__026_),
	.Cout(),
	.Q());
defparam syn__399_.coord_x = 8;
defparam syn__399_.coord_y = 5;
defparam syn__399_.coord_z = 7;
defparam syn__399_.mask = 16'h3331;
defparam syn__399_.modeMux = 1'b0;
defparam syn__399_.FeedbackMux = 1'b0;
defparam syn__399_.ShiftMux = 1'b0;
defparam syn__399_.BypassEn = 1'b0;
defparam syn__399_.CarryEnb = 1'b1;

alta_slice syn__400_(
	.A(syn__028_),
	.B(syn__071_),
	.C(syn__070_),
	.D(syn__069_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__027_),
	.Cout(),
	.Q());
defparam syn__400_.coord_x = 8;
defparam syn__400_.coord_y = 7;
defparam syn__400_.coord_z = 10;
defparam syn__400_.mask = 16'h3220;
defparam syn__400_.modeMux = 1'b0;
defparam syn__400_.FeedbackMux = 1'b0;
defparam syn__400_.ShiftMux = 1'b0;
defparam syn__400_.BypassEn = 1'b0;
defparam syn__400_.CarryEnb = 1'b1;

alta_slice syn__401_(
	.A(syn__029_),
	.B(syn__067_),
	.C(syn__066_),
	.D(syn__068_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__028_),
	.Cout(),
	.Q());
defparam syn__401_.coord_x = 6;
defparam syn__401_.coord_y = 7;
defparam syn__401_.coord_z = 13;
defparam syn__401_.mask = 16'hC0D4;
defparam syn__401_.modeMux = 1'b0;
defparam syn__401_.FeedbackMux = 1'b0;
defparam syn__401_.ShiftMux = 1'b0;
defparam syn__401_.BypassEn = 1'b0;
defparam syn__401_.CarryEnb = 1'b1;

alta_slice syn__402_(
	.A(syn__030_),
	.B(syn__063_),
	.C(syn__064_),
	.D(syn__065_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__029_),
	.Cout(),
	.Q());
defparam syn__402_.coord_x = 6;
defparam syn__402_.coord_y = 7;
defparam syn__402_.coord_z = 12;
defparam syn__402_.mask = 16'hC0C4;
defparam syn__402_.modeMux = 1'b0;
defparam syn__402_.FeedbackMux = 1'b0;
defparam syn__402_.ShiftMux = 1'b0;
defparam syn__402_.BypassEn = 1'b0;
defparam syn__402_.CarryEnb = 1'b1;

alta_slice syn__403_(
	.A(syn__031_),
	.B(syn__062_),
	.C(syn__061_),
	.D(syn__060_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__030_),
	.Cout(),
	.Q());
defparam syn__403_.coord_x = 7;
defparam syn__403_.coord_y = 8;
defparam syn__403_.coord_z = 13;
defparam syn__403_.mask = 16'h001F;
defparam syn__403_.modeMux = 1'b0;
defparam syn__403_.FeedbackMux = 1'b0;
defparam syn__403_.ShiftMux = 1'b0;
defparam syn__403_.BypassEn = 1'b0;
defparam syn__403_.CarryEnb = 1'b1;

alta_slice syn__404_(
	.A(syn__032_),
	.B(syn__057_),
	.C(syn__059_),
	.D(syn__058_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__031_),
	.Cout(),
	.Q());
defparam syn__404_.coord_x = 7;
defparam syn__404_.coord_y = 8;
defparam syn__404_.coord_z = 6;
defparam syn__404_.mask = 16'h0113;
defparam syn__404_.modeMux = 1'b0;
defparam syn__404_.FeedbackMux = 1'b0;
defparam syn__404_.ShiftMux = 1'b0;
defparam syn__404_.BypassEn = 1'b0;
defparam syn__404_.CarryEnb = 1'b1;

alta_slice syn__405_(
	.A(syn__054_),
	.B(syn__033_),
	.C(syn__056_),
	.D(syn__055_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__032_),
	.Cout(),
	.Q());
defparam syn__405_.coord_x = 7;
defparam syn__405_.coord_y = 8;
defparam syn__405_.coord_z = 2;
defparam syn__405_.mask = 16'h0515;
defparam syn__405_.modeMux = 1'b0;
defparam syn__405_.FeedbackMux = 1'b0;
defparam syn__405_.ShiftMux = 1'b0;
defparam syn__405_.BypassEn = 1'b0;
defparam syn__405_.CarryEnb = 1'b1;

alta_slice syn__406_(
	.A(syn__051_),
	.B(syn__053_),
	.C(syn__052_),
	.D(syn__034_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__033_),
	.Cout(),
	.Q());
defparam syn__406_.coord_x = 6;
defparam syn__406_.coord_y = 8;
defparam syn__406_.coord_z = 4;
defparam syn__406_.mask = 16'hA0A2;
defparam syn__406_.modeMux = 1'b0;
defparam syn__406_.FeedbackMux = 1'b0;
defparam syn__406_.ShiftMux = 1'b0;
defparam syn__406_.BypassEn = 1'b0;
defparam syn__406_.CarryEnb = 1'b1;

alta_slice syn__407_(
	.A(syn__049_),
	.B(syn__048_),
	.C(syn__035_),
	.D(syn__050_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__034_),
	.Cout(),
	.Q());
defparam syn__407_.coord_x = 5;
defparam syn__407_.coord_y = 8;
defparam syn__407_.coord_z = 11;
defparam syn__407_.mask = 16'h1113;
defparam syn__407_.modeMux = 1'b0;
defparam syn__407_.FeedbackMux = 1'b0;
defparam syn__407_.ShiftMux = 1'b0;
defparam syn__407_.BypassEn = 1'b0;
defparam syn__407_.CarryEnb = 1'b1;

alta_slice syn__408_(
	.A(syn__036_),
	.B(syn__045_),
	.C(syn__047_),
	.D(syn__046_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__035_),
	.Cout(),
	.Q());
defparam syn__408_.coord_x = 5;
defparam syn__408_.coord_y = 8;
defparam syn__408_.coord_z = 4;
defparam syn__408_.mask = 16'h0113;
defparam syn__408_.modeMux = 1'b0;
defparam syn__408_.FeedbackMux = 1'b0;
defparam syn__408_.ShiftMux = 1'b0;
defparam syn__408_.BypassEn = 1'b0;
defparam syn__408_.CarryEnb = 1'b1;

alta_slice syn__409_(
	.A(syn__042_),
	.B(syn__043_),
	.C(syn__037_),
	.D(syn__044_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__036_),
	.Cout(),
	.Q());
defparam syn__409_.coord_x = 5;
defparam syn__409_.coord_y = 8;
defparam syn__409_.coord_z = 0;
defparam syn__409_.mask = 16'h888E;
defparam syn__409_.modeMux = 1'b0;
defparam syn__409_.FeedbackMux = 1'b0;
defparam syn__409_.ShiftMux = 1'b0;
defparam syn__409_.BypassEn = 1'b0;
defparam syn__409_.CarryEnb = 1'b1;

alta_slice syn__410_(
	.A(syn__041_),
	.B(syn__039_),
	.C(syn__038_),
	.D(syn__040_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__037_),
	.Cout(),
	.Q());
defparam syn__410_.coord_x = 5;
defparam syn__410_.coord_y = 7;
defparam syn__410_.coord_z = 14;
defparam syn__410_.mask = 16'h2A02;
defparam syn__410_.modeMux = 1'b0;
defparam syn__410_.FeedbackMux = 1'b0;
defparam syn__410_.ShiftMux = 1'b0;
defparam syn__410_.BypassEn = 1'b0;
defparam syn__410_.CarryEnb = 1'b1;

alta_slice syn__411_(
	.A(vcc),
	.B(IOaddr[1]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__038_),
	.Cout(),
	.Q());
defparam syn__411_.coord_x = 5;
defparam syn__411_.coord_y = 7;
defparam syn__411_.coord_z = 2;
defparam syn__411_.mask = 16'h0FC3;
defparam syn__411_.modeMux = 1'b0;
defparam syn__411_.FeedbackMux = 1'b0;
defparam syn__411_.ShiftMux = 1'b0;
defparam syn__411_.BypassEn = 1'b0;
defparam syn__411_.CarryEnb = 1'b1;

alta_slice syn__412_(
	.A(vcc),
	.B(IOaddr[1]),
	.C(IOvalue[1]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__039_),
	.Cout(),
	.Q());
defparam syn__412_.coord_x = 5;
defparam syn__412_.coord_y = 7;
defparam syn__412_.coord_z = 11;
defparam syn__412_.mask = 16'h330F;
defparam syn__412_.modeMux = 1'b0;
defparam syn__412_.FeedbackMux = 1'b0;
defparam syn__412_.ShiftMux = 1'b0;
defparam syn__412_.BypassEn = 1'b0;
defparam syn__412_.CarryEnb = 1'b1;

alta_slice syn__413_(
	.A(\tc.IM [7]),
	.B(IOaddr[0]),
	.C(IOvalue[0]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__040_),
	.Cout(),
	.Q());
defparam syn__413_.coord_x = 5;
defparam syn__413_.coord_y = 7;
defparam syn__413_.coord_z = 9;
defparam syn__413_.mask = 16'hCC60;
defparam syn__413_.modeMux = 1'b0;
defparam syn__413_.FeedbackMux = 1'b0;
defparam syn__413_.ShiftMux = 1'b0;
defparam syn__413_.BypassEn = 1'b0;
defparam syn__413_.CarryEnb = 1'b1;

alta_slice syn__414_(
	.A(\tc.IM [8]),
	.B(IOvalue[2]),
	.C(\tc.IM [7]),
	.D(IOaddr[2]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__041_),
	.Cout(),
	.Q());
defparam syn__414_.coord_x = 4;
defparam syn__414_.coord_y = 7;
defparam syn__414_.coord_z = 1;
defparam syn__414_.mask = 16'h4BB4;
defparam syn__414_.modeMux = 1'b0;
defparam syn__414_.FeedbackMux = 1'b0;
defparam syn__414_.ShiftMux = 1'b0;
defparam syn__414_.BypassEn = 1'b0;
defparam syn__414_.CarryEnb = 1'b1;

alta_slice syn__415_(
	.A(vcc),
	.B(IOaddr[3]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__042_),
	.Cout(),
	.Q());
defparam syn__415_.coord_x = 5;
defparam syn__415_.coord_y = 8;
defparam syn__415_.coord_z = 8;
defparam syn__415_.mask = 16'h0FC3;
defparam syn__415_.modeMux = 1'b0;
defparam syn__415_.FeedbackMux = 1'b0;
defparam syn__415_.ShiftMux = 1'b0;
defparam syn__415_.BypassEn = 1'b0;
defparam syn__415_.CarryEnb = 1'b1;

alta_slice syn__416_(
	.A(IOvalue[3]),
	.B(vcc),
	.C(IOaddr[3]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__043_),
	.Cout(),
	.Q());
defparam syn__416_.coord_x = 4;
defparam syn__416_.coord_y = 8;
defparam syn__416_.coord_z = 11;
defparam syn__416_.mask = 16'h0F55;
defparam syn__416_.modeMux = 1'b0;
defparam syn__416_.FeedbackMux = 1'b0;
defparam syn__416_.ShiftMux = 1'b0;
defparam syn__416_.BypassEn = 1'b0;
defparam syn__416_.CarryEnb = 1'b1;

alta_slice syn__417_(
	.A(IOvalue[2]),
	.B(IOaddr[2]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__044_),
	.Cout(),
	.Q());
defparam syn__417_.coord_x = 5;
defparam syn__417_.coord_y = 8;
defparam syn__417_.coord_z = 1;
defparam syn__417_.mask = 16'hC028;
defparam syn__417_.modeMux = 1'b0;
defparam syn__417_.FeedbackMux = 1'b0;
defparam syn__417_.ShiftMux = 1'b0;
defparam syn__417_.BypassEn = 1'b0;
defparam syn__417_.CarryEnb = 1'b1;

alta_slice syn__418_(
	.A(IOaddr[5]),
	.B(IOvalue[5]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__045_),
	.Cout(),
	.Q());
defparam syn__418_.coord_x = 5;
defparam syn__418_.coord_y = 8;
defparam syn__418_.coord_z = 5;
defparam syn__418_.mask = 16'h0521;
defparam syn__418_.modeMux = 1'b0;
defparam syn__418_.FeedbackMux = 1'b0;
defparam syn__418_.ShiftMux = 1'b0;
defparam syn__418_.BypassEn = 1'b0;
defparam syn__418_.CarryEnb = 1'b1;

alta_slice syn__419_(
	.A(vcc),
	.B(IOaddr[4]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__046_),
	.Cout(),
	.Q());
defparam syn__419_.coord_x = 4;
defparam syn__419_.coord_y = 8;
defparam syn__419_.coord_z = 1;
defparam syn__419_.mask = 16'h0FC3;
defparam syn__419_.modeMux = 1'b0;
defparam syn__419_.FeedbackMux = 1'b0;
defparam syn__419_.ShiftMux = 1'b0;
defparam syn__419_.BypassEn = 1'b0;
defparam syn__419_.CarryEnb = 1'b1;

alta_slice syn__420_(
	.A(vcc),
	.B(IOaddr[4]),
	.C(IOvalue[4]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__047_),
	.Cout(),
	.Q());
defparam syn__420_.coord_x = 4;
defparam syn__420_.coord_y = 8;
defparam syn__420_.coord_z = 13;
defparam syn__420_.mask = 16'h330F;
defparam syn__420_.modeMux = 1'b0;
defparam syn__420_.FeedbackMux = 1'b0;
defparam syn__420_.ShiftMux = 1'b0;
defparam syn__420_.BypassEn = 1'b0;
defparam syn__420_.CarryEnb = 1'b1;

alta_slice syn__421_(
	.A(IOaddr[6]),
	.B(IOvalue[6]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__048_),
	.Cout(),
	.Q());
defparam syn__421_.coord_x = 5;
defparam syn__421_.coord_y = 8;
defparam syn__421_.coord_z = 10;
defparam syn__421_.mask = 16'hA048;
defparam syn__421_.modeMux = 1'b0;
defparam syn__421_.FeedbackMux = 1'b0;
defparam syn__421_.ShiftMux = 1'b0;
defparam syn__421_.BypassEn = 1'b0;
defparam syn__421_.CarryEnb = 1'b1;

alta_slice syn__422_(
	.A(IOaddr[6]),
	.B(IOvalue[6]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__049_),
	.Cout(),
	.Q());
defparam syn__422_.coord_x = 5;
defparam syn__422_.coord_y = 8;
defparam syn__422_.coord_z = 14;
defparam syn__422_.mask = 16'h5A96;
defparam syn__422_.modeMux = 1'b0;
defparam syn__422_.FeedbackMux = 1'b0;
defparam syn__422_.ShiftMux = 1'b0;
defparam syn__422_.BypassEn = 1'b0;
defparam syn__422_.CarryEnb = 1'b1;

alta_slice syn__423_(
	.A(IOaddr[5]),
	.B(IOvalue[5]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__050_),
	.Cout(),
	.Q());
defparam syn__423_.coord_x = 5;
defparam syn__423_.coord_y = 8;
defparam syn__423_.coord_z = 7;
defparam syn__423_.mask = 16'hA048;
defparam syn__423_.modeMux = 1'b0;
defparam syn__423_.FeedbackMux = 1'b0;
defparam syn__423_.ShiftMux = 1'b0;
defparam syn__423_.BypassEn = 1'b0;
defparam syn__423_.CarryEnb = 1'b1;

alta_slice syn__424_(
	.A(IOvalue[8]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOaddr[8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__051_),
	.Cout(),
	.Q());
defparam syn__424_.coord_x = 5;
defparam syn__424_.coord_y = 7;
defparam syn__424_.coord_z = 5;
defparam syn__424_.mask = 16'h2DD2;
defparam syn__424_.modeMux = 1'b0;
defparam syn__424_.FeedbackMux = 1'b0;
defparam syn__424_.ShiftMux = 1'b0;
defparam syn__424_.BypassEn = 1'b0;
defparam syn__424_.CarryEnb = 1'b1;

alta_slice syn__425_(
	.A(IOvalue[7]),
	.B(IOaddr[7]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__052_),
	.Cout(),
	.Q());
defparam syn__425_.coord_x = 6;
defparam syn__425_.coord_y = 8;
defparam syn__425_.coord_z = 14;
defparam syn__425_.mask = 16'hC028;
defparam syn__425_.modeMux = 1'b0;
defparam syn__425_.FeedbackMux = 1'b0;
defparam syn__425_.ShiftMux = 1'b0;
defparam syn__425_.BypassEn = 1'b0;
defparam syn__425_.CarryEnb = 1'b1;

alta_slice syn__426_(
	.A(IOvalue[7]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOaddr[7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__053_),
	.Cout(),
	.Q());
defparam syn__426_.coord_x = 6;
defparam syn__426_.coord_y = 8;
defparam syn__426_.coord_z = 1;
defparam syn__426_.mask = 16'h100D;
defparam syn__426_.modeMux = 1'b0;
defparam syn__426_.FeedbackMux = 1'b0;
defparam syn__426_.ShiftMux = 1'b0;
defparam syn__426_.BypassEn = 1'b0;
defparam syn__426_.CarryEnb = 1'b1;

alta_slice syn__427_(
	.A(IOaddr[9]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOvalue[9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__054_),
	.Cout(),
	.Q());
defparam syn__427_.coord_x = 6;
defparam syn__427_.coord_y = 8;
defparam syn__427_.coord_z = 3;
defparam syn__427_.mask = 16'h9280;
defparam syn__427_.modeMux = 1'b0;
defparam syn__427_.FeedbackMux = 1'b0;
defparam syn__427_.ShiftMux = 1'b0;
defparam syn__427_.BypassEn = 1'b0;
defparam syn__427_.CarryEnb = 1'b1;

alta_slice syn__428_(
	.A(IOvalue[8]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOaddr[8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__055_),
	.Cout(),
	.Q());
defparam syn__428_.coord_x = 5;
defparam syn__428_.coord_y = 7;
defparam syn__428_.coord_z = 13;
defparam syn__428_.mask = 16'hC220;
defparam syn__428_.modeMux = 1'b0;
defparam syn__428_.FeedbackMux = 1'b0;
defparam syn__428_.ShiftMux = 1'b0;
defparam syn__428_.BypassEn = 1'b0;
defparam syn__428_.CarryEnb = 1'b1;

alta_slice syn__429_(
	.A(IOaddr[9]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOvalue[9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__056_),
	.Cout(),
	.Q());
defparam syn__429_.coord_x = 6;
defparam syn__429_.coord_y = 8;
defparam syn__429_.coord_z = 9;
defparam syn__429_.mask = 16'h695A;
defparam syn__429_.modeMux = 1'b0;
defparam syn__429_.FeedbackMux = 1'b0;
defparam syn__429_.ShiftMux = 1'b0;
defparam syn__429_.BypassEn = 1'b0;
defparam syn__429_.CarryEnb = 1'b1;

alta_slice syn__430_(
	.A(IOaddr[11]),
	.B(IOvalue[11]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__057_),
	.Cout(),
	.Q());
defparam syn__430_.coord_x = 7;
defparam syn__430_.coord_y = 8;
defparam syn__430_.coord_z = 7;
defparam syn__430_.mask = 16'h0521;
defparam syn__430_.modeMux = 1'b0;
defparam syn__430_.FeedbackMux = 1'b0;
defparam syn__430_.ShiftMux = 1'b0;
defparam syn__430_.BypassEn = 1'b0;
defparam syn__430_.CarryEnb = 1'b1;

alta_slice syn__431_(
	.A(vcc),
	.B(IOaddr[10]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__058_),
	.Cout(),
	.Q());
defparam syn__431_.coord_x = 7;
defparam syn__431_.coord_y = 8;
defparam syn__431_.coord_z = 5;
defparam syn__431_.mask = 16'h0FC3;
defparam syn__431_.modeMux = 1'b0;
defparam syn__431_.FeedbackMux = 1'b0;
defparam syn__431_.ShiftMux = 1'b0;
defparam syn__431_.BypassEn = 1'b0;
defparam syn__431_.CarryEnb = 1'b1;

alta_slice syn__432_(
	.A(vcc),
	.B(IOaddr[10]),
	.C(IOvalue[10]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__059_),
	.Cout(),
	.Q());
defparam syn__432_.coord_x = 7;
defparam syn__432_.coord_y = 8;
defparam syn__432_.coord_z = 0;
defparam syn__432_.mask = 16'h330F;
defparam syn__432_.modeMux = 1'b0;
defparam syn__432_.FeedbackMux = 1'b0;
defparam syn__432_.ShiftMux = 1'b0;
defparam syn__432_.BypassEn = 1'b0;
defparam syn__432_.CarryEnb = 1'b1;

alta_slice syn__433_(
	.A(IOvalue[12]),
	.B(\tc.IM [7]),
	.C(IOaddr[12]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__060_),
	.Cout(),
	.Q());
defparam syn__433_.coord_x = 8;
defparam syn__433_.coord_y = 6;
defparam syn__433_.coord_z = 5;
defparam syn__433_.mask = 16'hC028;
defparam syn__433_.modeMux = 1'b0;
defparam syn__433_.FeedbackMux = 1'b0;
defparam syn__433_.ShiftMux = 1'b0;
defparam syn__433_.BypassEn = 1'b0;
defparam syn__433_.CarryEnb = 1'b1;

alta_slice syn__434_(
	.A(IOvalue[12]),
	.B(\tc.IM [7]),
	.C(IOaddr[12]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__061_),
	.Cout(),
	.Q());
defparam syn__434_.coord_x = 8;
defparam syn__434_.coord_y = 6;
defparam syn__434_.coord_z = 1;
defparam syn__434_.mask = 16'h3C96;
defparam syn__434_.modeMux = 1'b0;
defparam syn__434_.FeedbackMux = 1'b0;
defparam syn__434_.ShiftMux = 1'b0;
defparam syn__434_.BypassEn = 1'b0;
defparam syn__434_.CarryEnb = 1'b1;

alta_slice syn__435_(
	.A(IOaddr[11]),
	.B(IOvalue[11]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__062_),
	.Cout(),
	.Q());
defparam syn__435_.coord_x = 7;
defparam syn__435_.coord_y = 8;
defparam syn__435_.coord_z = 15;
defparam syn__435_.mask = 16'hA048;
defparam syn__435_.modeMux = 1'b0;
defparam syn__435_.FeedbackMux = 1'b0;
defparam syn__435_.ShiftMux = 1'b0;
defparam syn__435_.BypassEn = 1'b0;
defparam syn__435_.CarryEnb = 1'b1;

alta_slice syn__436_(
	.A(\tc.IM [8]),
	.B(IOvalue[14]),
	.C(\tc.IM [7]),
	.D(IOaddr[14]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__063_),
	.Cout(),
	.Q());
defparam syn__436_.coord_x = 6;
defparam syn__436_.coord_y = 7;
defparam syn__436_.coord_z = 11;
defparam syn__436_.mask = 16'h4BB4;
defparam syn__436_.modeMux = 1'b0;
defparam syn__436_.FeedbackMux = 1'b0;
defparam syn__436_.ShiftMux = 1'b0;
defparam syn__436_.BypassEn = 1'b0;
defparam syn__436_.CarryEnb = 1'b1;

alta_slice syn__437_(
	.A(\tc.IM [8]),
	.B(IOaddr[13]),
	.C(\tc.IM [7]),
	.D(IOvalue[13]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__064_),
	.Cout(),
	.Q());
defparam syn__437_.coord_x = 6;
defparam syn__437_.coord_y = 7;
defparam syn__437_.coord_z = 6;
defparam syn__437_.mask = 16'h9480;
defparam syn__437_.modeMux = 1'b0;
defparam syn__437_.FeedbackMux = 1'b0;
defparam syn__437_.ShiftMux = 1'b0;
defparam syn__437_.BypassEn = 1'b0;
defparam syn__437_.CarryEnb = 1'b1;

alta_slice syn__438_(
	.A(IOaddr[13]),
	.B(IOvalue[13]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__065_),
	.Cout(),
	.Q());
defparam syn__438_.coord_x = 6;
defparam syn__438_.coord_y = 7;
defparam syn__438_.coord_z = 9;
defparam syn__438_.mask = 16'h0251;
defparam syn__438_.modeMux = 1'b0;
defparam syn__438_.FeedbackMux = 1'b0;
defparam syn__438_.ShiftMux = 1'b0;
defparam syn__438_.BypassEn = 1'b0;
defparam syn__438_.CarryEnb = 1'b1;

alta_slice syn__439_(
	.A(\tc.IM [7]),
	.B(\tc.IM [8]),
	.C(IOaddr[15]),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__066_),
	.Cout(),
	.Q());
defparam syn__439_.coord_x = 6;
defparam syn__439_.coord_y = 7;
defparam syn__439_.coord_z = 2;
defparam syn__439_.mask = 16'h6565;
defparam syn__439_.modeMux = 1'b0;
defparam syn__439_.FeedbackMux = 1'b0;
defparam syn__439_.ShiftMux = 1'b0;
defparam syn__439_.BypassEn = 1'b0;
defparam syn__439_.CarryEnb = 1'b1;

alta_slice syn__440_(
	.A(vcc),
	.B(\tc.IM [8]),
	.C(IOaddr[15]),
	.D(IOvalue[15]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__067_),
	.Cout(),
	.Q());
defparam syn__440_.coord_x = 6;
defparam syn__440_.coord_y = 7;
defparam syn__440_.coord_z = 7;
defparam syn__440_.mask = 16'h0C3F;
defparam syn__440_.modeMux = 1'b0;
defparam syn__440_.FeedbackMux = 1'b0;
defparam syn__440_.ShiftMux = 1'b0;
defparam syn__440_.BypassEn = 1'b0;
defparam syn__440_.CarryEnb = 1'b1;

alta_slice syn__441_(
	.A(\tc.IM [8]),
	.B(IOvalue[14]),
	.C(\tc.IM [7]),
	.D(IOaddr[14]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__068_),
	.Cout(),
	.Q());
defparam syn__441_.coord_x = 6;
defparam syn__441_.coord_y = 7;
defparam syn__441_.coord_z = 3;
defparam syn__441_.mask = 16'hA440;
defparam syn__441_.modeMux = 1'b0;
defparam syn__441_.FeedbackMux = 1'b0;
defparam syn__441_.ShiftMux = 1'b0;
defparam syn__441_.BypassEn = 1'b0;
defparam syn__441_.CarryEnb = 1'b1;

alta_slice syn__442_(
	.A(vcc),
	.B(IOaddr[16]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__069_),
	.Cout(),
	.Q());
defparam syn__442_.coord_x = 8;
defparam syn__442_.coord_y = 7;
defparam syn__442_.coord_z = 15;
defparam syn__442_.mask = 16'h0FC3;
defparam syn__442_.modeMux = 1'b0;
defparam syn__442_.FeedbackMux = 1'b0;
defparam syn__442_.ShiftMux = 1'b0;
defparam syn__442_.BypassEn = 1'b0;
defparam syn__442_.CarryEnb = 1'b1;

alta_slice syn__443_(
	.A(vcc),
	.B(IOaddr[16]),
	.C(IOvalue[16]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__070_),
	.Cout(),
	.Q());
defparam syn__443_.coord_x = 8;
defparam syn__443_.coord_y = 7;
defparam syn__443_.coord_z = 11;
defparam syn__443_.mask = 16'h330F;
defparam syn__443_.modeMux = 1'b0;
defparam syn__443_.FeedbackMux = 1'b0;
defparam syn__443_.ShiftMux = 1'b0;
defparam syn__443_.BypassEn = 1'b0;
defparam syn__443_.CarryEnb = 1'b1;

alta_slice syn__444_(
	.A(IOaddr[17]),
	.B(IOvalue[17]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__071_),
	.Cout(),
	.Q());
defparam syn__444_.coord_x = 8;
defparam syn__444_.coord_y = 7;
defparam syn__444_.coord_z = 13;
defparam syn__444_.mask = 16'hA048;
defparam syn__444_.modeMux = 1'b0;
defparam syn__444_.FeedbackMux = 1'b0;
defparam syn__444_.ShiftMux = 1'b0;
defparam syn__444_.BypassEn = 1'b0;
defparam syn__444_.CarryEnb = 1'b1;

alta_slice syn__445_(
	.A(IOvalue[18]),
	.B(IOaddr[18]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__072_),
	.Cout(),
	.Q());
defparam syn__445_.coord_x = 8;
defparam syn__445_.coord_y = 5;
defparam syn__445_.coord_z = 9;
defparam syn__445_.mask = 16'hC028;
defparam syn__445_.modeMux = 1'b0;
defparam syn__445_.FeedbackMux = 1'b0;
defparam syn__445_.ShiftMux = 1'b0;
defparam syn__445_.BypassEn = 1'b0;
defparam syn__445_.CarryEnb = 1'b1;

alta_slice syn__446_(
	.A(IOaddr[18]),
	.B(IOvalue[18]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__073_),
	.Cout(),
	.Q());
defparam syn__446_.coord_x = 8;
defparam syn__446_.coord_y = 5;
defparam syn__446_.coord_z = 10;
defparam syn__446_.mask = 16'h5A96;
defparam syn__446_.modeMux = 1'b0;
defparam syn__446_.FeedbackMux = 1'b0;
defparam syn__446_.ShiftMux = 1'b0;
defparam syn__446_.BypassEn = 1'b0;
defparam syn__446_.CarryEnb = 1'b1;

alta_slice syn__447_(
	.A(IOaddr[17]),
	.B(IOvalue[17]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__074_),
	.Cout(),
	.Q());
defparam syn__447_.coord_x = 8;
defparam syn__447_.coord_y = 5;
defparam syn__447_.coord_z = 3;
defparam syn__447_.mask = 16'h0521;
defparam syn__447_.modeMux = 1'b0;
defparam syn__447_.FeedbackMux = 1'b0;
defparam syn__447_.ShiftMux = 1'b0;
defparam syn__447_.BypassEn = 1'b0;
defparam syn__447_.CarryEnb = 1'b1;

alta_slice syn__448_(
	.A(IOaddr[20]),
	.B(IOvalue[20]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__075_),
	.Cout(),
	.Q());
defparam syn__448_.coord_x = 8;
defparam syn__448_.coord_y = 5;
defparam syn__448_.coord_z = 0;
defparam syn__448_.mask = 16'h5A96;
defparam syn__448_.modeMux = 1'b0;
defparam syn__448_.FeedbackMux = 1'b0;
defparam syn__448_.ShiftMux = 1'b0;
defparam syn__448_.BypassEn = 1'b0;
defparam syn__448_.CarryEnb = 1'b1;

alta_slice syn__449_(
	.A(IOvalue[19]),
	.B(IOaddr[19]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__076_),
	.Cout(),
	.Q());
defparam syn__449_.coord_x = 8;
defparam syn__449_.coord_y = 5;
defparam syn__449_.coord_z = 8;
defparam syn__449_.mask = 16'hC028;
defparam syn__449_.modeMux = 1'b0;
defparam syn__449_.FeedbackMux = 1'b0;
defparam syn__449_.ShiftMux = 1'b0;
defparam syn__449_.BypassEn = 1'b0;
defparam syn__449_.CarryEnb = 1'b1;

alta_slice syn__450_(
	.A(IOaddr[19]),
	.B(IOvalue[19]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__077_),
	.Cout(),
	.Q());
defparam syn__450_.coord_x = 8;
defparam syn__450_.coord_y = 5;
defparam syn__450_.coord_z = 15;
defparam syn__450_.mask = 16'h0521;
defparam syn__450_.modeMux = 1'b0;
defparam syn__450_.FeedbackMux = 1'b0;
defparam syn__450_.ShiftMux = 1'b0;
defparam syn__450_.BypassEn = 1'b0;
defparam syn__450_.CarryEnb = 1'b1;

alta_slice syn__451_(
	.A(\tc.IM [8]),
	.B(IOaddr[21]),
	.C(\tc.IM [7]),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__078_),
	.Cout(),
	.Q());
defparam syn__451_.coord_x = 4;
defparam syn__451_.coord_y = 7;
defparam syn__451_.coord_z = 7;
defparam syn__451_.mask = 16'h4B4B;
defparam syn__451_.modeMux = 1'b0;
defparam syn__451_.FeedbackMux = 1'b0;
defparam syn__451_.ShiftMux = 1'b0;
defparam syn__451_.BypassEn = 1'b0;
defparam syn__451_.CarryEnb = 1'b1;

alta_slice syn__452_(
	.A(IOvalue[21]),
	.B(IOaddr[21]),
	.C(vcc),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__079_),
	.Cout(),
	.Q());
defparam syn__452_.coord_x = 4;
defparam syn__452_.coord_y = 5;
defparam syn__452_.coord_z = 3;
defparam syn__452_.mask = 16'h3355;
defparam syn__452_.modeMux = 1'b0;
defparam syn__452_.FeedbackMux = 1'b0;
defparam syn__452_.ShiftMux = 1'b0;
defparam syn__452_.BypassEn = 1'b0;
defparam syn__452_.CarryEnb = 1'b1;

alta_slice syn__453_(
	.A(\tc.IM [7]),
	.B(IOaddr[20]),
	.C(\tc.IM [8]),
	.D(IOvalue[20]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__080_),
	.Cout(),
	.Q());
defparam syn__453_.coord_x = 4;
defparam syn__453_.coord_y = 7;
defparam syn__453_.coord_z = 6;
defparam syn__453_.mask = 16'h8680;
defparam syn__453_.modeMux = 1'b0;
defparam syn__453_.FeedbackMux = 1'b0;
defparam syn__453_.ShiftMux = 1'b0;
defparam syn__453_.BypassEn = 1'b0;
defparam syn__453_.CarryEnb = 1'b1;

alta_slice syn__454_(
	.A(IOvalue[23]),
	.B(IOaddr[23]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__081_),
	.Cout(),
	.Q());
defparam syn__454_.coord_x = 5;
defparam syn__454_.coord_y = 5;
defparam syn__454_.coord_z = 3;
defparam syn__454_.mask = 16'hC028;
defparam syn__454_.modeMux = 1'b0;
defparam syn__454_.FeedbackMux = 1'b0;
defparam syn__454_.ShiftMux = 1'b0;
defparam syn__454_.BypassEn = 1'b0;
defparam syn__454_.CarryEnb = 1'b1;

alta_slice syn__455_(
	.A(vcc),
	.B(IOaddr[22]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__082_),
	.Cout(),
	.Q());
defparam syn__455_.coord_x = 5;
defparam syn__455_.coord_y = 5;
defparam syn__455_.coord_z = 13;
defparam syn__455_.mask = 16'h0FC3;
defparam syn__455_.modeMux = 1'b0;
defparam syn__455_.FeedbackMux = 1'b0;
defparam syn__455_.ShiftMux = 1'b0;
defparam syn__455_.BypassEn = 1'b0;
defparam syn__455_.CarryEnb = 1'b1;

alta_slice syn__456_(
	.A(IOvalue[22]),
	.B(IOaddr[22]),
	.C(vcc),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__083_),
	.Cout(),
	.Q());
defparam syn__456_.coord_x = 5;
defparam syn__456_.coord_y = 5;
defparam syn__456_.coord_z = 14;
defparam syn__456_.mask = 16'h3355;
defparam syn__456_.modeMux = 1'b0;
defparam syn__456_.FeedbackMux = 1'b0;
defparam syn__456_.ShiftMux = 1'b0;
defparam syn__456_.BypassEn = 1'b0;
defparam syn__456_.CarryEnb = 1'b1;

alta_slice syn__457_(
	.A(\tc.IM [7]),
	.B(IOaddr[24]),
	.C(\tc.IM [8]),
	.D(IOvalue[24]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__084_),
	.Cout(),
	.Q());
defparam syn__457_.coord_x = 4;
defparam syn__457_.coord_y = 7;
defparam syn__457_.coord_z = 13;
defparam syn__457_.mask = 16'h8680;
defparam syn__457_.modeMux = 1'b0;
defparam syn__457_.FeedbackMux = 1'b0;
defparam syn__457_.ShiftMux = 1'b0;
defparam syn__457_.BypassEn = 1'b0;
defparam syn__457_.CarryEnb = 1'b1;

alta_slice syn__458_(
	.A(IOaddr[24]),
	.B(IOvalue[24]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__085_),
	.Cout(),
	.Q());
defparam syn__458_.coord_x = 5;
defparam syn__458_.coord_y = 5;
defparam syn__458_.coord_z = 1;
defparam syn__458_.mask = 16'h5A96;
defparam syn__458_.modeMux = 1'b0;
defparam syn__458_.FeedbackMux = 1'b0;
defparam syn__458_.ShiftMux = 1'b0;
defparam syn__458_.BypassEn = 1'b0;
defparam syn__458_.CarryEnb = 1'b1;

alta_slice syn__459_(
	.A(IOaddr[23]),
	.B(IOvalue[23]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__086_),
	.Cout(),
	.Q());
defparam syn__459_.coord_x = 5;
defparam syn__459_.coord_y = 5;
defparam syn__459_.coord_z = 11;
defparam syn__459_.mask = 16'h0521;
defparam syn__459_.modeMux = 1'b0;
defparam syn__459_.FeedbackMux = 1'b0;
defparam syn__459_.ShiftMux = 1'b0;
defparam syn__459_.BypassEn = 1'b0;
defparam syn__459_.CarryEnb = 1'b1;

alta_slice syn__460_(
	.A(IOaddr[26]),
	.B(IOvalue[26]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__087_),
	.Cout(),
	.Q());
defparam syn__460_.coord_x = 4;
defparam syn__460_.coord_y = 5;
defparam syn__460_.coord_z = 1;
defparam syn__460_.mask = 16'h5A96;
defparam syn__460_.modeMux = 1'b0;
defparam syn__460_.FeedbackMux = 1'b0;
defparam syn__460_.ShiftMux = 1'b0;
defparam syn__460_.BypassEn = 1'b0;
defparam syn__460_.CarryEnb = 1'b1;

alta_slice syn__461_(
	.A(vcc),
	.B(IOaddr[25]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__088_),
	.Cout(),
	.Q());
defparam syn__461_.coord_x = 4;
defparam syn__461_.coord_y = 5;
defparam syn__461_.coord_z = 13;
defparam syn__461_.mask = 16'h0FC3;
defparam syn__461_.modeMux = 1'b0;
defparam syn__461_.FeedbackMux = 1'b0;
defparam syn__461_.ShiftMux = 1'b0;
defparam syn__461_.BypassEn = 1'b0;
defparam syn__461_.CarryEnb = 1'b1;

alta_slice syn__462_(
	.A(IOvalue[25]),
	.B(IOaddr[25]),
	.C(vcc),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__089_),
	.Cout(),
	.Q());
defparam syn__462_.coord_x = 5;
defparam syn__462_.coord_y = 4;
defparam syn__462_.coord_z = 1;
defparam syn__462_.mask = 16'h3355;
defparam syn__462_.modeMux = 1'b0;
defparam syn__462_.FeedbackMux = 1'b0;
defparam syn__462_.ShiftMux = 1'b0;
defparam syn__462_.BypassEn = 1'b0;
defparam syn__462_.CarryEnb = 1'b1;

alta_slice syn__463_(
	.A(IOvalue[27]),
	.B(IOaddr[27]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__090_),
	.Cout(),
	.Q());
defparam syn__463_.coord_x = 4;
defparam syn__463_.coord_y = 6;
defparam syn__463_.coord_z = 11;
defparam syn__463_.mask = 16'hC028;
defparam syn__463_.modeMux = 1'b0;
defparam syn__463_.FeedbackMux = 1'b0;
defparam syn__463_.ShiftMux = 1'b0;
defparam syn__463_.BypassEn = 1'b0;
defparam syn__463_.CarryEnb = 1'b1;

alta_slice syn__464_(
	.A(IOaddr[27]),
	.B(IOvalue[27]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__091_),
	.Cout(),
	.Q());
defparam syn__464_.coord_x = 6;
defparam syn__464_.coord_y = 6;
defparam syn__464_.coord_z = 14;
defparam syn__464_.mask = 16'h59A6;
defparam syn__464_.modeMux = 1'b0;
defparam syn__464_.FeedbackMux = 1'b0;
defparam syn__464_.ShiftMux = 1'b0;
defparam syn__464_.BypassEn = 1'b0;
defparam syn__464_.CarryEnb = 1'b1;

alta_slice syn__465_(
	.A(IOvalue[26]),
	.B(IOaddr[26]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__092_),
	.Cout(),
	.Q());
defparam syn__465_.coord_x = 6;
defparam syn__465_.coord_y = 6;
defparam syn__465_.coord_z = 10;
defparam syn__465_.mask = 16'hC208;
defparam syn__465_.modeMux = 1'b0;
defparam syn__465_.FeedbackMux = 1'b0;
defparam syn__465_.ShiftMux = 1'b0;
defparam syn__465_.BypassEn = 1'b0;
defparam syn__465_.CarryEnb = 1'b1;

alta_slice syn__466_(
	.A(IOaddr[29]),
	.B(IOvalue[29]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__093_),
	.Cout(),
	.Q());
defparam syn__466_.coord_x = 4;
defparam syn__466_.coord_y = 6;
defparam syn__466_.coord_z = 7;
defparam syn__466_.mask = 16'h0521;
defparam syn__466_.modeMux = 1'b0;
defparam syn__466_.FeedbackMux = 1'b0;
defparam syn__466_.ShiftMux = 1'b0;
defparam syn__466_.BypassEn = 1'b0;
defparam syn__466_.CarryEnb = 1'b1;

alta_slice syn__467_(
	.A(vcc),
	.B(IOaddr[28]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__094_),
	.Cout(),
	.Q());
defparam syn__467_.coord_x = 6;
defparam syn__467_.coord_y = 6;
defparam syn__467_.coord_z = 0;
defparam syn__467_.mask = 16'h0CF3;
defparam syn__467_.modeMux = 1'b0;
defparam syn__467_.FeedbackMux = 1'b0;
defparam syn__467_.ShiftMux = 1'b0;
defparam syn__467_.BypassEn = 1'b0;
defparam syn__467_.CarryEnb = 1'b1;

alta_slice syn__468_(
	.A(IOvalue[28]),
	.B(IOaddr[28]),
	.C(\tc.IM [8]),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__095_),
	.Cout(),
	.Q());
defparam syn__468_.coord_x = 6;
defparam syn__468_.coord_y = 6;
defparam syn__468_.coord_z = 3;
defparam syn__468_.mask = 16'h3535;
defparam syn__468_.modeMux = 1'b0;
defparam syn__468_.FeedbackMux = 1'b0;
defparam syn__468_.ShiftMux = 1'b0;
defparam syn__468_.BypassEn = 1'b0;
defparam syn__468_.CarryEnb = 1'b1;

alta_slice syn__469_(
	.A(IOvalue[30]),
	.B(IOaddr[30]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__096_),
	.Cout(),
	.Q());
defparam syn__469_.coord_x = 4;
defparam syn__469_.coord_y = 6;
defparam syn__469_.coord_z = 8;
defparam syn__469_.mask = 16'hC028;
defparam syn__469_.modeMux = 1'b0;
defparam syn__469_.FeedbackMux = 1'b0;
defparam syn__469_.ShiftMux = 1'b0;
defparam syn__469_.BypassEn = 1'b0;
defparam syn__469_.CarryEnb = 1'b1;

alta_slice syn__470_(
	.A(IOaddr[30]),
	.B(IOvalue[30]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__097_),
	.Cout(),
	.Q());
defparam syn__470_.coord_x = 4;
defparam syn__470_.coord_y = 6;
defparam syn__470_.coord_z = 12;
defparam syn__470_.mask = 16'h5A96;
defparam syn__470_.modeMux = 1'b0;
defparam syn__470_.FeedbackMux = 1'b0;
defparam syn__470_.ShiftMux = 1'b0;
defparam syn__470_.BypassEn = 1'b0;
defparam syn__470_.CarryEnb = 1'b1;

alta_slice syn__471_(
	.A(IOvalue[29]),
	.B(IOaddr[29]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__098_),
	.Cout(),
	.Q());
defparam syn__471_.coord_x = 5;
defparam syn__471_.coord_y = 6;
defparam syn__471_.coord_z = 1;
defparam syn__471_.mask = 16'hC028;
defparam syn__471_.modeMux = 1'b0;
defparam syn__471_.FeedbackMux = 1'b0;
defparam syn__471_.ShiftMux = 1'b0;
defparam syn__471_.BypassEn = 1'b0;
defparam syn__471_.CarryEnb = 1'b1;

alta_slice syn__472_(
	.A(IOaddr[31]),
	.B(syn__102_),
	.C(syn__100_),
	.D(IOvalue[31]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__099_),
	.Cout(),
	.Q());
defparam syn__472_.coord_x = 5;
defparam syn__472_.coord_y = 6;
defparam syn__472_.coord_z = 11;
defparam syn__472_.mask = 16'h0B07;
defparam syn__472_.modeMux = 1'b0;
defparam syn__472_.FeedbackMux = 1'b0;
defparam syn__472_.ShiftMux = 1'b0;
defparam syn__472_.BypassEn = 1'b0;
defparam syn__472_.CarryEnb = 1'b1;

alta_slice syn__473_(
	.A(IOaddr[31]),
	.B(syn__101_),
	.C(IOvalue[31]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__100_),
	.Cout(),
	.Q());
defparam syn__473_.coord_x = 6;
defparam syn__473_.coord_y = 6;
defparam syn__473_.coord_z = 2;
defparam syn__473_.mask = 16'hC880;
defparam syn__473_.modeMux = 1'b0;
defparam syn__473_.FeedbackMux = 1'b0;
defparam syn__473_.ShiftMux = 1'b0;
defparam syn__473_.BypassEn = 1'b0;
defparam syn__473_.CarryEnb = 1'b1;

alta_slice syn__474_(
	.A(vcc),
	.B(vcc),
	.C(\tc.IM [8]),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__101_),
	.Cout(),
	.Q());
defparam syn__474_.coord_x = 6;
defparam syn__474_.coord_y = 6;
defparam syn__474_.coord_z = 1;
defparam syn__474_.mask = 16'h0F00;
defparam syn__474_.modeMux = 1'b0;
defparam syn__474_.FeedbackMux = 1'b0;
defparam syn__474_.ShiftMux = 1'b0;
defparam syn__474_.BypassEn = 1'b0;
defparam syn__474_.CarryEnb = 1'b1;

alta_slice syn__475_(
	.A(vcc),
	.B(\tc.IM [9]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__102_),
	.Cout(),
	.Q());
defparam syn__475_.coord_x = 6;
defparam syn__475_.coord_y = 6;
defparam syn__475_.coord_z = 13;
defparam syn__475_.mask = 16'hC000;
defparam syn__475_.modeMux = 1'b0;
defparam syn__475_.FeedbackMux = 1'b0;
defparam syn__475_.ShiftMux = 1'b0;
defparam syn__475_.BypassEn = 1'b0;
defparam syn__475_.CarryEnb = 1'b1;

alta_slice syn__476_(
	.A(IOaddr[31]),
	.B(IOvalue[31]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__103_),
	.Cout(),
	.Q());
defparam syn__476_.coord_x = 4;
defparam syn__476_.coord_y = 6;
defparam syn__476_.coord_z = 13;
defparam syn__476_.mask = 16'hA569;
defparam syn__476_.modeMux = 1'b0;
defparam syn__476_.FeedbackMux = 1'b0;
defparam syn__476_.ShiftMux = 1'b0;
defparam syn__476_.BypassEn = 1'b0;
defparam syn__476_.CarryEnb = 1'b1;

alta_slice syn__477_(
	.A(vcc),
	.B(syn__105_),
	.C(syn__106_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__104_),
	.Cout(),
	.Q());
defparam syn__477_.coord_x = 7;
defparam syn__477_.coord_y = 6;
defparam syn__477_.coord_z = 14;
defparam syn__477_.mask = 16'hCF00;
defparam syn__477_.modeMux = 1'b0;
defparam syn__477_.FeedbackMux = 1'b0;
defparam syn__477_.ShiftMux = 1'b0;
defparam syn__477_.BypassEn = 1'b0;
defparam syn__477_.CarryEnb = 1'b1;

alta_slice syn__478_(
	.A(syn__019_),
	.B(syn__098_),
	.C(syn__097_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__105_),
	.Cout(),
	.Q());
defparam syn__478_.coord_x = 5;
defparam syn__478_.coord_y = 6;
defparam syn__478_.coord_z = 12;
defparam syn__478_.mask = 16'h001E;
defparam syn__478_.modeMux = 1'b0;
defparam syn__478_.FeedbackMux = 1'b0;
defparam syn__478_.ShiftMux = 1'b0;
defparam syn__478_.BypassEn = 1'b0;
defparam syn__478_.CarryEnb = 1'b1;

alta_slice syn__479_(
	.A(IOvalue[30]),
	.B(IOaddr[30]),
	.C(syn__107_),
	.D(syn__102_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__106_),
	.Cout(),
	.Q());
defparam syn__479_.coord_x = 6;
defparam syn__479_.coord_y = 3;
defparam syn__479_.coord_z = 13;
defparam syn__479_.mask = 16'h090F;
defparam syn__479_.modeMux = 1'b0;
defparam syn__479_.FeedbackMux = 1'b0;
defparam syn__479_.ShiftMux = 1'b0;
defparam syn__479_.BypassEn = 1'b0;
defparam syn__479_.CarryEnb = 1'b1;

alta_slice syn__480_(
	.A(IOaddr[30]),
	.B(\tc.IM [7]),
	.C(IOvalue[30]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__107_),
	.Cout(),
	.Q());
defparam syn__480_.coord_x = 6;
defparam syn__480_.coord_y = 6;
defparam syn__480_.coord_z = 8;
defparam syn__480_.mask = 16'hE800;
defparam syn__480_.modeMux = 1'b0;
defparam syn__480_.FeedbackMux = 1'b0;
defparam syn__480_.ShiftMux = 1'b0;
defparam syn__480_.BypassEn = 1'b0;
defparam syn__480_.CarryEnb = 1'b1;

alta_slice syn__481_(
	.A(vcc),
	.B(vcc),
	.C(\tc.IM [5]),
	.D(\tc.IM [6]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__108_),
	.Cout(),
	.Q());
defparam syn__481_.coord_x = 5;
defparam syn__481_.coord_y = 3;
defparam syn__481_.coord_z = 13;
defparam syn__481_.mask = 16'h000F;
defparam syn__481_.modeMux = 1'b0;
defparam syn__481_.FeedbackMux = 1'b0;
defparam syn__481_.ShiftMux = 1'b0;
defparam syn__481_.BypassEn = 1'b0;
defparam syn__481_.CarryEnb = 1'b1;

alta_slice syn__482_(
	.A(syn__302_),
	.B(syn__110_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__109_),
	.Cout(),
	.Q());
defparam syn__482_.coord_x = 7;
defparam syn__482_.coord_y = 6;
defparam syn__482_.coord_z = 1;
defparam syn__482_.mask = 16'hCFAF;
defparam syn__482_.modeMux = 1'b0;
defparam syn__482_.FeedbackMux = 1'b0;
defparam syn__482_.ShiftMux = 1'b0;
defparam syn__482_.BypassEn = 1'b0;
defparam syn__482_.CarryEnb = 1'b1;

alta_slice syn__483_(
	.A(syn__111_),
	.B(syn__112_),
	.C(syn__063_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__110_),
	.Cout(),
	.Q());
defparam syn__483_.coord_x = 6;
defparam syn__483_.coord_y = 7;
defparam syn__483_.coord_z = 10;
defparam syn__483_.mask = 16'hCC48;
defparam syn__483_.modeMux = 1'b0;
defparam syn__483_.FeedbackMux = 1'b0;
defparam syn__483_.ShiftMux = 1'b0;
defparam syn__483_.BypassEn = 1'b0;
defparam syn__483_.CarryEnb = 1'b1;

alta_slice syn__484_(
	.A(syn__064_),
	.B(vcc),
	.C(syn__030_),
	.D(syn__065_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__111_),
	.Cout(),
	.Q());
defparam syn__484_.coord_x = 6;
defparam syn__484_.coord_y = 7;
defparam syn__484_.coord_z = 8;
defparam syn__484_.mask = 16'h5550;
defparam syn__484_.modeMux = 1'b0;
defparam syn__484_.FeedbackMux = 1'b0;
defparam syn__484_.ShiftMux = 1'b0;
defparam syn__484_.BypassEn = 1'b0;
defparam syn__484_.CarryEnb = 1'b1;

alta_slice syn__485_(
	.A(syn__102_),
	.B(IOvalue[14]),
	.C(syn__113_),
	.D(IOaddr[14]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__112_),
	.Cout(),
	.Q());
defparam syn__485_.coord_x = 6;
defparam syn__485_.coord_y = 7;
defparam syn__485_.coord_z = 5;
defparam syn__485_.mask = 16'h0D07;
defparam syn__485_.modeMux = 1'b0;
defparam syn__485_.FeedbackMux = 1'b0;
defparam syn__485_.ShiftMux = 1'b0;
defparam syn__485_.BypassEn = 1'b0;
defparam syn__485_.CarryEnb = 1'b1;

alta_slice syn__486_(
	.A(syn__101_),
	.B(IOaddr[14]),
	.C(\tc.IM [7]),
	.D(IOvalue[14]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__113_),
	.Cout(),
	.Q());
defparam syn__486_.coord_x = 6;
defparam syn__486_.coord_y = 7;
defparam syn__486_.coord_z = 4;
defparam syn__486_.mask = 16'hA880;
defparam syn__486_.modeMux = 1'b0;
defparam syn__486_.FeedbackMux = 1'b0;
defparam syn__486_.ShiftMux = 1'b0;
defparam syn__486_.BypassEn = 1'b0;
defparam syn__486_.CarryEnb = 1'b1;

alta_slice syn__487_(
	.A(syn__049_),
	.B(\tc.IM [9]),
	.C(syn__035_),
	.D(syn__050_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__114_),
	.Cout(),
	.Q());
defparam syn__487_.coord_x = 5;
defparam syn__487_.coord_y = 8;
defparam syn__487_.coord_z = 15;
defparam syn__487_.mask = 16'h1112;
defparam syn__487_.modeMux = 1'b0;
defparam syn__487_.FeedbackMux = 1'b0;
defparam syn__487_.ShiftMux = 1'b0;
defparam syn__487_.BypassEn = 1'b0;
defparam syn__487_.CarryEnb = 1'b1;

alta_slice syn__488_(
	.A(vcc),
	.B(vcc),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__115_),
	.Cout(),
	.Q());
defparam syn__488_.coord_x = 7;
defparam syn__488_.coord_y = 3;
defparam syn__488_.coord_z = 13;
defparam syn__488_.mask = 16'h0F00;
defparam syn__488_.modeMux = 1'b0;
defparam syn__488_.FeedbackMux = 1'b0;
defparam syn__488_.ShiftMux = 1'b0;
defparam syn__488_.BypassEn = 1'b0;
defparam syn__488_.CarryEnb = 1'b1;

alta_slice syn__489_(
	.A(syn__105_),
	.B(syn__117_),
	.C(syn__106_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__116_),
	.Cout(),
	.Q());
defparam syn__489_.coord_x = 7;
defparam syn__489_.coord_y = 6;
defparam syn__489_.coord_z = 6;
defparam syn__489_.mask = 16'h40CC;
defparam syn__489_.modeMux = 1'b0;
defparam syn__489_.FeedbackMux = 1'b0;
defparam syn__489_.ShiftMux = 1'b0;
defparam syn__489_.BypassEn = 1'b0;
defparam syn__489_.CarryEnb = 1'b1;

alta_slice syn__490_(
	.A(vcc),
	.B(syn__123_),
	.C(syn__118_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__117_),
	.Cout(),
	.Q());
defparam syn__490_.coord_x = 7;
defparam syn__490_.coord_y = 6;
defparam syn__490_.coord_z = 15;
defparam syn__490_.mask = 16'hC0CC;
defparam syn__490_.modeMux = 1'b0;
defparam syn__490_.FeedbackMux = 1'b0;
defparam syn__490_.ShiftMux = 1'b0;
defparam syn__490_.BypassEn = 1'b0;
defparam syn__490_.CarryEnb = 1'b1;

alta_slice syn__491_(
	.A(\tc.IM [9]),
	.B(vcc),
	.C(syn__121_),
	.D(syn__119_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__118_),
	.Cout(),
	.Q());
defparam syn__491_.coord_x = 6;
defparam syn__491_.coord_y = 3;
defparam syn__491_.coord_z = 5;
defparam syn__491_.mask = 16'hA0F0;
defparam syn__491_.modeMux = 1'b0;
defparam syn__491_.FeedbackMux = 1'b0;
defparam syn__491_.ShiftMux = 1'b0;
defparam syn__491_.BypassEn = 1'b0;
defparam syn__491_.CarryEnb = 1'b1;

alta_slice syn__492_(
	.A(syn__094_),
	.B(syn__120_),
	.C(syn__095_),
	.D(syn__020_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__119_),
	.Cout(),
	.Q());
defparam syn__492_.coord_x = 6;
defparam syn__492_.coord_y = 3;
defparam syn__492_.coord_z = 7;
defparam syn__492_.mask = 16'hC993;
defparam syn__492_.modeMux = 1'b0;
defparam syn__492_.FeedbackMux = 1'b0;
defparam syn__492_.ShiftMux = 1'b0;
defparam syn__492_.BypassEn = 1'b0;
defparam syn__492_.CarryEnb = 1'b1;

alta_slice syn__493_(
	.A(vcc),
	.B(syn__093_),
	.C(vcc),
	.D(syn__098_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__120_),
	.Cout(),
	.Q());
defparam syn__493_.coord_x = 5;
defparam syn__493_.coord_y = 6;
defparam syn__493_.coord_z = 0;
defparam syn__493_.mask = 16'h0033;
defparam syn__493_.modeMux = 1'b0;
defparam syn__493_.FeedbackMux = 1'b0;
defparam syn__493_.ShiftMux = 1'b0;
defparam syn__493_.BypassEn = 1'b0;
defparam syn__493_.CarryEnb = 1'b1;

alta_slice syn__494_(
	.A(IOvalue[29]),
	.B(IOaddr[29]),
	.C(syn__122_),
	.D(syn__102_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__121_),
	.Cout(),
	.Q());
defparam syn__494_.coord_x = 6;
defparam syn__494_.coord_y = 3;
defparam syn__494_.coord_z = 4;
defparam syn__494_.mask = 16'h090F;
defparam syn__494_.modeMux = 1'b0;
defparam syn__494_.FeedbackMux = 1'b0;
defparam syn__494_.ShiftMux = 1'b0;
defparam syn__494_.BypassEn = 1'b0;
defparam syn__494_.CarryEnb = 1'b1;

alta_slice syn__495_(
	.A(IOaddr[29]),
	.B(\tc.IM [7]),
	.C(IOvalue[29]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__122_),
	.Cout(),
	.Q());
defparam syn__495_.coord_x = 6;
defparam syn__495_.coord_y = 6;
defparam syn__495_.coord_z = 9;
defparam syn__495_.mask = 16'hE800;
defparam syn__495_.modeMux = 1'b0;
defparam syn__495_.FeedbackMux = 1'b0;
defparam syn__495_.ShiftMux = 1'b0;
defparam syn__495_.BypassEn = 1'b0;
defparam syn__495_.CarryEnb = 1'b1;

alta_slice syn__496_(
	.A(syn__304_),
	.B(syn__306_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__123_),
	.Cout(),
	.Q());
defparam syn__496_.coord_x = 7;
defparam syn__496_.coord_y = 3;
defparam syn__496_.coord_z = 2;
defparam syn__496_.mask = 16'hAFCF;
defparam syn__496_.modeMux = 1'b0;
defparam syn__496_.FeedbackMux = 1'b0;
defparam syn__496_.ShiftMux = 1'b0;
defparam syn__496_.BypassEn = 1'b0;
defparam syn__496_.CarryEnb = 1'b1;

alta_slice syn__497_(
	.A(vcc),
	.B(vcc),
	.C(syn__064_),
	.D(syn__065_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__124_),
	.Cout(),
	.Q());
defparam syn__497_.coord_x = 6;
defparam syn__497_.coord_y = 7;
defparam syn__497_.coord_z = 14;
defparam syn__497_.mask = 16'h000F;
defparam syn__497_.modeMux = 1'b0;
defparam syn__497_.FeedbackMux = 1'b0;
defparam syn__497_.ShiftMux = 1'b0;
defparam syn__497_.BypassEn = 1'b0;
defparam syn__497_.CarryEnb = 1'b1;

alta_slice syn__498_(
	.A(syn__036_),
	.B(vcc),
	.C(syn__047_),
	.D(syn__046_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__125_),
	.Cout(),
	.Q());
defparam syn__498_.coord_x = 5;
defparam syn__498_.coord_y = 8;
defparam syn__498_.coord_z = 9;
defparam syn__498_.mask = 16'hFAA0;
defparam syn__498_.modeMux = 1'b0;
defparam syn__498_.FeedbackMux = 1'b0;
defparam syn__498_.ShiftMux = 1'b0;
defparam syn__498_.BypassEn = 1'b0;
defparam syn__498_.CarryEnb = 1'b1;

alta_slice syn__499_(
	.A(vcc),
	.B(syn__045_),
	.C(vcc),
	.D(syn__050_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__126_),
	.Cout(),
	.Q());
defparam syn__499_.coord_x = 5;
defparam syn__499_.coord_y = 8;
defparam syn__499_.coord_z = 6;
defparam syn__499_.mask = 16'h0033;
defparam syn__499_.modeMux = 1'b0;
defparam syn__499_.FeedbackMux = 1'b0;
defparam syn__499_.ShiftMux = 1'b0;
defparam syn__499_.BypassEn = 1'b0;
defparam syn__499_.CarryEnb = 1'b1;

alta_slice syn__500_(
	.A(syn__128_),
	.B(syn__224_),
	.C(syn__360_),
	.D(syn__231_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__127_),
	.Cout(),
	.Q());
defparam syn__500_.coord_x = 6;
defparam syn__500_.coord_y = 3;
defparam syn__500_.coord_z = 2;
defparam syn__500_.mask = 16'h8000;
defparam syn__500_.modeMux = 1'b0;
defparam syn__500_.FeedbackMux = 1'b0;
defparam syn__500_.ShiftMux = 1'b0;
defparam syn__500_.BypassEn = 1'b0;
defparam syn__500_.CarryEnb = 1'b1;

alta_slice syn__501_(
	.A(syn__220_),
	.B(syn__147_),
	.C(syn__129_),
	.D(syn__314_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__128_),
	.Cout(),
	.Q());
defparam syn__501_.coord_x = 6;
defparam syn__501_.coord_y = 4;
defparam syn__501_.coord_z = 4;
defparam syn__501_.mask = 16'h8000;
defparam syn__501_.modeMux = 1'b0;
defparam syn__501_.FeedbackMux = 1'b0;
defparam syn__501_.ShiftMux = 1'b0;
defparam syn__501_.BypassEn = 1'b0;
defparam syn__501_.CarryEnb = 1'b1;

alta_slice syn__502_(
	.A(syn__115_),
	.B(syn__131_),
	.C(syn__135_),
	.D(syn__308_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__129_),
	.Cout(),
	.Q());
defparam syn__502_.coord_x = 6;
defparam syn__502_.coord_y = 4;
defparam syn__502_.coord_z = 0;
defparam syn__502_.mask = 16'h3010;
defparam syn__502_.modeMux = 1'b0;
defparam syn__502_.FeedbackMux = 1'b0;
defparam syn__502_.ShiftMux = 1'b0;
defparam syn__502_.BypassEn = 1'b0;
defparam syn__502_.CarryEnb = 1'b1;

alta_slice syn__503_(
	.A(syn__094_),
	.B(vcc),
	.C(syn__095_),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__130_),
	.Cout(),
	.Q());
defparam syn__503_.coord_x = 6;
defparam syn__503_.coord_y = 3;
defparam syn__503_.coord_z = 14;
defparam syn__503_.mask = 16'h5A5A;
defparam syn__503_.modeMux = 1'b0;
defparam syn__503_.FeedbackMux = 1'b0;
defparam syn__503_.ShiftMux = 1'b0;
defparam syn__503_.BypassEn = 1'b0;
defparam syn__503_.CarryEnb = 1'b1;

alta_slice syn__504_(
	.A(vcc),
	.B(syn__133_),
	.C(syn__132_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__131_),
	.Cout(),
	.Q());
defparam syn__504_.coord_x = 5;
defparam syn__504_.coord_y = 6;
defparam syn__504_.coord_z = 8;
defparam syn__504_.mask = 16'hF300;
defparam syn__504_.modeMux = 1'b0;
defparam syn__504_.FeedbackMux = 1'b0;
defparam syn__504_.ShiftMux = 1'b0;
defparam syn__504_.BypassEn = 1'b0;
defparam syn__504_.CarryEnb = 1'b1;

alta_slice syn__505_(
	.A(\tc.IM [9]),
	.B(syn__091_),
	.C(syn__021_),
	.D(syn__092_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__132_),
	.Cout(),
	.Q());
defparam syn__505_.coord_x = 5;
defparam syn__505_.coord_y = 6;
defparam syn__505_.coord_z = 10;
defparam syn__505_.mask = 16'h1114;
defparam syn__505_.modeMux = 1'b0;
defparam syn__505_.FeedbackMux = 1'b0;
defparam syn__505_.ShiftMux = 1'b0;
defparam syn__505_.BypassEn = 1'b0;
defparam syn__505_.CarryEnb = 1'b1;

alta_slice syn__506_(
	.A(IOaddr[27]),
	.B(syn__102_),
	.C(IOvalue[27]),
	.D(syn__134_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__133_),
	.Cout(),
	.Q());
defparam syn__506_.coord_x = 5;
defparam syn__506_.coord_y = 6;
defparam syn__506_.coord_z = 9;
defparam syn__506_.mask = 16'h00B7;
defparam syn__506_.modeMux = 1'b0;
defparam syn__506_.FeedbackMux = 1'b0;
defparam syn__506_.ShiftMux = 1'b0;
defparam syn__506_.BypassEn = 1'b0;
defparam syn__506_.CarryEnb = 1'b1;

alta_slice syn__507_(
	.A(IOaddr[27]),
	.B(\tc.IM [7]),
	.C(IOvalue[27]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__134_),
	.Cout(),
	.Q());
defparam syn__507_.coord_x = 6;
defparam syn__507_.coord_y = 6;
defparam syn__507_.coord_z = 11;
defparam syn__507_.mask = 16'hE800;
defparam syn__507_.modeMux = 1'b0;
defparam syn__507_.FeedbackMux = 1'b0;
defparam syn__507_.ShiftMux = 1'b0;
defparam syn__507_.BypassEn = 1'b0;
defparam syn__507_.CarryEnb = 1'b1;

alta_slice syn__508_(
	.A(syn__312_),
	.B(syn__310_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__135_),
	.Cout(),
	.Q());
defparam syn__508_.coord_x = 7;
defparam syn__508_.coord_y = 3;
defparam syn__508_.coord_z = 6;
defparam syn__508_.mask = 16'hCFAF;
defparam syn__508_.modeMux = 1'b0;
defparam syn__508_.FeedbackMux = 1'b0;
defparam syn__508_.ShiftMux = 1'b0;
defparam syn__508_.BypassEn = 1'b0;
defparam syn__508_.CarryEnb = 1'b1;

alta_slice syn__509_(
	.A(vcc),
	.B(syn__032_),
	.C(syn__059_),
	.D(syn__058_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__136_),
	.Cout(),
	.Q());
defparam syn__509_.coord_x = 7;
defparam syn__509_.coord_y = 8;
defparam syn__509_.coord_z = 3;
defparam syn__509_.mask = 16'hFCC0;
defparam syn__509_.modeMux = 1'b0;
defparam syn__509_.FeedbackMux = 1'b0;
defparam syn__509_.ShiftMux = 1'b0;
defparam syn__509_.BypassEn = 1'b0;
defparam syn__509_.CarryEnb = 1'b1;

alta_slice syn__510_(
	.A(vcc),
	.B(syn__057_),
	.C(vcc),
	.D(syn__062_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__137_),
	.Cout(),
	.Q());
defparam syn__510_.coord_x = 7;
defparam syn__510_.coord_y = 8;
defparam syn__510_.coord_z = 14;
defparam syn__510_.mask = 16'h0033;
defparam syn__510_.modeMux = 1'b0;
defparam syn__510_.FeedbackMux = 1'b0;
defparam syn__510_.ShiftMux = 1'b0;
defparam syn__510_.BypassEn = 1'b0;
defparam syn__510_.CarryEnb = 1'b1;

alta_slice syn__511_(
	.A(syn__139_),
	.B(syn__044_),
	.C(syn__037_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__138_),
	.Cout(),
	.Q());
defparam syn__511_.coord_x = 5;
defparam syn__511_.coord_y = 8;
defparam syn__511_.coord_z = 12;
defparam syn__511_.mask = 16'h0056;
defparam syn__511_.modeMux = 1'b0;
defparam syn__511_.FeedbackMux = 1'b0;
defparam syn__511_.ShiftMux = 1'b0;
defparam syn__511_.BypassEn = 1'b0;
defparam syn__511_.CarryEnb = 1'b1;

alta_slice syn__512_(
	.A(vcc),
	.B(vcc),
	.C(syn__042_),
	.D(syn__043_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__139_),
	.Cout(),
	.Q());
defparam syn__512_.coord_x = 5;
defparam syn__512_.coord_y = 8;
defparam syn__512_.coord_z = 13;
defparam syn__512_.mask = 16'h0FF0;
defparam syn__512_.modeMux = 1'b0;
defparam syn__512_.FeedbackMux = 1'b0;
defparam syn__512_.ShiftMux = 1'b0;
defparam syn__512_.BypassEn = 1'b0;
defparam syn__512_.CarryEnb = 1'b1;

alta_slice syn__513_(
	.A(vcc),
	.B(vcc),
	.C(syn__132_),
	.D(syn__133_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__140_),
	.Cout(),
	.Q());
defparam syn__513_.coord_x = 5;
defparam syn__513_.coord_y = 6;
defparam syn__513_.coord_z = 6;
defparam syn__513_.mask = 16'h0F00;
defparam syn__513_.modeMux = 1'b0;
defparam syn__513_.FeedbackMux = 1'b0;
defparam syn__513_.ShiftMux = 1'b0;
defparam syn__513_.BypassEn = 1'b0;
defparam syn__513_.CarryEnb = 1'b1;

alta_slice syn__514_(
	.A(\tc.IM [9]),
	.B(syn__142_),
	.C(syn__075_),
	.D(syn__143_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__141_),
	.Cout(),
	.Q());
defparam syn__514_.coord_x = 8;
defparam syn__514_.coord_y = 5;
defparam syn__514_.coord_z = 13;
defparam syn__514_.mask = 16'hBE00;
defparam syn__514_.modeMux = 1'b0;
defparam syn__514_.FeedbackMux = 1'b0;
defparam syn__514_.ShiftMux = 1'b0;
defparam syn__514_.BypassEn = 1'b0;
defparam syn__514_.CarryEnb = 1'b1;

alta_slice syn__515_(
	.A(vcc),
	.B(syn__026_),
	.C(syn__076_),
	.D(syn__077_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__142_),
	.Cout(),
	.Q());
defparam syn__515_.coord_x = 8;
defparam syn__515_.coord_y = 5;
defparam syn__515_.coord_z = 1;
defparam syn__515_.mask = 16'h0F0C;
defparam syn__515_.modeMux = 1'b0;
defparam syn__515_.FeedbackMux = 1'b0;
defparam syn__515_.ShiftMux = 1'b0;
defparam syn__515_.BypassEn = 1'b0;
defparam syn__515_.CarryEnb = 1'b1;

alta_slice syn__516_(
	.A(IOaddr[20]),
	.B(syn__102_),
	.C(IOvalue[20]),
	.D(syn__144_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__143_),
	.Cout(),
	.Q());
defparam syn__516_.coord_x = 5;
defparam syn__516_.coord_y = 6;
defparam syn__516_.coord_z = 3;
defparam syn__516_.mask = 16'h00B7;
defparam syn__516_.modeMux = 1'b0;
defparam syn__516_.FeedbackMux = 1'b0;
defparam syn__516_.ShiftMux = 1'b0;
defparam syn__516_.BypassEn = 1'b0;
defparam syn__516_.CarryEnb = 1'b1;

alta_slice syn__517_(
	.A(IOaddr[20]),
	.B(\tc.IM [7]),
	.C(IOvalue[20]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__144_),
	.Cout(),
	.Q());
defparam syn__517_.coord_x = 6;
defparam syn__517_.coord_y = 6;
defparam syn__517_.coord_z = 7;
defparam syn__517_.mask = 16'hE800;
defparam syn__517_.modeMux = 1'b0;
defparam syn__517_.FeedbackMux = 1'b0;
defparam syn__517_.ShiftMux = 1'b0;
defparam syn__517_.BypassEn = 1'b0;
defparam syn__517_.CarryEnb = 1'b1;

alta_slice syn__518_(
	.A(vcc),
	.B(vcc),
	.C(syn__076_),
	.D(syn__077_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__145_),
	.Cout(),
	.Q());
defparam syn__518_.coord_x = 8;
defparam syn__518_.coord_y = 5;
defparam syn__518_.coord_z = 5;
defparam syn__518_.mask = 16'h000F;
defparam syn__518_.modeMux = 1'b0;
defparam syn__518_.FeedbackMux = 1'b0;
defparam syn__518_.ShiftMux = 1'b0;
defparam syn__518_.BypassEn = 1'b0;
defparam syn__518_.CarryEnb = 1'b1;

alta_slice syn__519_(
	.A(vcc),
	.B(vcc),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__146_),
	.Cout(),
	.Q());
defparam syn__519_.coord_x = 7;
defparam syn__519_.coord_y = 3;
defparam syn__519_.coord_z = 12;
defparam syn__519_.mask = 16'h00F0;
defparam syn__519_.modeMux = 1'b0;
defparam syn__519_.FeedbackMux = 1'b0;
defparam syn__519_.ShiftMux = 1'b0;
defparam syn__519_.BypassEn = 1'b0;
defparam syn__519_.CarryEnb = 1'b1;

alta_slice syn__520_(
	.A(syn__155_),
	.B(syn__356_),
	.C(syn__318_),
	.D(syn__354_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__147_),
	.Cout(),
	.Q());
defparam syn__520_.coord_x = 6;
defparam syn__520_.coord_y = 4;
defparam syn__520_.coord_z = 5;
defparam syn__520_.mask = 16'h8000;
defparam syn__520_.modeMux = 1'b0;
defparam syn__520_.FeedbackMux = 1'b0;
defparam syn__520_.ShiftMux = 1'b0;
defparam syn__520_.BypassEn = 1'b0;
defparam syn__520_.CarryEnb = 1'b1;

alta_slice syn__521_(
	.A(syn__087_),
	.B(syn__089_),
	.C(syn__022_),
	.D(syn__088_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__148_),
	.Cout(),
	.Q());
defparam syn__521_.coord_x = 5;
defparam syn__521_.coord_y = 4;
defparam syn__521_.coord_z = 0;
defparam syn__521_.mask = 16'hA995;
defparam syn__521_.modeMux = 1'b0;
defparam syn__521_.FeedbackMux = 1'b0;
defparam syn__521_.ShiftMux = 1'b0;
defparam syn__521_.BypassEn = 1'b0;
defparam syn__521_.CarryEnb = 1'b1;

alta_slice syn__522_(
	.A(syn__150_),
	.B(syn__151_),
	.C(\tc.IM [9]),
	.D(syn__073_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__149_),
	.Cout(),
	.Q());
defparam syn__522_.coord_x = 8;
defparam syn__522_.coord_y = 5;
defparam syn__522_.coord_z = 11;
defparam syn__522_.mask = 16'hC8C4;
defparam syn__522_.modeMux = 1'b0;
defparam syn__522_.FeedbackMux = 1'b0;
defparam syn__522_.ShiftMux = 1'b0;
defparam syn__522_.BypassEn = 1'b0;
defparam syn__522_.CarryEnb = 1'b1;

alta_slice syn__523_(
	.A(vcc),
	.B(vcc),
	.C(syn__027_),
	.D(syn__074_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__150_),
	.Cout(),
	.Q());
defparam syn__523_.coord_x = 8;
defparam syn__523_.coord_y = 5;
defparam syn__523_.coord_z = 2;
defparam syn__523_.mask = 16'h000F;
defparam syn__523_.modeMux = 1'b0;
defparam syn__523_.FeedbackMux = 1'b0;
defparam syn__523_.ShiftMux = 1'b0;
defparam syn__523_.BypassEn = 1'b0;
defparam syn__523_.CarryEnb = 1'b1;

alta_slice syn__524_(
	.A(syn__152_),
	.B(syn__102_),
	.C(IOvalue[18]),
	.D(IOaddr[18]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__151_),
	.Cout(),
	.Q());
defparam syn__524_.coord_x = 5;
defparam syn__524_.coord_y = 6;
defparam syn__524_.coord_z = 5;
defparam syn__524_.mask = 16'h5115;
defparam syn__524_.modeMux = 1'b0;
defparam syn__524_.FeedbackMux = 1'b0;
defparam syn__524_.ShiftMux = 1'b0;
defparam syn__524_.BypassEn = 1'b0;
defparam syn__524_.CarryEnb = 1'b1;

alta_slice syn__525_(
	.A(IOaddr[18]),
	.B(\tc.IM [7]),
	.C(IOvalue[18]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__152_),
	.Cout(),
	.Q());
defparam syn__525_.coord_x = 6;
defparam syn__525_.coord_y = 6;
defparam syn__525_.coord_z = 5;
defparam syn__525_.mask = 16'hE800;
defparam syn__525_.modeMux = 1'b0;
defparam syn__525_.FeedbackMux = 1'b0;
defparam syn__525_.ShiftMux = 1'b0;
defparam syn__525_.BypassEn = 1'b0;
defparam syn__525_.CarryEnb = 1'b1;

alta_slice syn__526_(
	.A(vcc),
	.B(vcc),
	.C(syn__059_),
	.D(syn__058_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__153_),
	.Cout(),
	.Q());
defparam syn__526_.coord_x = 7;
defparam syn__526_.coord_y = 8;
defparam syn__526_.coord_z = 4;
defparam syn__526_.mask = 16'h0FF0;
defparam syn__526_.modeMux = 1'b0;
defparam syn__526_.FeedbackMux = 1'b0;
defparam syn__526_.ShiftMux = 1'b0;
defparam syn__526_.BypassEn = 1'b0;
defparam syn__526_.CarryEnb = 1'b1;

alta_slice syn__527_(
	.A(vcc),
	.B(vcc),
	.C(\tc.IM [5]),
	.D(\tc.IM [6]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__154_),
	.Cout(),
	.Q());
defparam syn__527_.coord_x = 5;
defparam syn__527_.coord_y = 3;
defparam syn__527_.coord_z = 8;
defparam syn__527_.mask = 16'hF000;
defparam syn__527_.modeMux = 1'b0;
defparam syn__527_.FeedbackMux = 1'b0;
defparam syn__527_.ShiftMux = 1'b0;
defparam syn__527_.BypassEn = 1'b0;
defparam syn__527_.CarryEnb = 1'b1;

alta_slice syn__528_(
	.A(syn__156_),
	.B(syn__217_),
	.C(syn__214_),
	.D(syn__163_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__155_),
	.Cout(),
	.Q());
defparam syn__528_.coord_x = 4;
defparam syn__528_.coord_y = 4;
defparam syn__528_.coord_z = 0;
defparam syn__528_.mask = 16'h8000;
defparam syn__528_.modeMux = 1'b0;
defparam syn__528_.FeedbackMux = 1'b0;
defparam syn__528_.ShiftMux = 1'b0;
defparam syn__528_.BypassEn = 1'b0;
defparam syn__528_.CarryEnb = 1'b1;

alta_slice syn__529_(
	.A(syn__158_),
	.B(syn__324_),
	.C(syn__154_),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__156_),
	.Cout(),
	.Q());
defparam syn__529_.coord_x = 5;
defparam syn__529_.coord_y = 3;
defparam syn__529_.coord_z = 7;
defparam syn__529_.mask = 16'h8A8A;
defparam syn__529_.modeMux = 1'b0;
defparam syn__529_.FeedbackMux = 1'b0;
defparam syn__529_.ShiftMux = 1'b0;
defparam syn__529_.BypassEn = 1'b0;
defparam syn__529_.CarryEnb = 1'b1;

alta_slice syn__530_(
	.A(vcc),
	.B(syn__088_),
	.C(vcc),
	.D(syn__089_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__157_),
	.Cout(),
	.Q());
defparam syn__530_.coord_x = 5;
defparam syn__530_.coord_y = 4;
defparam syn__530_.coord_z = 10;
defparam syn__530_.mask = 16'h33CC;
defparam syn__530_.modeMux = 1'b0;
defparam syn__530_.FeedbackMux = 1'b0;
defparam syn__530_.ShiftMux = 1'b0;
defparam syn__530_.BypassEn = 1'b0;
defparam syn__530_.CarryEnb = 1'b1;

alta_slice syn__531_(
	.A(vcc),
	.B(syn__161_),
	.C(syn__326_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__158_),
	.Cout(),
	.Q());
defparam syn__531_.coord_x = 8;
defparam syn__531_.coord_y = 6;
defparam syn__531_.coord_z = 2;
defparam syn__531_.mask = 16'hC0CC;
defparam syn__531_.modeMux = 1'b0;
defparam syn__531_.FeedbackMux = 1'b0;
defparam syn__531_.ShiftMux = 1'b0;
defparam syn__531_.BypassEn = 1'b0;
defparam syn__531_.CarryEnb = 1'b1;

alta_slice syn__532_(
	.A(vcc),
	.B(syn__069_),
	.C(syn__028_),
	.D(syn__070_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__159_),
	.Cout(),
	.Q());
defparam syn__532_.coord_x = 8;
defparam syn__532_.coord_y = 7;
defparam syn__532_.coord_z = 9;
defparam syn__532_.mask = 16'hFCC0;
defparam syn__532_.modeMux = 1'b0;
defparam syn__532_.FeedbackMux = 1'b0;
defparam syn__532_.ShiftMux = 1'b0;
defparam syn__532_.BypassEn = 1'b0;
defparam syn__532_.CarryEnb = 1'b1;

alta_slice syn__533_(
	.A(vcc),
	.B(syn__071_),
	.C(vcc),
	.D(syn__074_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__160_),
	.Cout(),
	.Q());
defparam syn__533_.coord_x = 8;
defparam syn__533_.coord_y = 7;
defparam syn__533_.coord_z = 8;
defparam syn__533_.mask = 16'h0033;
defparam syn__533_.modeMux = 1'b0;
defparam syn__533_.FeedbackMux = 1'b0;
defparam syn__533_.ShiftMux = 1'b0;
defparam syn__533_.BypassEn = 1'b0;
defparam syn__533_.CarryEnb = 1'b1;

alta_slice syn__534_(
	.A(syn__322_),
	.B(syn__328_),
	.C(syn__108_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__161_),
	.Cout(),
	.Q());
defparam syn__534_.coord_x = 7;
defparam syn__534_.coord_y = 4;
defparam syn__534_.coord_z = 6;
defparam syn__534_.mask = 16'h8ACF;
defparam syn__534_.modeMux = 1'b0;
defparam syn__534_.FeedbackMux = 1'b0;
defparam syn__534_.ShiftMux = 1'b0;
defparam syn__534_.BypassEn = 1'b0;
defparam syn__534_.CarryEnb = 1'b1;

alta_slice syn__535_(
	.A(syn__033_),
	.B(syn__056_),
	.C(syn__055_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__162_),
	.Cout(),
	.Q());
defparam syn__535_.coord_x = 6;
defparam syn__535_.coord_y = 8;
defparam syn__535_.coord_z = 0;
defparam syn__535_.mask = 16'h0036;
defparam syn__535_.modeMux = 1'b0;
defparam syn__535_.FeedbackMux = 1'b0;
defparam syn__535_.ShiftMux = 1'b0;
defparam syn__535_.BypassEn = 1'b0;
defparam syn__535_.CarryEnb = 1'b1;

alta_slice syn__536_(
	.A(syn__175_),
	.B(syn__187_),
	.C(syn__164_),
	.D(syn__332_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__163_),
	.Cout(),
	.Q());
defparam syn__536_.coord_x = 4;
defparam syn__536_.coord_y = 4;
defparam syn__536_.coord_z = 9;
defparam syn__536_.mask = 16'h8000;
defparam syn__536_.modeMux = 1'b0;
defparam syn__536_.FeedbackMux = 1'b0;
defparam syn__536_.ShiftMux = 1'b0;
defparam syn__536_.BypassEn = 1'b0;
defparam syn__536_.CarryEnb = 1'b1;

alta_slice syn__537_(
	.A(syn__154_),
	.B(syn__165_),
	.C(syn__166_),
	.D(syn__173_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__164_),
	.Cout(),
	.Q());
defparam syn__537_.coord_x = 4;
defparam syn__537_.coord_y = 4;
defparam syn__537_.coord_z = 14;
defparam syn__537_.mask = 16'h7050;
defparam syn__537_.modeMux = 1'b0;
defparam syn__537_.FeedbackMux = 1'b0;
defparam syn__537_.ShiftMux = 1'b0;
defparam syn__537_.BypassEn = 1'b0;
defparam syn__537_.CarryEnb = 1'b1;

alta_slice syn__538_(
	.A(syn__023_),
	.B(syn__085_),
	.C(\tc.IM [9]),
	.D(syn__086_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__165_),
	.Cout(),
	.Q());
defparam syn__538_.coord_x = 5;
defparam syn__538_.coord_y = 5;
defparam syn__538_.coord_z = 5;
defparam syn__538_.mask = 16'h0C09;
defparam syn__538_.modeMux = 1'b0;
defparam syn__538_.FeedbackMux = 1'b0;
defparam syn__538_.ShiftMux = 1'b0;
defparam syn__538_.BypassEn = 1'b0;
defparam syn__538_.CarryEnb = 1'b1;

alta_slice syn__539_(
	.A(vcc),
	.B(syn__168_),
	.C(syn__330_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__166_),
	.Cout(),
	.Q());
defparam syn__539_.coord_x = 8;
defparam syn__539_.coord_y = 6;
defparam syn__539_.coord_z = 9;
defparam syn__539_.mask = 16'hC0CC;
defparam syn__539_.modeMux = 1'b0;
defparam syn__539_.FeedbackMux = 1'b0;
defparam syn__539_.ShiftMux = 1'b0;
defparam syn__539_.BypassEn = 1'b0;
defparam syn__539_.CarryEnb = 1'b1;

alta_slice syn__540_(
	.A(vcc),
	.B(syn__070_),
	.C(vcc),
	.D(syn__069_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__167_),
	.Cout(),
	.Q());
defparam syn__540_.coord_x = 8;
defparam syn__540_.coord_y = 7;
defparam syn__540_.coord_z = 14;
defparam syn__540_.mask = 16'h33CC;
defparam syn__540_.modeMux = 1'b0;
defparam syn__540_.FeedbackMux = 1'b0;
defparam syn__540_.ShiftMux = 1'b0;
defparam syn__540_.BypassEn = 1'b0;
defparam syn__540_.CarryEnb = 1'b1;

alta_slice syn__541_(
	.A(syn__328_),
	.B(syn__108_),
	.C(syn__169_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__168_),
	.Cout(),
	.Q());
defparam syn__541_.coord_x = 7;
defparam syn__541_.coord_y = 6;
defparam syn__541_.coord_z = 0;
defparam syn__541_.mask = 16'hA2F3;
defparam syn__541_.modeMux = 1'b0;
defparam syn__541_.FeedbackMux = 1'b0;
defparam syn__541_.ShiftMux = 1'b0;
defparam syn__541_.BypassEn = 1'b0;
defparam syn__541_.CarryEnb = 1'b1;

alta_slice syn__542_(
	.A(syn__171_),
	.B(syn__170_),
	.C(syn__051_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__169_),
	.Cout(),
	.Q());
defparam syn__542_.coord_x = 6;
defparam syn__542_.coord_y = 8;
defparam syn__542_.coord_z = 12;
defparam syn__542_.mask = 16'hAA28;
defparam syn__542_.modeMux = 1'b0;
defparam syn__542_.FeedbackMux = 1'b0;
defparam syn__542_.ShiftMux = 1'b0;
defparam syn__542_.BypassEn = 1'b0;
defparam syn__542_.CarryEnb = 1'b1;

alta_slice syn__543_(
	.A(vcc),
	.B(syn__053_),
	.C(syn__052_),
	.D(syn__034_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__170_),
	.Cout(),
	.Q());
defparam syn__543_.coord_x = 6;
defparam syn__543_.coord_y = 8;
defparam syn__543_.coord_z = 7;
defparam syn__543_.mask = 16'h0F0C;
defparam syn__543_.modeMux = 1'b0;
defparam syn__543_.FeedbackMux = 1'b0;
defparam syn__543_.ShiftMux = 1'b0;
defparam syn__543_.BypassEn = 1'b0;
defparam syn__543_.CarryEnb = 1'b1;

alta_slice syn__544_(
	.A(syn__102_),
	.B(IOvalue[8]),
	.C(IOaddr[8]),
	.D(syn__172_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__171_),
	.Cout(),
	.Q());
defparam syn__544_.coord_x = 5;
defparam syn__544_.coord_y = 7;
defparam syn__544_.coord_z = 4;
defparam syn__544_.mask = 16'h00D7;
defparam syn__544_.modeMux = 1'b0;
defparam syn__544_.FeedbackMux = 1'b0;
defparam syn__544_.ShiftMux = 1'b0;
defparam syn__544_.BypassEn = 1'b0;
defparam syn__544_.CarryEnb = 1'b1;

alta_slice syn__545_(
	.A(\tc.IM [7]),
	.B(syn__101_),
	.C(IOvalue[8]),
	.D(IOaddr[8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__172_),
	.Cout(),
	.Q());
defparam syn__545_.coord_x = 5;
defparam syn__545_.coord_y = 7;
defparam syn__545_.coord_z = 7;
defparam syn__545_.mask = 16'hC880;
defparam syn__545_.modeMux = 1'b0;
defparam syn__545_.FeedbackMux = 1'b0;
defparam syn__545_.ShiftMux = 1'b0;
defparam syn__545_.BypassEn = 1'b0;
defparam syn__545_.CarryEnb = 1'b1;

alta_slice syn__546_(
	.A(IOaddr[24]),
	.B(syn__102_),
	.C(syn__174_),
	.D(IOvalue[24]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__173_),
	.Cout(),
	.Q());
defparam syn__546_.coord_x = 5;
defparam syn__546_.coord_y = 6;
defparam syn__546_.coord_z = 7;
defparam syn__546_.mask = 16'h0B07;
defparam syn__546_.modeMux = 1'b0;
defparam syn__546_.FeedbackMux = 1'b0;
defparam syn__546_.ShiftMux = 1'b0;
defparam syn__546_.BypassEn = 1'b0;
defparam syn__546_.CarryEnb = 1'b1;

alta_slice syn__547_(
	.A(IOaddr[24]),
	.B(\tc.IM [7]),
	.C(IOvalue[24]),
	.D(syn__101_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__174_),
	.Cout(),
	.Q());
defparam syn__547_.coord_x = 6;
defparam syn__547_.coord_y = 6;
defparam syn__547_.coord_z = 15;
defparam syn__547_.mask = 16'hE800;
defparam syn__547_.modeMux = 1'b0;
defparam syn__547_.FeedbackMux = 1'b0;
defparam syn__547_.ShiftMux = 1'b0;
defparam syn__547_.BypassEn = 1'b0;
defparam syn__547_.CarryEnb = 1'b1;

alta_slice syn__548_(
	.A(syn__146_),
	.B(syn__165_),
	.C(syn__173_),
	.D(syn__176_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__175_),
	.Cout(),
	.Q());
defparam syn__548_.coord_x = 5;
defparam syn__548_.coord_y = 4;
defparam syn__548_.coord_z = 4;
defparam syn__548_.mask = 16'h7500;
defparam syn__548_.modeMux = 1'b0;
defparam syn__548_.FeedbackMux = 1'b0;
defparam syn__548_.ShiftMux = 1'b0;
defparam syn__548_.BypassEn = 1'b0;
defparam syn__548_.CarryEnb = 1'b1;

alta_slice syn__549_(
	.A(vcc),
	.B(syn__177_),
	.C(syn__326_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__176_),
	.Cout(),
	.Q());
defparam syn__549_.coord_x = 5;
defparam syn__549_.coord_y = 4;
defparam syn__549_.coord_z = 15;
defparam syn__549_.mask = 16'hC0CC;
defparam syn__549_.modeMux = 1'b0;
defparam syn__549_.FeedbackMux = 1'b0;
defparam syn__549_.ShiftMux = 1'b0;
defparam syn__549_.BypassEn = 1'b0;
defparam syn__549_.CarryEnb = 1'b1;

alta_slice syn__550_(
	.A(syn__330_),
	.B(syn__178_),
	.C(syn__154_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__177_),
	.Cout(),
	.Q());
defparam syn__550_.coord_x = 5;
defparam syn__550_.coord_y = 3;
defparam syn__550_.coord_z = 11;
defparam syn__550_.mask = 16'h8ACF;
defparam syn__550_.modeMux = 1'b0;
defparam syn__550_.FeedbackMux = 1'b0;
defparam syn__550_.ShiftMux = 1'b0;
defparam syn__550_.BypassEn = 1'b0;
defparam syn__550_.CarryEnb = 1'b1;

alta_slice syn__551_(
	.A(\tc.IM [9]),
	.B(syn__179_),
	.C(syn__181_),
	.D(syn__040_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__178_),
	.Cout(),
	.Q());
defparam syn__551_.coord_x = 5;
defparam syn__551_.coord_y = 7;
defparam syn__551_.coord_z = 0;
defparam syn__551_.mask = 16'hCCC8;
defparam syn__551_.modeMux = 1'b0;
defparam syn__551_.FeedbackMux = 1'b0;
defparam syn__551_.ShiftMux = 1'b0;
defparam syn__551_.BypassEn = 1'b0;
defparam syn__551_.CarryEnb = 1'b1;

alta_slice syn__552_(
	.A(syn__102_),
	.B(syn__180_),
	.C(IOvalue[0]),
	.D(IOaddr[0]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__179_),
	.Cout(),
	.Q());
defparam syn__552_.coord_x = 5;
defparam syn__552_.coord_y = 7;
defparam syn__552_.coord_z = 3;
defparam syn__552_.mask = 16'h3113;
defparam syn__552_.modeMux = 1'b0;
defparam syn__552_.FeedbackMux = 1'b0;
defparam syn__552_.ShiftMux = 1'b0;
defparam syn__552_.BypassEn = 1'b0;
defparam syn__552_.CarryEnb = 1'b1;

alta_slice syn__553_(
	.A(\tc.IM [7]),
	.B(syn__101_),
	.C(IOvalue[0]),
	.D(IOaddr[0]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__180_),
	.Cout(),
	.Q());
defparam syn__553_.coord_x = 5;
defparam syn__553_.coord_y = 7;
defparam syn__553_.coord_z = 15;
defparam syn__553_.mask = 16'hC880;
defparam syn__553_.modeMux = 1'b0;
defparam syn__553_.FeedbackMux = 1'b0;
defparam syn__553_.ShiftMux = 1'b0;
defparam syn__553_.BypassEn = 1'b0;
defparam syn__553_.CarryEnb = 1'b1;

alta_slice syn__554_(
	.A(IOvalue[0]),
	.B(IOaddr[0]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__181_),
	.Cout(),
	.Q());
defparam syn__554_.coord_x = 5;
defparam syn__554_.coord_y = 7;
defparam syn__554_.coord_z = 6;
defparam syn__554_.mask = 16'h0041;
defparam syn__554_.modeMux = 1'b0;
defparam syn__554_.FeedbackMux = 1'b0;
defparam syn__554_.ShiftMux = 1'b0;
defparam syn__554_.BypassEn = 1'b0;
defparam syn__554_.CarryEnb = 1'b1;

alta_slice syn__555_(
	.A(vcc),
	.B(syn__082_),
	.C(syn__024_),
	.D(syn__083_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__182_),
	.Cout(),
	.Q());
defparam syn__555_.coord_x = 5;
defparam syn__555_.coord_y = 5;
defparam syn__555_.coord_z = 15;
defparam syn__555_.mask = 16'hFCC0;
defparam syn__555_.modeMux = 1'b0;
defparam syn__555_.FeedbackMux = 1'b0;
defparam syn__555_.ShiftMux = 1'b0;
defparam syn__555_.BypassEn = 1'b0;
defparam syn__555_.CarryEnb = 1'b1;

alta_slice syn__556_(
	.A(vcc),
	.B(syn__081_),
	.C(vcc),
	.D(syn__086_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__183_),
	.Cout(),
	.Q());
defparam syn__556_.coord_x = 5;
defparam syn__556_.coord_y = 5;
defparam syn__556_.coord_z = 9;
defparam syn__556_.mask = 16'h0033;
defparam syn__556_.modeMux = 1'b0;
defparam syn__556_.FeedbackMux = 1'b0;
defparam syn__556_.ShiftMux = 1'b0;
defparam syn__556_.BypassEn = 1'b0;
defparam syn__556_.CarryEnb = 1'b1;

alta_slice syn__557_(
	.A(\tc.IM [9]),
	.B(syn__068_),
	.C(syn__029_),
	.D(syn__185_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__184_),
	.Cout(),
	.Q());
defparam syn__557_.coord_x = 6;
defparam syn__557_.coord_y = 7;
defparam syn__557_.coord_z = 0;
defparam syn__557_.mask = 16'h0154;
defparam syn__557_.modeMux = 1'b0;
defparam syn__557_.FeedbackMux = 1'b0;
defparam syn__557_.ShiftMux = 1'b0;
defparam syn__557_.BypassEn = 1'b0;
defparam syn__557_.CarryEnb = 1'b1;

alta_slice syn__558_(
	.A(vcc),
	.B(vcc),
	.C(syn__066_),
	.D(syn__067_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__185_),
	.Cout(),
	.Q());
defparam syn__558_.coord_x = 6;
defparam syn__558_.coord_y = 7;
defparam syn__558_.coord_z = 15;
defparam syn__558_.mask = 16'h0FF0;
defparam syn__558_.modeMux = 1'b0;
defparam syn__558_.FeedbackMux = 1'b0;
defparam syn__558_.ShiftMux = 1'b0;
defparam syn__558_.BypassEn = 1'b0;
defparam syn__558_.CarryEnb = 1'b1;

alta_slice syn__559_(
	.A(vcc),
	.B(vcc),
	.C(syn__052_),
	.D(syn__053_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__186_),
	.Cout(),
	.Q());
defparam syn__559_.coord_x = 6;
defparam syn__559_.coord_y = 8;
defparam syn__559_.coord_z = 10;
defparam syn__559_.mask = 16'h000F;
defparam syn__559_.modeMux = 1'b0;
defparam syn__559_.FeedbackMux = 1'b0;
defparam syn__559_.ShiftMux = 1'b0;
defparam syn__559_.BypassEn = 1'b0;
defparam syn__559_.CarryEnb = 1'b1;

alta_slice syn__560_(
	.A(syn__188_),
	.B(syn__192_),
	.C(syn__344_),
	.D(syn__199_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__187_),
	.Cout(),
	.Q());
defparam syn__560_.coord_x = 2;
defparam syn__560_.coord_y = 6;
defparam syn__560_.coord_z = 15;
defparam syn__560_.mask = 16'h8000;
defparam syn__560_.modeMux = 1'b0;
defparam syn__560_.FeedbackMux = 1'b0;
defparam syn__560_.ShiftMux = 1'b0;
defparam syn__560_.BypassEn = 1'b0;
defparam syn__560_.CarryEnb = 1'b1;

alta_slice syn__561_(
	.A(vcc),
	.B(syn__340_),
	.C(syn__154_),
	.D(syn__190_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__188_),
	.Cout(),
	.Q());
defparam syn__561_.coord_x = 4;
defparam syn__561_.coord_y = 4;
defparam syn__561_.coord_z = 4;
defparam syn__561_.mask = 16'hCF00;
defparam syn__561_.modeMux = 1'b0;
defparam syn__561_.FeedbackMux = 1'b0;
defparam syn__561_.ShiftMux = 1'b0;
defparam syn__561_.BypassEn = 1'b0;
defparam syn__561_.CarryEnb = 1'b1;

alta_slice syn__562_(
	.A(vcc),
	.B(vcc),
	.C(syn__083_),
	.D(syn__082_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__189_),
	.Cout(),
	.Q());
defparam syn__562_.coord_x = 5;
defparam syn__562_.coord_y = 5;
defparam syn__562_.coord_z = 12;
defparam syn__562_.mask = 16'h0FF0;
defparam syn__562_.modeMux = 1'b0;
defparam syn__562_.FeedbackMux = 1'b0;
defparam syn__562_.ShiftMux = 1'b0;
defparam syn__562_.BypassEn = 1'b0;
defparam syn__562_.CarryEnb = 1'b1;

alta_slice syn__563_(
	.A(syn__191_),
	.B(syn__146_),
	.C(syn__110_),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__190_),
	.Cout(),
	.Q());
defparam syn__563_.coord_x = 8;
defparam syn__563_.coord_y = 6;
defparam syn__563_.coord_z = 0;
defparam syn__563_.mask = 16'hA2A2;
defparam syn__563_.modeMux = 1'b0;
defparam syn__563_.FeedbackMux = 1'b0;
defparam syn__563_.ShiftMux = 1'b0;
defparam syn__563_.BypassEn = 1'b0;
defparam syn__563_.CarryEnb = 1'b1;

alta_slice syn__564_(
	.A(syn__302_),
	.B(syn__108_),
	.C(syn__338_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__191_),
	.Cout(),
	.Q());
defparam syn__564_.coord_x = 7;
defparam syn__564_.coord_y = 6;
defparam syn__564_.coord_z = 2;
defparam syn__564_.mask = 16'hB0BB;
defparam syn__564_.modeMux = 1'b0;
defparam syn__564_.FeedbackMux = 1'b0;
defparam syn__564_.ShiftMux = 1'b0;
defparam syn__564_.BypassEn = 1'b0;
defparam syn__564_.CarryEnb = 1'b1;

alta_slice syn__565_(
	.A(vcc),
	.B(syn__195_),
	.C(syn__342_),
	.D(syn__154_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__192_),
	.Cout(),
	.Q());
defparam syn__565_.coord_x = 2;
defparam syn__565_.coord_y = 6;
defparam syn__565_.coord_z = 14;
defparam syn__565_.mask = 16'hC0CC;
defparam syn__565_.modeMux = 1'b0;
defparam syn__565_.FeedbackMux = 1'b0;
defparam syn__565_.ShiftMux = 1'b0;
defparam syn__565_.BypassEn = 1'b0;
defparam syn__565_.CarryEnb = 1'b1;

alta_slice syn__566_(
	.A(syn__080_),
	.B(vcc),
	.C(syn__025_),
	.D(vcc),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__193_),
	.Cout(),
	.Q());
defparam syn__566_.coord_x = 5;
defparam syn__566_.coord_y = 5;
defparam syn__566_.coord_z = 2;
defparam syn__566_.mask = 16'h0505;
defparam syn__566_.modeMux = 1'b0;
defparam syn__566_.FeedbackMux = 1'b0;
defparam syn__566_.ShiftMux = 1'b0;
defparam syn__566_.BypassEn = 1'b0;
defparam syn__566_.CarryEnb = 1'b1;

alta_slice syn__567_(
	.A(vcc),
	.B(syn__079_),
	.C(vcc),
	.D(syn__078_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__194_),
	.Cout(),
	.Q());
defparam syn__567_.coord_x = 5;
defparam syn__567_.coord_y = 5;
defparam syn__567_.coord_z = 4;
defparam syn__567_.mask = 16'h33CC;
defparam syn__567_.modeMux = 1'b0;
defparam syn__567_.FeedbackMux = 1'b0;
defparam syn__567_.ShiftMux = 1'b0;
defparam syn__567_.BypassEn = 1'b0;
defparam syn__567_.CarryEnb = 1'b1;

alta_slice syn__568_(
	.A(vcc),
	.B(syn__196_),
	.C(syn__304_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__195_),
	.Cout(),
	.Q());
defparam syn__568_.coord_x = 8;
defparam syn__568_.coord_y = 6;
defparam syn__568_.coord_z = 4;
defparam syn__568_.mask = 16'hC0CC;
defparam syn__568_.modeMux = 1'b0;
defparam syn__568_.FeedbackMux = 1'b0;
defparam syn__568_.ShiftMux = 1'b0;
defparam syn__568_.BypassEn = 1'b0;
defparam syn__568_.CarryEnb = 1'b1;

alta_slice syn__569_(
	.A(syn__306_),
	.B(syn__108_),
	.C(syn__302_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__196_),
	.Cout(),
	.Q());
defparam syn__569_.coord_x = 7;
defparam syn__569_.coord_y = 6;
defparam syn__569_.coord_z = 5;
defparam syn__569_.mask = 16'hB0BB;
defparam syn__569_.modeMux = 1'b0;
defparam syn__569_.FeedbackMux = 1'b0;
defparam syn__569_.ShiftMux = 1'b0;
defparam syn__569_.BypassEn = 1'b0;
defparam syn__569_.CarryEnb = 1'b1;

alta_slice syn__570_(
	.A(syn__061_),
	.B(syn__062_),
	.C(syn__031_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__197_),
	.Cout(),
	.Q());
defparam syn__570_.coord_x = 7;
defparam syn__570_.coord_y = 8;
defparam syn__570_.coord_z = 1;
defparam syn__570_.mask = 16'h0056;
defparam syn__570_.modeMux = 1'b0;
defparam syn__570_.FeedbackMux = 1'b0;
defparam syn__570_.ShiftMux = 1'b0;
defparam syn__570_.BypassEn = 1'b0;
defparam syn__570_.CarryEnb = 1'b1;

alta_slice syn__571_(
	.A(vcc),
	.B(vcc),
	.C(syn__047_),
	.D(syn__046_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__198_),
	.Cout(),
	.Q());
defparam syn__571_.coord_x = 5;
defparam syn__571_.coord_y = 8;
defparam syn__571_.coord_z = 3;
defparam syn__571_.mask = 16'h0FF0;
defparam syn__571_.modeMux = 1'b0;
defparam syn__571_.FeedbackMux = 1'b0;
defparam syn__571_.ShiftMux = 1'b0;
defparam syn__571_.BypassEn = 1'b0;
defparam syn__571_.CarryEnb = 1'b1;

alta_slice syn__572_(
	.A(syn__200_),
	.B(syn__203_),
	.C(syn__211_),
	.D(syn__207_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__199_),
	.Cout(),
	.Q());
defparam syn__572_.coord_x = 2;
defparam syn__572_.coord_y = 6;
defparam syn__572_.coord_z = 11;
defparam syn__572_.mask = 16'h8000;
defparam syn__572_.modeMux = 1'b0;
defparam syn__572_.FeedbackMux = 1'b0;
defparam syn__572_.ShiftMux = 1'b0;
defparam syn__572_.BypassEn = 1'b0;
defparam syn__572_.CarryEnb = 1'b1;

alta_slice syn__573_(
	.A(vcc),
	.B(syn__201_),
	.C(syn__316_),
	.D(syn__154_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__200_),
	.Cout(),
	.Q());
defparam syn__573_.coord_x = 2;
defparam syn__573_.coord_y = 6;
defparam syn__573_.coord_z = 10;
defparam syn__573_.mask = 16'hC0CC;
defparam syn__573_.modeMux = 1'b0;
defparam syn__573_.FeedbackMux = 1'b0;
defparam syn__573_.ShiftMux = 1'b0;
defparam syn__573_.BypassEn = 1'b0;
defparam syn__573_.CarryEnb = 1'b1;

alta_slice syn__574_(
	.A(vcc),
	.B(syn__202_),
	.C(syn__310_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__201_),
	.Cout(),
	.Q());
defparam syn__574_.coord_x = 8;
defparam syn__574_.coord_y = 6;
defparam syn__574_.coord_z = 8;
defparam syn__574_.mask = 16'hC0CC;
defparam syn__574_.modeMux = 1'b0;
defparam syn__574_.FeedbackMux = 1'b0;
defparam syn__574_.ShiftMux = 1'b0;
defparam syn__574_.BypassEn = 1'b0;
defparam syn__574_.CarryEnb = 1'b1;

alta_slice syn__575_(
	.A(syn__348_),
	.B(syn__115_),
	.C(syn__312_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__202_),
	.Cout(),
	.Q());
defparam syn__575_.coord_x = 7;
defparam syn__575_.coord_y = 6;
defparam syn__575_.coord_z = 3;
defparam syn__575_.mask = 16'hB0BB;
defparam syn__575_.modeMux = 1'b0;
defparam syn__575_.FeedbackMux = 1'b0;
defparam syn__575_.ShiftMux = 1'b0;
defparam syn__575_.BypassEn = 1'b0;
defparam syn__575_.CarryEnb = 1'b1;

alta_slice syn__576_(
	.A(vcc),
	.B(syn__204_),
	.C(syn__154_),
	.D(syn__149_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__203_),
	.Cout(),
	.Q());
defparam syn__576_.coord_x = 5;
defparam syn__576_.coord_y = 3;
defparam syn__576_.coord_z = 3;
defparam syn__576_.mask = 16'hCC0C;
defparam syn__576_.modeMux = 1'b0;
defparam syn__576_.FeedbackMux = 1'b0;
defparam syn__576_.ShiftMux = 1'b0;
defparam syn__576_.BypassEn = 1'b0;
defparam syn__576_.CarryEnb = 1'b1;

alta_slice syn__577_(
	.A(syn__205_),
	.B(vcc),
	.C(syn__322_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__204_),
	.Cout(),
	.Q());
defparam syn__577_.coord_x = 7;
defparam syn__577_.coord_y = 4;
defparam syn__577_.coord_z = 9;
defparam syn__577_.mask = 16'hA0AA;
defparam syn__577_.modeMux = 1'b0;
defparam syn__577_.FeedbackMux = 1'b0;
defparam syn__577_.ShiftMux = 1'b0;
defparam syn__577_.BypassEn = 1'b0;
defparam syn__577_.CarryEnb = 1'b1;

alta_slice syn__578_(
	.A(syn__350_),
	.B(syn__312_),
	.C(syn__108_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__205_),
	.Cout(),
	.Q());
defparam syn__578_.coord_x = 7;
defparam syn__578_.coord_y = 4;
defparam syn__578_.coord_z = 14;
defparam syn__578_.mask = 16'h8CAF;
defparam syn__578_.modeMux = 1'b0;
defparam syn__578_.FeedbackMux = 1'b0;
defparam syn__578_.ShiftMux = 1'b0;
defparam syn__578_.BypassEn = 1'b0;
defparam syn__578_.CarryEnb = 1'b1;

alta_slice syn__579_(
	.A(syn__041_),
	.B(syn__039_),
	.C(syn__038_),
	.D(syn__040_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__206_),
	.Cout(),
	.Q());
defparam syn__579_.coord_x = 5;
defparam syn__579_.coord_y = 7;
defparam syn__579_.coord_z = 8;
defparam syn__579_.mask = 16'h95A9;
defparam syn__579_.modeMux = 1'b0;
defparam syn__579_.FeedbackMux = 1'b0;
defparam syn__579_.ShiftMux = 1'b0;
defparam syn__579_.BypassEn = 1'b0;
defparam syn__579_.CarryEnb = 1'b1;

alta_slice syn__580_(
	.A(vcc),
	.B(syn__208_),
	.C(syn__154_),
	.D(syn__326_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__207_),
	.Cout(),
	.Q());
defparam syn__580_.coord_x = 5;
defparam syn__580_.coord_y = 3;
defparam syn__580_.coord_z = 6;
defparam syn__580_.mask = 16'hCC0C;
defparam syn__580_.modeMux = 1'b0;
defparam syn__580_.FeedbackMux = 1'b0;
defparam syn__580_.ShiftMux = 1'b0;
defparam syn__580_.BypassEn = 1'b0;
defparam syn__580_.CarryEnb = 1'b1;

alta_slice syn__581_(
	.A(vcc),
	.B(syn__209_),
	.C(syn__328_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__208_),
	.Cout(),
	.Q());
defparam syn__581_.coord_x = 8;
defparam syn__581_.coord_y = 6;
defparam syn__581_.coord_z = 6;
defparam syn__581_.mask = 16'hC0CC;
defparam syn__581_.modeMux = 1'b0;
defparam syn__581_.FeedbackMux = 1'b0;
defparam syn__581_.ShiftMux = 1'b0;
defparam syn__581_.BypassEn = 1'b0;
defparam syn__581_.CarryEnb = 1'b1;

alta_slice syn__582_(
	.A(syn__350_),
	.B(syn__352_),
	.C(syn__108_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__209_),
	.Cout(),
	.Q());
defparam syn__582_.coord_x = 7;
defparam syn__582_.coord_y = 4;
defparam syn__582_.coord_z = 1;
defparam syn__582_.mask = 16'h8ACF;
defparam syn__582_.modeMux = 1'b0;
defparam syn__582_.FeedbackMux = 1'b0;
defparam syn__582_.ShiftMux = 1'b0;
defparam syn__582_.BypassEn = 1'b0;
defparam syn__582_.CarryEnb = 1'b1;

alta_slice syn__583_(
	.A(vcc),
	.B(vcc),
	.C(syn__038_),
	.D(syn__039_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__210_),
	.Cout(),
	.Q());
defparam syn__583_.coord_x = 5;
defparam syn__583_.coord_y = 7;
defparam syn__583_.coord_z = 12;
defparam syn__583_.mask = 16'h0FF0;
defparam syn__583_.modeMux = 1'b0;
defparam syn__583_.FeedbackMux = 1'b0;
defparam syn__583_.ShiftMux = 1'b0;
defparam syn__583_.BypassEn = 1'b0;
defparam syn__583_.CarryEnb = 1'b1;

alta_slice syn__584_(
	.A(syn__330_),
	.B(vcc),
	.C(syn__154_),
	.D(syn__212_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__211_),
	.Cout(),
	.Q());
defparam syn__584_.coord_x = 5;
defparam syn__584_.coord_y = 3;
defparam syn__584_.coord_z = 2;
defparam syn__584_.mask = 16'hAF00;
defparam syn__584_.modeMux = 1'b0;
defparam syn__584_.FeedbackMux = 1'b0;
defparam syn__584_.ShiftMux = 1'b0;
defparam syn__584_.BypassEn = 1'b0;
defparam syn__584_.CarryEnb = 1'b1;

alta_slice syn__585_(
	.A(syn__146_),
	.B(vcc),
	.C(syn__213_),
	.D(syn__169_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__212_),
	.Cout(),
	.Q());
defparam syn__585_.coord_x = 5;
defparam syn__585_.coord_y = 4;
defparam syn__585_.coord_z = 14;
defparam syn__585_.mask = 16'hF050;
defparam syn__585_.modeMux = 1'b0;
defparam syn__585_.FeedbackMux = 1'b0;
defparam syn__585_.ShiftMux = 1'b0;
defparam syn__585_.BypassEn = 1'b0;
defparam syn__585_.CarryEnb = 1'b1;

alta_slice syn__586_(
	.A(syn__178_),
	.B(syn__352_),
	.C(syn__108_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__213_),
	.Cout(),
	.Q());
defparam syn__586_.coord_x = 7;
defparam syn__586_.coord_y = 4;
defparam syn__586_.coord_z = 5;
defparam syn__586_.mask = 16'h8CAF;
defparam syn__586_.modeMux = 1'b0;
defparam syn__586_.FeedbackMux = 1'b0;
defparam syn__586_.ShiftMux = 1'b0;
defparam syn__586_.BypassEn = 1'b0;
defparam syn__586_.CarryEnb = 1'b1;

alta_slice syn__587_(
	.A(syn__146_),
	.B(vcc),
	.C(syn__215_),
	.D(syn__324_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__214_),
	.Cout(),
	.Q());
defparam syn__587_.coord_x = 5;
defparam syn__587_.coord_y = 4;
defparam syn__587_.coord_z = 7;
defparam syn__587_.mask = 16'hF050;
defparam syn__587_.modeMux = 1'b0;
defparam syn__587_.FeedbackMux = 1'b0;
defparam syn__587_.ShiftMux = 1'b0;
defparam syn__587_.BypassEn = 1'b0;
defparam syn__587_.CarryEnb = 1'b1;

alta_slice syn__588_(
	.A(syn__216_),
	.B(vcc),
	.C(syn__149_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__215_),
	.Cout(),
	.Q());
defparam syn__588_.coord_x = 7;
defparam syn__588_.coord_y = 4;
defparam syn__588_.coord_z = 4;
defparam syn__588_.mask = 16'hA0AA;
defparam syn__588_.modeMux = 1'b0;
defparam syn__588_.FeedbackMux = 1'b0;
defparam syn__588_.ShiftMux = 1'b0;
defparam syn__588_.BypassEn = 1'b0;
defparam syn__588_.CarryEnb = 1'b1;

alta_slice syn__589_(
	.A(syn__352_),
	.B(syn__326_),
	.C(syn__154_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__216_),
	.Cout(),
	.Q());
defparam syn__589_.coord_x = 5;
defparam syn__589_.coord_y = 3;
defparam syn__589_.coord_z = 9;
defparam syn__589_.mask = 16'h8CAF;
defparam syn__589_.modeMux = 1'b0;
defparam syn__589_.FeedbackMux = 1'b0;
defparam syn__589_.ShiftMux = 1'b0;
defparam syn__589_.BypassEn = 1'b0;
defparam syn__589_.CarryEnb = 1'b1;

alta_slice syn__590_(
	.A(syn__324_),
	.B(syn__218_),
	.C(syn__219_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__217_),
	.Cout(),
	.Q());
defparam syn__590_.coord_x = 7;
defparam syn__590_.coord_y = 4;
defparam syn__590_.coord_z = 3;
defparam syn__590_.mask = 16'h2030;
defparam syn__590_.modeMux = 1'b0;
defparam syn__590_.FeedbackMux = 1'b0;
defparam syn__590_.ShiftMux = 1'b0;
defparam syn__590_.BypassEn = 1'b0;
defparam syn__590_.CarryEnb = 1'b1;

alta_slice syn__591_(
	.A(syn__108_),
	.B(syn__165_),
	.C(vcc),
	.D(syn__173_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__218_),
	.Cout(),
	.Q());
defparam syn__591_.coord_x = 4;
defparam syn__591_.coord_y = 4;
defparam syn__591_.coord_z = 12;
defparam syn__591_.mask = 16'h88AA;
defparam syn__591_.modeMux = 1'b0;
defparam syn__591_.FeedbackMux = 1'b0;
defparam syn__591_.ShiftMux = 1'b0;
defparam syn__591_.BypassEn = 1'b0;
defparam syn__591_.CarryEnb = 1'b1;

alta_slice syn__592_(
	.A(syn__169_),
	.B(syn__178_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__219_),
	.Cout(),
	.Q());
defparam syn__592_.coord_x = 7;
defparam syn__592_.coord_y = 4;
defparam syn__592_.coord_z = 2;
defparam syn__592_.mask = 16'hAFCF;
defparam syn__592_.modeMux = 1'b0;
defparam syn__592_.FeedbackMux = 1'b0;
defparam syn__592_.ShiftMux = 1'b0;
defparam syn__592_.BypassEn = 1'b0;
defparam syn__592_.CarryEnb = 1'b1;

alta_slice syn__593_(
	.A(syn__140_),
	.B(syn__358_),
	.C(syn__221_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__220_),
	.Cout(),
	.Q());
defparam syn__593_.coord_x = 6;
defparam syn__593_.coord_y = 3;
defparam syn__593_.coord_z = 6;
defparam syn__593_.mask = 16'h80C0;
defparam syn__593_.modeMux = 1'b0;
defparam syn__593_.FeedbackMux = 1'b0;
defparam syn__593_.ShiftMux = 1'b0;
defparam syn__593_.BypassEn = 1'b0;
defparam syn__593_.CarryEnb = 1'b1;

alta_slice syn__594_(
	.A(syn__222_),
	.B(syn__133_),
	.C(syn__132_),
	.D(syn__154_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__221_),
	.Cout(),
	.Q());
defparam syn__594_.coord_x = 5;
defparam syn__594_.coord_y = 6;
defparam syn__594_.coord_z = 15;
defparam syn__594_.mask = 16'h08AA;
defparam syn__594_.modeMux = 1'b0;
defparam syn__594_.FeedbackMux = 1'b0;
defparam syn__594_.ShiftMux = 1'b0;
defparam syn__594_.BypassEn = 1'b0;
defparam syn__594_.CarryEnb = 1'b1;

alta_slice syn__595_(
	.A(vcc),
	.B(syn__223_),
	.C(syn__316_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__222_),
	.Cout(),
	.Q());
defparam syn__595_.coord_x = 8;
defparam syn__595_.coord_y = 6;
defparam syn__595_.coord_z = 14;
defparam syn__595_.mask = 16'hC0CC;
defparam syn__595_.modeMux = 1'b0;
defparam syn__595_.FeedbackMux = 1'b0;
defparam syn__595_.ShiftMux = 1'b0;
defparam syn__595_.BypassEn = 1'b0;
defparam syn__595_.CarryEnb = 1'b1;

alta_slice syn__596_(
	.A(syn__108_),
	.B(syn__115_),
	.C(syn__310_),
	.D(syn__346_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__223_),
	.Cout(),
	.Q());
defparam syn__596_.coord_x = 7;
defparam syn__596_.coord_y = 6;
defparam syn__596_.coord_z = 11;
defparam syn__596_.mask = 16'hF531;
defparam syn__596_.modeMux = 1'b0;
defparam syn__596_.FeedbackMux = 1'b0;
defparam syn__596_.ShiftMux = 1'b0;
defparam syn__596_.BypassEn = 1'b0;
defparam syn__596_.CarryEnb = 1'b1;

alta_slice syn__597_(
	.A(vcc),
	.B(vcc),
	.C(syn__225_),
	.D(syn__228_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__224_),
	.Cout(),
	.Q());
defparam syn__597_.coord_x = 6;
defparam syn__597_.coord_y = 3;
defparam syn__597_.coord_z = 11;
defparam syn__597_.mask = 16'hF000;
defparam syn__597_.modeMux = 1'b0;
defparam syn__597_.FeedbackMux = 1'b0;
defparam syn__597_.ShiftMux = 1'b0;
defparam syn__597_.BypassEn = 1'b0;
defparam syn__597_.CarryEnb = 1'b1;

alta_slice syn__598_(
	.A(syn__146_),
	.B(vcc),
	.C(syn__308_),
	.D(syn__226_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__225_),
	.Cout(),
	.Q());
defparam syn__598_.coord_x = 5;
defparam syn__598_.coord_y = 4;
defparam syn__598_.coord_z = 13;
defparam syn__598_.mask = 16'hF500;
defparam syn__598_.modeMux = 1'b0;
defparam syn__598_.FeedbackMux = 1'b0;
defparam syn__598_.ShiftMux = 1'b0;
defparam syn__598_.BypassEn = 1'b0;
defparam syn__598_.CarryEnb = 1'b1;

alta_slice syn__599_(
	.A(vcc),
	.B(syn__227_),
	.C(syn__342_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__226_),
	.Cout(),
	.Q());
defparam syn__599_.coord_x = 7;
defparam syn__599_.coord_y = 4;
defparam syn__599_.coord_z = 0;
defparam syn__599_.mask = 16'hC0CC;
defparam syn__599_.modeMux = 1'b0;
defparam syn__599_.FeedbackMux = 1'b0;
defparam syn__599_.ShiftMux = 1'b0;
defparam syn__599_.BypassEn = 1'b0;
defparam syn__599_.CarryEnb = 1'b1;

alta_slice syn__600_(
	.A(syn__348_),
	.B(syn__141_),
	.C(syn__154_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__227_),
	.Cout(),
	.Q());
defparam syn__600_.coord_x = 5;
defparam syn__600_.coord_y = 3;
defparam syn__600_.coord_z = 4;
defparam syn__600_.mask = 16'h8CAF;
defparam syn__600_.modeMux = 1'b0;
defparam syn__600_.FeedbackMux = 1'b0;
defparam syn__600_.ShiftMux = 1'b0;
defparam syn__600_.BypassEn = 1'b0;
defparam syn__600_.CarryEnb = 1'b1;

alta_slice syn__601_(
	.A(syn__308_),
	.B(vcc),
	.C(syn__154_),
	.D(syn__229_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__228_),
	.Cout(),
	.Q());
defparam syn__601_.coord_x = 5;
defparam syn__601_.coord_y = 3;
defparam syn__601_.coord_z = 10;
defparam syn__601_.mask = 16'hAF00;
defparam syn__601_.modeMux = 1'b0;
defparam syn__601_.FeedbackMux = 1'b0;
defparam syn__601_.ShiftMux = 1'b0;
defparam syn__601_.BypassEn = 1'b0;
defparam syn__601_.CarryEnb = 1'b1;

alta_slice syn__602_(
	.A(vcc),
	.B(syn__230_),
	.C(syn__141_),
	.D(syn__146_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__229_),
	.Cout(),
	.Q());
defparam syn__602_.coord_x = 8;
defparam syn__602_.coord_y = 6;
defparam syn__602_.coord_z = 3;
defparam syn__602_.mask = 16'hC0CC;
defparam syn__602_.modeMux = 1'b0;
defparam syn__602_.FeedbackMux = 1'b0;
defparam syn__602_.ShiftMux = 1'b0;
defparam syn__602_.BypassEn = 1'b0;
defparam syn__602_.CarryEnb = 1'b1;

alta_slice syn__603_(
	.A(syn__346_),
	.B(syn__108_),
	.C(syn__304_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__230_),
	.Cout(),
	.Q());
defparam syn__603_.coord_x = 7;
defparam syn__603_.coord_y = 6;
defparam syn__603_.coord_z = 8;
defparam syn__603_.mask = 16'hB0BB;
defparam syn__603_.modeMux = 1'b0;
defparam syn__603_.FeedbackMux = 1'b0;
defparam syn__603_.ShiftMux = 1'b0;
defparam syn__603_.BypassEn = 1'b0;
defparam syn__603_.CarryEnb = 1'b1;

alta_slice syn__604_(
	.A(syn__362_),
	.B(syn__233_),
	.C(syn__232_),
	.D(syn__234_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__231_),
	.Cout(),
	.Q());
defparam syn__604_.coord_x = 6;
defparam syn__604_.coord_y = 3;
defparam syn__604_.coord_z = 1;
defparam syn__604_.mask = 16'h0200;
defparam syn__604_.modeMux = 1'b0;
defparam syn__604_.FeedbackMux = 1'b0;
defparam syn__604_.ShiftMux = 1'b0;
defparam syn__604_.BypassEn = 1'b0;
defparam syn__604_.CarryEnb = 1'b1;

alta_slice syn__605_(
	.A(syn__121_),
	.B(syn__119_),
	.C(\tc.IM [9]),
	.D(syn__154_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__232_),
	.Cout(),
	.Q());
defparam syn__605_.coord_x = 6;
defparam syn__605_.coord_y = 3;
defparam syn__605_.coord_z = 12;
defparam syn__605_.mask = 16'h5D00;
defparam syn__605_.modeMux = 1'b0;
defparam syn__605_.FeedbackMux = 1'b0;
defparam syn__605_.ShiftMux = 1'b0;
defparam syn__605_.BypassEn = 1'b0;
defparam syn__605_.CarryEnb = 1'b1;

alta_slice syn__606_(
	.A(\tc.IM [9]),
	.B(syn__119_),
	.C(syn__121_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__233_),
	.Cout(),
	.Q());
defparam syn__606_.coord_x = 6;
defparam syn__606_.coord_y = 3;
defparam syn__606_.coord_z = 15;
defparam syn__606_.mask = 16'h4F00;
defparam syn__606_.modeMux = 1'b0;
defparam syn__606_.FeedbackMux = 1'b0;
defparam syn__606_.ShiftMux = 1'b0;
defparam syn__606_.BypassEn = 1'b0;
defparam syn__606_.CarryEnb = 1'b1;

alta_slice syn__607_(
	.A(vcc),
	.B(syn__110_),
	.C(syn__235_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__234_),
	.Cout(),
	.Q());
defparam syn__607_.coord_x = 7;
defparam syn__607_.coord_y = 4;
defparam syn__607_.coord_z = 12;
defparam syn__607_.mask = 16'hC0F0;
defparam syn__607_.modeMux = 1'b0;
defparam syn__607_.FeedbackMux = 1'b0;
defparam syn__607_.ShiftMux = 1'b0;
defparam syn__607_.BypassEn = 1'b0;
defparam syn__607_.CarryEnb = 1'b1;

alta_slice syn__608_(
	.A(syn__304_),
	.B(syn__342_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__235_),
	.Cout(),
	.Q());
defparam syn__608_.coord_x = 7;
defparam syn__608_.coord_y = 3;
defparam syn__608_.coord_z = 8;
defparam syn__608_.mask = 16'hFFCA;
defparam syn__608_.modeMux = 1'b0;
defparam syn__608_.FeedbackMux = 1'b0;
defparam syn__608_.ShiftMux = 1'b0;
defparam syn__608_.BypassEn = 1'b0;
defparam syn__608_.CarryEnb = 1'b1;

alta_slice syn__609_(
	.A(vcc),
	.B(syn__237_),
	.C(vcc),
	.D(syn__240_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__236_),
	.Cout(),
	.Q());
defparam syn__609_.coord_x = 4;
defparam syn__609_.coord_y = 4;
defparam syn__609_.coord_z = 3;
defparam syn__609_.mask = 16'hCC00;
defparam syn__609_.modeMux = 1'b0;
defparam syn__609_.FeedbackMux = 1'b0;
defparam syn__609_.ShiftMux = 1'b0;
defparam syn__609_.BypassEn = 1'b0;
defparam syn__609_.CarryEnb = 1'b1;

alta_slice syn__610_(
	.A(syn__105_),
	.B(syn__106_),
	.C(syn__146_),
	.D(syn__238_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__237_),
	.Cout(),
	.Q());
defparam syn__610_.coord_x = 5;
defparam syn__610_.coord_y = 4;
defparam syn__610_.coord_z = 12;
defparam syn__610_.mask = 16'h4F00;
defparam syn__610_.modeMux = 1'b0;
defparam syn__610_.FeedbackMux = 1'b0;
defparam syn__610_.ShiftMux = 1'b0;
defparam syn__610_.BypassEn = 1'b0;
defparam syn__610_.CarryEnb = 1'b1;

alta_slice syn__611_(
	.A(vcc),
	.B(syn__239_),
	.C(syn__334_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__238_),
	.Cout(),
	.Q());
defparam syn__611_.coord_x = 5;
defparam syn__611_.coord_y = 4;
defparam syn__611_.coord_z = 3;
defparam syn__611_.mask = 16'hC0CC;
defparam syn__611_.modeMux = 1'b0;
defparam syn__611_.FeedbackMux = 1'b0;
defparam syn__611_.ShiftMux = 1'b0;
defparam syn__611_.BypassEn = 1'b0;
defparam syn__611_.CarryEnb = 1'b1;

alta_slice syn__612_(
	.A(syn__154_),
	.B(syn__108_),
	.C(syn__340_),
	.D(syn__302_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__239_),
	.Cout(),
	.Q());
defparam syn__612_.coord_x = 5;
defparam syn__612_.coord_y = 3;
defparam syn__612_.coord_z = 15;
defparam syn__612_.mask = 16'hF351;
defparam syn__612_.modeMux = 1'b0;
defparam syn__612_.FeedbackMux = 1'b0;
defparam syn__612_.ShiftMux = 1'b0;
defparam syn__612_.BypassEn = 1'b0;
defparam syn__612_.CarryEnb = 1'b1;

alta_slice syn__613_(
	.A(syn__154_),
	.B(syn__106_),
	.C(syn__241_),
	.D(syn__105_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__240_),
	.Cout(),
	.Q());
defparam syn__613_.coord_x = 4;
defparam syn__613_.coord_y = 4;
defparam syn__613_.coord_z = 2;
defparam syn__613_.mask = 16'h50D0;
defparam syn__613_.modeMux = 1'b0;
defparam syn__613_.FeedbackMux = 1'b0;
defparam syn__613_.ShiftMux = 1'b0;
defparam syn__613_.BypassEn = 1'b0;
defparam syn__613_.CarryEnb = 1'b1;

alta_slice syn__614_(
	.A(vcc),
	.B(syn__146_),
	.C(syn__242_),
	.D(syn__340_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__241_),
	.Cout(),
	.Q());
defparam syn__614_.coord_x = 7;
defparam syn__614_.coord_y = 6;
defparam syn__614_.coord_z = 4;
defparam syn__614_.mask = 16'hF030;
defparam syn__614_.modeMux = 1'b0;
defparam syn__614_.FeedbackMux = 1'b0;
defparam syn__614_.ShiftMux = 1'b0;
defparam syn__614_.BypassEn = 1'b0;
defparam syn__614_.CarryEnb = 1'b1;

alta_slice syn__615_(
	.A(syn__108_),
	.B(syn__110_),
	.C(syn__336_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__242_),
	.Cout(),
	.Q());
defparam syn__615_.coord_x = 7;
defparam syn__615_.coord_y = 6;
defparam syn__615_.coord_z = 10;
defparam syn__615_.mask = 16'hD0DD;
defparam syn__615_.modeMux = 1'b0;
defparam syn__615_.FeedbackMux = 1'b0;
defparam syn__615_.ShiftMux = 1'b0;
defparam syn__615_.BypassEn = 1'b0;
defparam syn__615_.CarryEnb = 1'b1;

alta_slice syn__616_(
	.A(syn__250_),
	.B(vcc),
	.C(syn__247_),
	.D(syn__244_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__243_),
	.Cout(),
	.Q());
defparam syn__616_.coord_x = 7;
defparam syn__616_.coord_y = 3;
defparam syn__616_.coord_z = 14;
defparam syn__616_.mask = 16'hA000;
defparam syn__616_.modeMux = 1'b0;
defparam syn__616_.FeedbackMux = 1'b0;
defparam syn__616_.ShiftMux = 1'b0;
defparam syn__616_.BypassEn = 1'b0;
defparam syn__616_.CarryEnb = 1'b1;

alta_slice syn__617_(
	.A(vcc),
	.B(syn__245_),
	.C(syn__154_),
	.D(syn__017_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__244_),
	.Cout(),
	.Q());
defparam syn__617_.coord_x = 5;
defparam syn__617_.coord_y = 3;
defparam syn__617_.coord_z = 5;
defparam syn__617_.mask = 16'hCC0C;
defparam syn__617_.modeMux = 1'b0;
defparam syn__617_.FeedbackMux = 1'b0;
defparam syn__617_.ShiftMux = 1'b0;
defparam syn__617_.BypassEn = 1'b0;
defparam syn__617_.CarryEnb = 1'b1;

alta_slice syn__618_(
	.A(syn__146_),
	.B(vcc),
	.C(syn__334_),
	.D(syn__246_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__245_),
	.Cout(),
	.Q());
defparam syn__618_.coord_x = 5;
defparam syn__618_.coord_y = 4;
defparam syn__618_.coord_z = 5;
defparam syn__618_.mask = 16'hF500;
defparam syn__618_.modeMux = 1'b0;
defparam syn__618_.FeedbackMux = 1'b0;
defparam syn__618_.ShiftMux = 1'b0;
defparam syn__618_.BypassEn = 1'b0;
defparam syn__618_.CarryEnb = 1'b1;

alta_slice syn__619_(
	.A(syn__115_),
	.B(syn__330_),
	.C(syn__336_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__246_),
	.Cout(),
	.Q());
defparam syn__619_.coord_x = 5;
defparam syn__619_.coord_y = 3;
defparam syn__619_.coord_z = 14;
defparam syn__619_.mask = 16'hD0DD;
defparam syn__619_.modeMux = 1'b0;
defparam syn__619_.FeedbackMux = 1'b0;
defparam syn__619_.ShiftMux = 1'b0;
defparam syn__619_.BypassEn = 1'b0;
defparam syn__619_.CarryEnb = 1'b1;

alta_slice syn__620_(
	.A(vcc),
	.B(syn__017_),
	.C(syn__248_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__247_),
	.Cout(),
	.Q());
defparam syn__620_.coord_x = 5;
defparam syn__620_.coord_y = 3;
defparam syn__620_.coord_z = 12;
defparam syn__620_.mask = 16'hC0F0;
defparam syn__620_.modeMux = 1'b0;
defparam syn__620_.FeedbackMux = 1'b0;
defparam syn__620_.ShiftMux = 1'b0;
defparam syn__620_.BypassEn = 1'b0;
defparam syn__620_.CarryEnb = 1'b1;

alta_slice syn__621_(
	.A(syn__154_),
	.B(syn__336_),
	.C(vcc),
	.D(syn__249_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__248_),
	.Cout(),
	.Q());
defparam syn__621_.coord_x = 5;
defparam syn__621_.coord_y = 3;
defparam syn__621_.coord_z = 0;
defparam syn__621_.mask = 16'hDD00;
defparam syn__621_.modeMux = 1'b0;
defparam syn__621_.FeedbackMux = 1'b0;
defparam syn__621_.ShiftMux = 1'b0;
defparam syn__621_.BypassEn = 1'b0;
defparam syn__621_.CarryEnb = 1'b1;

alta_slice syn__622_(
	.A(syn__146_),
	.B(syn__178_),
	.C(syn__338_),
	.D(syn__115_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__249_),
	.Cout(),
	.Q());
defparam syn__622_.coord_x = 7;
defparam syn__622_.coord_y = 4;
defparam syn__622_.coord_z = 8;
defparam syn__622_.mask = 16'hC4F5;
defparam syn__622_.modeMux = 1'b0;
defparam syn__622_.FeedbackMux = 1'b0;
defparam syn__622_.ShiftMux = 1'b0;
defparam syn__622_.BypassEn = 1'b0;
defparam syn__622_.CarryEnb = 1'b1;

alta_slice syn__623_(
	.A(vcc),
	.B(syn__251_),
	.C(syn__146_),
	.D(syn__017_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__250_),
	.Cout(),
	.Q());
defparam syn__623_.coord_x = 7;
defparam syn__623_.coord_y = 3;
defparam syn__623_.coord_z = 10;
defparam syn__623_.mask = 16'hCC0C;
defparam syn__623_.modeMux = 1'b0;
defparam syn__623_.FeedbackMux = 1'b0;
defparam syn__623_.ShiftMux = 1'b0;
defparam syn__623_.BypassEn = 1'b0;
defparam syn__623_.CarryEnb = 1'b1;

alta_slice syn__624_(
	.A(syn__115_),
	.B(syn__165_),
	.C(syn__252_),
	.D(syn__173_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__251_),
	.Cout(),
	.Q());
defparam syn__624_.coord_x = 4;
defparam syn__624_.coord_y = 4;
defparam syn__624_.coord_z = 6;
defparam syn__624_.mask = 16'h7050;
defparam syn__624_.modeMux = 1'b0;
defparam syn__624_.FeedbackMux = 1'b0;
defparam syn__624_.ShiftMux = 1'b0;
defparam syn__624_.BypassEn = 1'b0;
defparam syn__624_.CarryEnb = 1'b1;

alta_slice syn__625_(
	.A(syn__334_),
	.B(syn__338_),
	.C(syn__154_),
	.D(syn__108_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__252_),
	.Cout(),
	.Q());
defparam syn__625_.coord_x = 5;
defparam syn__625_.coord_y = 3;
defparam syn__625_.coord_z = 1;
defparam syn__625_.mask = 16'h8ACF;
defparam syn__625_.modeMux = 1'b0;
defparam syn__625_.FeedbackMux = 1'b0;
defparam syn__625_.ShiftMux = 1'b0;
defparam syn__625_.BypassEn = 1'b0;
defparam syn__625_.CarryEnb = 1'b1;

alta_slice syn__626_(
	.A(vcc),
	.B(\tc.IM [24]),
	.C(syn__247_),
	.D(\tc.IM [4]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__253_),
	.Cout(),
	.Q());
defparam syn__626_.coord_x = 7;
defparam syn__626_.coord_y = 3;
defparam syn__626_.coord_z = 5;
defparam syn__626_.mask = 16'h3303;
defparam syn__626_.modeMux = 1'b0;
defparam syn__626_.FeedbackMux = 1'b0;
defparam syn__626_.ShiftMux = 1'b0;
defparam syn__626_.BypassEn = 1'b0;
defparam syn__626_.CarryEnb = 1'b1;

alta_slice syn__627_(
	.A(\tc.IM [1]),
	.B(\tc.IM [0]),
	.C(\tc.IM [2]),
	.D(\tc.IM [24]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__254_),
	.Cout(),
	.Q());
defparam syn__627_.coord_x = 2;
defparam syn__627_.coord_y = 6;
defparam syn__627_.coord_z = 12;
defparam syn__627_.mask = 16'h0020;
defparam syn__627_.modeMux = 1'b0;
defparam syn__627_.FeedbackMux = 1'b0;
defparam syn__627_.ShiftMux = 1'b0;
defparam syn__627_.BypassEn = 1'b0;
defparam syn__627_.CarryEnb = 1'b1;

alta_slice syn__629_(
	.A(vcc),
	.B(vcc),
	.C(\tc.PC [0]),
	.D(syn__014_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__255_),
	.Cout(),
	.Q());
defparam syn__629_.coord_x = 1;
defparam syn__629_.coord_y = 6;
defparam syn__629_.coord_z = 5;
defparam syn__629_.mask = 16'h000F;
defparam syn__629_.modeMux = 1'b0;
defparam syn__629_.FeedbackMux = 1'b0;
defparam syn__629_.ShiftMux = 1'b0;
defparam syn__629_.BypassEn = 1'b0;
defparam syn__629_.CarryEnb = 1'b1;

alta_slice syn__631_(
	.A(vcc),
	.B(\tc.PC [1]),
	.C(\tc.PC [0]),
	.D(syn__014_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__256_),
	.Cout(),
	.Q());
defparam syn__631_.coord_x = 1;
defparam syn__631_.coord_y = 6;
defparam syn__631_.coord_z = 7;
defparam syn__631_.mask = 16'hCCC0;
defparam syn__631_.modeMux = 1'b0;
defparam syn__631_.FeedbackMux = 1'b0;
defparam syn__631_.ShiftMux = 1'b0;
defparam syn__631_.BypassEn = 1'b0;
defparam syn__631_.CarryEnb = 1'b1;

alta_slice syn__633_(
	.A(\tc.PC [2]),
	.B(\tc.PC [1]),
	.C(\tc.PC [0]),
	.D(syn__014_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__257_),
	.Cout(),
	.Q());
defparam syn__633_.coord_x = 1;
defparam syn__633_.coord_y = 6;
defparam syn__633_.coord_z = 10;
defparam syn__633_.mask = 16'h8880;
defparam syn__633_.modeMux = 1'b0;
defparam syn__633_.FeedbackMux = 1'b0;
defparam syn__633_.ShiftMux = 1'b0;
defparam syn__633_.BypassEn = 1'b0;
defparam syn__633_.CarryEnb = 1'b1;

alta_slice syn__635_(
	.A(syn__259_),
	.B(vcc),
	.C(\tc.PC [0]),
	.D(syn__014_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__258_),
	.Cout(),
	.Q());
defparam syn__635_.coord_x = 1;
defparam syn__635_.coord_y = 6;
defparam syn__635_.coord_z = 13;
defparam syn__635_.mask = 16'hAAA0;
defparam syn__635_.modeMux = 1'b0;
defparam syn__635_.FeedbackMux = 1'b0;
defparam syn__635_.ShiftMux = 1'b0;
defparam syn__635_.BypassEn = 1'b0;
defparam syn__635_.CarryEnb = 1'b1;

alta_slice syn__636_(
	.A(\tc.PC [3]),
	.B(vcc),
	.C(\tc.PC [2]),
	.D(\tc.PC [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__259_),
	.Cout(),
	.Q());
defparam syn__636_.coord_x = 1;
defparam syn__636_.coord_y = 6;
defparam syn__636_.coord_z = 14;
defparam syn__636_.mask = 16'hA000;
defparam syn__636_.modeMux = 1'b0;
defparam syn__636_.FeedbackMux = 1'b0;
defparam syn__636_.ShiftMux = 1'b0;
defparam syn__636_.BypassEn = 1'b0;
defparam syn__636_.CarryEnb = 1'b1;

alta_slice syn__638_(
	.A(\tc.PC [5]),
	.B(syn__261_),
	.C(\tc.PC [0]),
	.D(syn__014_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__260_),
	.Cout(),
	.Q());
defparam syn__638_.coord_x = 1;
defparam syn__638_.coord_y = 6;
defparam syn__638_.coord_z = 11;
defparam syn__638_.mask = 16'h9995;
defparam syn__638_.modeMux = 1'b0;
defparam syn__638_.FeedbackMux = 1'b0;
defparam syn__638_.ShiftMux = 1'b0;
defparam syn__638_.BypassEn = 1'b0;
defparam syn__638_.CarryEnb = 1'b1;

alta_slice syn__639_(
	.A(vcc),
	.B(vcc),
	.C(syn__259_),
	.D(\tc.PC [4]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__261_),
	.Cout(),
	.Q());
defparam syn__639_.coord_x = 2;
defparam syn__639_.coord_y = 6;
defparam syn__639_.coord_z = 9;
defparam syn__639_.mask = 16'hF000;
defparam syn__639_.modeMux = 1'b0;
defparam syn__639_.FeedbackMux = 1'b0;
defparam syn__639_.ShiftMux = 1'b0;
defparam syn__639_.BypassEn = 1'b0;
defparam syn__639_.CarryEnb = 1'b1;

alta_slice syn__641_(
	.A(\tc.PC [6]),
	.B(syn__014_),
	.C(syn__263_),
	.D(\tc.PC [0]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__262_),
	.Cout(),
	.Q());
defparam syn__641_.coord_x = 1;
defparam syn__641_.coord_y = 6;
defparam syn__641_.coord_z = 9;
defparam syn__641_.mask = 16'hA595;
defparam syn__641_.modeMux = 1'b0;
defparam syn__641_.FeedbackMux = 1'b0;
defparam syn__641_.ShiftMux = 1'b0;
defparam syn__641_.BypassEn = 1'b0;
defparam syn__641_.CarryEnb = 1'b1;

alta_slice syn__642_(
	.A(vcc),
	.B(vcc),
	.C(\tc.PC [5]),
	.D(syn__261_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__263_),
	.Cout(),
	.Q());
defparam syn__642_.coord_x = 4;
defparam syn__642_.coord_y = 7;
defparam syn__642_.coord_z = 3;
defparam syn__642_.mask = 16'hF000;
defparam syn__642_.modeMux = 1'b0;
defparam syn__642_.FeedbackMux = 1'b0;
defparam syn__642_.ShiftMux = 1'b0;
defparam syn__642_.BypassEn = 1'b0;
defparam syn__642_.CarryEnb = 1'b1;

alta_slice syn__643_(
	.A(syn__247_),
	.B(\tc.DM [31]),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [31]),
	.Cout(),
	.Q());
defparam syn__643_.coord_x = 4;
defparam syn__643_.coord_y = 3;
defparam syn__643_.coord_z = 1;
defparam syn__643_.mask = 16'hD5C0;
defparam syn__643_.modeMux = 1'b0;
defparam syn__643_.FeedbackMux = 1'b0;
defparam syn__643_.ShiftMux = 1'b0;
defparam syn__643_.BypassEn = 1'b0;
defparam syn__643_.CarryEnb = 1'b1;

alta_slice syn__644_(
	.A(\tc.IM [0]),
	.B(\tc.IM [24]),
	.C(\tc.IM [2]),
	.D(\tc.IM [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__264_),
	.Cout(),
	.Q());
defparam syn__644_.coord_x = 4;
defparam syn__644_.coord_y = 7;
defparam syn__644_.coord_z = 0;
defparam syn__644_.mask = 16'h0010;
defparam syn__644_.modeMux = 1'b0;
defparam syn__644_.FeedbackMux = 1'b0;
defparam syn__644_.ShiftMux = 1'b0;
defparam syn__644_.BypassEn = 1'b0;
defparam syn__644_.CarryEnb = 1'b1;

alta_slice syn__645_(
	.A(\tc.DM [30]),
	.B(syn__016_),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [30]),
	.Cout(),
	.Q());
defparam syn__645_.coord_x = 4;
defparam syn__645_.coord_y = 3;
defparam syn__645_.coord_z = 11;
defparam syn__645_.mask = 16'hB3A0;
defparam syn__645_.modeMux = 1'b0;
defparam syn__645_.FeedbackMux = 1'b0;
defparam syn__645_.ShiftMux = 1'b0;
defparam syn__645_.BypassEn = 1'b0;
defparam syn__645_.CarryEnb = 1'b1;

alta_slice syn__646_(
	.A(\tc.DM [29]),
	.B(syn__116_),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [29]),
	.Cout(),
	.Q());
defparam syn__646_.coord_x = 4;
defparam syn__646_.coord_y = 3;
defparam syn__646_.coord_z = 7;
defparam syn__646_.mask = 16'hB3A0;
defparam syn__646_.modeMux = 1'b0;
defparam syn__646_.FeedbackMux = 1'b0;
defparam syn__646_.ShiftMux = 1'b0;
defparam syn__646_.BypassEn = 1'b0;
defparam syn__646_.CarryEnb = 1'b1;

alta_slice syn__647_(
	.A(\tc.DM [28]),
	.B(syn__264_),
	.C(vcc),
	.D(syn__265_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [28]),
	.Cout(),
	.Q());
defparam syn__647_.coord_x = 4;
defparam syn__647_.coord_y = 5;
defparam syn__647_.coord_z = 7;
defparam syn__647_.mask = 16'hFF88;
defparam syn__647_.modeMux = 1'b0;
defparam syn__647_.FeedbackMux = 1'b0;
defparam syn__647_.ShiftMux = 1'b0;
defparam syn__647_.BypassEn = 1'b0;
defparam syn__647_.CarryEnb = 1'b1;

alta_slice syn__648_(
	.A(syn__362_),
	.B(vcc),
	.C(syn__005_),
	.D(syn__233_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__265_),
	.Cout(),
	.Q());
defparam syn__648_.coord_x = 6;
defparam syn__648_.coord_y = 3;
defparam syn__648_.coord_z = 9;
defparam syn__648_.mask = 16'hF050;
defparam syn__648_.modeMux = 1'b0;
defparam syn__648_.FeedbackMux = 1'b0;
defparam syn__648_.ShiftMux = 1'b0;
defparam syn__648_.BypassEn = 1'b0;
defparam syn__648_.CarryEnb = 1'b1;

alta_slice syn__649_(
	.A(syn__129_),
	.B(\tc.DM [27]),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [27]),
	.Cout(),
	.Q());
defparam syn__649_.coord_x = 6;
defparam syn__649_.coord_y = 4;
defparam syn__649_.coord_z = 15;
defparam syn__649_.mask = 16'hD5C0;
defparam syn__649_.modeMux = 1'b0;
defparam syn__649_.FeedbackMux = 1'b0;
defparam syn__649_.ShiftMux = 1'b0;
defparam syn__649_.BypassEn = 1'b0;
defparam syn__649_.CarryEnb = 1'b1;

alta_slice syn__650_(
	.A(vcc),
	.B(\tc.DM [26]),
	.C(syn__264_),
	.D(syn__266_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [26]),
	.Cout(),
	.Q());
defparam syn__650_.coord_x = 6;
defparam syn__650_.coord_y = 4;
defparam syn__650_.coord_z = 3;
defparam syn__650_.mask = 16'hFFC0;
defparam syn__650_.modeMux = 1'b0;
defparam syn__650_.FeedbackMux = 1'b0;
defparam syn__650_.ShiftMux = 1'b0;
defparam syn__650_.BypassEn = 1'b0;
defparam syn__650_.CarryEnb = 1'b1;

alta_slice syn__651_(
	.A(syn__358_),
	.B(syn__115_),
	.C(syn__140_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__266_),
	.Cout(),
	.Q());
defparam syn__651_.coord_x = 6;
defparam syn__651_.coord_y = 4;
defparam syn__651_.coord_z = 2;
defparam syn__651_.mask = 16'h5D00;
defparam syn__651_.modeMux = 1'b0;
defparam syn__651_.FeedbackMux = 1'b0;
defparam syn__651_.ShiftMux = 1'b0;
defparam syn__651_.BypassEn = 1'b0;
defparam syn__651_.CarryEnb = 1'b1;

alta_slice syn__652_(
	.A(\tc.DM [25]),
	.B(syn__356_),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [25]),
	.Cout(),
	.Q());
defparam syn__652_.coord_x = 6;
defparam syn__652_.coord_y = 4;
defparam syn__652_.coord_z = 8;
defparam syn__652_.mask = 16'hB3A0;
defparam syn__652_.modeMux = 1'b0;
defparam syn__652_.FeedbackMux = 1'b0;
defparam syn__652_.ShiftMux = 1'b0;
defparam syn__652_.BypassEn = 1'b0;
defparam syn__652_.CarryEnb = 1'b1;

alta_slice syn__653_(
	.A(\tc.DM [24]),
	.B(syn__217_),
	.C(syn__264_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [24]),
	.Cout(),
	.Q());
defparam syn__653_.coord_x = 4;
defparam syn__653_.coord_y = 3;
defparam syn__653_.coord_z = 5;
defparam syn__653_.mask = 16'hB3A0;
defparam syn__653_.modeMux = 1'b0;
defparam syn__653_.FeedbackMux = 1'b0;
defparam syn__653_.ShiftMux = 1'b0;
defparam syn__653_.BypassEn = 1'b0;
defparam syn__653_.CarryEnb = 1'b1;

alta_slice syn__654_(
	.A(vcc),
	.B(syn__267_),
	.C(syn__250_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [23]),
	.Cout(),
	.Q());
defparam syn__654_.coord_x = 7;
defparam syn__654_.coord_y = 3;
defparam syn__654_.coord_z = 15;
defparam syn__654_.mask = 16'h3F33;
defparam syn__654_.modeMux = 1'b0;
defparam syn__654_.FeedbackMux = 1'b0;
defparam syn__654_.ShiftMux = 1'b0;
defparam syn__654_.BypassEn = 1'b0;
defparam syn__654_.CarryEnb = 1'b1;

alta_slice syn__655_(
	.A(\tc.IM [23]),
	.B(\tc.IM [24]),
	.C(\tc.DM [23]),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__267_),
	.Cout(),
	.Q());
defparam syn__655_.coord_x = 4;
defparam syn__655_.coord_y = 5;
defparam syn__655_.coord_z = 5;
defparam syn__655_.mask = 16'h0777;
defparam syn__655_.modeMux = 1'b0;
defparam syn__655_.FeedbackMux = 1'b0;
defparam syn__655_.ShiftMux = 1'b0;
defparam syn__655_.BypassEn = 1'b0;
defparam syn__655_.CarryEnb = 1'b1;

alta_slice syn__656_(
	.A(syn__268_),
	.B(vcc),
	.C(syn__237_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [22]),
	.Cout(),
	.Q());
defparam syn__656_.coord_x = 4;
defparam syn__656_.coord_y = 3;
defparam syn__656_.coord_z = 9;
defparam syn__656_.mask = 16'h5F55;
defparam syn__656_.modeMux = 1'b0;
defparam syn__656_.FeedbackMux = 1'b0;
defparam syn__656_.ShiftMux = 1'b0;
defparam syn__656_.BypassEn = 1'b0;
defparam syn__656_.CarryEnb = 1'b1;

alta_slice syn__657_(
	.A(\tc.IM [22]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.DM [22]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__268_),
	.Cout(),
	.Q());
defparam syn__657_.coord_x = 4;
defparam syn__657_.coord_y = 3;
defparam syn__657_.coord_z = 4;
defparam syn__657_.mask = 16'h0777;
defparam syn__657_.modeMux = 1'b0;
defparam syn__657_.FeedbackMux = 1'b0;
defparam syn__657_.ShiftMux = 1'b0;
defparam syn__657_.BypassEn = 1'b0;
defparam syn__657_.CarryEnb = 1'b1;

alta_slice syn__658_(
	.A(syn__360_),
	.B(vcc),
	.C(syn__005_),
	.D(syn__269_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [21]),
	.Cout(),
	.Q());
defparam syn__658_.coord_x = 6;
defparam syn__658_.coord_y = 3;
defparam syn__658_.coord_z = 3;
defparam syn__658_.mask = 16'h50FF;
defparam syn__658_.modeMux = 1'b0;
defparam syn__658_.FeedbackMux = 1'b0;
defparam syn__658_.ShiftMux = 1'b0;
defparam syn__658_.BypassEn = 1'b0;
defparam syn__658_.CarryEnb = 1'b1;

alta_slice syn__659_(
	.A(\tc.IM [21]),
	.B(\tc.IM [24]),
	.C(\tc.DM [21]),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__269_),
	.Cout(),
	.Q());
defparam syn__659_.coord_x = 4;
defparam syn__659_.coord_y = 5;
defparam syn__659_.coord_z = 9;
defparam syn__659_.mask = 16'h0777;
defparam syn__659_.modeMux = 1'b0;
defparam syn__659_.FeedbackMux = 1'b0;
defparam syn__659_.ShiftMux = 1'b0;
defparam syn__659_.BypassEn = 1'b0;
defparam syn__659_.CarryEnb = 1'b1;

alta_slice syn__660_(
	.A(syn__270_),
	.B(vcc),
	.C(syn__225_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [20]),
	.Cout(),
	.Q());
defparam syn__660_.coord_x = 4;
defparam syn__660_.coord_y = 3;
defparam syn__660_.coord_z = 2;
defparam syn__660_.mask = 16'h5F55;
defparam syn__660_.modeMux = 1'b0;
defparam syn__660_.FeedbackMux = 1'b0;
defparam syn__660_.ShiftMux = 1'b0;
defparam syn__660_.BypassEn = 1'b0;
defparam syn__660_.CarryEnb = 1'b1;

alta_slice syn__661_(
	.A(\tc.IM [20]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.DM [20]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__270_),
	.Cout(),
	.Q());
defparam syn__661_.coord_x = 4;
defparam syn__661_.coord_y = 3;
defparam syn__661_.coord_z = 8;
defparam syn__661_.mask = 16'h0777;
defparam syn__661_.modeMux = 1'b0;
defparam syn__661_.FeedbackMux = 1'b0;
defparam syn__661_.ShiftMux = 1'b0;
defparam syn__661_.BypassEn = 1'b0;
defparam syn__661_.CarryEnb = 1'b1;

alta_slice syn__662_(
	.A(vcc),
	.B(syn__314_),
	.C(syn__271_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [19]),
	.Cout(),
	.Q());
defparam syn__662_.coord_x = 6;
defparam syn__662_.coord_y = 4;
defparam syn__662_.coord_z = 9;
defparam syn__662_.mask = 16'h3F0F;
defparam syn__662_.modeMux = 1'b0;
defparam syn__662_.FeedbackMux = 1'b0;
defparam syn__662_.ShiftMux = 1'b0;
defparam syn__662_.BypassEn = 1'b0;
defparam syn__662_.CarryEnb = 1'b1;

alta_slice syn__663_(
	.A(\tc.IM [19]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.DM [19]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__271_),
	.Cout(),
	.Q());
defparam syn__663_.coord_x = 6;
defparam syn__663_.coord_y = 4;
defparam syn__663_.coord_z = 10;
defparam syn__663_.mask = 16'h0777;
defparam syn__663_.modeMux = 1'b0;
defparam syn__663_.FeedbackMux = 1'b0;
defparam syn__663_.ShiftMux = 1'b0;
defparam syn__663_.BypassEn = 1'b0;
defparam syn__663_.CarryEnb = 1'b1;

alta_slice syn__664_(
	.A(vcc),
	.B(syn__272_),
	.C(syn__354_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [18]),
	.Cout(),
	.Q());
defparam syn__664_.coord_x = 6;
defparam syn__664_.coord_y = 4;
defparam syn__664_.coord_z = 12;
defparam syn__664_.mask = 16'h3F33;
defparam syn__664_.modeMux = 1'b0;
defparam syn__664_.FeedbackMux = 1'b0;
defparam syn__664_.ShiftMux = 1'b0;
defparam syn__664_.BypassEn = 1'b0;
defparam syn__664_.CarryEnb = 1'b1;

alta_slice syn__665_(
	.A(\tc.IM [18]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.DM [18]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__272_),
	.Cout(),
	.Q());
defparam syn__665_.coord_x = 6;
defparam syn__665_.coord_y = 4;
defparam syn__665_.coord_z = 13;
defparam syn__665_.mask = 16'h0777;
defparam syn__665_.modeMux = 1'b0;
defparam syn__665_.FeedbackMux = 1'b0;
defparam syn__665_.ShiftMux = 1'b0;
defparam syn__665_.BypassEn = 1'b0;
defparam syn__665_.CarryEnb = 1'b1;

alta_slice syn__666_(
	.A(syn__273_),
	.B(vcc),
	.C(syn__214_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [17]),
	.Cout(),
	.Q());
defparam syn__666_.coord_x = 4;
defparam syn__666_.coord_y = 3;
defparam syn__666_.coord_z = 12;
defparam syn__666_.mask = 16'h5F55;
defparam syn__666_.modeMux = 1'b0;
defparam syn__666_.FeedbackMux = 1'b0;
defparam syn__666_.ShiftMux = 1'b0;
defparam syn__666_.BypassEn = 1'b0;
defparam syn__666_.CarryEnb = 1'b1;

alta_slice syn__667_(
	.A(\tc.IM [24]),
	.B(\tc.DM [17]),
	.C(syn__264_),
	.D(\tc.IM [17]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__273_),
	.Cout(),
	.Q());
defparam syn__667_.coord_x = 4;
defparam syn__667_.coord_y = 3;
defparam syn__667_.coord_z = 14;
defparam syn__667_.mask = 16'h153F;
defparam syn__667_.modeMux = 1'b0;
defparam syn__667_.FeedbackMux = 1'b0;
defparam syn__667_.ShiftMux = 1'b0;
defparam syn__667_.BypassEn = 1'b0;
defparam syn__667_.CarryEnb = 1'b1;

alta_slice syn__668_(
	.A(syn__274_),
	.B(vcc),
	.C(syn__175_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [16]),
	.Cout(),
	.Q());
defparam syn__668_.coord_x = 4;
defparam syn__668_.coord_y = 3;
defparam syn__668_.coord_z = 3;
defparam syn__668_.mask = 16'h5F55;
defparam syn__668_.modeMux = 1'b0;
defparam syn__668_.FeedbackMux = 1'b0;
defparam syn__668_.ShiftMux = 1'b0;
defparam syn__668_.BypassEn = 1'b0;
defparam syn__668_.CarryEnb = 1'b1;

alta_slice syn__669_(
	.A(\tc.DM [16]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.IM [16]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__274_),
	.Cout(),
	.Q());
defparam syn__669_.coord_x = 4;
defparam syn__669_.coord_y = 3;
defparam syn__669_.coord_z = 6;
defparam syn__669_.mask = 16'h135F;
defparam syn__669_.modeMux = 1'b0;
defparam syn__669_.FeedbackMux = 1'b0;
defparam syn__669_.ShiftMux = 1'b0;
defparam syn__669_.BypassEn = 1'b0;
defparam syn__669_.CarryEnb = 1'b1;

alta_slice syn__670_(
	.A(syn__244_),
	.B(vcc),
	.C(syn__275_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [15]),
	.Cout(),
	.Q());
defparam syn__670_.coord_x = 4;
defparam syn__670_.coord_y = 3;
defparam syn__670_.coord_z = 15;
defparam syn__670_.mask = 16'h5F0F;
defparam syn__670_.modeMux = 1'b0;
defparam syn__670_.FeedbackMux = 1'b0;
defparam syn__670_.ShiftMux = 1'b0;
defparam syn__670_.BypassEn = 1'b0;
defparam syn__670_.CarryEnb = 1'b1;

alta_slice syn__671_(
	.A(\tc.IM [24]),
	.B(\tc.IM [15]),
	.C(syn__264_),
	.D(\tc.DM [15]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__275_),
	.Cout(),
	.Q());
defparam syn__671_.coord_x = 4;
defparam syn__671_.coord_y = 3;
defparam syn__671_.coord_z = 10;
defparam syn__671_.mask = 16'h0777;
defparam syn__671_.modeMux = 1'b0;
defparam syn__671_.FeedbackMux = 1'b0;
defparam syn__671_.ShiftMux = 1'b0;
defparam syn__671_.BypassEn = 1'b0;
defparam syn__671_.CarryEnb = 1'b1;

alta_slice syn__672_(
	.A(vcc),
	.B(syn__276_),
	.C(syn__240_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [14]),
	.Cout(),
	.Q());
defparam syn__672_.coord_x = 4;
defparam syn__672_.coord_y = 4;
defparam syn__672_.coord_z = 1;
defparam syn__672_.mask = 16'h3F33;
defparam syn__672_.modeMux = 1'b0;
defparam syn__672_.FeedbackMux = 1'b0;
defparam syn__672_.ShiftMux = 1'b0;
defparam syn__672_.BypassEn = 1'b0;
defparam syn__672_.CarryEnb = 1'b1;

alta_slice syn__673_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.DM [14]),
	.D(\tc.IM [14]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__276_),
	.Cout(),
	.Q());
defparam syn__673_.coord_x = 4;
defparam syn__673_.coord_y = 5;
defparam syn__673_.coord_z = 10;
defparam syn__673_.mask = 16'h153F;
defparam syn__673_.modeMux = 1'b0;
defparam syn__673_.FeedbackMux = 1'b0;
defparam syn__673_.ShiftMux = 1'b0;
defparam syn__673_.BypassEn = 1'b0;
defparam syn__673_.CarryEnb = 1'b1;

alta_slice syn__674_(
	.A(syn__234_),
	.B(syn__277_),
	.C(syn__232_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [13]),
	.Cout(),
	.Q());
defparam syn__674_.coord_x = 6;
defparam syn__674_.coord_y = 3;
defparam syn__674_.coord_z = 0;
defparam syn__674_.mask = 16'hF733;
defparam syn__674_.modeMux = 1'b0;
defparam syn__674_.FeedbackMux = 1'b0;
defparam syn__674_.ShiftMux = 1'b0;
defparam syn__674_.BypassEn = 1'b0;
defparam syn__674_.CarryEnb = 1'b1;

alta_slice syn__675_(
	.A(\tc.IM [13]),
	.B(syn__264_),
	.C(\tc.IM [24]),
	.D(\tc.DM [13]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__277_),
	.Cout(),
	.Q());
defparam syn__675_.coord_x = 4;
defparam syn__675_.coord_y = 5;
defparam syn__675_.coord_z = 12;
defparam syn__675_.mask = 16'h135F;
defparam syn__675_.modeMux = 1'b0;
defparam syn__675_.FeedbackMux = 1'b0;
defparam syn__675_.ShiftMux = 1'b0;
defparam syn__675_.BypassEn = 1'b0;
defparam syn__675_.CarryEnb = 1'b1;

alta_slice syn__676_(
	.A(vcc),
	.B(syn__005_),
	.C(syn__278_),
	.D(syn__228_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [12]),
	.Cout(),
	.Q());
defparam syn__676_.coord_x = 4;
defparam syn__676_.coord_y = 3;
defparam syn__676_.coord_z = 13;
defparam syn__676_.mask = 16'h0FCF;
defparam syn__676_.modeMux = 1'b0;
defparam syn__676_.FeedbackMux = 1'b0;
defparam syn__676_.ShiftMux = 1'b0;
defparam syn__676_.BypassEn = 1'b0;
defparam syn__676_.CarryEnb = 1'b1;

alta_slice syn__677_(
	.A(syn__264_),
	.B(\tc.IM [12]),
	.C(\tc.IM [24]),
	.D(\tc.DM [12]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__278_),
	.Cout(),
	.Q());
defparam syn__677_.coord_x = 4;
defparam syn__677_.coord_y = 3;
defparam syn__677_.coord_z = 0;
defparam syn__677_.mask = 16'h153F;
defparam syn__677_.modeMux = 1'b0;
defparam syn__677_.FeedbackMux = 1'b0;
defparam syn__677_.ShiftMux = 1'b0;
defparam syn__677_.BypassEn = 1'b0;
defparam syn__677_.CarryEnb = 1'b1;

alta_slice syn__678_(
	.A(syn__279_),
	.B(vcc),
	.C(syn__221_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [11]),
	.Cout(),
	.Q());
defparam syn__678_.coord_x = 4;
defparam syn__678_.coord_y = 6;
defparam syn__678_.coord_z = 1;
defparam syn__678_.mask = 16'h5F55;
defparam syn__678_.modeMux = 1'b0;
defparam syn__678_.FeedbackMux = 1'b0;
defparam syn__678_.ShiftMux = 1'b0;
defparam syn__678_.BypassEn = 1'b0;
defparam syn__678_.CarryEnb = 1'b1;

alta_slice syn__679_(
	.A(\tc.IM [24]),
	.B(\tc.DM [11]),
	.C(\tc.IM [11]),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__279_),
	.Cout(),
	.Q());
defparam syn__679_.coord_x = 4;
defparam syn__679_.coord_y = 6;
defparam syn__679_.coord_z = 6;
defparam syn__679_.mask = 16'h135F;
defparam syn__679_.modeMux = 1'b0;
defparam syn__679_.FeedbackMux = 1'b0;
defparam syn__679_.ShiftMux = 1'b0;
defparam syn__679_.BypassEn = 1'b0;
defparam syn__679_.CarryEnb = 1'b1;

alta_slice syn__680_(
	.A(syn__280_),
	.B(vcc),
	.C(syn__318_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [10]),
	.Cout(),
	.Q());
defparam syn__680_.coord_x = 6;
defparam syn__680_.coord_y = 4;
defparam syn__680_.coord_z = 11;
defparam syn__680_.mask = 16'h5F55;
defparam syn__680_.modeMux = 1'b0;
defparam syn__680_.FeedbackMux = 1'b0;
defparam syn__680_.ShiftMux = 1'b0;
defparam syn__680_.BypassEn = 1'b0;
defparam syn__680_.CarryEnb = 1'b1;

alta_slice syn__681_(
	.A(\tc.IM [24]),
	.B(\tc.DM [10]),
	.C(syn__264_),
	.D(\tc.IM [10]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__280_),
	.Cout(),
	.Q());
defparam syn__681_.coord_x = 6;
defparam syn__681_.coord_y = 4;
defparam syn__681_.coord_z = 14;
defparam syn__681_.mask = 16'h153F;
defparam syn__681_.modeMux = 1'b0;
defparam syn__681_.FeedbackMux = 1'b0;
defparam syn__681_.ShiftMux = 1'b0;
defparam syn__681_.BypassEn = 1'b0;
defparam syn__681_.CarryEnb = 1'b1;

alta_slice syn__682_(
	.A(vcc),
	.B(syn__156_),
	.C(syn__281_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [9]),
	.Cout(),
	.Q());
defparam syn__682_.coord_x = 4;
defparam syn__682_.coord_y = 6;
defparam syn__682_.coord_z = 14;
defparam syn__682_.mask = 16'h3F0F;
defparam syn__682_.modeMux = 1'b0;
defparam syn__682_.FeedbackMux = 1'b0;
defparam syn__682_.ShiftMux = 1'b0;
defparam syn__682_.BypassEn = 1'b0;
defparam syn__682_.CarryEnb = 1'b1;

alta_slice syn__683_(
	.A(\tc.DM [9]),
	.B(syn__264_),
	.C(\tc.IM [9]),
	.D(\tc.IM [24]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__281_),
	.Cout(),
	.Q());
defparam syn__683_.coord_x = 4;
defparam syn__683_.coord_y = 6;
defparam syn__683_.coord_z = 0;
defparam syn__683_.mask = 16'h0777;
defparam syn__683_.modeMux = 1'b0;
defparam syn__683_.FeedbackMux = 1'b0;
defparam syn__683_.ShiftMux = 1'b0;
defparam syn__683_.BypassEn = 1'b0;
defparam syn__683_.CarryEnb = 1'b1;

alta_slice syn__684_(
	.A(vcc),
	.B(syn__282_),
	.C(syn__164_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [8]),
	.Cout(),
	.Q());
defparam syn__684_.coord_x = 4;
defparam syn__684_.coord_y = 4;
defparam syn__684_.coord_z = 15;
defparam syn__684_.mask = 16'h3F33;
defparam syn__684_.modeMux = 1'b0;
defparam syn__684_.FeedbackMux = 1'b0;
defparam syn__684_.ShiftMux = 1'b0;
defparam syn__684_.BypassEn = 1'b0;
defparam syn__684_.CarryEnb = 1'b1;

alta_slice syn__685_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.DM [8]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__282_),
	.Cout(),
	.Q());
defparam syn__685_.coord_x = 4;
defparam syn__685_.coord_y = 5;
defparam syn__685_.coord_z = 15;
defparam syn__685_.mask = 16'h153F;
defparam syn__685_.modeMux = 1'b0;
defparam syn__685_.FeedbackMux = 1'b0;
defparam syn__685_.ShiftMux = 1'b0;
defparam syn__685_.BypassEn = 1'b0;
defparam syn__685_.CarryEnb = 1'b1;

alta_slice syn__686_(
	.A(vcc),
	.B(syn__283_),
	.C(syn__332_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [7]),
	.Cout(),
	.Q());
defparam syn__686_.coord_x = 4;
defparam syn__686_.coord_y = 4;
defparam syn__686_.coord_z = 5;
defparam syn__686_.mask = 16'h3F33;
defparam syn__686_.modeMux = 1'b0;
defparam syn__686_.FeedbackMux = 1'b0;
defparam syn__686_.ShiftMux = 1'b0;
defparam syn__686_.BypassEn = 1'b0;
defparam syn__686_.CarryEnb = 1'b1;

alta_slice syn__687_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.IM [7]),
	.D(\tc.DM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__283_),
	.Cout(),
	.Q());
defparam syn__687_.coord_x = 4;
defparam syn__687_.coord_y = 5;
defparam syn__687_.coord_z = 11;
defparam syn__687_.mask = 16'h135F;
defparam syn__687_.modeMux = 1'b0;
defparam syn__687_.FeedbackMux = 1'b0;
defparam syn__687_.ShiftMux = 1'b0;
defparam syn__687_.BypassEn = 1'b0;
defparam syn__687_.CarryEnb = 1'b1;

alta_slice syn__688_(
	.A(syn__284_),
	.B(syn__285_),
	.C(syn__188_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [6]),
	.Cout(),
	.Q());
defparam syn__688_.coord_x = 4;
defparam syn__688_.coord_y = 6;
defparam syn__688_.coord_z = 3;
defparam syn__688_.mask = 16'hBFBB;
defparam syn__688_.modeMux = 1'b0;
defparam syn__688_.FeedbackMux = 1'b0;
defparam syn__688_.ShiftMux = 1'b0;
defparam syn__688_.BypassEn = 1'b0;
defparam syn__688_.CarryEnb = 1'b1;

alta_slice syn__689_(
	.A(\tc.PC [0]),
	.B(\tc.PC [6]),
	.C(syn__263_),
	.D(syn__254_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__284_),
	.Cout(),
	.Q());
defparam syn__689_.coord_x = 1;
defparam syn__689_.coord_y = 6;
defparam syn__689_.coord_z = 12;
defparam syn__689_.mask = 16'h6C00;
defparam syn__689_.modeMux = 1'b0;
defparam syn__689_.FeedbackMux = 1'b0;
defparam syn__689_.ShiftMux = 1'b0;
defparam syn__689_.BypassEn = 1'b0;
defparam syn__689_.CarryEnb = 1'b1;

alta_slice syn__690_(
	.A(\tc.IM [24]),
	.B(\tc.DM [6]),
	.C(\tc.IM [6]),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__285_),
	.Cout(),
	.Q());
defparam syn__690_.coord_x = 4;
defparam syn__690_.coord_y = 6;
defparam syn__690_.coord_z = 5;
defparam syn__690_.mask = 16'h135F;
defparam syn__690_.modeMux = 1'b0;
defparam syn__690_.FeedbackMux = 1'b0;
defparam syn__690_.ShiftMux = 1'b0;
defparam syn__690_.BypassEn = 1'b0;
defparam syn__690_.CarryEnb = 1'b1;

alta_slice syn__691_(
	.A(vcc),
	.B(syn__286_),
	.C(syn__192_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [5]),
	.Cout(),
	.Q());
defparam syn__691_.coord_x = 2;
defparam syn__691_.coord_y = 6;
defparam syn__691_.coord_z = 6;
defparam syn__691_.mask = 16'h3F33;
defparam syn__691_.modeMux = 1'b0;
defparam syn__691_.FeedbackMux = 1'b0;
defparam syn__691_.ShiftMux = 1'b0;
defparam syn__691_.BypassEn = 1'b0;
defparam syn__691_.CarryEnb = 1'b1;

alta_slice syn__692_(
	.A(syn__287_),
	.B(vcc),
	.C(syn__254_),
	.D(syn__288_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__286_),
	.Cout(),
	.Q());
defparam syn__692_.coord_x = 2;
defparam syn__692_.coord_y = 6;
defparam syn__692_.coord_z = 7;
defparam syn__692_.mask = 16'h5F00;
defparam syn__692_.modeMux = 1'b0;
defparam syn__692_.FeedbackMux = 1'b0;
defparam syn__692_.ShiftMux = 1'b0;
defparam syn__692_.BypassEn = 1'b0;
defparam syn__692_.CarryEnb = 1'b1;

alta_slice syn__693_(
	.A(\tc.PC [5]),
	.B(vcc),
	.C(\tc.PC [0]),
	.D(syn__261_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__287_),
	.Cout(),
	.Q());
defparam syn__693_.coord_x = 1;
defparam syn__693_.coord_y = 6;
defparam syn__693_.coord_z = 15;
defparam syn__693_.mask = 16'h5AAA;
defparam syn__693_.modeMux = 1'b0;
defparam syn__693_.FeedbackMux = 1'b0;
defparam syn__693_.ShiftMux = 1'b0;
defparam syn__693_.BypassEn = 1'b0;
defparam syn__693_.CarryEnb = 1'b1;

alta_slice syn__694_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.DM [5]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__288_),
	.Cout(),
	.Q());
defparam syn__694_.coord_x = 4;
defparam syn__694_.coord_y = 5;
defparam syn__694_.coord_z = 0;
defparam syn__694_.mask = 16'h153F;
defparam syn__694_.modeMux = 1'b0;
defparam syn__694_.FeedbackMux = 1'b0;
defparam syn__694_.ShiftMux = 1'b0;
defparam syn__694_.BypassEn = 1'b0;
defparam syn__694_.CarryEnb = 1'b1;

alta_slice syn__695_(
	.A(syn__289_),
	.B(syn__291_),
	.C(syn__344_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [4]),
	.Cout(),
	.Q());
defparam syn__695_.coord_x = 4;
defparam syn__695_.coord_y = 6;
defparam syn__695_.coord_z = 15;
defparam syn__695_.mask = 16'hBFBB;
defparam syn__695_.modeMux = 1'b0;
defparam syn__695_.FeedbackMux = 1'b0;
defparam syn__695_.ShiftMux = 1'b0;
defparam syn__695_.BypassEn = 1'b0;
defparam syn__695_.CarryEnb = 1'b1;

alta_slice syn__696_(
	.A(\tc.PC [4]),
	.B(\tc.PC [3]),
	.C(syn__290_),
	.D(syn__254_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__289_),
	.Cout(),
	.Q());
defparam syn__696_.coord_x = 2;
defparam syn__696_.coord_y = 6;
defparam syn__696_.coord_z = 13;
defparam syn__696_.mask = 16'h6A00;
defparam syn__696_.modeMux = 1'b0;
defparam syn__696_.FeedbackMux = 1'b0;
defparam syn__696_.ShiftMux = 1'b0;
defparam syn__696_.BypassEn = 1'b0;
defparam syn__696_.CarryEnb = 1'b1;

alta_slice syn__697_(
	.A(\tc.PC [2]),
	.B(vcc),
	.C(\tc.PC [0]),
	.D(\tc.PC [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__290_),
	.Cout(),
	.Q());
defparam syn__697_.coord_x = 1;
defparam syn__697_.coord_y = 6;
defparam syn__697_.coord_z = 2;
defparam syn__697_.mask = 16'hA000;
defparam syn__697_.modeMux = 1'b0;
defparam syn__697_.FeedbackMux = 1'b0;
defparam syn__697_.ShiftMux = 1'b0;
defparam syn__697_.BypassEn = 1'b0;
defparam syn__697_.CarryEnb = 1'b1;

alta_slice syn__698_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.IM [4]),
	.D(\tc.DM [4]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__291_),
	.Cout(),
	.Q());
defparam syn__698_.coord_x = 4;
defparam syn__698_.coord_y = 6;
defparam syn__698_.coord_z = 9;
defparam syn__698_.mask = 16'h135F;
defparam syn__698_.modeMux = 1'b0;
defparam syn__698_.FeedbackMux = 1'b0;
defparam syn__698_.ShiftMux = 1'b0;
defparam syn__698_.BypassEn = 1'b0;
defparam syn__698_.CarryEnb = 1'b1;

alta_slice syn__699_(
	.A(syn__292_),
	.B(vcc),
	.C(syn__200_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [3]),
	.Cout(),
	.Q());
defparam syn__699_.coord_x = 2;
defparam syn__699_.coord_y = 6;
defparam syn__699_.coord_z = 5;
defparam syn__699_.mask = 16'h5F55;
defparam syn__699_.modeMux = 1'b0;
defparam syn__699_.FeedbackMux = 1'b0;
defparam syn__699_.ShiftMux = 1'b0;
defparam syn__699_.BypassEn = 1'b0;
defparam syn__699_.CarryEnb = 1'b1;

alta_slice syn__700_(
	.A(syn__290_),
	.B(syn__293_),
	.C(syn__254_),
	.D(\tc.PC [3]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__292_),
	.Cout(),
	.Q());
defparam syn__700_.coord_x = 2;
defparam syn__700_.coord_y = 6;
defparam syn__700_.coord_z = 0;
defparam syn__700_.mask = 16'h8C4C;
defparam syn__700_.modeMux = 1'b0;
defparam syn__700_.FeedbackMux = 1'b0;
defparam syn__700_.ShiftMux = 1'b0;
defparam syn__700_.BypassEn = 1'b0;
defparam syn__700_.CarryEnb = 1'b1;

alta_slice syn__701_(
	.A(\tc.IM [24]),
	.B(syn__264_),
	.C(\tc.DM [3]),
	.D(\tc.IM [3]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__293_),
	.Cout(),
	.Q());
defparam syn__701_.coord_x = 4;
defparam syn__701_.coord_y = 5;
defparam syn__701_.coord_z = 4;
defparam syn__701_.mask = 16'h153F;
defparam syn__701_.modeMux = 1'b0;
defparam syn__701_.FeedbackMux = 1'b0;
defparam syn__701_.ShiftMux = 1'b0;
defparam syn__701_.BypassEn = 1'b0;
defparam syn__701_.CarryEnb = 1'b1;

alta_slice syn__702_(
	.A(syn__203_),
	.B(syn__295_),
	.C(syn__005_),
	.D(syn__294_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [2]),
	.Cout(),
	.Q());
defparam syn__702_.coord_x = 4;
defparam syn__702_.coord_y = 7;
defparam syn__702_.coord_z = 4;
defparam syn__702_.mask = 16'hFF73;
defparam syn__702_.modeMux = 1'b0;
defparam syn__702_.FeedbackMux = 1'b0;
defparam syn__702_.ShiftMux = 1'b0;
defparam syn__702_.BypassEn = 1'b0;
defparam syn__702_.CarryEnb = 1'b1;

alta_slice syn__703_(
	.A(\tc.PC [2]),
	.B(\tc.PC [1]),
	.C(\tc.PC [0]),
	.D(syn__254_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__294_),
	.Cout(),
	.Q());
defparam syn__703_.coord_x = 1;
defparam syn__703_.coord_y = 6;
defparam syn__703_.coord_z = 1;
defparam syn__703_.mask = 16'h6A00;
defparam syn__703_.modeMux = 1'b0;
defparam syn__703_.FeedbackMux = 1'b0;
defparam syn__703_.ShiftMux = 1'b0;
defparam syn__703_.BypassEn = 1'b0;
defparam syn__703_.CarryEnb = 1'b1;

alta_slice syn__704_(
	.A(\tc.IM [2]),
	.B(\tc.IM [24]),
	.C(syn__264_),
	.D(\tc.DM [2]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__295_),
	.Cout(),
	.Q());
defparam syn__704_.coord_x = 4;
defparam syn__704_.coord_y = 7;
defparam syn__704_.coord_z = 5;
defparam syn__704_.mask = 16'h0777;
defparam syn__704_.modeMux = 1'b0;
defparam syn__704_.FeedbackMux = 1'b0;
defparam syn__704_.ShiftMux = 1'b0;
defparam syn__704_.BypassEn = 1'b0;
defparam syn__704_.CarryEnb = 1'b1;

alta_slice syn__705_(
	.A(vcc),
	.B(syn__207_),
	.C(syn__296_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [1]),
	.Cout(),
	.Q());
defparam syn__705_.coord_x = 4;
defparam syn__705_.coord_y = 6;
defparam syn__705_.coord_z = 4;
defparam syn__705_.mask = 16'h3F0F;
defparam syn__705_.modeMux = 1'b0;
defparam syn__705_.FeedbackMux = 1'b0;
defparam syn__705_.ShiftMux = 1'b0;
defparam syn__705_.BypassEn = 1'b0;
defparam syn__705_.CarryEnb = 1'b1;

alta_slice syn__706_(
	.A(\tc.IM [24]),
	.B(vcc),
	.C(syn__297_),
	.D(\tc.IM [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__296_),
	.Cout(),
	.Q());
defparam syn__706_.coord_x = 7;
defparam syn__706_.coord_y = 3;
defparam syn__706_.coord_z = 7;
defparam syn__706_.mask = 16'h50F0;
defparam syn__706_.modeMux = 1'b0;
defparam syn__706_.FeedbackMux = 1'b0;
defparam syn__706_.ShiftMux = 1'b0;
defparam syn__706_.BypassEn = 1'b0;
defparam syn__706_.CarryEnb = 1'b1;

alta_slice syn__707_(
	.A(vcc),
	.B(syn__298_),
	.C(\tc.DM [1]),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__297_),
	.Cout(),
	.Q());
defparam syn__707_.coord_x = 2;
defparam syn__707_.coord_y = 3;
defparam syn__707_.coord_z = 0;
defparam syn__707_.mask = 16'h0333;
defparam syn__707_.modeMux = 1'b0;
defparam syn__707_.FeedbackMux = 1'b0;
defparam syn__707_.ShiftMux = 1'b0;
defparam syn__707_.BypassEn = 1'b0;
defparam syn__707_.CarryEnb = 1'b1;

alta_slice syn__708_(
	.A(vcc),
	.B(\tc.PC [1]),
	.C(\tc.PC [0]),
	.D(syn__254_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__298_),
	.Cout(),
	.Q());
defparam syn__708_.coord_x = 1;
defparam syn__708_.coord_y = 6;
defparam syn__708_.coord_z = 6;
defparam syn__708_.mask = 16'h3C00;
defparam syn__708_.modeMux = 1'b0;
defparam syn__708_.FeedbackMux = 1'b0;
defparam syn__708_.ShiftMux = 1'b0;
defparam syn__708_.BypassEn = 1'b0;
defparam syn__708_.CarryEnb = 1'b1;

alta_slice syn__709_(
	.A(syn__299_),
	.B(vcc),
	.C(syn__211_),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WD [0]),
	.Cout(),
	.Q());
defparam syn__709_.coord_x = 4;
defparam syn__709_.coord_y = 6;
defparam syn__709_.coord_z = 2;
defparam syn__709_.mask = 16'h5F55;
defparam syn__709_.modeMux = 1'b0;
defparam syn__709_.FeedbackMux = 1'b0;
defparam syn__709_.ShiftMux = 1'b0;
defparam syn__709_.BypassEn = 1'b0;
defparam syn__709_.CarryEnb = 1'b1;

alta_slice syn__710_(
	.A(vcc),
	.B(\tc.DM [0]),
	.C(syn__300_),
	.D(syn__264_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__299_),
	.Cout(),
	.Q());
defparam syn__710_.coord_x = 4;
defparam syn__710_.coord_y = 6;
defparam syn__710_.coord_z = 10;
defparam syn__710_.mask = 16'h30F0;
defparam syn__710_.modeMux = 1'b0;
defparam syn__710_.FeedbackMux = 1'b0;
defparam syn__710_.ShiftMux = 1'b0;
defparam syn__710_.BypassEn = 1'b0;
defparam syn__710_.CarryEnb = 1'b1;

alta_slice syn__711_(
	.A(\tc.IM [24]),
	.B(\tc.IM [0]),
	.C(\tc.PC [0]),
	.D(syn__254_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__300_),
	.Cout(),
	.Q());
defparam syn__711_.coord_x = 1;
defparam syn__711_.coord_y = 6;
defparam syn__711_.coord_z = 4;
defparam syn__711_.mask = 16'h7077;
defparam syn__711_.modeMux = 1'b0;
defparam syn__711_.FeedbackMux = 1'b0;
defparam syn__711_.ShiftMux = 1'b0;
defparam syn__711_.BypassEn = 1'b0;
defparam syn__711_.CarryEnb = 1'b1;

alta_slice syn__712_(
	.A(vcc),
	.B(\tc.IM [1]),
	.C(\tc.IM [0]),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WriteDM ),
	.Cout(),
	.Q());
defparam syn__712_.coord_x = 4;
defparam syn__712_.coord_y = 7;
defparam syn__712_.coord_z = 9;
defparam syn__712_.mask = 16'h0C00;
defparam syn__712_.modeMux = 1'b0;
defparam syn__712_.FeedbackMux = 1'b0;
defparam syn__712_.ShiftMux = 1'b0;
defparam syn__712_.BypassEn = 1'b0;
defparam syn__712_.CarryEnb = 1'b1;

alta_slice syn__713_(
	.A(vcc),
	.B(\tc.IM [0]),
	.C(\tc.IM [1]),
	.D(syn__005_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.WriteIM ),
	.Cout(),
	.Q());
defparam syn__713_.coord_x = 5;
defparam syn__713_.coord_y = 7;
defparam syn__713_.coord_z = 10;
defparam syn__713_.mask = 16'h0C00;
defparam syn__713_.modeMux = 1'b0;
defparam syn__713_.FeedbackMux = 1'b0;
defparam syn__713_.ShiftMux = 1'b0;
defparam syn__713_.BypassEn = 1'b0;
defparam syn__713_.CarryEnb = 1'b1;

alta_slice syn__714_(
	.A(IOvalue[6]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOaddr[6]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__301_),
	.Cout(),
	.Q());
defparam syn__714_.coord_x = 6;
defparam syn__714_.coord_y = 8;
defparam syn__714_.coord_z = 15;
defparam syn__714_.mask = 16'h72A0;
defparam syn__714_.modeMux = 1'b0;
defparam syn__714_.FeedbackMux = 1'b0;
defparam syn__714_.ShiftMux = 1'b0;
defparam syn__714_.BypassEn = 1'b0;
defparam syn__714_.CarryEnb = 1'b1;

alta_slice syn__715_(
	.A(vcc),
	.B(syn__301_),
	.C(syn__114_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__302_),
	.Cout(),
	.Q());
defparam syn__715_.coord_x = 6;
defparam syn__715_.coord_y = 8;
defparam syn__715_.coord_z = 5;
defparam syn__715_.mask = 16'h030F;
defparam syn__715_.modeMux = 1'b0;
defparam syn__715_.FeedbackMux = 1'b0;
defparam syn__715_.ShiftMux = 1'b0;
defparam syn__715_.BypassEn = 1'b0;
defparam syn__715_.CarryEnb = 1'b1;

alta_slice syn__716_(
	.A(IOaddr[13]),
	.B(IOvalue[13]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__303_),
	.Cout(),
	.Q());
defparam syn__716_.coord_x = 8;
defparam syn__716_.coord_y = 6;
defparam syn__716_.coord_z = 12;
defparam syn__716_.mask = 16'h9F17;
defparam syn__716_.modeMux = 1'b0;
defparam syn__716_.FeedbackMux = 1'b0;
defparam syn__716_.ShiftMux = 1'b0;
defparam syn__716_.BypassEn = 1'b0;
defparam syn__716_.CarryEnb = 1'b1;

alta_slice syn__717_(
	.A(syn__303_),
	.B(\tc.IM [9]),
	.C(syn__124_),
	.D(syn__030_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__304_),
	.Cout(),
	.Q());
defparam syn__717_.coord_x = 6;
defparam syn__717_.coord_y = 6;
defparam syn__717_.coord_z = 12;
defparam syn__717_.mask = 16'h8BB8;
defparam syn__717_.modeMux = 1'b0;
defparam syn__717_.FeedbackMux = 1'b0;
defparam syn__717_.ShiftMux = 1'b0;
defparam syn__717_.BypassEn = 1'b0;
defparam syn__717_.CarryEnb = 1'b1;

alta_slice syn__718_(
	.A(IOvalue[5]),
	.B(\tc.IM [8]),
	.C(IOaddr[5]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__305_),
	.Cout(),
	.Q());
defparam syn__718_.coord_x = 8;
defparam syn__718_.coord_y = 6;
defparam syn__718_.coord_z = 10;
defparam syn__718_.mask = 16'h85DF;
defparam syn__718_.modeMux = 1'b0;
defparam syn__718_.FeedbackMux = 1'b0;
defparam syn__718_.ShiftMux = 1'b0;
defparam syn__718_.BypassEn = 1'b0;
defparam syn__718_.CarryEnb = 1'b1;

alta_slice syn__719_(
	.A(syn__305_),
	.B(syn__125_),
	.C(syn__126_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__306_),
	.Cout(),
	.Q());
defparam syn__719_.coord_x = 8;
defparam syn__719_.coord_y = 6;
defparam syn__719_.coord_z = 13;
defparam syn__719_.mask = 16'hAA3C;
defparam syn__719_.modeMux = 1'b0;
defparam syn__719_.FeedbackMux = 1'b0;
defparam syn__719_.ShiftMux = 1'b0;
defparam syn__719_.BypassEn = 1'b0;
defparam syn__719_.CarryEnb = 1'b1;

alta_slice syn__720_(
	.A(IOaddr[28]),
	.B(IOvalue[28]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__307_),
	.Cout(),
	.Q());
defparam syn__720_.coord_x = 6;
defparam syn__720_.coord_y = 4;
defparam syn__720_.coord_z = 6;
defparam syn__720_.mask = 16'h91F7;
defparam syn__720_.modeMux = 1'b0;
defparam syn__720_.FeedbackMux = 1'b0;
defparam syn__720_.ShiftMux = 1'b0;
defparam syn__720_.BypassEn = 1'b0;
defparam syn__720_.CarryEnb = 1'b1;

alta_slice syn__721_(
	.A(\tc.IM [9]),
	.B(syn__307_),
	.C(syn__130_),
	.D(syn__020_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__308_),
	.Cout(),
	.Q());
defparam syn__721_.coord_x = 6;
defparam syn__721_.coord_y = 4;
defparam syn__721_.coord_z = 7;
defparam syn__721_.mask = 16'h8DD8;
defparam syn__721_.modeMux = 1'b0;
defparam syn__721_.FeedbackMux = 1'b0;
defparam syn__721_.ShiftMux = 1'b0;
defparam syn__721_.BypassEn = 1'b0;
defparam syn__721_.CarryEnb = 1'b1;

alta_slice syn__722_(
	.A(IOaddr[11]),
	.B(IOvalue[11]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__309_),
	.Cout(),
	.Q());
defparam syn__722_.coord_x = 7;
defparam syn__722_.coord_y = 8;
defparam syn__722_.coord_z = 8;
defparam syn__722_.mask = 16'h9F17;
defparam syn__722_.modeMux = 1'b0;
defparam syn__722_.FeedbackMux = 1'b0;
defparam syn__722_.ShiftMux = 1'b0;
defparam syn__722_.BypassEn = 1'b0;
defparam syn__722_.CarryEnb = 1'b1;

alta_slice syn__723_(
	.A(syn__137_),
	.B(syn__136_),
	.C(syn__309_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__310_),
	.Cout(),
	.Q());
defparam syn__723_.coord_x = 7;
defparam syn__723_.coord_y = 8;
defparam syn__723_.coord_z = 9;
defparam syn__723_.mask = 16'hF066;
defparam syn__723_.modeMux = 1'b0;
defparam syn__723_.FeedbackMux = 1'b0;
defparam syn__723_.ShiftMux = 1'b0;
defparam syn__723_.BypassEn = 1'b0;
defparam syn__723_.CarryEnb = 1'b1;

alta_slice syn__724_(
	.A(IOvalue[3]),
	.B(\tc.IM [7]),
	.C(IOaddr[3]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__311_),
	.Cout(),
	.Q());
defparam syn__724_.coord_x = 4;
defparam syn__724_.coord_y = 8;
defparam syn__724_.coord_z = 0;
defparam syn__724_.mask = 16'h48E8;
defparam syn__724_.modeMux = 1'b0;
defparam syn__724_.FeedbackMux = 1'b0;
defparam syn__724_.ShiftMux = 1'b0;
defparam syn__724_.BypassEn = 1'b0;
defparam syn__724_.CarryEnb = 1'b1;

alta_slice syn__725_(
	.A(\tc.IM [9]),
	.B(vcc),
	.C(syn__138_),
	.D(syn__311_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__312_),
	.Cout(),
	.Q());
defparam syn__725_.coord_x = 6;
defparam syn__725_.coord_y = 4;
defparam syn__725_.coord_z = 1;
defparam syn__725_.mask = 16'h050F;
defparam syn__725_.modeMux = 1'b0;
defparam syn__725_.FeedbackMux = 1'b0;
defparam syn__725_.ShiftMux = 1'b0;
defparam syn__725_.BypassEn = 1'b0;
defparam syn__725_.CarryEnb = 1'b1;

alta_slice syn__726_(
	.A(syn__312_),
	.B(syn__141_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__313_),
	.Cout(),
	.Q());
defparam syn__726_.coord_x = 7;
defparam syn__726_.coord_y = 3;
defparam syn__726_.coord_z = 0;
defparam syn__726_.mask = 16'hACF0;
defparam syn__726_.modeMux = 1'b0;
defparam syn__726_.FeedbackMux = 1'b0;
defparam syn__726_.ShiftMux = 1'b0;
defparam syn__726_.BypassEn = 1'b0;
defparam syn__726_.CarryEnb = 1'b1;

alta_slice syn__727_(
	.A(syn__140_),
	.B(syn__313_),
	.C(syn__316_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__314_),
	.Cout(),
	.Q());
defparam syn__727_.coord_x = 8;
defparam syn__727_.coord_y = 5;
defparam syn__727_.coord_z = 12;
defparam syn__727_.mask = 16'hCCB8;
defparam syn__727_.modeMux = 1'b0;
defparam syn__727_.FeedbackMux = 1'b0;
defparam syn__727_.ShiftMux = 1'b0;
defparam syn__727_.BypassEn = 1'b0;
defparam syn__727_.CarryEnb = 1'b1;

alta_slice syn__728_(
	.A(IOvalue[19]),
	.B(IOaddr[19]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__315_),
	.Cout(),
	.Q());
defparam syn__728_.coord_x = 8;
defparam syn__728_.coord_y = 5;
defparam syn__728_.coord_z = 14;
defparam syn__728_.mask = 16'h9F17;
defparam syn__728_.modeMux = 1'b0;
defparam syn__728_.FeedbackMux = 1'b0;
defparam syn__728_.ShiftMux = 1'b0;
defparam syn__728_.BypassEn = 1'b0;
defparam syn__728_.CarryEnb = 1'b1;

alta_slice syn__729_(
	.A(syn__315_),
	.B(syn__145_),
	.C(\tc.IM [9]),
	.D(syn__026_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__316_),
	.Cout(),
	.Q());
defparam syn__729_.coord_x = 8;
defparam syn__729_.coord_y = 5;
defparam syn__729_.coord_z = 4;
defparam syn__729_.mask = 16'hA3AC;
defparam syn__729_.modeMux = 1'b0;
defparam syn__729_.FeedbackMux = 1'b0;
defparam syn__729_.ShiftMux = 1'b0;
defparam syn__729_.BypassEn = 1'b0;
defparam syn__729_.CarryEnb = 1'b1;

alta_slice syn__730_(
	.A(syn__322_),
	.B(\tc.IM [6]),
	.C(syn__149_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__317_),
	.Cout(),
	.Q());
defparam syn__730_.coord_x = 7;
defparam syn__730_.coord_y = 4;
defparam syn__730_.coord_z = 13;
defparam syn__730_.mask = 16'hCCE2;
defparam syn__730_.modeMux = 1'b0;
defparam syn__730_.FeedbackMux = 1'b0;
defparam syn__730_.ShiftMux = 1'b0;
defparam syn__730_.BypassEn = 1'b0;
defparam syn__730_.CarryEnb = 1'b1;

alta_slice syn__731_(
	.A(syn__317_),
	.B(syn__320_),
	.C(syn__310_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__318_),
	.Cout(),
	.Q());
defparam syn__731_.coord_x = 5;
defparam syn__731_.coord_y = 4;
defparam syn__731_.coord_z = 11;
defparam syn__731_.mask = 16'hD8AA;
defparam syn__731_.modeMux = 1'b0;
defparam syn__731_.FeedbackMux = 1'b0;
defparam syn__731_.ShiftMux = 1'b0;
defparam syn__731_.BypassEn = 1'b0;
defparam syn__731_.CarryEnb = 1'b1;

alta_slice syn__732_(
	.A(IOvalue[26]),
	.B(IOaddr[26]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__319_),
	.Cout(),
	.Q());
defparam syn__732_.coord_x = 4;
defparam syn__732_.coord_y = 5;
defparam syn__732_.coord_z = 8;
defparam syn__732_.mask = 16'h9F17;
defparam syn__732_.modeMux = 1'b0;
defparam syn__732_.FeedbackMux = 1'b0;
defparam syn__732_.ShiftMux = 1'b0;
defparam syn__732_.BypassEn = 1'b0;
defparam syn__732_.CarryEnb = 1'b1;

alta_slice syn__733_(
	.A(syn__148_),
	.B(vcc),
	.C(syn__319_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__320_),
	.Cout(),
	.Q());
defparam syn__733_.coord_x = 5;
defparam syn__733_.coord_y = 4;
defparam syn__733_.coord_z = 9;
defparam syn__733_.mask = 16'hF055;
defparam syn__733_.modeMux = 1'b0;
defparam syn__733_.FeedbackMux = 1'b0;
defparam syn__733_.ShiftMux = 1'b0;
defparam syn__733_.BypassEn = 1'b0;
defparam syn__733_.CarryEnb = 1'b1;

alta_slice syn__734_(
	.A(IOvalue[10]),
	.B(IOaddr[10]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__321_),
	.Cout(),
	.Q());
defparam syn__734_.coord_x = 7;
defparam syn__734_.coord_y = 8;
defparam syn__734_.coord_z = 11;
defparam syn__734_.mask = 16'h9F17;
defparam syn__734_.modeMux = 1'b0;
defparam syn__734_.FeedbackMux = 1'b0;
defparam syn__734_.ShiftMux = 1'b0;
defparam syn__734_.BypassEn = 1'b0;
defparam syn__734_.CarryEnb = 1'b1;

alta_slice syn__735_(
	.A(syn__153_),
	.B(syn__321_),
	.C(syn__032_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__322_),
	.Cout(),
	.Q());
defparam syn__735_.coord_x = 7;
defparam syn__735_.coord_y = 8;
defparam syn__735_.coord_z = 10;
defparam syn__735_.mask = 16'hCC5A;
defparam syn__735_.modeMux = 1'b0;
defparam syn__735_.FeedbackMux = 1'b0;
defparam syn__735_.ShiftMux = 1'b0;
defparam syn__735_.BypassEn = 1'b0;
defparam syn__735_.CarryEnb = 1'b1;

alta_slice syn__736_(
	.A(IOvalue[25]),
	.B(IOaddr[25]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__323_),
	.Cout(),
	.Q());
defparam syn__736_.coord_x = 4;
defparam syn__736_.coord_y = 5;
defparam syn__736_.coord_z = 6;
defparam syn__736_.mask = 16'h9F17;
defparam syn__736_.modeMux = 1'b0;
defparam syn__736_.FeedbackMux = 1'b0;
defparam syn__736_.ShiftMux = 1'b0;
defparam syn__736_.BypassEn = 1'b0;
defparam syn__736_.CarryEnb = 1'b1;

alta_slice syn__737_(
	.A(syn__157_),
	.B(syn__323_),
	.C(syn__022_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__324_),
	.Cout(),
	.Q());
defparam syn__737_.coord_x = 5;
defparam syn__737_.coord_y = 4;
defparam syn__737_.coord_z = 6;
defparam syn__737_.mask = 16'hCC5A;
defparam syn__737_.modeMux = 1'b0;
defparam syn__737_.FeedbackMux = 1'b0;
defparam syn__737_.ShiftMux = 1'b0;
defparam syn__737_.BypassEn = 1'b0;
defparam syn__737_.CarryEnb = 1'b1;

alta_slice syn__738_(
	.A(\tc.IM [8]),
	.B(IOaddr[17]),
	.C(\tc.IM [7]),
	.D(IOvalue[17]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__325_),
	.Cout(),
	.Q());
defparam syn__738_.coord_x = 4;
defparam syn__738_.coord_y = 7;
defparam syn__738_.coord_z = 10;
defparam syn__738_.mask = 16'h8B3F;
defparam syn__738_.modeMux = 1'b0;
defparam syn__738_.FeedbackMux = 1'b0;
defparam syn__738_.ShiftMux = 1'b0;
defparam syn__738_.BypassEn = 1'b0;
defparam syn__738_.CarryEnb = 1'b1;

alta_slice syn__739_(
	.A(syn__160_),
	.B(syn__159_),
	.C(syn__325_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__326_),
	.Cout(),
	.Q());
defparam syn__739_.coord_x = 8;
defparam syn__739_.coord_y = 7;
defparam syn__739_.coord_z = 7;
defparam syn__739_.mask = 16'hF066;
defparam syn__739_.modeMux = 1'b0;
defparam syn__739_.FeedbackMux = 1'b0;
defparam syn__739_.ShiftMux = 1'b0;
defparam syn__739_.BypassEn = 1'b0;
defparam syn__739_.CarryEnb = 1'b1;

alta_slice syn__740_(
	.A(IOaddr[9]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOvalue[9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__327_),
	.Cout(),
	.Q());
defparam syn__740_.coord_x = 6;
defparam syn__740_.coord_y = 8;
defparam syn__740_.coord_z = 11;
defparam syn__740_.mask = 16'h72A0;
defparam syn__740_.modeMux = 1'b0;
defparam syn__740_.FeedbackMux = 1'b0;
defparam syn__740_.ShiftMux = 1'b0;
defparam syn__740_.BypassEn = 1'b0;
defparam syn__740_.CarryEnb = 1'b1;

alta_slice syn__741_(
	.A(vcc),
	.B(syn__327_),
	.C(syn__162_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__328_),
	.Cout(),
	.Q());
defparam syn__741_.coord_x = 6;
defparam syn__741_.coord_y = 8;
defparam syn__741_.coord_z = 13;
defparam syn__741_.mask = 16'h030F;
defparam syn__741_.modeMux = 1'b0;
defparam syn__741_.FeedbackMux = 1'b0;
defparam syn__741_.ShiftMux = 1'b0;
defparam syn__741_.BypassEn = 1'b0;
defparam syn__741_.CarryEnb = 1'b1;

alta_slice syn__742_(
	.A(IOvalue[16]),
	.B(IOaddr[16]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__329_),
	.Cout(),
	.Q());
defparam syn__742_.coord_x = 8;
defparam syn__742_.coord_y = 7;
defparam syn__742_.coord_z = 4;
defparam syn__742_.mask = 16'h9F17;
defparam syn__742_.modeMux = 1'b0;
defparam syn__742_.FeedbackMux = 1'b0;
defparam syn__742_.ShiftMux = 1'b0;
defparam syn__742_.BypassEn = 1'b0;
defparam syn__742_.CarryEnb = 1'b1;

alta_slice syn__743_(
	.A(syn__329_),
	.B(syn__167_),
	.C(syn__028_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__330_),
	.Cout(),
	.Q());
defparam syn__743_.coord_x = 8;
defparam syn__743_.coord_y = 7;
defparam syn__743_.coord_z = 3;
defparam syn__743_.mask = 16'hAA3C;
defparam syn__743_.modeMux = 1'b0;
defparam syn__743_.FeedbackMux = 1'b0;
defparam syn__743_.ShiftMux = 1'b0;
defparam syn__743_.BypassEn = 1'b0;
defparam syn__743_.CarryEnb = 1'b1;

alta_slice syn__744_(
	.A(\tc.IM [5]),
	.B(syn__336_),
	.C(syn__338_),
	.D(\tc.IM [6]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__331_),
	.Cout(),
	.Q());
defparam syn__744_.coord_x = 6;
defparam syn__744_.coord_y = 8;
defparam syn__744_.coord_z = 8;
defparam syn__744_.mask = 16'hEE50;
defparam syn__744_.modeMux = 1'b0;
defparam syn__744_.FeedbackMux = 1'b0;
defparam syn__744_.ShiftMux = 1'b0;
defparam syn__744_.BypassEn = 1'b0;
defparam syn__744_.CarryEnb = 1'b1;

alta_slice syn__745_(
	.A(syn__331_),
	.B(syn__169_),
	.C(syn__334_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__332_),
	.Cout(),
	.Q());
defparam syn__745_.coord_x = 4;
defparam syn__745_.coord_y = 4;
defparam syn__745_.coord_z = 8;
defparam syn__745_.mask = 16'hE4AA;
defparam syn__745_.modeMux = 1'b0;
defparam syn__745_.FeedbackMux = 1'b0;
defparam syn__745_.ShiftMux = 1'b0;
defparam syn__745_.BypassEn = 1'b0;
defparam syn__745_.CarryEnb = 1'b1;

alta_slice syn__746_(
	.A(IOvalue[23]),
	.B(IOaddr[23]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__333_),
	.Cout(),
	.Q());
defparam syn__746_.coord_x = 4;
defparam syn__746_.coord_y = 5;
defparam syn__746_.coord_z = 14;
defparam syn__746_.mask = 16'h9F17;
defparam syn__746_.modeMux = 1'b0;
defparam syn__746_.FeedbackMux = 1'b0;
defparam syn__746_.ShiftMux = 1'b0;
defparam syn__746_.BypassEn = 1'b0;
defparam syn__746_.CarryEnb = 1'b1;

alta_slice syn__747_(
	.A(syn__183_),
	.B(\tc.IM [9]),
	.C(syn__333_),
	.D(syn__182_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__334_),
	.Cout(),
	.Q());
defparam syn__747_.coord_x = 5;
defparam syn__747_.coord_y = 5;
defparam syn__747_.coord_z = 8;
defparam syn__747_.mask = 16'hD1E2;
defparam syn__747_.modeMux = 1'b0;
defparam syn__747_.FeedbackMux = 1'b0;
defparam syn__747_.ShiftMux = 1'b0;
defparam syn__747_.BypassEn = 1'b0;
defparam syn__747_.CarryEnb = 1'b1;

alta_slice syn__748_(
	.A(\tc.IM [8]),
	.B(IOvalue[15]),
	.C(\tc.IM [7]),
	.D(IOaddr[15]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__335_),
	.Cout(),
	.Q());
defparam syn__748_.coord_x = 4;
defparam syn__748_.coord_y = 7;
defparam syn__748_.coord_z = 11;
defparam syn__748_.mask = 16'h74C0;
defparam syn__748_.modeMux = 1'b0;
defparam syn__748_.FeedbackMux = 1'b0;
defparam syn__748_.ShiftMux = 1'b0;
defparam syn__748_.BypassEn = 1'b0;
defparam syn__748_.CarryEnb = 1'b1;

alta_slice syn__749_(
	.A(vcc),
	.B(syn__335_),
	.C(\tc.IM [9]),
	.D(syn__184_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__336_),
	.Cout(),
	.Q());
defparam syn__749_.coord_x = 4;
defparam syn__749_.coord_y = 7;
defparam syn__749_.coord_z = 12;
defparam syn__749_.mask = 16'h003F;
defparam syn__749_.modeMux = 1'b0;
defparam syn__749_.FeedbackMux = 1'b0;
defparam syn__749_.ShiftMux = 1'b0;
defparam syn__749_.BypassEn = 1'b0;
defparam syn__749_.CarryEnb = 1'b1;

alta_slice syn__750_(
	.A(IOvalue[7]),
	.B(\tc.IM [8]),
	.C(\tc.IM [7]),
	.D(IOaddr[7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__337_),
	.Cout(),
	.Q());
defparam syn__750_.coord_x = 6;
defparam syn__750_.coord_y = 8;
defparam syn__750_.coord_z = 2;
defparam syn__750_.mask = 16'h8D5F;
defparam syn__750_.modeMux = 1'b0;
defparam syn__750_.FeedbackMux = 1'b0;
defparam syn__750_.ShiftMux = 1'b0;
defparam syn__750_.BypassEn = 1'b0;
defparam syn__750_.CarryEnb = 1'b1;

alta_slice syn__751_(
	.A(syn__186_),
	.B(syn__034_),
	.C(syn__337_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__338_),
	.Cout(),
	.Q());
defparam syn__751_.coord_x = 6;
defparam syn__751_.coord_y = 8;
defparam syn__751_.coord_z = 6;
defparam syn__751_.mask = 16'hF066;
defparam syn__751_.modeMux = 1'b0;
defparam syn__751_.FeedbackMux = 1'b0;
defparam syn__751_.ShiftMux = 1'b0;
defparam syn__751_.BypassEn = 1'b0;
defparam syn__751_.CarryEnb = 1'b1;

alta_slice syn__752_(
	.A(IOvalue[22]),
	.B(IOaddr[22]),
	.C(\tc.IM [7]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__339_),
	.Cout(),
	.Q());
defparam syn__752_.coord_x = 4;
defparam syn__752_.coord_y = 5;
defparam syn__752_.coord_z = 2;
defparam syn__752_.mask = 16'h9F17;
defparam syn__752_.modeMux = 1'b0;
defparam syn__752_.FeedbackMux = 1'b0;
defparam syn__752_.ShiftMux = 1'b0;
defparam syn__752_.BypassEn = 1'b0;
defparam syn__752_.CarryEnb = 1'b1;

alta_slice syn__753_(
	.A(syn__189_),
	.B(\tc.IM [9]),
	.C(syn__339_),
	.D(syn__024_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__340_),
	.Cout(),
	.Q());
defparam syn__753_.coord_x = 5;
defparam syn__753_.coord_y = 5;
defparam syn__753_.coord_z = 7;
defparam syn__753_.mask = 16'hD1E2;
defparam syn__753_.modeMux = 1'b0;
defparam syn__753_.FeedbackMux = 1'b0;
defparam syn__753_.ShiftMux = 1'b0;
defparam syn__753_.BypassEn = 1'b0;
defparam syn__753_.CarryEnb = 1'b1;

alta_slice syn__754_(
	.A(IOaddr[21]),
	.B(IOvalue[21]),
	.C(\tc.IM [8]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__341_),
	.Cout(),
	.Q());
defparam syn__754_.coord_x = 6;
defparam syn__754_.coord_y = 6;
defparam syn__754_.coord_z = 4;
defparam syn__754_.mask = 16'h91F7;
defparam syn__754_.modeMux = 1'b0;
defparam syn__754_.FeedbackMux = 1'b0;
defparam syn__754_.ShiftMux = 1'b0;
defparam syn__754_.BypassEn = 1'b0;
defparam syn__754_.CarryEnb = 1'b1;

alta_slice syn__755_(
	.A(syn__341_),
	.B(syn__194_),
	.C(syn__193_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__342_),
	.Cout(),
	.Q());
defparam syn__755_.coord_x = 6;
defparam syn__755_.coord_y = 6;
defparam syn__755_.coord_z = 6;
defparam syn__755_.mask = 16'hAA3C;
defparam syn__755_.modeMux = 1'b0;
defparam syn__755_.FeedbackMux = 1'b0;
defparam syn__755_.ShiftMux = 1'b0;
defparam syn__755_.BypassEn = 1'b0;
defparam syn__755_.CarryEnb = 1'b1;

alta_slice syn__756_(
	.A(syn__348_),
	.B(syn__346_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__343_),
	.Cout(),
	.Q());
defparam syn__756_.coord_x = 7;
defparam syn__756_.coord_y = 6;
defparam syn__756_.coord_z = 7;
defparam syn__756_.mask = 16'hF0CA;
defparam syn__756_.modeMux = 1'b0;
defparam syn__756_.FeedbackMux = 1'b0;
defparam syn__756_.ShiftMux = 1'b0;
defparam syn__756_.BypassEn = 1'b0;
defparam syn__756_.CarryEnb = 1'b1;

alta_slice syn__757_(
	.A(syn__343_),
	.B(syn__141_),
	.C(syn__306_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__344_),
	.Cout(),
	.Q());
defparam syn__757_.coord_x = 2;
defparam syn__757_.coord_y = 6;
defparam syn__757_.coord_z = 4;
defparam syn__757_.mask = 16'hD8AA;
defparam syn__757_.modeMux = 1'b0;
defparam syn__757_.FeedbackMux = 1'b0;
defparam syn__757_.ShiftMux = 1'b0;
defparam syn__757_.BypassEn = 1'b0;
defparam syn__757_.CarryEnb = 1'b1;

alta_slice syn__758_(
	.A(IOvalue[12]),
	.B(\tc.IM [7]),
	.C(IOaddr[12]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__345_),
	.Cout(),
	.Q());
defparam syn__758_.coord_x = 8;
defparam syn__758_.coord_y = 6;
defparam syn__758_.coord_z = 15;
defparam syn__758_.mask = 16'h48E8;
defparam syn__758_.modeMux = 1'b0;
defparam syn__758_.FeedbackMux = 1'b0;
defparam syn__758_.ShiftMux = 1'b0;
defparam syn__758_.BypassEn = 1'b0;
defparam syn__758_.CarryEnb = 1'b1;

alta_slice syn__759_(
	.A(syn__197_),
	.B(\tc.IM [9]),
	.C(vcc),
	.D(syn__345_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__346_),
	.Cout(),
	.Q());
defparam syn__759_.coord_x = 7;
defparam syn__759_.coord_y = 6;
defparam syn__759_.coord_z = 9;
defparam syn__759_.mask = 16'h1155;
defparam syn__759_.modeMux = 1'b0;
defparam syn__759_.FeedbackMux = 1'b0;
defparam syn__759_.ShiftMux = 1'b0;
defparam syn__759_.BypassEn = 1'b0;
defparam syn__759_.CarryEnb = 1'b1;

alta_slice syn__760_(
	.A(\tc.IM [7]),
	.B(IOaddr[4]),
	.C(IOvalue[4]),
	.D(\tc.IM [8]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__347_),
	.Cout(),
	.Q());
defparam syn__760_.coord_x = 4;
defparam syn__760_.coord_y = 8;
defparam syn__760_.coord_z = 10;
defparam syn__760_.mask = 16'hD717;
defparam syn__760_.modeMux = 1'b0;
defparam syn__760_.FeedbackMux = 1'b0;
defparam syn__760_.ShiftMux = 1'b0;
defparam syn__760_.BypassEn = 1'b0;
defparam syn__760_.CarryEnb = 1'b1;

alta_slice syn__761_(
	.A(syn__347_),
	.B(syn__198_),
	.C(syn__036_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__348_),
	.Cout(),
	.Q());
defparam syn__761_.coord_x = 5;
defparam syn__761_.coord_y = 8;
defparam syn__761_.coord_z = 2;
defparam syn__761_.mask = 16'hAA3C;
defparam syn__761_.modeMux = 1'b0;
defparam syn__761_.FeedbackMux = 1'b0;
defparam syn__761_.ShiftMux = 1'b0;
defparam syn__761_.BypassEn = 1'b0;
defparam syn__761_.CarryEnb = 1'b1;

alta_slice syn__762_(
	.A(\tc.IM [8]),
	.B(IOaddr[2]),
	.C(IOvalue[2]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__349_),
	.Cout(),
	.Q());
defparam syn__762_.coord_x = 4;
defparam syn__762_.coord_y = 7;
defparam syn__762_.coord_z = 2;
defparam syn__762_.mask = 16'h83BF;
defparam syn__762_.modeMux = 1'b0;
defparam syn__762_.FeedbackMux = 1'b0;
defparam syn__762_.ShiftMux = 1'b0;
defparam syn__762_.BypassEn = 1'b0;
defparam syn__762_.CarryEnb = 1'b1;

alta_slice syn__763_(
	.A(vcc),
	.B(syn__349_),
	.C(syn__206_),
	.D(\tc.IM [9]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__350_),
	.Cout(),
	.Q());
defparam syn__763_.coord_x = 7;
defparam syn__763_.coord_y = 4;
defparam syn__763_.coord_z = 10;
defparam syn__763_.mask = 16'hCC0F;
defparam syn__763_.modeMux = 1'b0;
defparam syn__763_.FeedbackMux = 1'b0;
defparam syn__763_.ShiftMux = 1'b0;
defparam syn__763_.BypassEn = 1'b0;
defparam syn__763_.CarryEnb = 1'b1;

alta_slice syn__764_(
	.A(\tc.IM [8]),
	.B(IOvalue[1]),
	.C(IOaddr[1]),
	.D(\tc.IM [7]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__351_),
	.Cout(),
	.Q());
defparam syn__764_.coord_x = 4;
defparam syn__764_.coord_y = 7;
defparam syn__764_.coord_z = 14;
defparam syn__764_.mask = 16'h83BF;
defparam syn__764_.modeMux = 1'b0;
defparam syn__764_.FeedbackMux = 1'b0;
defparam syn__764_.ShiftMux = 1'b0;
defparam syn__764_.BypassEn = 1'b0;
defparam syn__764_.CarryEnb = 1'b1;

alta_slice syn__765_(
	.A(\tc.IM [9]),
	.B(syn__040_),
	.C(syn__210_),
	.D(syn__351_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__352_),
	.Cout(),
	.Q());
defparam syn__765_.coord_x = 5;
defparam syn__765_.coord_y = 7;
defparam syn__765_.coord_z = 1;
defparam syn__765_.mask = 16'hEB41;
defparam syn__765_.modeMux = 1'b0;
defparam syn__765_.FeedbackMux = 1'b0;
defparam syn__765_.ShiftMux = 1'b0;
defparam syn__765_.BypassEn = 1'b0;
defparam syn__765_.CarryEnb = 1'b1;

alta_slice syn__766_(
	.A(syn__350_),
	.B(syn__316_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__353_),
	.Cout(),
	.Q());
defparam syn__766_.coord_x = 7;
defparam syn__766_.coord_y = 4;
defparam syn__766_.coord_z = 11;
defparam syn__766_.mask = 16'hACF0;
defparam syn__766_.modeMux = 1'b0;
defparam syn__766_.FeedbackMux = 1'b0;
defparam syn__766_.ShiftMux = 1'b0;
defparam syn__766_.BypassEn = 1'b0;
defparam syn__766_.CarryEnb = 1'b1;

alta_slice syn__767_(
	.A(syn__149_),
	.B(syn__353_),
	.C(syn__320_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__354_),
	.Cout(),
	.Q());
defparam syn__767_.coord_x = 7;
defparam syn__767_.coord_y = 4;
defparam syn__767_.coord_z = 15;
defparam syn__767_.mask = 16'hCCE2;
defparam syn__767_.modeMux = 1'b0;
defparam syn__767_.FeedbackMux = 1'b0;
defparam syn__767_.ShiftMux = 1'b0;
defparam syn__767_.BypassEn = 1'b0;
defparam syn__767_.CarryEnb = 1'b1;

alta_slice syn__768_(
	.A(syn__324_),
	.B(syn__352_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__355_),
	.Cout(),
	.Q());
defparam syn__768_.coord_x = 7;
defparam syn__768_.coord_y = 3;
defparam syn__768_.coord_z = 1;
defparam syn__768_.mask = 16'hF0CA;
defparam syn__768_.modeMux = 1'b0;
defparam syn__768_.FeedbackMux = 1'b0;
defparam syn__768_.ShiftMux = 1'b0;
defparam syn__768_.BypassEn = 1'b0;
defparam syn__768_.CarryEnb = 1'b1;

alta_slice syn__769_(
	.A(syn__355_),
	.B(syn__320_),
	.C(syn__328_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__356_),
	.Cout(),
	.Q());
defparam syn__769_.coord_x = 5;
defparam syn__769_.coord_y = 4;
defparam syn__769_.coord_z = 8;
defparam syn__769_.mask = 16'hE4AA;
defparam syn__769_.modeMux = 1'b0;
defparam syn__769_.FeedbackMux = 1'b0;
defparam syn__769_.ShiftMux = 1'b0;
defparam syn__769_.BypassEn = 1'b0;
defparam syn__769_.CarryEnb = 1'b1;

alta_slice syn__770_(
	.A(syn__350_),
	.B(vcc),
	.C(syn__322_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__357_),
	.Cout(),
	.Q());
defparam syn__770_.coord_x = 7;
defparam syn__770_.coord_y = 4;
defparam syn__770_.coord_z = 7;
defparam syn__770_.mask = 16'hF0AA;
defparam syn__770_.modeMux = 1'b0;
defparam syn__770_.FeedbackMux = 1'b0;
defparam syn__770_.ShiftMux = 1'b0;
defparam syn__770_.BypassEn = 1'b0;
defparam syn__770_.CarryEnb = 1'b1;

alta_slice syn__771_(
	.A(syn__357_),
	.B(syn__320_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__358_),
	.Cout(),
	.Q());
defparam syn__771_.coord_x = 7;
defparam syn__771_.coord_y = 3;
defparam syn__771_.coord_z = 9;
defparam syn__771_.mask = 16'hAFAC;
defparam syn__771_.modeMux = 1'b0;
defparam syn__771_.FeedbackMux = 1'b0;
defparam syn__771_.ShiftMux = 1'b0;
defparam syn__771_.BypassEn = 1'b0;
defparam syn__771_.CarryEnb = 1'b1;

alta_slice syn__772_(
	.A(syn__340_),
	.B(syn__306_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__359_),
	.Cout(),
	.Q());
defparam syn__772_.coord_x = 7;
defparam syn__772_.coord_y = 3;
defparam syn__772_.coord_z = 11;
defparam syn__772_.mask = 16'hCAF0;
defparam syn__772_.modeMux = 1'b0;
defparam syn__772_.FeedbackMux = 1'b0;
defparam syn__772_.ShiftMux = 1'b0;
defparam syn__772_.BypassEn = 1'b0;
defparam syn__772_.CarryEnb = 1'b1;

alta_slice syn__773_(
	.A(syn__342_),
	.B(\tc.IM [5]),
	.C(syn__359_),
	.D(syn__118_),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__360_),
	.Cout(),
	.Q());
defparam syn__773_.coord_x = 6;
defparam syn__773_.coord_y = 3;
defparam syn__773_.coord_z = 8;
defparam syn__773_.mask = 16'hF2C2;
defparam syn__773_.modeMux = 1'b0;
defparam syn__773_.FeedbackMux = 1'b0;
defparam syn__773_.ShiftMux = 1'b0;
defparam syn__773_.BypassEn = 1'b0;
defparam syn__773_.CarryEnb = 1'b1;

alta_slice syn__774_(
	.A(vcc),
	.B(syn__346_),
	.C(syn__348_),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__361_),
	.Cout(),
	.Q());
defparam syn__774_.coord_x = 7;
defparam syn__774_.coord_y = 6;
defparam syn__774_.coord_z = 13;
defparam syn__774_.mask = 16'hCCF0;
defparam syn__774_.modeMux = 1'b0;
defparam syn__774_.FeedbackMux = 1'b0;
defparam syn__774_.ShiftMux = 1'b0;
defparam syn__774_.BypassEn = 1'b0;
defparam syn__774_.CarryEnb = 1'b1;

alta_slice syn__775_(
	.A(syn__361_),
	.B(syn__308_),
	.C(\tc.IM [6]),
	.D(\tc.IM [5]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__362_),
	.Cout(),
	.Q());
defparam syn__775_.coord_x = 7;
defparam syn__775_.coord_y = 3;
defparam syn__775_.coord_z = 4;
defparam syn__775_.mask = 16'hAFAC;
defparam syn__775_.modeMux = 1'b0;
defparam syn__775_.FeedbackMux = 1'b0;
defparam syn__775_.ShiftMux = 1'b0;
defparam syn__775_.BypassEn = 1'b0;
defparam syn__775_.CarryEnb = 1'b1;

alta_rio syn__776_(
	.padio(bank0[0]),
	.datain(syn__363_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__776_.coord_x = 2;
defparam syn__776_.coord_y = 9;
defparam syn__776_.coord_z = 0;
defparam syn__776_.IN_ASYNC_MODE = 1'b0;
defparam syn__776_.IN_SYNC_MODE = 1'b0;
defparam syn__776_.IN_POWERUP = 1'b0;
defparam syn__776_.OUT_REG_MODE = 1'b0;
defparam syn__776_.OUT_ASYNC_MODE = 1'b0;
defparam syn__776_.OUT_SYNC_MODE = 1'b0;
defparam syn__776_.OUT_POWERUP = 1'b0;
defparam syn__776_.OE_REG_MODE = 1'b0;
defparam syn__776_.OE_ASYNC_MODE = 1'b0;
defparam syn__776_.OE_SYNC_MODE = 1'b0;
defparam syn__776_.OE_POWERUP = 1'b0;
defparam syn__776_.CFG_TRI_INPUT = 1'b0;
defparam syn__776_.CFG_PULL_UP = 1'b0;
defparam syn__776_.CFG_SLR = 1'b0;
defparam syn__776_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__776_.CFG_PDRCTRL = 4'b0010;
defparam syn__776_.CFG_KEEP = 2'b00;
defparam syn__776_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__776_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__776_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__776_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__776_.DPCLK_DELAY = 4'b0000;
defparam syn__776_.OUT_DELAY = 1'b0;
defparam syn__776_.IN_DATA_DELAY = 3'b000;
defparam syn__776_.IN_REG_DELAY = 3'b000;

alta_rio syn__777_(
	.padio(bank0[1]),
	.datain(syn__363_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__777_.coord_x = 1;
defparam syn__777_.coord_y = 9;
defparam syn__777_.coord_z = 3;
defparam syn__777_.IN_ASYNC_MODE = 1'b0;
defparam syn__777_.IN_SYNC_MODE = 1'b0;
defparam syn__777_.IN_POWERUP = 1'b0;
defparam syn__777_.OUT_REG_MODE = 1'b0;
defparam syn__777_.OUT_ASYNC_MODE = 1'b0;
defparam syn__777_.OUT_SYNC_MODE = 1'b0;
defparam syn__777_.OUT_POWERUP = 1'b0;
defparam syn__777_.OE_REG_MODE = 1'b0;
defparam syn__777_.OE_ASYNC_MODE = 1'b0;
defparam syn__777_.OE_SYNC_MODE = 1'b0;
defparam syn__777_.OE_POWERUP = 1'b0;
defparam syn__777_.CFG_TRI_INPUT = 1'b0;
defparam syn__777_.CFG_PULL_UP = 1'b0;
defparam syn__777_.CFG_SLR = 1'b0;
defparam syn__777_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__777_.CFG_PDRCTRL = 4'b0010;
defparam syn__777_.CFG_KEEP = 2'b00;
defparam syn__777_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__777_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__777_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__777_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__777_.DPCLK_DELAY = 4'b0000;
defparam syn__777_.OUT_DELAY = 1'b0;
defparam syn__777_.IN_DATA_DELAY = 3'b000;
defparam syn__777_.IN_REG_DELAY = 3'b000;

alta_rio syn__778_(
	.padio(bank0[2]),
	.datain(syn__363_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__778_.coord_x = 0;
defparam syn__778_.coord_y = 9;
defparam syn__778_.coord_z = 2;
defparam syn__778_.IN_ASYNC_MODE = 1'b0;
defparam syn__778_.IN_SYNC_MODE = 1'b0;
defparam syn__778_.IN_POWERUP = 1'b0;
defparam syn__778_.OUT_REG_MODE = 1'b0;
defparam syn__778_.OUT_ASYNC_MODE = 1'b0;
defparam syn__778_.OUT_SYNC_MODE = 1'b0;
defparam syn__778_.OUT_POWERUP = 1'b0;
defparam syn__778_.OE_REG_MODE = 1'b0;
defparam syn__778_.OE_ASYNC_MODE = 1'b0;
defparam syn__778_.OE_SYNC_MODE = 1'b0;
defparam syn__778_.OE_POWERUP = 1'b0;
defparam syn__778_.CFG_TRI_INPUT = 1'b0;
defparam syn__778_.CFG_PULL_UP = 1'b0;
defparam syn__778_.CFG_SLR = 1'b0;
defparam syn__778_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__778_.CFG_PDRCTRL = 4'b0010;
defparam syn__778_.CFG_KEEP = 2'b00;
defparam syn__778_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__778_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__778_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__778_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__778_.DPCLK_DELAY = 4'b0000;
defparam syn__778_.OUT_DELAY = 1'b0;
defparam syn__778_.IN_DATA_DELAY = 3'b000;
defparam syn__778_.IN_REG_DELAY = 3'b000;

alta_rio syn__779_(
	.padio(bank0[3]),
	.datain(syn__363_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__779_.coord_x = 0;
defparam syn__779_.coord_y = 9;
defparam syn__779_.coord_z = 0;
defparam syn__779_.IN_ASYNC_MODE = 1'b0;
defparam syn__779_.IN_SYNC_MODE = 1'b0;
defparam syn__779_.IN_POWERUP = 1'b0;
defparam syn__779_.OUT_REG_MODE = 1'b0;
defparam syn__779_.OUT_ASYNC_MODE = 1'b0;
defparam syn__779_.OUT_SYNC_MODE = 1'b0;
defparam syn__779_.OUT_POWERUP = 1'b0;
defparam syn__779_.OE_REG_MODE = 1'b0;
defparam syn__779_.OE_ASYNC_MODE = 1'b0;
defparam syn__779_.OE_SYNC_MODE = 1'b0;
defparam syn__779_.OE_POWERUP = 1'b0;
defparam syn__779_.CFG_TRI_INPUT = 1'b0;
defparam syn__779_.CFG_PULL_UP = 1'b0;
defparam syn__779_.CFG_SLR = 1'b0;
defparam syn__779_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__779_.CFG_PDRCTRL = 4'b0010;
defparam syn__779_.CFG_KEEP = 2'b00;
defparam syn__779_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__779_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__779_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__779_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__779_.DPCLK_DELAY = 4'b0000;
defparam syn__779_.OUT_DELAY = 1'b0;
defparam syn__779_.IN_DATA_DELAY = 3'b000;
defparam syn__779_.IN_REG_DELAY = 3'b000;

alta_rio syn__780_(
	.padio(bank0[4]),
	.datain(syn__363_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__780_.coord_x = 1;
defparam syn__780_.coord_y = 9;
defparam syn__780_.coord_z = 1;
defparam syn__780_.IN_ASYNC_MODE = 1'b0;
defparam syn__780_.IN_SYNC_MODE = 1'b0;
defparam syn__780_.IN_POWERUP = 1'b0;
defparam syn__780_.OUT_REG_MODE = 1'b0;
defparam syn__780_.OUT_ASYNC_MODE = 1'b0;
defparam syn__780_.OUT_SYNC_MODE = 1'b0;
defparam syn__780_.OUT_POWERUP = 1'b0;
defparam syn__780_.OE_REG_MODE = 1'b0;
defparam syn__780_.OE_ASYNC_MODE = 1'b0;
defparam syn__780_.OE_SYNC_MODE = 1'b0;
defparam syn__780_.OE_POWERUP = 1'b0;
defparam syn__780_.CFG_TRI_INPUT = 1'b0;
defparam syn__780_.CFG_PULL_UP = 1'b0;
defparam syn__780_.CFG_SLR = 1'b0;
defparam syn__780_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__780_.CFG_PDRCTRL = 4'b0010;
defparam syn__780_.CFG_KEEP = 2'b00;
defparam syn__780_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__780_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__780_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__780_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__780_.DPCLK_DELAY = 4'b0000;
defparam syn__780_.OUT_DELAY = 1'b0;
defparam syn__780_.IN_DATA_DELAY = 3'b000;
defparam syn__780_.IN_REG_DELAY = 3'b000;

alta_rio syn__781_(
	.padio(bank0[5]),
	.datain(syn__363_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__781_.coord_x = 6;
defparam syn__781_.coord_y = 9;
defparam syn__781_.coord_z = 2;
defparam syn__781_.IN_ASYNC_MODE = 1'b0;
defparam syn__781_.IN_SYNC_MODE = 1'b0;
defparam syn__781_.IN_POWERUP = 1'b0;
defparam syn__781_.OUT_REG_MODE = 1'b0;
defparam syn__781_.OUT_ASYNC_MODE = 1'b0;
defparam syn__781_.OUT_SYNC_MODE = 1'b0;
defparam syn__781_.OUT_POWERUP = 1'b0;
defparam syn__781_.OE_REG_MODE = 1'b0;
defparam syn__781_.OE_ASYNC_MODE = 1'b0;
defparam syn__781_.OE_SYNC_MODE = 1'b0;
defparam syn__781_.OE_POWERUP = 1'b0;
defparam syn__781_.CFG_TRI_INPUT = 1'b0;
defparam syn__781_.CFG_PULL_UP = 1'b0;
defparam syn__781_.CFG_SLR = 1'b0;
defparam syn__781_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__781_.CFG_PDRCTRL = 4'b0010;
defparam syn__781_.CFG_KEEP = 2'b00;
defparam syn__781_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__781_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__781_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__781_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__781_.DPCLK_DELAY = 4'b0000;
defparam syn__781_.OUT_DELAY = 1'b0;
defparam syn__781_.IN_DATA_DELAY = 3'b000;
defparam syn__781_.IN_REG_DELAY = 3'b000;

alta_rio syn__782_(
	.padio(bank0[6]),
	.datain(syn__363_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__782_.coord_x = 2;
defparam syn__782_.coord_y = 1;
defparam syn__782_.coord_z = 0;
defparam syn__782_.IN_ASYNC_MODE = 1'b0;
defparam syn__782_.IN_SYNC_MODE = 1'b0;
defparam syn__782_.IN_POWERUP = 1'b0;
defparam syn__782_.OUT_REG_MODE = 1'b0;
defparam syn__782_.OUT_ASYNC_MODE = 1'b0;
defparam syn__782_.OUT_SYNC_MODE = 1'b0;
defparam syn__782_.OUT_POWERUP = 1'b0;
defparam syn__782_.OE_REG_MODE = 1'b0;
defparam syn__782_.OE_ASYNC_MODE = 1'b0;
defparam syn__782_.OE_SYNC_MODE = 1'b0;
defparam syn__782_.OE_POWERUP = 1'b0;
defparam syn__782_.CFG_TRI_INPUT = 1'b0;
defparam syn__782_.CFG_PULL_UP = 1'b0;
defparam syn__782_.CFG_SLR = 1'b0;
defparam syn__782_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__782_.CFG_PDRCTRL = 4'b0010;
defparam syn__782_.CFG_KEEP = 2'b00;
defparam syn__782_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__782_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__782_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__782_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__782_.DPCLK_DELAY = 4'b0000;
defparam syn__782_.OUT_DELAY = 1'b0;
defparam syn__782_.IN_DATA_DELAY = 3'b000;
defparam syn__782_.IN_REG_DELAY = 3'b000;

alta_rio syn__783_(
	.padio(bank0[7]),
	.datain(syn__363_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__783_.coord_x = 2;
defparam syn__783_.coord_y = 1;
defparam syn__783_.coord_z = 2;
defparam syn__783_.IN_ASYNC_MODE = 1'b0;
defparam syn__783_.IN_SYNC_MODE = 1'b0;
defparam syn__783_.IN_POWERUP = 1'b0;
defparam syn__783_.OUT_REG_MODE = 1'b0;
defparam syn__783_.OUT_ASYNC_MODE = 1'b0;
defparam syn__783_.OUT_SYNC_MODE = 1'b0;
defparam syn__783_.OUT_POWERUP = 1'b0;
defparam syn__783_.OE_REG_MODE = 1'b0;
defparam syn__783_.OE_ASYNC_MODE = 1'b0;
defparam syn__783_.OE_SYNC_MODE = 1'b0;
defparam syn__783_.OE_POWERUP = 1'b0;
defparam syn__783_.CFG_TRI_INPUT = 1'b0;
defparam syn__783_.CFG_PULL_UP = 1'b0;
defparam syn__783_.CFG_SLR = 1'b0;
defparam syn__783_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__783_.CFG_PDRCTRL = 4'b0010;
defparam syn__783_.CFG_KEEP = 2'b00;
defparam syn__783_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__783_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__783_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__783_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__783_.DPCLK_DELAY = 4'b0000;
defparam syn__783_.OUT_DELAY = 1'b0;
defparam syn__783_.IN_DATA_DELAY = 3'b000;
defparam syn__783_.IN_REG_DELAY = 3'b000;

alta_rio syn__784_(
	.padio(bank1[0]),
	.datain(syn__363_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__784_.coord_x = 4;
defparam syn__784_.coord_y = 1;
defparam syn__784_.coord_z = 0;
defparam syn__784_.IN_ASYNC_MODE = 1'b0;
defparam syn__784_.IN_SYNC_MODE = 1'b0;
defparam syn__784_.IN_POWERUP = 1'b0;
defparam syn__784_.OUT_REG_MODE = 1'b0;
defparam syn__784_.OUT_ASYNC_MODE = 1'b0;
defparam syn__784_.OUT_SYNC_MODE = 1'b0;
defparam syn__784_.OUT_POWERUP = 1'b0;
defparam syn__784_.OE_REG_MODE = 1'b0;
defparam syn__784_.OE_ASYNC_MODE = 1'b0;
defparam syn__784_.OE_SYNC_MODE = 1'b0;
defparam syn__784_.OE_POWERUP = 1'b0;
defparam syn__784_.CFG_TRI_INPUT = 1'b0;
defparam syn__784_.CFG_PULL_UP = 1'b0;
defparam syn__784_.CFG_SLR = 1'b0;
defparam syn__784_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__784_.CFG_PDRCTRL = 4'b0010;
defparam syn__784_.CFG_KEEP = 2'b00;
defparam syn__784_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__784_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__784_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__784_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__784_.DPCLK_DELAY = 4'b0000;
defparam syn__784_.OUT_DELAY = 1'b0;
defparam syn__784_.IN_DATA_DELAY = 3'b000;
defparam syn__784_.IN_REG_DELAY = 3'b000;

alta_rio syn__785_(
	.padio(bank1[1]),
	.datain(syn__363_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__785_.coord_x = 4;
defparam syn__785_.coord_y = 1;
defparam syn__785_.coord_z = 2;
defparam syn__785_.IN_ASYNC_MODE = 1'b0;
defparam syn__785_.IN_SYNC_MODE = 1'b0;
defparam syn__785_.IN_POWERUP = 1'b0;
defparam syn__785_.OUT_REG_MODE = 1'b0;
defparam syn__785_.OUT_ASYNC_MODE = 1'b0;
defparam syn__785_.OUT_SYNC_MODE = 1'b0;
defparam syn__785_.OUT_POWERUP = 1'b0;
defparam syn__785_.OE_REG_MODE = 1'b0;
defparam syn__785_.OE_ASYNC_MODE = 1'b0;
defparam syn__785_.OE_SYNC_MODE = 1'b0;
defparam syn__785_.OE_POWERUP = 1'b0;
defparam syn__785_.CFG_TRI_INPUT = 1'b0;
defparam syn__785_.CFG_PULL_UP = 1'b0;
defparam syn__785_.CFG_SLR = 1'b0;
defparam syn__785_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__785_.CFG_PDRCTRL = 4'b0010;
defparam syn__785_.CFG_KEEP = 2'b00;
defparam syn__785_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__785_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__785_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__785_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__785_.DPCLK_DELAY = 4'b0000;
defparam syn__785_.OUT_DELAY = 1'b0;
defparam syn__785_.IN_DATA_DELAY = 3'b000;
defparam syn__785_.IN_REG_DELAY = 3'b000;

alta_rio syn__786_(
	.padio(bank1[2]),
	.datain(syn__363_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__786_.coord_x = 5;
defparam syn__786_.coord_y = 1;
defparam syn__786_.coord_z = 0;
defparam syn__786_.IN_ASYNC_MODE = 1'b0;
defparam syn__786_.IN_SYNC_MODE = 1'b0;
defparam syn__786_.IN_POWERUP = 1'b0;
defparam syn__786_.OUT_REG_MODE = 1'b0;
defparam syn__786_.OUT_ASYNC_MODE = 1'b0;
defparam syn__786_.OUT_SYNC_MODE = 1'b0;
defparam syn__786_.OUT_POWERUP = 1'b0;
defparam syn__786_.OE_REG_MODE = 1'b0;
defparam syn__786_.OE_ASYNC_MODE = 1'b0;
defparam syn__786_.OE_SYNC_MODE = 1'b0;
defparam syn__786_.OE_POWERUP = 1'b0;
defparam syn__786_.CFG_TRI_INPUT = 1'b0;
defparam syn__786_.CFG_PULL_UP = 1'b0;
defparam syn__786_.CFG_SLR = 1'b0;
defparam syn__786_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__786_.CFG_PDRCTRL = 4'b0010;
defparam syn__786_.CFG_KEEP = 2'b00;
defparam syn__786_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__786_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__786_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__786_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__786_.DPCLK_DELAY = 4'b0000;
defparam syn__786_.OUT_DELAY = 1'b0;
defparam syn__786_.IN_DATA_DELAY = 3'b000;
defparam syn__786_.IN_REG_DELAY = 3'b000;

alta_rio syn__787_(
	.padio(bank1[3]),
	.datain(syn__363_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__787_.coord_x = 5;
defparam syn__787_.coord_y = 1;
defparam syn__787_.coord_z = 1;
defparam syn__787_.IN_ASYNC_MODE = 1'b0;
defparam syn__787_.IN_SYNC_MODE = 1'b0;
defparam syn__787_.IN_POWERUP = 1'b0;
defparam syn__787_.OUT_REG_MODE = 1'b0;
defparam syn__787_.OUT_ASYNC_MODE = 1'b0;
defparam syn__787_.OUT_SYNC_MODE = 1'b0;
defparam syn__787_.OUT_POWERUP = 1'b0;
defparam syn__787_.OE_REG_MODE = 1'b0;
defparam syn__787_.OE_ASYNC_MODE = 1'b0;
defparam syn__787_.OE_SYNC_MODE = 1'b0;
defparam syn__787_.OE_POWERUP = 1'b0;
defparam syn__787_.CFG_TRI_INPUT = 1'b0;
defparam syn__787_.CFG_PULL_UP = 1'b0;
defparam syn__787_.CFG_SLR = 1'b0;
defparam syn__787_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__787_.CFG_PDRCTRL = 4'b0010;
defparam syn__787_.CFG_KEEP = 2'b00;
defparam syn__787_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__787_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__787_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__787_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__787_.DPCLK_DELAY = 4'b0000;
defparam syn__787_.OUT_DELAY = 1'b0;
defparam syn__787_.IN_DATA_DELAY = 3'b000;
defparam syn__787_.IN_REG_DELAY = 3'b000;

alta_rio syn__788_(
	.padio(bank1[4]),
	.datain(syn__363_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__788_.coord_x = 5;
defparam syn__788_.coord_y = 1;
defparam syn__788_.coord_z = 2;
defparam syn__788_.IN_ASYNC_MODE = 1'b0;
defparam syn__788_.IN_SYNC_MODE = 1'b0;
defparam syn__788_.IN_POWERUP = 1'b0;
defparam syn__788_.OUT_REG_MODE = 1'b0;
defparam syn__788_.OUT_ASYNC_MODE = 1'b0;
defparam syn__788_.OUT_SYNC_MODE = 1'b0;
defparam syn__788_.OUT_POWERUP = 1'b0;
defparam syn__788_.OE_REG_MODE = 1'b0;
defparam syn__788_.OE_ASYNC_MODE = 1'b0;
defparam syn__788_.OE_SYNC_MODE = 1'b0;
defparam syn__788_.OE_POWERUP = 1'b0;
defparam syn__788_.CFG_TRI_INPUT = 1'b0;
defparam syn__788_.CFG_PULL_UP = 1'b0;
defparam syn__788_.CFG_SLR = 1'b0;
defparam syn__788_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__788_.CFG_PDRCTRL = 4'b0010;
defparam syn__788_.CFG_KEEP = 2'b00;
defparam syn__788_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__788_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__788_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__788_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__788_.DPCLK_DELAY = 4'b0000;
defparam syn__788_.OUT_DELAY = 1'b0;
defparam syn__788_.IN_DATA_DELAY = 3'b000;
defparam syn__788_.IN_REG_DELAY = 3'b000;

alta_rio syn__789_(
	.padio(bank1[5]),
	.datain(syn__363_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__789_.coord_x = 5;
defparam syn__789_.coord_y = 1;
defparam syn__789_.coord_z = 3;
defparam syn__789_.IN_ASYNC_MODE = 1'b0;
defparam syn__789_.IN_SYNC_MODE = 1'b0;
defparam syn__789_.IN_POWERUP = 1'b0;
defparam syn__789_.OUT_REG_MODE = 1'b0;
defparam syn__789_.OUT_ASYNC_MODE = 1'b0;
defparam syn__789_.OUT_SYNC_MODE = 1'b0;
defparam syn__789_.OUT_POWERUP = 1'b0;
defparam syn__789_.OE_REG_MODE = 1'b0;
defparam syn__789_.OE_ASYNC_MODE = 1'b0;
defparam syn__789_.OE_SYNC_MODE = 1'b0;
defparam syn__789_.OE_POWERUP = 1'b0;
defparam syn__789_.CFG_TRI_INPUT = 1'b0;
defparam syn__789_.CFG_PULL_UP = 1'b0;
defparam syn__789_.CFG_SLR = 1'b0;
defparam syn__789_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__789_.CFG_PDRCTRL = 4'b0010;
defparam syn__789_.CFG_KEEP = 2'b00;
defparam syn__789_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__789_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__789_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__789_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__789_.DPCLK_DELAY = 4'b0000;
defparam syn__789_.OUT_DELAY = 1'b0;
defparam syn__789_.IN_DATA_DELAY = 3'b000;
defparam syn__789_.IN_REG_DELAY = 3'b000;

alta_rio syn__790_(
	.padio(bank1[6]),
	.datain(syn__363_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__790_.coord_x = 6;
defparam syn__790_.coord_y = 1;
defparam syn__790_.coord_z = 0;
defparam syn__790_.IN_ASYNC_MODE = 1'b0;
defparam syn__790_.IN_SYNC_MODE = 1'b0;
defparam syn__790_.IN_POWERUP = 1'b0;
defparam syn__790_.OUT_REG_MODE = 1'b0;
defparam syn__790_.OUT_ASYNC_MODE = 1'b0;
defparam syn__790_.OUT_SYNC_MODE = 1'b0;
defparam syn__790_.OUT_POWERUP = 1'b0;
defparam syn__790_.OE_REG_MODE = 1'b0;
defparam syn__790_.OE_ASYNC_MODE = 1'b0;
defparam syn__790_.OE_SYNC_MODE = 1'b0;
defparam syn__790_.OE_POWERUP = 1'b0;
defparam syn__790_.CFG_TRI_INPUT = 1'b0;
defparam syn__790_.CFG_PULL_UP = 1'b0;
defparam syn__790_.CFG_SLR = 1'b0;
defparam syn__790_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__790_.CFG_PDRCTRL = 4'b0010;
defparam syn__790_.CFG_KEEP = 2'b00;
defparam syn__790_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__790_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__790_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__790_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__790_.DPCLK_DELAY = 4'b0000;
defparam syn__790_.OUT_DELAY = 1'b0;
defparam syn__790_.IN_DATA_DELAY = 3'b000;
defparam syn__790_.IN_REG_DELAY = 3'b000;

alta_rio syn__791_(
	.padio(bank1[7]),
	.datain(syn__363_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__791_.coord_x = 6;
defparam syn__791_.coord_y = 1;
defparam syn__791_.coord_z = 1;
defparam syn__791_.IN_ASYNC_MODE = 1'b0;
defparam syn__791_.IN_SYNC_MODE = 1'b0;
defparam syn__791_.IN_POWERUP = 1'b0;
defparam syn__791_.OUT_REG_MODE = 1'b0;
defparam syn__791_.OUT_ASYNC_MODE = 1'b0;
defparam syn__791_.OUT_SYNC_MODE = 1'b0;
defparam syn__791_.OUT_POWERUP = 1'b0;
defparam syn__791_.OE_REG_MODE = 1'b0;
defparam syn__791_.OE_ASYNC_MODE = 1'b0;
defparam syn__791_.OE_SYNC_MODE = 1'b0;
defparam syn__791_.OE_POWERUP = 1'b0;
defparam syn__791_.CFG_TRI_INPUT = 1'b0;
defparam syn__791_.CFG_PULL_UP = 1'b0;
defparam syn__791_.CFG_SLR = 1'b0;
defparam syn__791_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__791_.CFG_PDRCTRL = 4'b0010;
defparam syn__791_.CFG_KEEP = 2'b00;
defparam syn__791_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__791_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__791_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__791_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__791_.DPCLK_DELAY = 4'b0000;
defparam syn__791_.OUT_DELAY = 1'b0;
defparam syn__791_.IN_DATA_DELAY = 3'b000;
defparam syn__791_.IN_REG_DELAY = 3'b000;

alta_rio syn__792_(
	.padio(bank2[0]),
	.datain(syn__363_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__792_.coord_x = 6;
defparam syn__792_.coord_y = 1;
defparam syn__792_.coord_z = 2;
defparam syn__792_.IN_ASYNC_MODE = 1'b0;
defparam syn__792_.IN_SYNC_MODE = 1'b0;
defparam syn__792_.IN_POWERUP = 1'b0;
defparam syn__792_.OUT_REG_MODE = 1'b0;
defparam syn__792_.OUT_ASYNC_MODE = 1'b0;
defparam syn__792_.OUT_SYNC_MODE = 1'b0;
defparam syn__792_.OUT_POWERUP = 1'b0;
defparam syn__792_.OE_REG_MODE = 1'b0;
defparam syn__792_.OE_ASYNC_MODE = 1'b0;
defparam syn__792_.OE_SYNC_MODE = 1'b0;
defparam syn__792_.OE_POWERUP = 1'b0;
defparam syn__792_.CFG_TRI_INPUT = 1'b0;
defparam syn__792_.CFG_PULL_UP = 1'b0;
defparam syn__792_.CFG_SLR = 1'b0;
defparam syn__792_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__792_.CFG_PDRCTRL = 4'b0010;
defparam syn__792_.CFG_KEEP = 2'b00;
defparam syn__792_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__792_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__792_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__792_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__792_.DPCLK_DELAY = 4'b0000;
defparam syn__792_.OUT_DELAY = 1'b0;
defparam syn__792_.IN_DATA_DELAY = 3'b000;
defparam syn__792_.IN_REG_DELAY = 3'b000;

alta_rio syn__793_(
	.padio(bank2[1]),
	.datain(syn__363_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__793_.coord_x = 6;
defparam syn__793_.coord_y = 1;
defparam syn__793_.coord_z = 3;
defparam syn__793_.IN_ASYNC_MODE = 1'b0;
defparam syn__793_.IN_SYNC_MODE = 1'b0;
defparam syn__793_.IN_POWERUP = 1'b0;
defparam syn__793_.OUT_REG_MODE = 1'b0;
defparam syn__793_.OUT_ASYNC_MODE = 1'b0;
defparam syn__793_.OUT_SYNC_MODE = 1'b0;
defparam syn__793_.OUT_POWERUP = 1'b0;
defparam syn__793_.OE_REG_MODE = 1'b0;
defparam syn__793_.OE_ASYNC_MODE = 1'b0;
defparam syn__793_.OE_SYNC_MODE = 1'b0;
defparam syn__793_.OE_POWERUP = 1'b0;
defparam syn__793_.CFG_TRI_INPUT = 1'b0;
defparam syn__793_.CFG_PULL_UP = 1'b0;
defparam syn__793_.CFG_SLR = 1'b0;
defparam syn__793_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__793_.CFG_PDRCTRL = 4'b0010;
defparam syn__793_.CFG_KEEP = 2'b00;
defparam syn__793_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__793_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__793_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__793_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__793_.DPCLK_DELAY = 4'b0000;
defparam syn__793_.OUT_DELAY = 1'b0;
defparam syn__793_.IN_DATA_DELAY = 3'b000;
defparam syn__793_.IN_REG_DELAY = 3'b000;

alta_rio syn__794_(
	.padio(bank2[2]),
	.datain(syn__363_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__794_.coord_x = 9;
defparam syn__794_.coord_y = 0;
defparam syn__794_.coord_z = 1;
defparam syn__794_.IN_ASYNC_MODE = 1'b0;
defparam syn__794_.IN_SYNC_MODE = 1'b0;
defparam syn__794_.IN_POWERUP = 1'b0;
defparam syn__794_.OUT_REG_MODE = 1'b0;
defparam syn__794_.OUT_ASYNC_MODE = 1'b0;
defparam syn__794_.OUT_SYNC_MODE = 1'b0;
defparam syn__794_.OUT_POWERUP = 1'b0;
defparam syn__794_.OE_REG_MODE = 1'b0;
defparam syn__794_.OE_ASYNC_MODE = 1'b0;
defparam syn__794_.OE_SYNC_MODE = 1'b0;
defparam syn__794_.OE_POWERUP = 1'b0;
defparam syn__794_.CFG_TRI_INPUT = 1'b0;
defparam syn__794_.CFG_PULL_UP = 1'b0;
defparam syn__794_.CFG_SLR = 1'b0;
defparam syn__794_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__794_.CFG_PDRCTRL = 4'b0010;
defparam syn__794_.CFG_KEEP = 2'b00;
defparam syn__794_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__794_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__794_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__794_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__794_.DPCLK_DELAY = 4'b0000;
defparam syn__794_.OUT_DELAY = 1'b0;
defparam syn__794_.IN_DATA_DELAY = 3'b000;
defparam syn__794_.IN_REG_DELAY = 3'b000;

alta_rio syn__795_(
	.padio(bank2[3]),
	.datain(syn__363_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__795_.coord_x = 9;
defparam syn__795_.coord_y = 0;
defparam syn__795_.coord_z = 3;
defparam syn__795_.IN_ASYNC_MODE = 1'b0;
defparam syn__795_.IN_SYNC_MODE = 1'b0;
defparam syn__795_.IN_POWERUP = 1'b0;
defparam syn__795_.OUT_REG_MODE = 1'b0;
defparam syn__795_.OUT_ASYNC_MODE = 1'b0;
defparam syn__795_.OUT_SYNC_MODE = 1'b0;
defparam syn__795_.OUT_POWERUP = 1'b0;
defparam syn__795_.OE_REG_MODE = 1'b0;
defparam syn__795_.OE_ASYNC_MODE = 1'b0;
defparam syn__795_.OE_SYNC_MODE = 1'b0;
defparam syn__795_.OE_POWERUP = 1'b0;
defparam syn__795_.CFG_TRI_INPUT = 1'b0;
defparam syn__795_.CFG_PULL_UP = 1'b0;
defparam syn__795_.CFG_SLR = 1'b0;
defparam syn__795_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__795_.CFG_PDRCTRL = 4'b0010;
defparam syn__795_.CFG_KEEP = 2'b00;
defparam syn__795_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__795_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__795_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__795_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__795_.DPCLK_DELAY = 4'b0000;
defparam syn__795_.OUT_DELAY = 1'b0;
defparam syn__795_.IN_DATA_DELAY = 3'b000;
defparam syn__795_.IN_REG_DELAY = 3'b000;

alta_rio syn__796_(
	.padio(bank2[4]),
	.datain(syn__363_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__796_.coord_x = 8;
defparam syn__796_.coord_y = 9;
defparam syn__796_.coord_z = 0;
defparam syn__796_.IN_ASYNC_MODE = 1'b0;
defparam syn__796_.IN_SYNC_MODE = 1'b0;
defparam syn__796_.IN_POWERUP = 1'b0;
defparam syn__796_.OUT_REG_MODE = 1'b0;
defparam syn__796_.OUT_ASYNC_MODE = 1'b0;
defparam syn__796_.OUT_SYNC_MODE = 1'b0;
defparam syn__796_.OUT_POWERUP = 1'b0;
defparam syn__796_.OE_REG_MODE = 1'b0;
defparam syn__796_.OE_ASYNC_MODE = 1'b0;
defparam syn__796_.OE_SYNC_MODE = 1'b0;
defparam syn__796_.OE_POWERUP = 1'b0;
defparam syn__796_.CFG_TRI_INPUT = 1'b0;
defparam syn__796_.CFG_PULL_UP = 1'b0;
defparam syn__796_.CFG_SLR = 1'b0;
defparam syn__796_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__796_.CFG_PDRCTRL = 4'b0010;
defparam syn__796_.CFG_KEEP = 2'b00;
defparam syn__796_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__796_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__796_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__796_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__796_.DPCLK_DELAY = 4'b0000;
defparam syn__796_.OUT_DELAY = 1'b0;
defparam syn__796_.IN_DATA_DELAY = 3'b000;
defparam syn__796_.IN_REG_DELAY = 3'b000;

alta_rio syn__797_(
	.padio(bank2[5]),
	.datain(syn__363_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__797_.coord_x = 11;
defparam syn__797_.coord_y = 9;
defparam syn__797_.coord_z = 1;
defparam syn__797_.IN_ASYNC_MODE = 1'b0;
defparam syn__797_.IN_SYNC_MODE = 1'b0;
defparam syn__797_.IN_POWERUP = 1'b0;
defparam syn__797_.OUT_REG_MODE = 1'b0;
defparam syn__797_.OUT_ASYNC_MODE = 1'b0;
defparam syn__797_.OUT_SYNC_MODE = 1'b0;
defparam syn__797_.OUT_POWERUP = 1'b0;
defparam syn__797_.OE_REG_MODE = 1'b0;
defparam syn__797_.OE_ASYNC_MODE = 1'b0;
defparam syn__797_.OE_SYNC_MODE = 1'b0;
defparam syn__797_.OE_POWERUP = 1'b0;
defparam syn__797_.CFG_TRI_INPUT = 1'b0;
defparam syn__797_.CFG_PULL_UP = 1'b0;
defparam syn__797_.CFG_SLR = 1'b0;
defparam syn__797_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__797_.CFG_PDRCTRL = 4'b0010;
defparam syn__797_.CFG_KEEP = 2'b00;
defparam syn__797_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__797_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__797_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__797_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__797_.DPCLK_DELAY = 4'b0000;
defparam syn__797_.OUT_DELAY = 1'b0;
defparam syn__797_.IN_DATA_DELAY = 3'b000;
defparam syn__797_.IN_REG_DELAY = 3'b000;

alta_rio syn__798_(
	.padio(bank2[6]),
	.datain(syn__363_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__798_.coord_x = 9;
defparam syn__798_.coord_y = 9;
defparam syn__798_.coord_z = 3;
defparam syn__798_.IN_ASYNC_MODE = 1'b0;
defparam syn__798_.IN_SYNC_MODE = 1'b0;
defparam syn__798_.IN_POWERUP = 1'b0;
defparam syn__798_.OUT_REG_MODE = 1'b0;
defparam syn__798_.OUT_ASYNC_MODE = 1'b0;
defparam syn__798_.OUT_SYNC_MODE = 1'b0;
defparam syn__798_.OUT_POWERUP = 1'b0;
defparam syn__798_.OE_REG_MODE = 1'b0;
defparam syn__798_.OE_ASYNC_MODE = 1'b0;
defparam syn__798_.OE_SYNC_MODE = 1'b0;
defparam syn__798_.OE_POWERUP = 1'b0;
defparam syn__798_.CFG_TRI_INPUT = 1'b0;
defparam syn__798_.CFG_PULL_UP = 1'b0;
defparam syn__798_.CFG_SLR = 1'b0;
defparam syn__798_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__798_.CFG_PDRCTRL = 4'b0010;
defparam syn__798_.CFG_KEEP = 2'b00;
defparam syn__798_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__798_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__798_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__798_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__798_.DPCLK_DELAY = 4'b0000;
defparam syn__798_.OUT_DELAY = 1'b0;
defparam syn__798_.IN_DATA_DELAY = 3'b000;
defparam syn__798_.IN_REG_DELAY = 3'b000;

alta_rio syn__799_(
	.padio(bank2[7]),
	.datain(syn__363_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__799_.coord_x = 9;
defparam syn__799_.coord_y = 9;
defparam syn__799_.coord_z = 1;
defparam syn__799_.IN_ASYNC_MODE = 1'b0;
defparam syn__799_.IN_SYNC_MODE = 1'b0;
defparam syn__799_.IN_POWERUP = 1'b0;
defparam syn__799_.OUT_REG_MODE = 1'b0;
defparam syn__799_.OUT_ASYNC_MODE = 1'b0;
defparam syn__799_.OUT_SYNC_MODE = 1'b0;
defparam syn__799_.OUT_POWERUP = 1'b0;
defparam syn__799_.OE_REG_MODE = 1'b0;
defparam syn__799_.OE_ASYNC_MODE = 1'b0;
defparam syn__799_.OE_SYNC_MODE = 1'b0;
defparam syn__799_.OE_POWERUP = 1'b0;
defparam syn__799_.CFG_TRI_INPUT = 1'b0;
defparam syn__799_.CFG_PULL_UP = 1'b0;
defparam syn__799_.CFG_SLR = 1'b0;
defparam syn__799_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__799_.CFG_PDRCTRL = 4'b0010;
defparam syn__799_.CFG_KEEP = 2'b00;
defparam syn__799_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__799_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__799_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__799_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__799_.DPCLK_DELAY = 4'b0000;
defparam syn__799_.OUT_DELAY = 1'b0;
defparam syn__799_.IN_DATA_DELAY = 3'b000;
defparam syn__799_.IN_REG_DELAY = 3'b000;

alta_rio syn__800_(
	.padio(bank3[0]),
	.datain(syn__363_[0]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__800_.coord_x = 8;
defparam syn__800_.coord_y = 9;
defparam syn__800_.coord_z = 3;
defparam syn__800_.IN_ASYNC_MODE = 1'b0;
defparam syn__800_.IN_SYNC_MODE = 1'b0;
defparam syn__800_.IN_POWERUP = 1'b0;
defparam syn__800_.OUT_REG_MODE = 1'b0;
defparam syn__800_.OUT_ASYNC_MODE = 1'b0;
defparam syn__800_.OUT_SYNC_MODE = 1'b0;
defparam syn__800_.OUT_POWERUP = 1'b0;
defparam syn__800_.OE_REG_MODE = 1'b0;
defparam syn__800_.OE_ASYNC_MODE = 1'b0;
defparam syn__800_.OE_SYNC_MODE = 1'b0;
defparam syn__800_.OE_POWERUP = 1'b0;
defparam syn__800_.CFG_TRI_INPUT = 1'b0;
defparam syn__800_.CFG_PULL_UP = 1'b0;
defparam syn__800_.CFG_SLR = 1'b0;
defparam syn__800_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__800_.CFG_PDRCTRL = 4'b0010;
defparam syn__800_.CFG_KEEP = 2'b00;
defparam syn__800_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__800_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__800_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__800_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__800_.DPCLK_DELAY = 4'b0000;
defparam syn__800_.OUT_DELAY = 1'b0;
defparam syn__800_.IN_DATA_DELAY = 3'b000;
defparam syn__800_.IN_REG_DELAY = 3'b000;

alta_rio syn__801_(
	.padio(bank3[1]),
	.datain(syn__363_[1]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__801_.coord_x = 7;
defparam syn__801_.coord_y = 9;
defparam syn__801_.coord_z = 3;
defparam syn__801_.IN_ASYNC_MODE = 1'b0;
defparam syn__801_.IN_SYNC_MODE = 1'b0;
defparam syn__801_.IN_POWERUP = 1'b0;
defparam syn__801_.OUT_REG_MODE = 1'b0;
defparam syn__801_.OUT_ASYNC_MODE = 1'b0;
defparam syn__801_.OUT_SYNC_MODE = 1'b0;
defparam syn__801_.OUT_POWERUP = 1'b0;
defparam syn__801_.OE_REG_MODE = 1'b0;
defparam syn__801_.OE_ASYNC_MODE = 1'b0;
defparam syn__801_.OE_SYNC_MODE = 1'b0;
defparam syn__801_.OE_POWERUP = 1'b0;
defparam syn__801_.CFG_TRI_INPUT = 1'b0;
defparam syn__801_.CFG_PULL_UP = 1'b0;
defparam syn__801_.CFG_SLR = 1'b0;
defparam syn__801_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__801_.CFG_PDRCTRL = 4'b0010;
defparam syn__801_.CFG_KEEP = 2'b00;
defparam syn__801_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__801_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__801_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__801_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__801_.DPCLK_DELAY = 4'b0000;
defparam syn__801_.OUT_DELAY = 1'b0;
defparam syn__801_.IN_DATA_DELAY = 3'b000;
defparam syn__801_.IN_REG_DELAY = 3'b000;

alta_rio syn__802_(
	.padio(bank3[2]),
	.datain(syn__363_[2]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__802_.coord_x = 7;
defparam syn__802_.coord_y = 9;
defparam syn__802_.coord_z = 0;
defparam syn__802_.IN_ASYNC_MODE = 1'b0;
defparam syn__802_.IN_SYNC_MODE = 1'b0;
defparam syn__802_.IN_POWERUP = 1'b0;
defparam syn__802_.OUT_REG_MODE = 1'b0;
defparam syn__802_.OUT_ASYNC_MODE = 1'b0;
defparam syn__802_.OUT_SYNC_MODE = 1'b0;
defparam syn__802_.OUT_POWERUP = 1'b0;
defparam syn__802_.OE_REG_MODE = 1'b0;
defparam syn__802_.OE_ASYNC_MODE = 1'b0;
defparam syn__802_.OE_SYNC_MODE = 1'b0;
defparam syn__802_.OE_POWERUP = 1'b0;
defparam syn__802_.CFG_TRI_INPUT = 1'b0;
defparam syn__802_.CFG_PULL_UP = 1'b0;
defparam syn__802_.CFG_SLR = 1'b0;
defparam syn__802_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__802_.CFG_PDRCTRL = 4'b0010;
defparam syn__802_.CFG_KEEP = 2'b00;
defparam syn__802_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__802_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__802_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__802_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__802_.DPCLK_DELAY = 4'b0000;
defparam syn__802_.OUT_DELAY = 1'b0;
defparam syn__802_.IN_DATA_DELAY = 3'b000;
defparam syn__802_.IN_REG_DELAY = 3'b000;

alta_rio syn__803_(
	.padio(bank3[3]),
	.datain(syn__363_[3]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__803_.coord_x = 6;
defparam syn__803_.coord_y = 9;
defparam syn__803_.coord_z = 0;
defparam syn__803_.IN_ASYNC_MODE = 1'b0;
defparam syn__803_.IN_SYNC_MODE = 1'b0;
defparam syn__803_.IN_POWERUP = 1'b0;
defparam syn__803_.OUT_REG_MODE = 1'b0;
defparam syn__803_.OUT_ASYNC_MODE = 1'b0;
defparam syn__803_.OUT_SYNC_MODE = 1'b0;
defparam syn__803_.OUT_POWERUP = 1'b0;
defparam syn__803_.OE_REG_MODE = 1'b0;
defparam syn__803_.OE_ASYNC_MODE = 1'b0;
defparam syn__803_.OE_SYNC_MODE = 1'b0;
defparam syn__803_.OE_POWERUP = 1'b0;
defparam syn__803_.CFG_TRI_INPUT = 1'b0;
defparam syn__803_.CFG_PULL_UP = 1'b0;
defparam syn__803_.CFG_SLR = 1'b0;
defparam syn__803_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__803_.CFG_PDRCTRL = 4'b0010;
defparam syn__803_.CFG_KEEP = 2'b00;
defparam syn__803_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__803_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__803_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__803_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__803_.DPCLK_DELAY = 4'b0000;
defparam syn__803_.OUT_DELAY = 1'b0;
defparam syn__803_.IN_DATA_DELAY = 3'b000;
defparam syn__803_.IN_REG_DELAY = 3'b000;

alta_rio syn__804_(
	.padio(bank3[4]),
	.datain(syn__363_[4]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__804_.coord_x = 5;
defparam syn__804_.coord_y = 9;
defparam syn__804_.coord_z = 3;
defparam syn__804_.IN_ASYNC_MODE = 1'b0;
defparam syn__804_.IN_SYNC_MODE = 1'b0;
defparam syn__804_.IN_POWERUP = 1'b0;
defparam syn__804_.OUT_REG_MODE = 1'b0;
defparam syn__804_.OUT_ASYNC_MODE = 1'b0;
defparam syn__804_.OUT_SYNC_MODE = 1'b0;
defparam syn__804_.OUT_POWERUP = 1'b0;
defparam syn__804_.OE_REG_MODE = 1'b0;
defparam syn__804_.OE_ASYNC_MODE = 1'b0;
defparam syn__804_.OE_SYNC_MODE = 1'b0;
defparam syn__804_.OE_POWERUP = 1'b0;
defparam syn__804_.CFG_TRI_INPUT = 1'b0;
defparam syn__804_.CFG_PULL_UP = 1'b0;
defparam syn__804_.CFG_SLR = 1'b0;
defparam syn__804_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__804_.CFG_PDRCTRL = 4'b0010;
defparam syn__804_.CFG_KEEP = 2'b00;
defparam syn__804_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__804_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__804_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__804_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__804_.DPCLK_DELAY = 4'b0000;
defparam syn__804_.OUT_DELAY = 1'b0;
defparam syn__804_.IN_DATA_DELAY = 3'b000;
defparam syn__804_.IN_REG_DELAY = 3'b000;

alta_rio syn__805_(
	.padio(bank3[5]),
	.datain(syn__363_[5]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__805_.coord_x = 5;
defparam syn__805_.coord_y = 9;
defparam syn__805_.coord_z = 2;
defparam syn__805_.IN_ASYNC_MODE = 1'b0;
defparam syn__805_.IN_SYNC_MODE = 1'b0;
defparam syn__805_.IN_POWERUP = 1'b0;
defparam syn__805_.OUT_REG_MODE = 1'b0;
defparam syn__805_.OUT_ASYNC_MODE = 1'b0;
defparam syn__805_.OUT_SYNC_MODE = 1'b0;
defparam syn__805_.OUT_POWERUP = 1'b0;
defparam syn__805_.OE_REG_MODE = 1'b0;
defparam syn__805_.OE_ASYNC_MODE = 1'b0;
defparam syn__805_.OE_SYNC_MODE = 1'b0;
defparam syn__805_.OE_POWERUP = 1'b0;
defparam syn__805_.CFG_TRI_INPUT = 1'b0;
defparam syn__805_.CFG_PULL_UP = 1'b0;
defparam syn__805_.CFG_SLR = 1'b0;
defparam syn__805_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__805_.CFG_PDRCTRL = 4'b0010;
defparam syn__805_.CFG_KEEP = 2'b00;
defparam syn__805_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__805_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__805_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__805_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__805_.DPCLK_DELAY = 4'b0000;
defparam syn__805_.OUT_DELAY = 1'b0;
defparam syn__805_.IN_DATA_DELAY = 3'b000;
defparam syn__805_.IN_REG_DELAY = 3'b000;

alta_rio syn__806_(
	.padio(bank3[6]),
	.datain(syn__363_[6]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__806_.coord_x = 5;
defparam syn__806_.coord_y = 9;
defparam syn__806_.coord_z = 1;
defparam syn__806_.IN_ASYNC_MODE = 1'b0;
defparam syn__806_.IN_SYNC_MODE = 1'b0;
defparam syn__806_.IN_POWERUP = 1'b0;
defparam syn__806_.OUT_REG_MODE = 1'b0;
defparam syn__806_.OUT_ASYNC_MODE = 1'b0;
defparam syn__806_.OUT_SYNC_MODE = 1'b0;
defparam syn__806_.OUT_POWERUP = 1'b0;
defparam syn__806_.OE_REG_MODE = 1'b0;
defparam syn__806_.OE_ASYNC_MODE = 1'b0;
defparam syn__806_.OE_SYNC_MODE = 1'b0;
defparam syn__806_.OE_POWERUP = 1'b0;
defparam syn__806_.CFG_TRI_INPUT = 1'b0;
defparam syn__806_.CFG_PULL_UP = 1'b0;
defparam syn__806_.CFG_SLR = 1'b0;
defparam syn__806_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__806_.CFG_PDRCTRL = 4'b0010;
defparam syn__806_.CFG_KEEP = 2'b00;
defparam syn__806_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__806_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__806_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__806_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__806_.DPCLK_DELAY = 4'b0000;
defparam syn__806_.OUT_DELAY = 1'b0;
defparam syn__806_.IN_DATA_DELAY = 3'b000;
defparam syn__806_.IN_REG_DELAY = 3'b000;

alta_rio syn__807_(
	.padio(bank3[7]),
	.datain(syn__363_[7]),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam syn__807_.coord_x = 5;
defparam syn__807_.coord_y = 9;
defparam syn__807_.coord_z = 0;
defparam syn__807_.IN_ASYNC_MODE = 1'b0;
defparam syn__807_.IN_SYNC_MODE = 1'b0;
defparam syn__807_.IN_POWERUP = 1'b0;
defparam syn__807_.OUT_REG_MODE = 1'b0;
defparam syn__807_.OUT_ASYNC_MODE = 1'b0;
defparam syn__807_.OUT_SYNC_MODE = 1'b0;
defparam syn__807_.OUT_POWERUP = 1'b0;
defparam syn__807_.OE_REG_MODE = 1'b0;
defparam syn__807_.OE_ASYNC_MODE = 1'b0;
defparam syn__807_.OE_SYNC_MODE = 1'b0;
defparam syn__807_.OE_POWERUP = 1'b0;
defparam syn__807_.CFG_TRI_INPUT = 1'b0;
defparam syn__807_.CFG_PULL_UP = 1'b0;
defparam syn__807_.CFG_SLR = 1'b0;
defparam syn__807_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__807_.CFG_PDRCTRL = 4'b0010;
defparam syn__807_.CFG_KEEP = 2'b00;
defparam syn__807_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__807_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__807_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__807_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__807_.DPCLK_DELAY = 4'b0000;
defparam syn__807_.OUT_DELAY = 1'b0;
defparam syn__807_.IN_DATA_DELAY = 3'b000;
defparam syn__807_.IN_REG_DELAY = 3'b000;

alta_rio syn__808_(
	.padio(clk),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(syn__364_),
	.regout());
defparam syn__808_.coord_x = 4;
defparam syn__808_.coord_y = 9;
defparam syn__808_.coord_z = 0;
defparam syn__808_.IN_ASYNC_MODE = 1'b0;
defparam syn__808_.IN_SYNC_MODE = 1'b0;
defparam syn__808_.IN_POWERUP = 1'b0;
defparam syn__808_.OUT_REG_MODE = 1'b0;
defparam syn__808_.OUT_ASYNC_MODE = 1'b0;
defparam syn__808_.OUT_SYNC_MODE = 1'b0;
defparam syn__808_.OUT_POWERUP = 1'b0;
defparam syn__808_.OE_REG_MODE = 1'b0;
defparam syn__808_.OE_ASYNC_MODE = 1'b0;
defparam syn__808_.OE_SYNC_MODE = 1'b0;
defparam syn__808_.OE_POWERUP = 1'b0;
defparam syn__808_.CFG_TRI_INPUT = 1'b0;
defparam syn__808_.CFG_PULL_UP = 1'b0;
defparam syn__808_.CFG_SLR = 1'b0;
defparam syn__808_.CFG_OPEN_DRAIN = 1'b0;
defparam syn__808_.CFG_PDRCTRL = 4'b0010;
defparam syn__808_.CFG_KEEP = 2'b00;
defparam syn__808_.CFG_LVDS_OUT_EN = 1'b0;
defparam syn__808_.CFG_LVDS_SEL_CUA = 2'b00;
defparam syn__808_.CFG_LVDS_IREF = 10'b0110000000;
defparam syn__808_.CFG_LVDS_IN_EN = 1'b0;
defparam syn__808_.DPCLK_DELAY = 4'b0000;
defparam syn__808_.OUT_DELAY = 1'b0;
defparam syn__808_.IN_DATA_DELAY = 3'b000;
defparam syn__808_.IN_REG_DELAY = 3'b000;

alta_slice syn__809_(
	.A(syn__001_),
	.B(vcc),
	.C(vcc),
	.D(IOvalue[0]),
	.Cin(),
	.Qin(syn__363_[0]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[0]),
	.Cout(),
	.Q(syn__363_[0]));
defparam syn__809_.coord_x = 4;
defparam syn__809_.coord_y = 8;
defparam syn__809_.coord_z = 5;
defparam syn__809_.mask = 16'hFA50;
defparam syn__809_.modeMux = 1'b0;
defparam syn__809_.FeedbackMux = 1'b1;
defparam syn__809_.ShiftMux = 1'b0;
defparam syn__809_.BypassEn = 1'b0;
defparam syn__809_.CarryEnb = 1'b1;

alta_slice syn__810_(
	.A(syn__001_),
	.B(vcc),
	.C(vcc),
	.D(IOvalue[1]),
	.Cin(),
	.Qin(syn__363_[1]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[1]),
	.Cout(),
	.Q(syn__363_[1]));
defparam syn__810_.coord_x = 4;
defparam syn__810_.coord_y = 8;
defparam syn__810_.coord_z = 3;
defparam syn__810_.mask = 16'hFA50;
defparam syn__810_.modeMux = 1'b0;
defparam syn__810_.FeedbackMux = 1'b1;
defparam syn__810_.ShiftMux = 1'b0;
defparam syn__810_.BypassEn = 1'b0;
defparam syn__810_.CarryEnb = 1'b1;

alta_slice syn__811_(
	.A(syn__001_),
	.B(vcc),
	.C(vcc),
	.D(IOvalue[2]),
	.Cin(),
	.Qin(syn__363_[2]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[2]),
	.Cout(),
	.Q(syn__363_[2]));
defparam syn__811_.coord_x = 4;
defparam syn__811_.coord_y = 8;
defparam syn__811_.coord_z = 7;
defparam syn__811_.mask = 16'hFA50;
defparam syn__811_.modeMux = 1'b0;
defparam syn__811_.FeedbackMux = 1'b1;
defparam syn__811_.ShiftMux = 1'b0;
defparam syn__811_.BypassEn = 1'b0;
defparam syn__811_.CarryEnb = 1'b1;

alta_slice syn__812_(
	.A(IOvalue[3]),
	.B(vcc),
	.C(vcc),
	.D(syn__001_),
	.Cin(),
	.Qin(syn__363_[3]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[3]),
	.Cout(),
	.Q(syn__363_[3]));
defparam syn__812_.coord_x = 4;
defparam syn__812_.coord_y = 8;
defparam syn__812_.coord_z = 15;
defparam syn__812_.mask = 16'hAAF0;
defparam syn__812_.modeMux = 1'b0;
defparam syn__812_.FeedbackMux = 1'b1;
defparam syn__812_.ShiftMux = 1'b0;
defparam syn__812_.BypassEn = 1'b0;
defparam syn__812_.CarryEnb = 1'b1;

alta_slice syn__813_(
	.A(vcc),
	.B(IOvalue[4]),
	.C(vcc),
	.D(syn__001_),
	.Cin(),
	.Qin(syn__363_[4]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[4]),
	.Cout(),
	.Q(syn__363_[4]));
defparam syn__813_.coord_x = 4;
defparam syn__813_.coord_y = 8;
defparam syn__813_.coord_z = 4;
defparam syn__813_.mask = 16'hCCF0;
defparam syn__813_.modeMux = 1'b0;
defparam syn__813_.FeedbackMux = 1'b1;
defparam syn__813_.ShiftMux = 1'b0;
defparam syn__813_.BypassEn = 1'b0;
defparam syn__813_.CarryEnb = 1'b1;

alta_slice syn__814_(
	.A(vcc),
	.B(syn__001_),
	.C(vcc),
	.D(IOvalue[5]),
	.Cin(),
	.Qin(syn__363_[5]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[5]),
	.Cout(),
	.Q(syn__363_[5]));
defparam syn__814_.coord_x = 4;
defparam syn__814_.coord_y = 8;
defparam syn__814_.coord_z = 14;
defparam syn__814_.mask = 16'hFC30;
defparam syn__814_.modeMux = 1'b0;
defparam syn__814_.FeedbackMux = 1'b1;
defparam syn__814_.ShiftMux = 1'b0;
defparam syn__814_.BypassEn = 1'b0;
defparam syn__814_.CarryEnb = 1'b1;

alta_slice syn__815_(
	.A(vcc),
	.B(IOvalue[6]),
	.C(vcc),
	.D(syn__001_),
	.Cin(),
	.Qin(syn__363_[6]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[6]),
	.Cout(),
	.Q(syn__363_[6]));
defparam syn__815_.coord_x = 4;
defparam syn__815_.coord_y = 8;
defparam syn__815_.coord_z = 6;
defparam syn__815_.mask = 16'hCCF0;
defparam syn__815_.modeMux = 1'b0;
defparam syn__815_.FeedbackMux = 1'b1;
defparam syn__815_.ShiftMux = 1'b0;
defparam syn__815_.BypassEn = 1'b0;
defparam syn__815_.CarryEnb = 1'b1;

alta_slice syn__816_(
	.A(vcc),
	.B(syn__001_),
	.C(vcc),
	.D(IOvalue[7]),
	.Cin(),
	.Qin(syn__363_[7]),
	.Clk(syn__364__X1009_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1009_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(syn__000_[7]),
	.Cout(),
	.Q(syn__363_[7]));
defparam syn__816_.coord_x = 4;
defparam syn__816_.coord_y = 8;
defparam syn__816_.coord_z = 2;
defparam syn__816_.mask = 16'hFC30;
defparam syn__816_.modeMux = 1'b0;
defparam syn__816_.FeedbackMux = 1'b1;
defparam syn__816_.ShiftMux = 1'b0;
defparam syn__816_.BypassEn = 1'b0;
defparam syn__816_.CarryEnb = 1'b1;

alta_slice syn__817_(
	.A(syn__211_),
	.B(syn__014_),
	.C(vcc),
	.D(syn__254_),
	.Cin(),
	.Qin(\tc.PC [0]),
	.Clk(syn__364__X1011_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [0]),
	.Cout(),
	.Q(\tc.PC [0]));
defparam syn__817_.coord_x = 1;
defparam syn__817_.coord_y = 6;
defparam syn__817_.coord_z = 8;
defparam syn__817_.mask = 16'h55C3;
defparam syn__817_.modeMux = 1'b0;
defparam syn__817_.FeedbackMux = 1'b1;
defparam syn__817_.ShiftMux = 1'b0;
defparam syn__817_.BypassEn = 1'b0;
defparam syn__817_.CarryEnb = 1'b1;

alta_slice syn__818_(
	.A(syn__207_),
	.B(syn__255_),
	.C(vcc),
	.D(syn__254_),
	.Cin(),
	.Qin(\tc.PC [1]),
	.Clk(syn__364__X1011_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [1]),
	.Cout(),
	.Q(\tc.PC [1]));
defparam syn__818_.coord_x = 1;
defparam syn__818_.coord_y = 6;
defparam syn__818_.coord_z = 3;
defparam syn__818_.mask = 16'h55C3;
defparam syn__818_.modeMux = 1'b0;
defparam syn__818_.FeedbackMux = 1'b1;
defparam syn__818_.ShiftMux = 1'b0;
defparam syn__818_.BypassEn = 1'b0;
defparam syn__818_.CarryEnb = 1'b1;

alta_slice syn__819_(
	.A(syn__203_),
	.B(syn__256_),
	.C(vcc),
	.D(syn__254_),
	.Cin(),
	.Qin(\tc.PC [2]),
	.Clk(syn__364__X1011_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1011_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [2]),
	.Cout(),
	.Q(\tc.PC [2]));
defparam syn__819_.coord_x = 1;
defparam syn__819_.coord_y = 6;
defparam syn__819_.coord_z = 0;
defparam syn__819_.mask = 16'h553C;
defparam syn__819_.modeMux = 1'b0;
defparam syn__819_.FeedbackMux = 1'b1;
defparam syn__819_.ShiftMux = 1'b0;
defparam syn__819_.BypassEn = 1'b0;
defparam syn__819_.CarryEnb = 1'b1;

alta_slice syn__820_(
	.A(syn__200_),
	.B(syn__257_),
	.C(vcc),
	.D(syn__254_),
	.Cin(),
	.Qin(\tc.PC [3]),
	.Clk(syn__364__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [3]),
	.Cout(),
	.Q(\tc.PC [3]));
defparam syn__820_.coord_x = 2;
defparam syn__820_.coord_y = 6;
defparam syn__820_.coord_z = 1;
defparam syn__820_.mask = 16'h553C;
defparam syn__820_.modeMux = 1'b0;
defparam syn__820_.FeedbackMux = 1'b1;
defparam syn__820_.ShiftMux = 1'b0;
defparam syn__820_.BypassEn = 1'b0;
defparam syn__820_.CarryEnb = 1'b1;

alta_slice syn__821_(
	.A(syn__344_),
	.B(syn__254_),
	.C(vcc),
	.D(syn__258_),
	.Cin(),
	.Qin(\tc.PC [4]),
	.Clk(syn__364__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [4]),
	.Cout(),
	.Q(\tc.PC [4]));
defparam syn__821_.coord_x = 2;
defparam syn__821_.coord_y = 6;
defparam syn__821_.coord_z = 8;
defparam syn__821_.mask = 16'h4774;
defparam syn__821_.modeMux = 1'b0;
defparam syn__821_.FeedbackMux = 1'b1;
defparam syn__821_.ShiftMux = 1'b0;
defparam syn__821_.BypassEn = 1'b0;
defparam syn__821_.CarryEnb = 1'b1;

alta_slice syn__822_(
	.A(syn__192_),
	.B(vcc),
	.C(syn__254_),
	.D(syn__260_),
	.Cin(),
	.Qin(\tc.PC [5]),
	.Clk(syn__364__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [5]),
	.Cout(),
	.Q(\tc.PC [5]));
defparam syn__822_.coord_x = 2;
defparam syn__822_.coord_y = 6;
defparam syn__822_.coord_z = 2;
defparam syn__822_.mask = 16'h505F;
defparam syn__822_.modeMux = 1'b0;
defparam syn__822_.FeedbackMux = 1'b0;
defparam syn__822_.ShiftMux = 1'b0;
defparam syn__822_.BypassEn = 1'b0;
defparam syn__822_.CarryEnb = 1'b1;

alta_slice syn__823_(
	.A(syn__188_),
	.B(vcc),
	.C(syn__254_),
	.D(syn__262_),
	.Cin(),
	.Qin(\tc.PC [6]),
	.Clk(syn__364__X1012_Y1001_SIG_VCC),
	.AsyncReset(AsyncReset_X1012_Y1001_GND),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\tc.PCmux [6]),
	.Cout(),
	.Q(\tc.PC [6]));
defparam syn__823_.coord_x = 2;
defparam syn__823_.coord_y = 6;
defparam syn__823_.coord_z = 3;
defparam syn__823_.mask = 16'h505F;
defparam syn__823_.modeMux = 1'b0;
defparam syn__823_.FeedbackMux = 1'b0;
defparam syn__823_.ShiftMux = 1'b0;
defparam syn__823_.BypassEn = 1'b0;
defparam syn__823_.CarryEnb = 1'b1;

alta_bram \tc.dm.ram_inst (
	.DataInA({IOvalue[17], IOvalue[16], IOvalue[15], IOvalue[14], IOvalue[13], IOvalue[12], IOvalue[11], IOvalue[10], IOvalue[9], IOvalue[8], IOvalue[7], IOvalue[6], IOvalue[5], IOvalue[4], IOvalue[3], IOvalue[2], IOvalue[1], IOvalue[0]}),
	.DataInB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.AddressA({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, IOaddr[6], IOaddr[5], IOaddr[4], IOaddr[3], IOaddr[2], IOaddr[1], IOaddr[0]}),
	.AddressB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, IOaddr[6], IOaddr[5], IOaddr[4], IOaddr[3], IOaddr[2], IOaddr[1], IOaddr[0]}),
	.DataOutA({\tc.dm.douta [17], \tc.dm.douta [16], \tc.dm.douta [15], \tc.dm.douta [14], \tc.dm.douta [13], \tc.dm.douta [12], \tc.dm.douta [11], \tc.dm.douta [10], \tc.dm.douta [9], \tc.dm.douta [8], \tc.dm.douta [7], \tc.dm.douta [6], \tc.dm.douta [5], \tc.dm.douta [4], \tc.dm.douta [3], \tc.dm.douta [2], \tc.dm.douta [1], \tc.dm.douta [0]}),
	.DataOutB({\tc.DM [17], \tc.DM [16], \tc.DM [15], \tc.DM [14], \tc.DM [13], \tc.DM [12], \tc.DM [11], \tc.DM [10], \tc.DM [9], \tc.DM [8], \tc.DM [7], \tc.DM [6], \tc.DM [5], \tc.DM [4], \tc.DM [3], \tc.DM [2], \tc.DM [1], \tc.DM [0]}),
	.Clk0(syn__364_),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(!syn__364_),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(\tc.WriteDM ),
	.WeRenB(gnd));
defparam \tc.dm.ram_inst .coord_x = 3;
defparam \tc.dm.ram_inst .coord_y = 5;
defparam \tc.dm.ram_inst .coord_z = 0;
defparam \tc.dm.ram_inst .CLKMODE = 1'b0;
defparam \tc.dm.ram_inst .PORTA_WIDTH = 4'b0000;
defparam \tc.dm.ram_inst .PORTB_WIDTH = 4'b0000;
defparam \tc.dm.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \tc.dm.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \tc.dm.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \tc.dm.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \tc.dm.ram_inst .PORTA_OUTREG = 1'b0;
defparam \tc.dm.ram_inst .PORTB_OUTREG = 1'b0;
defparam \tc.dm.ram_inst .PORTB_READONLY = 1'b1;
defparam \tc.dm.ram_inst .INIT_VAL = 4608'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

alta_bram \tc.im.ram_inst (
	.DataInA({IOvalue[17], IOvalue[16], IOvalue[15], IOvalue[14], IOvalue[13], IOvalue[12], IOvalue[11], IOvalue[10], IOvalue[9], IOvalue[8], IOvalue[7], IOvalue[6], IOvalue[5], IOvalue[4], IOvalue[3], IOvalue[2], IOvalue[1], IOvalue[0]}),
	.DataInB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.AddressA({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, IOaddr[6], IOaddr[5], IOaddr[4], IOaddr[3], IOaddr[2], IOaddr[1], IOaddr[0]}),
	.AddressB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \tc.PCmux [6], \tc.PCmux [5], \tc.PCmux [4], \tc.PCmux [3], \tc.PCmux [2], \tc.PCmux [1], \tc.PCmux [0]}),
	.DataOutA({\tc.im.douta [17], \tc.im.douta [16], \tc.im.douta [15], \tc.im.douta [14], \tc.im.douta [13], \tc.im.douta [12], \tc.im.douta [11], \tc.im.douta [10], \tc.im.douta [9], \tc.im.douta [8], \tc.im.douta [7], \tc.im.douta [6], \tc.im.douta [5], \tc.im.douta [4], \tc.im.douta [3], \tc.im.douta [2], \tc.im.douta [1], \tc.im.douta [0]}),
	.DataOutB({\tc.IM [17], \tc.IM [16], \tc.IM [15], \tc.IM [14], \tc.IM [13], \tc.IM [12], \tc.IM [11], \tc.IM [10], \tc.IM [9], \tc.IM [8], \tc.IM [7], \tc.IM [6], \tc.IM [5], \tc.IM [4], \tc.IM [3], \tc.IM [2], \tc.IM [1], \tc.IM [0]}),
	.Clk0(syn__364_),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(syn__364_),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(\tc.WriteIM ),
	.WeRenB(gnd));
defparam \tc.im.ram_inst .coord_x = 3;
defparam \tc.im.ram_inst .coord_y = 6;
defparam \tc.im.ram_inst .coord_z = 0;
defparam \tc.im.ram_inst .CLKMODE = 1'b0;
defparam \tc.im.ram_inst .PORTA_WIDTH = 4'b0000;
defparam \tc.im.ram_inst .PORTB_WIDTH = 4'b0000;
defparam \tc.im.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \tc.im.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \tc.im.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \tc.im.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \tc.im.ram_inst .PORTA_OUTREG = 1'b0;
defparam \tc.im.ram_inst .PORTB_OUTREG = 1'b0;
defparam \tc.im.ram_inst .PORTB_READONLY = 1'b1;
defparam \tc.im.ram_inst .INIT_VAL = 4608'h0000000000000000070003FF090000030200050004000460040008200400082004000820040008200E040C030A001006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

alta_bram \tc.rfA.ram_inst (
	.DataInA({\tc.WD [17], \tc.WD [16], \tc.WD [15], \tc.WD [14], \tc.WD [13], \tc.WD [12], \tc.WD [11], \tc.WD [10], \tc.WD [9], \tc.WD [8], \tc.WD [7], \tc.WD [6], \tc.WD [5], \tc.WD [4], \tc.WD [3], \tc.WD [2], \tc.WD [1], \tc.WD [0]}),
	.DataInB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.AddressA({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \tc.IM [31], \tc.IM [30], \tc.IM [29], \tc.IM [28], \tc.IM [27], \tc.IM [26], \tc.IM [25]}),
	.AddressB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \tc.IM [23], \tc.IM [22], \tc.IM [21], \tc.IM [20], \tc.IM [19], \tc.IM [18], \tc.IM [17]}),
	.DataOutA({\tc.rfA.douta [17], \tc.rfA.douta [16], \tc.rfA.douta [15], \tc.rfA.douta [14], \tc.rfA.douta [13], \tc.rfA.douta [12], \tc.rfA.douta [11], \tc.rfA.douta [10], \tc.rfA.douta [9], \tc.rfA.douta [8], \tc.rfA.douta [7], \tc.rfA.douta [6], \tc.rfA.douta [5], \tc.rfA.douta [4], \tc.rfA.douta [3], \tc.rfA.douta [2], \tc.rfA.douta [1], \tc.rfA.douta [0]}),
	.DataOutB({IOvalue[17], IOvalue[16], IOvalue[15], IOvalue[14], IOvalue[13], IOvalue[12], IOvalue[11], IOvalue[10], IOvalue[9], IOvalue[8], IOvalue[7], IOvalue[6], IOvalue[5], IOvalue[4], IOvalue[3], IOvalue[2], IOvalue[1], IOvalue[0]}),
	.Clk0(syn__364_),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(!syn__364_),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(vcc),
	.WeRenB(gnd));
defparam \tc.rfA.ram_inst .coord_x = 3;
defparam \tc.rfA.ram_inst .coord_y = 7;
defparam \tc.rfA.ram_inst .coord_z = 0;
defparam \tc.rfA.ram_inst .CLKMODE = 1'b0;
defparam \tc.rfA.ram_inst .PORTA_WIDTH = 4'b0000;
defparam \tc.rfA.ram_inst .PORTB_WIDTH = 4'b0000;
defparam \tc.rfA.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \tc.rfA.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \tc.rfA.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \tc.rfA.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \tc.rfA.ram_inst .PORTA_OUTREG = 1'b0;
defparam \tc.rfA.ram_inst .PORTB_OUTREG = 1'b0;
defparam \tc.rfA.ram_inst .PORTB_READONLY = 1'b1;
defparam \tc.rfA.ram_inst .INIT_VAL = 4608'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

alta_bram \tc.rfB.ram_inst (
	.DataInA({\tc.WD [17], \tc.WD [16], \tc.WD [15], \tc.WD [14], \tc.WD [13], \tc.WD [12], \tc.WD [11], \tc.WD [10], \tc.WD [9], \tc.WD [8], \tc.WD [7], \tc.WD [6], \tc.WD [5], \tc.WD [4], \tc.WD [3], \tc.WD [2], \tc.WD [1], \tc.WD [0]}),
	.DataInB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.AddressA({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \tc.IM [31], \tc.IM [30], \tc.IM [29], \tc.IM [28], \tc.IM [27], \tc.IM [26], \tc.IM [25]}),
	.AddressB({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, \tc.IM [16], \tc.IM [15], \tc.IM [14], \tc.IM [13], \tc.IM [12], \tc.IM [11], \tc.IM [10]}),
	.DataOutA({\tc.rfB.douta [17], \tc.rfB.douta [16], \tc.rfB.douta [15], \tc.rfB.douta [14], \tc.rfB.douta [13], \tc.rfB.douta [12], \tc.rfB.douta [11], \tc.rfB.douta [10], \tc.rfB.douta [9], \tc.rfB.douta [8], \tc.rfB.douta [7], \tc.rfB.douta [6], \tc.rfB.douta [5], \tc.rfB.douta [4], \tc.rfB.douta [3], \tc.rfB.douta [2], \tc.rfB.douta [1], \tc.rfB.douta [0]}),
	.DataOutB({IOaddr[17], IOaddr[16], IOaddr[15], IOaddr[14], IOaddr[13], IOaddr[12], IOaddr[11], IOaddr[10], IOaddr[9], IOaddr[8], IOaddr[7], IOaddr[6], IOaddr[5], IOaddr[4], IOaddr[3], IOaddr[2], IOaddr[1], IOaddr[0]}),
	.Clk0(syn__364_),
	.ClkEn0(vcc),
	.AsyncReset0(gnd),
	.Clk1(!syn__364_),
	.ClkEn1(vcc),
	.AsyncReset1(gnd),
	.WeRenA(vcc),
	.WeRenB(gnd));
defparam \tc.rfB.ram_inst .coord_x = 3;
defparam \tc.rfB.ram_inst .coord_y = 8;
defparam \tc.rfB.ram_inst .coord_z = 0;
defparam \tc.rfB.ram_inst .CLKMODE = 1'b0;
defparam \tc.rfB.ram_inst .PORTA_WIDTH = 4'b0000;
defparam \tc.rfB.ram_inst .PORTB_WIDTH = 4'b0000;
defparam \tc.rfB.ram_inst .PORTA_WRITEMODE = 1'b0;
defparam \tc.rfB.ram_inst .PORTB_WRITEMODE = 1'b0;
defparam \tc.rfB.ram_inst .PORTA_WRITETHRU = 1'b0;
defparam \tc.rfB.ram_inst .PORTB_WRITETHRU = 1'b0;
defparam \tc.rfB.ram_inst .PORTA_OUTREG = 1'b0;
defparam \tc.rfB.ram_inst .PORTB_OUTREG = 1'b0;
defparam \tc.rfB.ram_inst .PORTB_READONLY = 1'b1;
defparam \tc.rfB.ram_inst .INIT_VAL = 4608'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

endmodule
