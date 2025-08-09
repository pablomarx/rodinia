/////////////////////////////////////////////////////////////////////////////
// Copyright (c)2013 ALTAGATE CO.,Ltd                                      //
// All Rights Reserved                                                     //
// No part of this code may be reproduced, stored in a retrieval system,   //
// or transmitted, in any form or by any means, electronic, mechanical,    //
// photocopying, recording, or otherwise, without the prior written        //
// permission of ALTAGATE CO.,Ltd                                          //
/////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

`ifndef ALTA_LIB
  `ifndef ALTA_SYN
// synopsys translate_off
    `define ALTA_SIM
// synopsys translate_on
  `endif
`endif

`ifdef ALTA_SIM
  `define _ALTA_LIB
`else
  `ifdef ALTA_SYN
    `undef _ALTA_LIB
  `else
    `define _ALTA_LIB
  `endif
`endif

`ifdef ALTA_SIM
  `define TRI1 tri1
  `define TRI0 tri0
`else
  `define TRI1 wire
  `define TRI0 wire
`endif

`ifndef PLL_RESOLUTION
  `define PLL_RESOLUTION 1ns/10fs
`endif

`ifdef _ALTA_LIB
module alta_slice (
  input  A, B, C, D, Cin, Qin,
  input  Clk, AsyncReset, SyncReset, ShiftData, SyncLoad,
  output Cout, LutOut,
  output reg Q
);

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter mask = 16'h0000;
parameter modeMux = 1'b0;
parameter mode = "logic";
parameter FeedbackMux = 1'b1;
parameter ShiftMux = 1'b0;
parameter BypassEn = 1'b0;
parameter CarryEnb = 1'b0;
parameter AsyncResetMux = 2'bxx;
parameter SyncResetMux  = 2'bxx;
parameter SyncLoadMux   = 2'bxx;


wire pinC = modeMux ? Cin : (FeedbackMux ? Qin : C);
assign LutOut = D ? ( pinC ? ( B ? ( A ? mask[15] : mask[14]) : ( A ? mask[13] : mask[12]))
                           : ( B ? ( A ? mask[11] : mask[10]) : ( A ? mask[ 9] : mask[ 8])))
                  : ( pinC ? ( B ? ( A ? mask[ 7] : mask[ 6]) : ( A ? mask[ 5] : mask[ 4]))
                           : ( B ? ( A ? mask[ 3] : mask[ 2]) : ( A ? mask[ 1] : mask[ 0])));
assign Cout =  (Cin ? ( B ? ( A ? mask[ 7] : mask[ 6]) : ( A ? mask[ 5] : mask[ 4]))
                    : ( B ? ( A ? mask[ 3] : mask[ 2]) : ( A ? mask[ 1] : mask[ 0]))) | CarryEnb;
wire Din = !(BypassEn & SyncReset) & ((SyncLoad & BypassEn) ? C : (ShiftMux ? ShiftData : LutOut));

initial Q = 1'b0;
always @ (posedge Clk or posedge AsyncReset)
begin
  if (AsyncReset === 1'b1)
    Q <= 1'b0;
  else
    Q <= Din;
end

endmodule

module alta_clkenctrl_rst (
  input ClkIn, ClkEn, Rst,
  output ClkOut
);

reg ClkEn_reg = 1'b0;
always @ (ClkIn or ClkEn or Rst) begin
  if (Rst)
    ClkEn_reg <= 1'b0;
  else if (ClkIn == 1'b0)
    ClkEn_reg <= ClkEn;
end
assign ClkOut = ClkEn_reg & ClkIn;

endmodule

module alta_clkenctrl (
  input ClkIn, ClkEn,
  output ClkOut
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

parameter ClkMux   = 2'b10;
parameter ClkEnMux = 2'b10;

wire ClkMuxOut   = ClkMux[1] ? (ClkMux[0] ? !ClkIn : ClkIn) : (ClkMux[0] ? 1'b1 : 1'b0);
wire ClkEnMuxOut = ClkEnMux[1] ? (ClkEnMux[0] ? !ClkEn : ClkEn) : (ClkEnMux[0] ? 1'b1 : 1'b0);
alta_clkenctrl_rst inst(.ClkIn(ClkMuxOut), .ClkEn(ClkEnMuxOut), .Rst(1'b0), .ClkOut(ClkOut));

endmodule

module alta_asyncctrl (
  input Din,
  output Dout
);

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter AsyncCtrlMux = 2'b10;

assign Dout = AsyncCtrlMux[1] ? (AsyncCtrlMux[0] ? !Din : Din) : (AsyncCtrlMux[0] ? 1'b1 : 1'b0);

endmodule

module alta_syncctrl (
  input Din,
  output Dout
);

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter SyncCtrlMux = 2'b10;

assign Dout = SyncCtrlMux[1] ? (SyncCtrlMux[0] ? !Din : Din) : (SyncCtrlMux[0] ? 1'b1 : 1'b0);

endmodule

module alta_io_gclk (
  input inclk,
  output outclk
);

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

buf(outclk, inclk);

endmodule

module alta_gclksel (
  input  [3:0] clkin,
  input  [1:0] select,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

assign clkout = clkin[select];
endmodule

module alta_gclkgen (
  input  clkin, ena,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter ENA_REG_MODE = 1'b0;

alta_dff inst(.Din(ena), .Clk(!clkin), .AsyncReset(1'b0), .Q(ena_reg));
assign clkout = clkin & (ENA_REG_MODE ? ena_reg : ena);
endmodule

module alta_gclkgen0 (
  input  clkin, ena,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
alta_gclkgen inst(.clkin(clkin), .ena(ena), .clkout(clkout));
endmodule

module alta_gclkgen2 (
  input  clkin, ena, mode,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter PLLOUTP_EN = 1'b0;
parameter PLLOUTN_EN = 1'b0;

alta_dff inst0(.Din(ena    ), .Clk(!clkin), .AsyncReset(1'b0), .Q(ena_int));
alta_dff inst1(.Din(ena_int), .Clk(!clkin), .AsyncReset(1'b0), .Q(ena_reg));
assign clkout = clkin & (mode ? ena_reg : ena_int);
endmodule

module alta_io (
  inout  padio,
  input  datain, oe,
  output combout
);

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter PRG_DELAYB = 1'b0;
parameter RX_SEL = 1'b0;
parameter PDCNTL = 2'b11;
parameter NDCNTL = 2'b11;
parameter PRG_SLR = 1'b0;
parameter CFG_KEEP = 2'b00;
parameter PU = 4'b1000;
parameter LVDS_OUT = 1'b0;

`ifdef ALTA_SIM
reg bus_keep, pull_up, pull_down;
reg open_drain, open_drain_p;
reg output_drv;
reg trigate_in, last_value, hold_value;

initial last_value = 1'b0;

always @(datain or oe or padio or CFG_KEEP or PDCNTL or NDCNTL)
begin
  bus_keep     = (CFG_KEEP[1:0] == 2'b11);
  pull_up      = (CFG_KEEP[1:0] == 2'b10);
  pull_down    = (CFG_KEEP[1:0] == 2'b01);
  open_drain   = (|PDCNTL == 1'b0 && |NDCNTL == 1'b1); // includes 0001, 0010, 0011
  open_drain_p = (|PDCNTL == 1'b1 && |NDCNTL == 1'b0); // includes 0100, 1000, 1100
  output_drv   = (|PDCNTL == 1'b1 || |NDCNTL == 1'b1 || LVDS_OUT == 1'b1); // any output drive capability

  if (output_drv)
  begin
    if (!open_drain && !open_drain_p)
      trigate_in = datain;
    else if (open_drain && datain == 1'b0)
      trigate_in = 1'b0;
    else if (open_drain_p && datain == 1'b1)
      trigate_in = 1'b1;
    else
      trigate_in = 1'bz;
  end
  else // no output drive capability
    trigate_in = 1'bz;

  if (padio == 1'b0 || padio == 1'b1)
    last_value = padio;
  hold_value = (bus_keep ? last_value : (pull_up ? 1'b1 : (pull_down ? 1'b0 : 1'bz)));
end

cmos  pad  (padio  , trigate_in, oe  , ~oe);
cmos  in   (combout, last_value, 1'b1, 1'b0);
rcmos hold1(padio  , hold_value, 1'b1, 1'b0);
rcmos hold2(combout, hold_value, 1'b1, 1'b0);
bufif1 (weak1, weak0) pu(padio, 1'b1, |PU);
`else
  assign combout = padio;
  assign padio = oe ? datain : 1'bz;
`endif

endmodule

module alta_rio (
  input  datain, oe, outclk, outclkena, inclk, inclkena, areset, sreset,
  output combout, regout,
  inout  padio
);

parameter coord_x  = 0;
parameter coord_y  = 0;
parameter coord_z  = 0;

parameter IN_ASYNC_MODE  = 1'b0; // 0: Reset, 1: Preset
parameter IN_SYNC_MODE   = 1'b0; // 0: Reset, 1: Preset
parameter IN_POWERUP     = 1'b0; // Power up value
parameter OUT_REG_MODE   = 1'b0; // 0: Not registered, 1: Registered
parameter OUT_ASYNC_MODE = 1'b0;
parameter OUT_SYNC_MODE  = 1'b0;
parameter OUT_POWERUP    = 1'b0;
parameter OE_REG_MODE    = 1'b0;
parameter OE_ASYNC_MODE  = 1'b0;
parameter OE_SYNC_MODE   = 1'b0;
parameter OE_POWERUP     = 1'b0;

parameter CFG_TRI_INPUT    = 1'b0;
parameter CFG_INPUT_EN     = 1'b0;
parameter CFG_PULL_UP      = 1'b0;
parameter CFG_SLR          = 1'b0;
parameter CFG_OPEN_DRAIN   = 1'b0;
parameter CFG_PDRCTRL      = 4'b0010;
parameter CFG_KEEP         = 2'b00;
parameter CFG_LVDS_OUT_EN  = 1'b0;
parameter CFG_LVDS_SEL_CUA = 2'b00;
parameter CFG_LVDS_IREF    = 10'b0000000000;
parameter CFG_LVDS_IN_EN   = 1'b0;


parameter DPCLK_DELAY   = 4'b0000;
parameter OUT_DELAY     = 1'b0;
parameter IN_DATA_DELAY = 3'b000;
parameter IN_REG_DELAY  = 3'b000;

wire paddatain, paddataout, padoe;
wire in_reg, out_reg, oe_reg;

// Input
wire input_data = sreset ? IN_SYNC_MODE : paddataout;
alta_srff #(IN_POWERUP) reg_in(.Din(input_data), .Clk(inclk), .ClkEn(inclkena), .AsyncReset(areset && !IN_ASYNC_MODE), .AsyncPreset(areset && IN_ASYNC_MODE), .Q(in_reg));
assign regout = in_reg;
assign combout = paddataout;

// Output
wire output_data = sreset ? OUT_SYNC_MODE : datain;
alta_srff #(OUT_POWERUP) reg_out(.Din(output_data), .Clk(outclk), .ClkEn(outclkena), .AsyncReset(areset && !OUT_ASYNC_MODE), .AsyncPreset(areset && OUT_ASYNC_MODE), .Q(out_reg));
assign paddatain = OUT_REG_MODE ? out_reg : datain;

// Output enable
wire oe_data = sreset ? OE_SYNC_MODE : oe;
alta_srff #(OE_POWERUP) reg_oe(.Din(oe_data), .Clk(outclk), .ClkEn(outclkena), .AsyncReset(areset && !OE_ASYNC_MODE), .AsyncPreset(areset && OE_ASYNC_MODE), .Q(oe_reg));
assign padoe = OE_REG_MODE ? oe_reg : oe;

alta_io io_inst (.datain(paddatain), .oe(padoe), .combout(paddataout), .padio(padio));
defparam io_inst.PU       = CFG_PULL_UP ? 4'b1000 : 4'b0000;
defparam io_inst.CFG_KEEP = CFG_KEEP;
defparam io_inst.PDCNTL   = CFG_OPEN_DRAIN ? 2'b00 : CFG_PDRCTRL;
defparam io_inst.NDCNTL   = CFG_PDRCTRL;
defparam io_inst.LVDS_OUT = CFG_LVDS_OUT_EN;

endmodule

module alta_srff #(parameter INIT_VAL = 1'b0) (
  input Din, Clk, ClkEn, AsyncReset, AsyncPreset,
  output reg Q
);
always @ (posedge Clk or posedge AsyncReset or posedge AsyncPreset) begin
  if (AsyncReset == 1'b1)
    Q <= 1'b0;
  else if (AsyncPreset == 1'b1)
    Q <= 1'b1;
  else if (ClkEn == 1'b1)
    Q <= Din;
end
`ifdef ALTA_SIM
initial Q = INIT_VAL;
always @ (AsyncReset or AsyncPreset) begin
  if (!AsyncReset && AsyncPreset)
    force Q = 1'b1;
  else
    release Q;
end
`endif
endmodule

module alta_dff #(parameter INIT_VAL = 1'b0) (
  input Din, Clk, AsyncReset,
  output Q
);
alta_srff #(INIT_VAL) inst (.Din(Din), .Clk(Clk), .ClkEn(1'b1), .AsyncReset(AsyncReset), .AsyncPreset(1'b0), .Q(Q));
endmodule

module alta_ufm_gddd(input in, output out);
assign out = in;
endmodule

module alta_dff_stall #(parameter INIT_VAL = 1'b0) (
  input Din, Clk, AsyncReset, Stall,
  output Q
);
alta_dff #(INIT_VAL) inst (.Din(Stall ? Q : Din), .Clk(Clk), .AsyncReset(AsyncReset), .Q(Q));
endmodule

module alta_srlat #(parameter INIT_VAL = 1'b0) (
  input Din, Clk, AsyncReset, AsyncPreset,
  output reg Q
);
`ifdef ALTA_SIM
initial Q = INIT_VAL;
`endif
always @ (Din or Clk or AsyncReset or AsyncPreset) begin
  if (AsyncPreset) begin
    Q <= 1'b1;
  end else if (AsyncReset) begin
    Q <= 1'b0;
  end else if (Clk) begin
    Q <= Din;
  end
end
endmodule

module alta_dio (
  input  datain, datainh, oe, outclk, outclkena, inclk, inclkena, areset, sreset,
  output combout, regout,
  inout  padio
);

parameter coord_x  = 0;
parameter coord_y  = 0;
parameter coord_z  = 0;

parameter IN_ASYNC_MODE     = 1'b0; // 0: Reset, 1: Preset
parameter IN_SYNC_MODE      = 1'b0; // 0: Reset, 1: Preset
parameter IN_POWERUP        = 1'b0; // Power up value
parameter IN_ASYNC_DISABLE  = 1'b0; // 1: input async reset disabled
parameter IN_SYNC_DISABLE   = 1'b0; // 1: input sync reset disabled
parameter OUT_REG_MODE      = 1'b0; // 0: Not registered, 1: Registered
parameter OUT_ASYNC_MODE    = 1'b0;
parameter OUT_SYNC_MODE     = 1'b0;
parameter OUT_POWERUP       = 1'b0;
parameter OUT_CLKEN_DISABLE = 1'b0; // 1: output clken disabled
parameter OUT_ASYNC_DISABLE = 1'b0;
parameter OUT_SYNC_DISABLE  = 1'b0;
parameter OUT_DDIO          = 1'b0;
parameter OE_REG_MODE       = 1'b0;
parameter OE_ASYNC_MODE     = 1'b0;
parameter OE_SYNC_MODE      = 1'b0;
parameter OE_POWERUP        = 1'b0;
parameter OE_CLKEN_DISABLE  = 1'b0; // 1: output enable clken disabled
parameter OE_ASYNC_DISABLE  = 1'b0;
parameter OE_SYNC_DISABLE   = 1'b0;
parameter OE_DDIO           = 1'b0;

parameter CFG_TRI_INPUT     = 1'b0;
parameter CFG_PULL_UP       = 1'b0;
parameter CFG_OPEN_DRAIN    = 1'b0;
parameter CFG_ROCT_CAL_EN   = 1'b0;
parameter CFG_PDRV          = 7'b0010000;
parameter CFG_NDRV          = 7'b0010000;
parameter CFG_KEEP          = 2'b0;
parameter CFG_LVDS_OUT_EN   = 1'b0;
parameter CFG_LVDS_SEL_CUA  = 3'b0;
parameter CFG_LVDS_IREF     = 10'b0110000000;
parameter CFG_LVDS_IN_EN    = 1'b0;
parameter CFG_SSTL_OUT_EN   = 1'b0;
parameter CFG_SSTL_INPUT_EN = 1'b0;
parameter CFG_SSTL_SEL_CUA  = 3'b0;
parameter CFG_OSCDIV        = 2'b0;
parameter CFG_ROCTUSR       = 1'b0;
parameter CFG_SEL_CUA       = 1'b0;
parameter CFG_ROCT_EN       = 1'b0;

parameter INPUT_ONLY    = 1'b0;
parameter DPCLK_DELAY   = 4'b0000;
parameter OUT_DELAY     = 1'b0;
parameter IN_DATA_DELAY = 3'b000;
parameter IN_REG_DELAY  = 3'b000;

wire paddatain, paddataout, padoe;
wire in_reg, out_reg, oe_reg;

// Input
wire in_data = (sreset & !IN_SYNC_DISABLE) ? IN_SYNC_MODE : paddataout;
wire in_asyncreset  = areset & !IN_ASYNC_DISABLE & !IN_ASYNC_MODE;
wire in_asyncpreset = areset & !IN_ASYNC_DISABLE &  IN_ASYNC_MODE;
alta_srff #(IN_POWERUP) reg_in(.Din(in_data), .Clk(inclk), .ClkEn(inclkena), .AsyncReset(in_asyncreset), .AsyncPreset(in_asyncpreset), .Q(in_reg));
assign regout = in_reg;
assign combout = paddataout;

// Output
wire out_data_h = (sreset & !OUT_SYNC_DISABLE) ? OUT_SYNC_MODE : datainh;
wire out_data_l = (sreset & !OUT_SYNC_DISABLE) ? OUT_SYNC_MODE : datain;
wire out_clken  = outclkena | OUT_CLKEN_DISABLE;
wire out_asyncreset  = areset & !OUT_ASYNC_DISABLE & !OUT_ASYNC_MODE;
wire out_asyncpreset = areset & !OUT_ASYNC_DISABLE &  OUT_ASYNC_MODE;
alta_srlat data_h_inst(.Din(out_data_h), .Clk(!outclk | !out_clken), .AsyncReset(out_asyncreset), .AsyncPreset(out_asyncpreset), .Q(outreg_h));
alta_srff #(OUT_POWERUP) data_l_inst(.Din(out_data_l), .Clk(outclk), .ClkEn(out_clken), .AsyncReset(out_asyncreset), .AsyncPreset(out_asyncpreset), .Q(outreg_l));
assign paddatain = !OUT_REG_MODE ? datain : !OUT_DDIO ? outreg_l : outclk ? outreg_h : outreg_l;

// Output enable
wire oe_data_h = (sreset & !OE_SYNC_DISABLE) ? OE_SYNC_MODE : oe;
wire oe_clken  = outclkena | OE_CLKEN_DISABLE;
wire oe_asyncreset  = areset & !OE_ASYNC_DISABLE & !OE_ASYNC_MODE;
wire oe_asyncpreset = areset & !OE_ASYNC_DISABLE &  OE_ASYNC_MODE;
alta_srff #(OE_POWERUP) oe_h_inst(.Din(oe_data_h), .Clk( outclk), .ClkEn(oe_clken), .AsyncReset(oe_asyncreset), .AsyncPreset(oe_asyncpreset), .Q(oe_reg_h));
alta_srff #(OE_POWERUP) oe_l_inst(.Din(oe_reg_h),  .Clk(!outclk), .ClkEn(oe_clken), .AsyncReset(oe_asyncreset), .AsyncPreset(oe_asyncpreset), .Q(oe_reg_l));
assign padoe = !OE_REG_MODE ? oe : !OE_DDIO ? oe_reg_h : !oe_reg_h ? oe_reg_h : oe_reg_l;

alta_io io_inst (.datain(paddatain), .oe(padoe), .combout(paddataout), .padio(padio));
defparam io_inst.PU       = CFG_PULL_UP ? 4'b1000 : 4'b0000;
defparam io_inst.CFG_KEEP = CFG_KEEP;
defparam io_inst.PDCNTL   = CFG_OPEN_DRAIN ? 2'b00 : |CFG_PDRV ? 2'b11 : 2'b00;
defparam io_inst.NDCNTL   = |CFG_NDRV ? 2'b11 : 2'b00;
defparam io_inst.LVDS_OUT = CFG_LVDS_OUT_EN;

endmodule

module alta_indel (
  input in,
  output out
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter IN_DATA_DELAY = 3'b000;
assign out = in;
endmodule

module alta_dpclkdel (
  input clkin,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter DPCLK_DELAY = 4'b000;
assign clkout = clkin;
endmodule

module alta_ufms (
  input tri1 i_ufm_set,
  input  i_osc_ena,
  input  i_ufm_flash_csn,
  input  i_ufm_flash_sclk,
  input  i_ufm_flash_sdi,
  output o_osc,
  output o_ufm_flash_sdo
  );
`ifdef ALTA_SIM
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
alta_ufms_sim ufm0 (
  .osc_ena(i_osc_ena                   ),
  .cs     (i_ufm_flash_csn             ),
  .sclk   (i_ufm_flash_sclk & i_ufm_set),// Shut down clk when i_ufm_set is low
  .si     (i_ufm_flash_sdi             ),
  .osc    (o_osc                       ),
  .so     (o_ufm_flash_sdo             )
);
defparam ufm0.TPP_TIME = 10000;
`endif
endmodule

`timescale 1ns/10ps
module alta_ufms_sim   (input  sclk     ,
                        input  si       ,
                        input  cs       ,
                        output so       ,
                        output osc      ,
                        input  osc_ena
                        );

parameter TPP_TIME        = 700000;          // page program cycle time (0.7ms)
parameter TSE_TIME        = 100000000;       // sector erase cycle time (100ms)
parameter TCE_TIME        = 300000000;       // sector erase cycle time (100ms)
parameter osc_sim_setting = 180;             // default osc frequency to 5.56MHz
parameter T_HALF_PERIOD   = osc_sim_setting/2;

`ifndef ALTA_SIM
alta_ufms ufm0 (
  .i_ufm_set       (       ),
  .i_osc_ena       (osc_ena),
  .i_ufm_flash_csn (cs     ),
  .i_ufm_flash_sclk(sclk   ),
  .i_ufm_flash_sdi (si     ),
  .o_osc           (osc    ),
  .o_ufm_flash_sdo (so     )
  );
`else
reg osc_reg;
assign osc = osc_reg;
parameter        CMD_RDDATA            =  8'h03                       ,
                 CMD_PAGE_PROGRAM      =  8'h02                       ,
                 CMD_SECTOR_ERASE      =  8'h20                       ,
                 CMD_CHIP_ERASE        =  8'h52                       ,
                 CMD_WRITE_ENABLE      =  8'h06                       ,
                 CMD_READ_STATUS_REG   =  8'h05                       ;

parameter address_width = 16;
parameter num_bytes     = 1 << address_width;

parameter sector_range = 1<<(address_width - 4);


reg [7:0] mem [(1<<address_width -1)-1:0] ;

reg [7:0] data_reg   ;

reg [7:0] data_shift_reg ;

reg [2:0] cnt_flash_bit  ;

reg [7:0] cmd_reg        ;
reg [23:0] addr_reg      ;
reg [7:0] dataout        ;
reg program_pulse        ;
reg erase_pulse          ;
reg wren_pusle           ;
reg program_pulse_d1     ;
reg program_pulse_d2     ;
reg erase_pulse_d1       ;
reg erase_pulse_d2       ;
reg first_warning        ;
reg [5:0]cnt_cmd_addr    ;
reg [2:0]cnt_pp_bit      ;
reg ufm_sdo_valid        ;
reg sdo_valid_tmp        ;
reg [23:0] erase_addr    ;
reg erase_reg            ;
integer i;
initial
begin
  first_warning = 1;
  program_pulse = 0;
  erase_pulse   = 0;
  erase_addr    = 0;
  osc_reg       = 1;
  for (i=0; i<num_bytes; i=i+1)
    mem[i] = 8'hFF;
end

always@(negedge sclk)
begin
  program_pulse_d1 <= program_pulse;
  program_pulse_d2 <= program_pulse_d1;
  erase_pulse_d1   <= erase_pulse;
  erase_pulse_d2   <= erase_pulse_d1;
end


always@( * )
begin
  if((cmd_reg == CMD_PAGE_PROGRAM) && (cnt_cmd_addr == 6'h18) && (cnt_flash_bit == 3'b111))
  begin
    program_pulse = 1;
    $display("%t:  NOTE : Page program cycle is started",$realtime);
  end
  else if(cs && (cmd_reg == CMD_PAGE_PROGRAM))
  begin
    program_pulse = #TPP_TIME 0;
    $display("%t:  NOTE : Page program cycle is finished",$realtime);
  end
end

always@( * )
begin
  if(((cmd_reg == CMD_SECTOR_ERASE) || (cmd_reg == CMD_CHIP_ERASE))&& (cnt_cmd_addr == 6'h00) && (cnt_flash_bit == 3'b111))
    erase_reg = 1;
  else
    erase_reg =  0;
end

always@(posedge erase_reg)
begin
  if(cmd_reg == CMD_SECTOR_ERASE)
  begin
    erase_pulse	= 1;
    #TSE_TIME;
    erase_pulse	= 0;
  end
  else if(cmd_reg == CMD_CHIP_ERASE)
  begin
    erase_pulse	= 1;
    #TCE_TIME;
    erase_pulse	= 0;
  end
end

always@(negedge sclk)
begin
  if(cmd_reg == CMD_WRITE_ENABLE )
  begin
    wren_pusle = 1;
    $display("%t:  NOTE : Flash write enable is set",$realtime);
  end
  else if((!program_pulse_d1 && program_pulse_d2) || (!erase_pulse_d1 && erase_pulse_d2))
  begin
    wren_pusle = 0;
    $display("%t:  NOTE : Flash write enable is reset",$realtime);
  end
end


always@(negedge sclk or posedge cs)
begin
  if(cs)
    cnt_flash_bit <= 3'b111;
  else if(!cs)
    cnt_flash_bit <= cnt_flash_bit - 3'b001;
end


always@(negedge sclk or posedge cs)
begin
  if(cs)
    cnt_cmd_addr <= 6'h20 ;
  else if(!cs && |cnt_cmd_addr)
    cnt_cmd_addr <= cnt_cmd_addr - 6'b000001 ;
end


always@(negedge sclk or posedge cs)
begin
  if(cs)
    addr_reg <= 0 ;
  else if((cnt_cmd_addr == 6'h00) && (cnt_flash_bit == 3'b000))
    addr_reg <=  addr_reg + 1;
  else if((cnt_cmd_addr >= 6'h01 && cnt_cmd_addr <= 6'h18) && cmd_reg != CMD_READ_STATUS_REG)
    addr_reg <= {addr_reg[22:0],si};
end

always@(posedge sclk or posedge cs)
begin
  if(cs)
    cmd_reg <= 0 ;
  else if(cnt_cmd_addr >= 6'h19 && cnt_cmd_addr <= 6'h20)
    cmd_reg <= {cmd_reg[6:0],si} ;
end


always@(negedge sclk)
begin
  if((cnt_cmd_addr == 6'h01) && (cmd_reg == CMD_SECTOR_ERASE))
    erase_addr <= addr_reg ;
end

always@(cs or cmd_reg or cnt_cmd_addr or addr_reg or mem[addr_reg] or program_pulse or erase_pulse)
begin
  if(cs)
    dataout = 0;
  else if((cmd_reg == CMD_RDDATA) && (cnt_cmd_addr == 6'h00))
    dataout = mem[addr_reg];
  else if((cmd_reg == CMD_READ_STATUS_REG) && (program_pulse || erase_pulse))
    dataout = 8'h01;
  else
    dataout = 0;
end

assign so = ufm_sdo_valid ? dataout[cnt_flash_bit] : 1'b0;

always@(posedge sclk or posedge cs)
begin
  if(cs)
    sdo_valid_tmp <= 0;
  else if((cmd_reg == 8'h03) && (cnt_cmd_addr == 6'h01))
    sdo_valid_tmp <= 1;
  else if((cmd_reg == 8'h02) && (cnt_cmd_addr == 6'h19) && si )
    sdo_valid_tmp <= 1;
end

always@(negedge sclk or posedge cs)
begin
  if(cs)
    ufm_sdo_valid <= 0;
  else
    ufm_sdo_valid <= sdo_valid_tmp;
end

always@(posedge sclk or posedge cs)
begin
  if(cs)
    cnt_pp_bit <= 3'b111;
  else if(!cs)
    cnt_pp_bit <= cnt_pp_bit - 3'b001;
end


always@(posedge sclk or posedge cs)
begin
  if(cs)
    data_shift_reg <= 0;
  else if((cmd_reg == CMD_PAGE_PROGRAM) && wren_pusle && (cnt_cmd_addr == 6'h00))
    data_shift_reg[cnt_pp_bit] <= si ;
end

always@(negedge sclk)
begin
  if((cmd_reg == CMD_PAGE_PROGRAM) && wren_pusle && (cnt_cmd_addr == 6'h00) && (cnt_pp_bit == 3'b111))
  begin
    mem[addr_reg] <= data_shift_reg & mem[addr_reg];// The write operation is the logical "AND" in UFM
  end
end

// Produce oscillation clock to UFM
always @(osc_reg or osc_ena)
begin
  if (osc_ena === 'b1)
  begin
    if (first_warning == 1)
    begin
      $display("Info : UFM oscillator can operate at any frequency between 3.33MHz to 5.56Mhz.");
      $display ("Time: %0t  Instance: %m", $time);
      first_warning = 0;
    end

    if (osc_reg === 'b0 || osc_reg === 'b1)
      osc_reg <= #T_HALF_PERIOD ~osc_reg;
    else
      osc_reg <= #T_HALF_PERIOD 0;
  end
  else
  begin
    osc_reg <= #T_HALF_PERIOD 1;
  end
end

integer k = 0;

always @(posedge erase_pulse)
begin
  if(cmd_reg == CMD_SECTOR_ERASE)
  begin
    if(erase_addr >= 0 &&  erase_addr < sector_range)
    begin
      $display("%t:  NOTE : Sector0 erase cycle has begun",$realtime);
      for (k=0; k<sector_range; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector0 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range &&  erase_addr < sector_range*2))
    begin
      $display("%t:  NOTE : Sector1 erase cycle has begun",$realtime);
      for (k=sector_range; k<sector_range*2; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector1 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range*2 &&  erase_addr < sector_range*3))
    begin
      $display("%t:  NOTE : Sector2 erase cycle has begun",$realtime);
      for (k=sector_range*2; k<sector_range*3; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector2 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range*3 &&  erase_addr < sector_range*4))
    begin
      $display("%t:  NOTE : Sector3 erase cycle has begun",$realtime);
      for (k=sector_range*3; k<sector_range*4; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector3 erase cycle is finished",$realtime);
    end

    else if((erase_addr >= sector_range*4 &&  erase_addr < sector_range*5))
    begin
      $display("%t:  NOTE : Sector4 erase cycle has begun",$realtime);
      for (k=sector_range*4; k<sector_range*5; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector4 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range*5 &&  erase_addr < sector_range*6))
    begin
      $display("%t:  NOTE : Sector5 erase cycle has begun",$realtime);
      for (k=sector_range*5; k<sector_range*6; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector5 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range*6 &&  erase_addr < sector_range*7))
    begin
      $display("%t:  NOTE : Sector6 erase cycle has begun",$realtime);
      for (k=sector_range*6; k<sector_range*7; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector6 erase cycle is finished",$realtime);
    end
    else if((erase_addr >= sector_range*7 &&  erase_addr < sector_range*8))
    begin
      $display("%t:  NOTE : Sector7 erase cycle has begun",$realtime);
      for (k=sector_range*7; k<sector_range*8; k=k+1)
      begin
        mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
      end
      $display("%t:  NOTE : Sector7 erase cycle is finished",$realtime);
    end
  end
  else if(cmd_reg == CMD_CHIP_ERASE)
  begin
    $display("%t:  NOTE : CHIP erase cycle is begun",$realtime);
    for(k=0;k<sector_range*8; k=k+1)
    begin
      mem[k] <= 8'hff;  // Data in UFM is erased to all 1's
    end
    $display("%t:  NOTE : CHIP erase cycle is finished",$realtime);
  end
end
`endif
endmodule

`timescale 1ns/10ps
module alta_pll (
  input clkin, clkfb,
  input pllen, resetn, pfden,
  output clkout0, clkout1,
  output lock
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter CLKIN_DIV      = 6'h1;
parameter CLKFB_DIV      = 6'h1;
parameter CLKOUT0_DIV    = 6'h1;
parameter CLKOUT1_DIV    = 6'h1;
parameter CLKOUT0_DEL    = 6'h0;
parameter CLKOUT1_DEL    = 6'h0;
parameter CLKOUT0_PHASE  = 3'h0;
parameter CLKOUT1_PHASE  = 3'h0;
parameter FEEDBACK_CLOCK = 1'b0;
parameter FEEDBACK_MODE  = 1'b1;
parameter CLKOUT0_EN     = 1'h1;
parameter CLKOUT1_EN     = 1'h1;
parameter CLKIN_FREQ     = 10.0;
parameter CLKFB_FREQ     = 10.0;
parameter CLKOUT0_FREQ   = 10.0;
parameter CLKOUT1_FREQ   = 10.0;
`ifdef ALTA_SIM
  alta_pll_sim #(
    .NUM_CLKOUTS      (2),
    .CLKIN_DIV_BITS   (6),
    .CLKFB_DIV_BITS   (6),
    .CLKOUT_DIV_BITS  (6),
    .CLKOUT_DEL_BITS  (6),
    .CLKOUT_PHASE_BITS(3)
  ) sim_inst (
    .clkin         (clkin                         ),
    .clkfb         (clkfb                         ),
    .pllen         (pllen                         ),
    .resetn        (resetn                        ),
    .pfden         (pfden                         ),
    .clkout        ({clkout1   , clkout0   }      ),
    .clkouten      ({CLKOUT1_EN, CLKOUT0_EN}      ),
    .lock          (lock                          ),
    .FEEDBACK_CLOCK(FEEDBACK_CLOCK                ),
    .FEEDBACK_MODE (FEEDBACK_MODE                 ),
    .CLKIN_DIV     (CLKIN_DIV                     ),
    .CLKFB_DIV     (CLKFB_DIV                     ),
    .CLKDIV_EN     (2'b11                         ),
    .CLKOUT_DIVS   ({CLKOUT1_DIV  , CLKOUT0_DIV  }),
    .CLKOUT_DELS   ({CLKOUT1_DEL  , CLKOUT0_DEL  }),
    .CLKOUT_PHASES ({CLKOUT1_PHASE, CLKOUT0_PHASE})
  );
`else
  assign clkout0 = clkin;
  assign clkout1 = clkin;
  assign lock    = pllen & resetn & pfden & clkfb;
`endif
endmodule

module alta_pllx (
  input  clkin, clkfb, pllen, resetn,
  input  clkout0en, clkout1en, clkout2en, clkout3en,
  output clkout0, clkout1, clkout2, clkout3, lock
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter CLKIN_DIV      = 6'd0;
parameter CLKFB_DIV      = 6'd0;
parameter CLKDIV0_EN     = 1'b0;
parameter CLKDIV1_EN     = 1'b0;
parameter CLKDIV2_EN     = 1'b0;
parameter CLKDIV3_EN     = 1'b0;
parameter CLKOUT0_DIV    = 6'd0;
parameter CLKOUT1_DIV    = 6'd0;
parameter CLKOUT2_DIV    = 6'd0;
parameter CLKOUT3_DIV    = 6'd0;
parameter CLKOUT0_DEL    = 6'd0;
parameter CLKOUT1_DEL    = 6'd0;
parameter CLKOUT2_DEL    = 6'd0;
parameter CLKOUT3_DEL    = 6'd0;
parameter CLKOUT0_PHASE  = 3'd0;
parameter CLKOUT1_PHASE  = 3'd0;
parameter CLKOUT2_PHASE  = 3'd0;
parameter CLKOUT3_PHASE  = 3'd0;
parameter FEEDBACK_MODE  = 1'b1;
parameter FEEDBACK_CLOCK = 2'b00;
parameter CLKIN_FREQ     = 60.000;
parameter CLKFB_FREQ     = 20.000;
parameter CLKOUT0_FREQ   = -1.000;
parameter CLKOUT1_FREQ   = 50.000;
parameter CLKOUT2_FREQ   = 80.000;
parameter CLKOUT3_FREQ   = 100.000;
`ifdef ALTA_SIM
  alta_pll_sim #(
    .NUM_CLKOUTS      (4),
    .CLKIN_DIV_BITS   (6),
    .CLKFB_DIV_BITS   (6),
    .CLKOUT_DIV_BITS  (6),
    .CLKOUT_DEL_BITS  (6),
    .CLKOUT_PHASE_BITS(3)
  ) sim_inst (
    .clkin         (clkin                                                       ),
    .clkfb         (clkfb                                                       ),
    .pllen         (pllen                                                       ),
    .resetn        (resetn                                                      ),
    .pfden         (1'b1                                                        ),
    .clkout        ({clkout3  , clkout2  , clkout1  , clkout0  }                ),
    .clkouten      ({clkout3en, clkout2en, clkout1en, clkout0en}                ),
    .lock          (lock                                                        ),
    .FEEDBACK_CLOCK(FEEDBACK_CLOCK                                              ),
    .FEEDBACK_MODE (FEEDBACK_MODE                                               ),
    .CLKIN_DIV     (CLKIN_DIV                                                   ),
    .CLKFB_DIV     (CLKFB_DIV                                                   ),
    .CLKDIV_EN     ({CLKDIV3_EN   , CLKDIV2_EN   , CLKDIV1_EN   , CLKDIV0_EN   }),
    .CLKOUT_DIVS   ({CLKOUT3_DIV  , CLKOUT2_DIV  , CLKOUT1_DIV  , CLKOUT0_DIV  }),
    .CLKOUT_DELS   ({CLKOUT3_DEL  , CLKOUT2_DEL  , CLKOUT1_DEL  , CLKOUT0_DEL  }),
    .CLKOUT_PHASES ({CLKOUT3_PHASE, CLKOUT2_PHASE, CLKOUT1_PHASE, CLKOUT0_PHASE})
  );
`else
  assign clkout0 = clkout0en & clkin;
  assign clkout1 = clkout1en & clkin;
  assign clkout2 = clkout2en & clkin;
  assign clkout3 = clkout3en & clkin;
  assign lock    = pllen & resetn & clkfb;
`endif
endmodule

`ifdef ALTA_SIM
`timescale `PLL_RESOLUTION
module pll_clk_div #(
  parameter DIV_BITS = 6,
            DEL_BITS = 6) (
  input clkin, rst, ena,
  output clkout,
  input CLKDIV_EN,
  input [DIV_BITS-1:0] CLK_DIV,
  input [DEL_BITS-1:0] CLK_DEL
);

reg clk = 1'b0;
reg [DIV_BITS-1:0] divcnt = 0;
reg [DEL_BITS-1:0] dlycnt = 0;
reg pos_level, neg_level;
reg rst_sync1, rst_sync2;
reg divcnt_en;
wire [DIV_BITS:0] half_period = {1'b0, CLK_DIV[DIV_BITS-1:0]} + 1'b1;

initial begin
  divcnt = {DIV_BITS{1'b0}};
  dlycnt = {DEL_BITS{1'b0}};
  pos_level = 1'b0;
  neg_level = 1'b0;
  rst_sync1 = 1'b0;
  rst_sync2 = 1'b0;
  divcnt_en = 1'b0;
end

always @(*) begin
  if (CLK_DIV == {DIV_BITS{1'b0}}) begin
    if (divcnt_en)
      clk = clkin;
    else
      clk = 1'b0;
  end else begin
    if (CLK_DIV[0] == 1'b1) // Even divider
      clk = pos_level;
    else
      clk = pos_level || neg_level;
  end
end

reg clk_ena = 1'b0;
always @(*) begin
  if (rst) begin
    clk_ena <= 1'b0;
  end else if (!clk) begin
    clk_ena <= ena;
  end
end
assign clkout = clk & clk_ena;

always @(posedge clkin or posedge rst) begin
  if (rst) begin
    rst_sync1 <= 1'b0;
    rst_sync2 <= 1'b0;
  end else if (CLKDIV_EN) begin
    rst_sync1 <= 1'b1;
    rst_sync2 <= rst_sync1;
  end
end

always @(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    dlycnt <= {DEL_BITS{1'b0}};
  else if (!divcnt_en)
    dlycnt <= dlycnt + 1'd1;
end

always @(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt_en <= 1'b0;
  else if (CLK_DEL == {DEL_BITS{1'b0}})
    divcnt_en <= 1'b1;
  else if (dlycnt == CLK_DEL)
    divcnt_en <= 1'b1;
end

always @(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt <= {DIV_BITS{1'b0}};
  else if (!divcnt_en)
    divcnt <= {DIV_BITS{1'b0}};
  else if (divcnt == CLK_DIV)
    divcnt <= {DIV_BITS{1'b0}};
  else
    divcnt <= divcnt + 1'd1;
end

always @(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    pos_level <= 1'b0;
  else if (!divcnt_en)
    pos_level <= 1'b0;
  else if (divcnt == {DIV_BITS{1'b0}})
    pos_level <= 1'b1;
  else if (divcnt == half_period[DIV_BITS:1])
    pos_level <= 1'b0;
end

always @(negedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    neg_level <= 1'b0;
  else if (!divcnt_en)
    neg_level <= 1'b0;
  else
    neg_level <= pos_level;
end

endmodule

`timescale `PLL_RESOLUTION
module alta_pll_core #(
  parameter NUM_CLKOUTS       = 4,
            TOTAL_FBDIV_BITS  = 12,
            CLKOUT_PHASE_BITS = 3) (
  input pllen, pfden,
  input pfd_clkin, pfd_clkfb,
  output [NUM_CLKOUTS-1:0] vco_clkout,
  output reg [(1 << CLKOUT_PHASE_BITS)-1:0] vco_taps,
  output reg lock,
  input [TOTAL_FBDIV_BITS-1:0] TOTAL_FBDIV,
  input [CLKOUT_PHASE_BITS*NUM_CLKOUTS-1:0] CLKOUT_PHASES
);

localparam epsilon = 1.5;
realtime last_clkin_edge, next_clkin_edge;
realtime last_clkfb_edge, next_clkfb_edge;
realtime pfd_clkin_period, pfd_clkin_period0, pfd_clkin_period1, pfd_clkin_period2, pfd_clkfb_period;
realtime vco_clk_pulse, vco_clk_offset, fb_delay0, fb_delay1, fb_compensation;
real rounding_error;
integer vco_index;
reg pfd_clkin_valid, vco_clk_valid;
reg vco_clk, intfb_clk;

initial begin
  reset;
end
always @(negedge pllen) begin
  reset;
end

task reset; begin
  last_clkin_edge   = 0.0;
  next_clkin_edge   = 0.0;
  pfd_clkin_period0 = 0.0;
  pfd_clkin_period1 = 0.0;
  pfd_clkin_period2 = 0.0;
  pfd_clkin_period  = 0.0;
  last_clkfb_edge   = 0.0;
  next_clkfb_edge   = 0.0;
  pfd_clkfb_period  = 0.0;
  fb_delay0         = 0.0;
  fb_delay1         = 0.0;
  fb_compensation   = 0.0;
  rounding_error    = 0.0;
  vco_index         = 0;
  vco_clk_pulse     = 5.0;
  vco_clk_offset    = 0.0;
  pfd_clkin_valid   = 1'b0;
  vco_clk_valid     = 1'b0;
  vco_clk           = 1'b1;
  intfb_clk         = 1'b1;
  lock              = 1'b0;
end
endtask

always @(posedge pfd_clkin or negedge pllen) begin
  if (!pllen) begin
    pfd_clkin_valid = 1'b0;
  end else begin
    last_clkin_edge = next_clkin_edge;
    next_clkin_edge = $realtime;
    if (last_clkin_edge > 0) begin
      pfd_clkin_period  = pfd_clkin_period2;
      pfd_clkin_period2 = pfd_clkin_period1;
      pfd_clkin_period1 = pfd_clkin_period0;
      pfd_clkin_period0 = next_clkin_edge - last_clkin_edge;
    end
    if (pfd_clkin_period > 0 && is_equal(pfd_clkin_period , pfd_clkin_period0)
                             && is_equal(pfd_clkin_period0, pfd_clkin_period1)
                             && is_equal(pfd_clkin_period1, pfd_clkin_period2)) begin
      pfd_clkin_valid = 1'b1;
      if (TOTAL_FBDIV != 0) begin
        vco_clk_pulse  = round_number(pfd_clkin_period / TOTAL_FBDIV / 2);
        rounding_error = (pfd_clkin_period - TOTAL_FBDIV * vco_clk_pulse * 2) / 2;
      end
    end else begin
      pfd_clkin_valid = 1'b0;
    end
  end
end

always @(posedge pfd_clkfb or negedge pllen or negedge vco_clk_valid) begin
  if (!pllen || !vco_clk_valid) begin
    fb_delay0 = 0.0;
    fb_delay1 = 0.0;
  end else begin
    last_clkfb_edge = next_clkfb_edge;
    next_clkfb_edge = $realtime;
    if (last_clkfb_edge > 0) begin
      pfd_clkfb_period = next_clkfb_edge - last_clkfb_edge;
    end
    if (is_equal(pfd_clkin_period, pfd_clkfb_period)) begin
      if (!lock) begin
        fb_delay1 = fb_delay0;
        fb_delay0 = last_clkin_edge - last_clkfb_edge;
        if (fb_delay0 < -epsilon) begin
          fb_delay0 = next_clkin_edge - last_clkfb_edge;
        end
      end
      if (fb_delay0 > epsilon && fb_delay1 >= 0) begin
        fb_compensation = fb_delay1;
        while (fb_compensation > pfd_clkfb_period) begin
          fb_compensation = fb_compensation - pfd_clkfb_period;
        end
      end
    end
  end
end

always @(negedge pfd_clkfb or negedge pllen or negedge lock) begin
  if (!pllen || !lock) begin
    vco_clk_offset = 0.0;
  end else if (lock) begin
    vco_clk_offset = next_clkin_edge - next_clkfb_edge;
  end
end

always @(pfd_clkin or pfd_clkfb or negedge pllen) begin
  if (!pllen) begin
    lock <= 1'b0;
  end else if ($realtime - next_clkfb_edge > 2 * pfd_clkfb_period) begin
    lock <= 1'b0;
  end else if ($realtime - next_clkin_edge > 2 * pfd_clkin_period) begin
    lock <= 1'b0;
  end else if (pfd_clkin_valid && vco_clk_valid && fb_delay0 < epsilon && is_equal(pfd_clkin_period, pfd_clkfb_period)) begin
    lock <= 1'b1;
  end else begin
    lock <= 1'b0;
  end
end

always @ (lock) begin
  if (lock) begin
    $display("PLL core %m is locked at: %t", $realtime);
  end else if ($realtime > 0) begin
    $display("PLL core %m is unlocked at: %t", $realtime);
  end
end

always @(pfd_clkin or pfd_clkfb or negedge pllen) begin
  if (!pllen) begin
    vco_clk_valid <= 1'b0;
  end else if (!lock) begin
    vco_clk_valid <= pfd_clkin_valid;
  end else if (!is_equal(pfd_clkin_period, pfd_clkfb_period)) begin
    vco_clk_valid <= 1'b0;
  end
end

real vco_shift, intfb_pulse;
always @(vco_clk_valid or intfb_clk) begin
  if (!vco_clk_valid) begin
    intfb_clk <= 1'b1;
    vco_index = 0;
  end else begin
    vco_index = vco_index + 1;
    vco_shift = 0.0;
    if (vco_index >= TOTAL_FBDIV) begin
      vco_index = 0;
      vco_shift = rounding_error;
    end
    if (pfd_clkfb == 1'b0) begin
      vco_shift = vco_shift + vco_clk_offset;
      vco_clk_offset = 0;
    end
    if (pfden) begin
      intfb_pulse = vco_clk_pulse + vco_shift;
      if (intfb_pulse <= 0) begin
        intfb_pulse = 0.1;
      end
      intfb_clk <= #intfb_pulse !intfb_clk;
    end else begin
      intfb_clk <= #1.5 !intfb_clk;
    end
  end
end

always @(intfb_clk) begin
  vco_clk <= #(fb_compensation) intfb_clk;
end

generate
genvar v;
for (v = 0; v < (1 << CLKOUT_PHASE_BITS); v = v + 1) begin
  always @ (vco_clk) begin
    vco_taps[v] <= #(vco_clk_pulse * 2 * v / (1 << CLKOUT_PHASE_BITS)) vco_clk;
  end
end
endgenerate

reg [CLKOUT_PHASE_BITS-1:0] CLKOUT_PHASES_VAL [NUM_CLKOUTS-1:0];
generate
genvar i;
for (i = 0; i < NUM_CLKOUTS; i = i + 1) begin
  always @(vco_taps[CLKOUT_PHASES[CLKOUT_PHASE_BITS * (i + 1) - 1-:CLKOUT_PHASE_BITS]]) begin
    CLKOUT_PHASES_VAL[i] = #(vco_clk_pulse / (1 << CLKOUT_PHASE_BITS)) CLKOUT_PHASES[CLKOUT_PHASE_BITS * (i + 1) - 1-:CLKOUT_PHASE_BITS];
  end
  assign vco_clkout[i] = vco_taps[CLKOUT_PHASES_VAL[i]];
end
endgenerate

function is_equal(input real n1, input real n2);
begin
  is_equal = (n1 < n2 + epsilon && n2 < n1 + epsilon);
end
endfunction

function real round_number(input real number);
begin
  round_number = $rtoi(number * 100000.0) / 100000.0; // 100000 = 1ns / 10fs
end
endfunction

endmodule

`timescale `PLL_RESOLUTION
module alta_pll_sim #(
  parameter NUM_CLKOUTS       = 4,
            CLKIN_DIV_BITS    = 6,
            CLKFB_DIV_BITS    = 6,
            CLKOUT_DIV_BITS   = 6,
            CLKOUT_DEL_BITS   = 6,
            CLKOUT_PHASE_BITS = 3) (
  input  clkin, clkfb,
  input  pllen, resetn, pfden,
  input  [NUM_CLKOUTS-1:0] clkouten,
  output [NUM_CLKOUTS-1:0] clkout,
  output reg lock,
  input [clogb2(NUM_CLKOUTS)-1:0] FEEDBACK_CLOCK,
  input FEEDBACK_MODE,
  input [CLKIN_DIV_BITS-1:0] CLKIN_DIV,
  input [CLKFB_DIV_BITS-1:0] CLKFB_DIV,
  input [NUM_CLKOUTS-1:0] CLKDIV_EN,
  input [CLKOUT_DIV_BITS*NUM_CLKOUTS-1:0] CLKOUT_DIVS,
  input [CLKOUT_DEL_BITS*NUM_CLKOUTS-1:0] CLKOUT_DELS,
  input [CLKOUT_PHASE_BITS*NUM_CLKOUTS-1:0] CLKOUT_PHASES
);

wire [NUM_CLKOUTS-1:0] vco_clkout;
reg [CLKFB_DIV_BITS+CLKOUT_DIV_BITS-1:0] TOTAL_FBDIV;
wire clkfb_in = FEEDBACK_MODE ? clkfb : clkout[FEEDBACK_CLOCK];

always @(CLKFB_DIV or CLKOUT_DIVS or FEEDBACK_CLOCK) begin
  TOTAL_FBDIV = (CLKFB_DIV + 1) * (CLKOUT_DIV_VAL(FEEDBACK_CLOCK) + 1);
end

pll_clk_div #(
  .DIV_BITS(CLKIN_DIV_BITS),
  .DEL_BITS(1)
) clkin_div_inst (
  .clkin(clkin),
  .rst(!resetn),
  .ena(1'b1),
  .clkout(pfd_clkin),
  .CLKDIV_EN(1'b1),
  .CLK_DIV(CLKIN_DIV),
  .CLK_DEL(1'b0)
);

pll_clk_div #(
  .DIV_BITS(CLKFB_DIV_BITS),
  .DEL_BITS(1)
) clkfb_div_inst (
  .clkin(clkfb_in),
  .rst(!resetn),
  .ena(1'b1),
  .clkout(pfd_clkfb),
  .CLKDIV_EN(1'b1),
  .CLK_DIV(CLKFB_DIV),
  .CLK_DEL(1'b0)
);

generate
genvar i;
for (i = 0; i < NUM_CLKOUTS; i = i + 1) begin
  pll_clk_div #(
    .DIV_BITS(CLKOUT_DIV_BITS),
    .DEL_BITS(CLKOUT_DEL_BITS)
  ) clkout_div_inst (
    .clkin(vco_clkout[i]),
    .rst(!resetn),
    .ena(clkouten[i]),
    .clkout(clkout[i]),
    .CLKDIV_EN(CLKDIV_EN[i]),
    .CLK_DIV(CLKOUT_DIVS[CLKOUT_DIV_BITS*(i + 1) - 1 -:CLKOUT_DIV_BITS]),
    .CLK_DEL(CLKOUT_DELS[CLKOUT_DEL_BITS*(i + 1) - 1 -:CLKOUT_DEL_BITS])
  );
end
endgenerate

alta_pll_core #(
  .NUM_CLKOUTS      (NUM_CLKOUTS      ),
  .TOTAL_FBDIV_BITS (CLKFB_DIV_BITS + CLKOUT_DIV_BITS),
  .CLKOUT_PHASE_BITS(CLKOUT_PHASE_BITS)
) core_inst (
  .pllen        (pllen        ),
  .pfden        (1'b1         ),
  .pfd_clkin    (pfd_clkin    ),
  .pfd_clkfb    (pfd_clkfb    ),
  .vco_clkout   (vco_clkout   ),
  .vco_taps     (             ),
  .lock         (lock_int     ),
  .TOTAL_FBDIV  (TOTAL_FBDIV  ),
  .CLKOUT_PHASES(CLKOUT_PHASES)
);

parameter LOCK_COUNTER_BITS = 7;
reg [LOCK_COUNTER_BITS-1:0] lock_counter = {LOCK_COUNTER_BITS{1'b0}};
always @(posedge pfd_clkfb or negedge resetn or negedge lock_int) begin
  if (!resetn || !lock_int) begin
    lock <= 1'b0;
    lock_counter <= {LOCK_COUNTER_BITS{1'b0}};
  end else if (lock_counter == {LOCK_COUNTER_BITS{1'b1}}) begin
    lock <= 1'b1;
  end else if (!lock) begin
    lock_counter <= lock_counter + 1;
  end
end

function integer clogb2(input integer n);
begin
  clogb2 = 0;
  n = n - 1;
  while (n != 0) begin
    clogb2 = clogb2 + 1;
    n = n >> 1;
  end
end
endfunction

function [CLKOUT_DIV_BITS-1:0] CLKOUT_DIV_VAL(input integer clk_id);
begin
  CLKOUT_DIV_VAL = CLKOUT_DIVS[CLKOUT_DIV_BITS * (clk_id + 1) - 1-:CLKOUT_DIV_BITS];
end
endfunction

endmodule

module pll_clk_div_hl #(parameter DIV_BITS = 8, DEL_BITS = 8) (
  input clkin, rst, ena,
  input CLKDIV_EN,
  input [DIV_BITS-1:0] CLK_DIV_H, CLK_DIV_L,
  input [DEL_BITS-1:0] CLK_DEL,
  output clkout, bypass_clk
);
reg clk = 1'b0;
reg [DIV_BITS-1:0] divcnt_h = 0;
reg [DIV_BITS-1:0] divcnt_l = 0;
reg [DEL_BITS-1:0] dlycnt   = 0;
reg rst_sync1 = 1'b0;
reg rst_sync2 = 1'b0;
reg divcnt_en = 1'b0, divcnt_en_dly = 1'b0;

reg clk_ena = 1'b0;
always @(*) begin
  if (rst) begin
    clk_ena <= 1'b0;
  end else if (!clk) begin
    clk_ena <= ena;
  end
end
assign clkout = clk & clk_ena;
assign bypass_clk = clkin;

wire rstn = !rst && CLKDIV_EN;

always@(posedge clkin or negedge rstn) begin
  if(!rstn) begin
    rst_sync1 <= 0;
    rst_sync2 <= 0;
  end else begin
    rst_sync1 <= 1;
    rst_sync2 <= rst_sync1;
  end
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    dlycnt <= 0;
  else if(!divcnt_en)
    dlycnt <= dlycnt + 1;
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt_en <= 0;
  else if(dlycnt == CLK_DEL)
    divcnt_en <= 1;
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt_en_dly <= 0;
  else
    divcnt_en_dly <= divcnt_en;
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt_h <= 0;
  else if(divcnt_h == CLK_DIV_H)
    divcnt_h <= 0;
  else if(clk && divcnt_en_dly)
    divcnt_h <= divcnt_h + 1;
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    divcnt_l <= 0;
  else if(divcnt_l == CLK_DIV_L)
    divcnt_l <= 0;
  else if(!clk && divcnt_en_dly)
    divcnt_l <= divcnt_l + 1;
end

always@(posedge clkin or negedge rst_sync2) begin
  if (!rst_sync2)
    clk <= 0;
  else if(divcnt_en && !divcnt_en_dly)
    clk <= 1;
  else if((divcnt_l == CLK_DIV_L) && !clk && divcnt_en_dly)
    clk <= 1;
  else if((divcnt_h == CLK_DIV_H) && clk && divcnt_en_dly)
    clk <= 0;
end
endmodule

module alta_pll_sim_v #(
  parameter NUM_CLKOUTS       = 5,
            CLKIN_DIV_BITS    = 9,
            CLKFB_DIV_BITS    = 9,
            CLKFB_DEL_BITS    = 8,
            CLKOUT_DIV_BITS   = 8,
            CLKOUT_DEL_BITS   = 8,
            CLKOUT_PHASE_BITS = 3) (
  input  clkin, clkfb,
  input  pllen, resetn,
  input  [NUM_CLKOUTS-1:0] clkouten,
  output [NUM_CLKOUTS-1:0] clkout,
  output clkfbout,
  output reg lock,
  input [2:0] FEEDBACK_MODE,
  input [CLKIN_DIV_BITS-1:0] CLKIN_DIV,
  input [CLKFB_DIV_BITS-1:0] CLKFB_DIV,
  input [CLKFB_DEL_BITS-1:0] CLKFB_DEL,
  input CLKFB_TRIM,
  input [CLKOUT_PHASE_BITS-1:0] CLKFB_PHASE,
  input [NUM_CLKOUTS-1:0] CLKDIV_EN,
  input [CLKOUT_DIV_BITS*NUM_CLKOUTS-1:0] CLKOUT_DIVS_H,
  input [CLKOUT_DIV_BITS*NUM_CLKOUTS-1:0] CLKOUT_DIVS_L,
  input [CLKOUT_DEL_BITS*NUM_CLKOUTS-1:0] CLKOUT_DELS,
  input [NUM_CLKOUTS-1:0] CLKOUT_TRIM,
  input [NUM_CLKOUTS-1:0] CLKOUT_BYPASS,
  input [NUM_CLKOUTS-1:0] CLKOUT_CASCADE,
  input [CLKOUT_PHASE_BITS*NUM_CLKOUTS-1:0] CLKOUT_PHASES
);

wire [NUM_CLKOUTS:0] vco_clkout;
wire [CLKFB_DIV_BITS:0] TOTAL_FBDIV = CLKFB_DIV + 1;
wire pfd_clkfb = (FEEDBACK_MODE == 3'b001 || FEEDBACK_MODE == 3'b111) ? 1'bx : (FEEDBACK_MODE == 3'b010) ? clkfbout : clkfb;

wire [7:0] CLKIN_DIV_H = (CLKIN_DIV == 0) ? 8'h00 :CLKIN_DIV[8:1];
wire [7:0] CLKIN_DIV_L = (CLKIN_DIV == 0) ? 8'h00 :CLKIN_DIV[8:1] - !CLKIN_DIV[0];
pll_clk_div_hl #(
  .DIV_BITS(CLKIN_DIV_BITS-1),
  .DEL_BITS(1)
) clkin_div_inst (
  .clkin(clkin),
  .rst(!resetn),
  .ena(1'b1),
  .clkout(div_clkin),
  .bypass_clk(bypass_clkin),
  .CLKDIV_EN(1'b1),
  .CLK_DIV_H(CLKIN_DIV_H),
  .CLK_DIV_L(CLKIN_DIV_L),
  .CLK_DEL(1'b0)
);
wire pfd_clkin = (|CLKIN_DIV == 0) ? bypass_clkin : div_clkin;

wire [7:0] CLKFB_DIV_H = (CLKFB_DIV == 0) ? 8'h00 :CLKFB_DIV[8:1];
wire [7:0] CLKFB_DIV_L = (CLKFB_DIV == 0) ? 8'h00 :CLKFB_DIV[8:1] - !CLKFB_DIV[0];
pll_clk_div_hl #(
  .DIV_BITS(CLKFB_DIV_BITS-1),
  .DEL_BITS(CLKFB_DEL_BITS)
) clkfb_div_inst (
  .clkin(vco_clkout[NUM_CLKOUTS]),
  .rst(!resetn),
  .ena(1'b1),
  .clkout(clkfbout_div),
  .bypass_clk(bypass_clkfb),
  .CLKDIV_EN(1'b1),
  .CLK_DIV_H(CLKFB_DIV_H),
  .CLK_DIV_L(CLKFB_DIV_L),
  .CLK_DEL(CLKFB_DEL)
);

pll_clk_trim clkfb_trim_inst(
  .clkin(bypass_clkfb),
  .divclk(clkfbout_div),
  .TRIM(CLKFB_TRIM),
  .BYPASS(1'b0),
  .CFG_EN(1'b1),
  .clkout(clkfbout)
);

wire [NUM_CLKOUTS-1:0] div_clk, bypass_clk, mux_clk;
generate
genvar i;
for (i = 0; i < NUM_CLKOUTS; i = i + 1) begin
  if (i == 0) begin
    assign mux_clk[i] = vco_clkout[i];
  end else begin
    assign mux_clk[i] = CLKOUT_CASCADE[i] ? clkout[i-1] : vco_clkout[i];
  end
  pll_clk_div_hl #(
    .DIV_BITS(CLKOUT_DIV_BITS),
    .DEL_BITS(CLKOUT_DEL_BITS)
  ) clkout_div_inst (
    .clkin(mux_clk[i]),
    .rst(!resetn),
    .ena(clkouten[i]),
    .clkout(div_clk[i]),
    .bypass_clk(bypass_clk[i]),
    .CLKDIV_EN(CLKDIV_EN[i]),
    .CLK_DIV_H(CLKOUT_DIVS_H[CLKOUT_DIV_BITS*(i + 1) - 1 -:CLKOUT_DIV_BITS]),
    .CLK_DIV_L(CLKOUT_DIVS_L[CLKOUT_DIV_BITS*(i + 1) - 1 -:CLKOUT_DIV_BITS]),
    .CLK_DEL(CLKOUT_DELS[CLKOUT_DEL_BITS*(i + 1) - 1 -:CLKOUT_DEL_BITS])
  );
  pll_clk_trim clkout_trim_inst(
    .clkin(bypass_clk[i]),
    .divclk(div_clk[i]),
    .TRIM(CLKOUT_TRIM[i]),
    .BYPASS(CLKOUT_BYPASS[i]),
    .CFG_EN(1'b1),
    .clkout(clkout[i])
  );
end
endgenerate

alta_pll_core #(
  .NUM_CLKOUTS      (NUM_CLKOUTS+1    ),
  .TOTAL_FBDIV_BITS (CLKFB_DIV_BITS+1 ),
  .CLKOUT_PHASE_BITS(CLKOUT_PHASE_BITS)
) core_inst (
  .pllen        (pllen        ),
  .pfden        (1'b1         ),
  .pfd_clkin    (pfd_clkin    ),
  .pfd_clkfb    (pfd_clkfb    ),
  .vco_clkout   (vco_clkout   ),
  .vco_taps     (             ),
  .lock         (lock_int     ),
  .TOTAL_FBDIV  (TOTAL_FBDIV  ),
  .CLKOUT_PHASES({CLKFB_PHASE, CLKOUT_PHASES})
);

parameter LOCK_COUNTER_BITS = 7;
reg [LOCK_COUNTER_BITS-1:0] lock_counter = {LOCK_COUNTER_BITS{1'b0}};
always @(posedge pfd_clkfb or negedge resetn or negedge lock_int) begin
  if (!resetn || !lock_int) begin
    lock <= 1'b0;
    lock_counter <= {LOCK_COUNTER_BITS{1'b0}};
  end else if (lock_counter == {LOCK_COUNTER_BITS{1'b1}}) begin
    lock <= 1'b1;
  end else if (!lock) begin
    lock_counter <= lock_counter + 1;
  end
end

endmodule

module pll_clk_div_hl_ve #(parameter DIV_BITS = 8, DEL_BITS = 8) (
  input clkin, rst,
  input CLKDIV_EN,
  input [DIV_BITS-1:0] CLK_DIV_H, CLK_DIV_L,
  input [DEL_BITS-1:0] CLK_DEL,
  output clkout, bypass_clk
);
reg clk = 1'b0;
reg [DIV_BITS-1:0] divcnt_h = 0;
reg [DIV_BITS-1:0] divcnt_l = 0;
reg [DEL_BITS-1:0] dlycnt   = 0;
reg divcnt_en = 1'b0, divcnt_en_dly = 1'b0;

assign clkout     = clk;
assign bypass_clk = clkin;
wire rstn         = !rst & CLKDIV_EN;

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    dlycnt <= 0;
  else if(!divcnt_en)
    dlycnt <= dlycnt + 1;
end

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    divcnt_en <= 0;
  else if(dlycnt == CLK_DEL)
    divcnt_en <= 1;
end

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    divcnt_en_dly <= 0;
  else
    divcnt_en_dly <= divcnt_en;
end

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    divcnt_h <= 0;
  else if(divcnt_h == CLK_DIV_H)
    divcnt_h <= 0;
  else if(clk && divcnt_en_dly)
    divcnt_h <= divcnt_h + 1;
end

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    divcnt_l <= 0;
  else if(divcnt_l == CLK_DIV_L)
    divcnt_l <= 0;
  else if(!clk && divcnt_en_dly)
    divcnt_l <= divcnt_l + 1;
end

always@(posedge clkin or negedge rstn) begin
  if (!rstn)
    clk <= 0;
  else if(divcnt_en && !divcnt_en_dly)
    clk <= 1;
  else if((divcnt_l == CLK_DIV_L) && !clk && divcnt_en_dly)
    clk <= 1;
  else if((divcnt_h == CLK_DIV_H) && clk && divcnt_en_dly)
    clk <= 0;
end
endmodule

module alta_pll_sim_ve #(
  parameter NUM_CLKOUTS       = 5,
            CLKFB_DEL_BITS    = 8,
            CLKOUT_DIV_BITS   = 8,
            CLKOUT_DEL_BITS   = 8,
            CLKOUT_PHASE_BITS = 3) (
  input  clkin, clkfb,
  input  pfden, resetn,
  input  [2:0] phasecounterselect,
  input  phaseupdown, phasestep, scanclk,
  output phasedone,
  output [NUM_CLKOUTS-1:0] clkout,
  output clkfbout,
  output reg lock,
  input [2:0] FEEDBACK_MODE,
  input VCO_POST_DIV,
  input [CLKOUT_DIV_BITS-1:0] CLKIN_DIV_H, CLKIN_DIV_L,
  input [CLKOUT_DIV_BITS-1:0] CLKFB_DIV_H, CLKFB_DIV_L,
  input CLKIN_BYPASS, CLKFB_BYPASS,
  input [CLKFB_DEL_BITS-1:0] CLKFB_DEL,
  input CLKFB_TRIM,
  input [CLKOUT_PHASE_BITS-1:0] CLKFB_PHASE,
  input [NUM_CLKOUTS-1:0] CLKDIV_EN,
  input [CLKOUT_DIV_BITS*NUM_CLKOUTS-1:0] CLKOUT_DIVS_H,
  input [CLKOUT_DIV_BITS*NUM_CLKOUTS-1:0] CLKOUT_DIVS_L,
  input [CLKOUT_DEL_BITS*NUM_CLKOUTS-1:0] CLKOUT_DELS,
  input [NUM_CLKOUTS-1:0] CLKOUT_TRIM,
  input [NUM_CLKOUTS-1:0] CLKOUT_BYPASS,
  input [NUM_CLKOUTS-1:0] CLKOUT_CASCADE,
  input [CLKOUT_PHASE_BITS*NUM_CLKOUTS-1:0] CLKOUT_PHASES
);

wire [NUM_CLKOUTS:0] vco_clkout;
wire [CLKOUT_DIV_BITS:0] TOTAL_FBDIV = CLKFB_BYPASS ? 1 : (CLKFB_DIV_H + CLKFB_DIV_L + 2);
wire pfd_clkfb = (FEEDBACK_MODE == 3'b001 || FEEDBACK_MODE == 3'b111) ? 1'bx : (FEEDBACK_MODE == 3'b010) ? clkfbout : clkfb;

pll_clk_div_hl_ve #(
  .DIV_BITS(CLKOUT_DIV_BITS),
  .DEL_BITS(1)
) clkin_div_inst (
  .clkin(clkin),
  .rst(!resetn),
  .clkout(div_clkin),
  .bypass_clk(bypass_clkin),
  .CLKDIV_EN(1'b1),
  .CLK_DIV_H(CLKIN_DIV_H),
  .CLK_DIV_L(CLKIN_DIV_L),
  .CLK_DEL(1'b0)
);
wire pfd_clkin = CLKIN_BYPASS ? bypass_clkin : div_clkin;

pll_clk_div_hl_ve #(
  .DIV_BITS(CLKOUT_DIV_BITS),
  .DEL_BITS(CLKFB_DEL_BITS)
) clkfb_div_inst (
  .clkin(vco_clkout[NUM_CLKOUTS]),
  .rst(!resetn),
  .clkout(clkfbout_div),
  .bypass_clk(bypass_clkfb),
  .CLKDIV_EN(1'b1),
  .CLK_DIV_H(CLKFB_DIV_H),
  .CLK_DIV_L(CLKFB_DIV_L),
  .CLK_DEL(CLKFB_DEL)
);

pll_clk_trim clkfb_trim_inst(
  .clkin(bypass_clkfb),
  .divclk(clkfbout_div),
  .TRIM(CLKFB_TRIM),
  .BYPASS(1'b0),
  .CFG_EN(1'b1),
  .clkout(clkfbout)
);

wire [NUM_CLKOUTS-1:0] div_clk, bypass_clk, mux_clk;
generate
genvar i;
for (i = 0; i < NUM_CLKOUTS; i = i + 1) begin
  if (i == 0) begin
    assign mux_clk[i] = vco_clkout[i];
  end else begin
    assign mux_clk[i] = CLKOUT_CASCADE[i] ? clkout[i-1] : vco_clkout[i];
  end
  pll_clk_div_hl_ve #(
    .DIV_BITS(CLKOUT_DIV_BITS),
    .DEL_BITS(CLKOUT_DEL_BITS)
  ) clkout_div_inst (
    .clkin(mux_clk[i]),
    .rst(!resetn),
    .clkout(div_clk[i]),
    .bypass_clk(bypass_clk[i]),
    .CLKDIV_EN(CLKDIV_EN[i]),
    .CLK_DIV_H(CLKOUT_DIVS_H[CLKOUT_DIV_BITS*(i + 1) - 1 -:CLKOUT_DIV_BITS]),
    .CLK_DIV_L(CLKOUT_DIVS_L[CLKOUT_DIV_BITS*(i + 1) - 1 -:CLKOUT_DIV_BITS]),
    .CLK_DEL(CLKOUT_DELS[CLKOUT_DEL_BITS*(i + 1) - 1 -:CLKOUT_DEL_BITS])
  );
  pll_clk_trim clkout_trim_inst(
    .clkin(bypass_clk[i]),
    .divclk(div_clk[i]),
    .TRIM(CLKOUT_TRIM[i]),
    .BYPASS(CLKOUT_BYPASS[i]),
    .CFG_EN(CLKDIV_EN[i]),
    .clkout(clkout[i])
  );
end
endgenerate

reg [NUM_CLKOUTS:0] phase_counter_en = {(NUM_CLKOUTS+1){1'b0}};
reg phase_shift_dir = 1'b0, phase_update = 1'b0;
reg phase_shift_en0 = 1'b0, phase_shift_en1 = 1'b0, phase_shift_en2 = 1'b0;

always @ (negedge scanclk or negedge resetn) begin
  if (!resetn) begin
    phase_shift_en0 <= 1'b0;
    phase_shift_en1 <= 1'b0;
    phase_shift_en2 <= 1'b0;
  end else begin
    phase_shift_en0 <= phasestep;
    phase_shift_en1 <= phase_shift_en0;
    phase_shift_en2 <= phase_shift_en1;
  end
end

always @ (posedge scanclk or negedge resetn) begin
  if (!resetn) begin
    phase_shift_dir  <= 1'b0;
    phase_update     <= 1'b0;
    phase_counter_en <= {(NUM_CLKOUTS+1){1'b0}};
  end else if (phase_shift_en1 & !phase_shift_en2) begin
    phase_shift_dir <= phaseupdown;
    if (phasecounterselect != 3'b111) begin
      phase_update <= 1'b1;
      case (phasecounterselect)
        3'b000:  phase_counter_en <= {1'b0, {NUM_CLKOUTS{1'b1}}};   // All output counters
        3'b001:  phase_counter_en <= {1'b1, {NUM_CLKOUTS{1'b0}}};   // Feedback counter
        default: phase_counter_en <= (1 << phasecounterselect - 2); // Specific counter
      endcase
    end
  end else if (phase_shift_en2) begin
    phase_counter_en <= {(NUM_CLKOUTS+1){1'b0}};
  end
end

wire [CLKOUT_PHASE_BITS*(NUM_CLKOUTS+1)-1:0] CLKOUT_PHASES_ALL = {CLKFB_PHASE, CLKOUT_PHASES};
wire [CLKOUT_PHASE_BITS*(NUM_CLKOUTS+1)-1:0] CLKOUT_PHASES_CNT;
reg [CLKOUT_PHASE_BITS*(NUM_CLKOUTS+1)-1:0] CLKOUT_PHASES_REG = 0;
reg [CLKOUT_PHASE_BITS*(NUM_CLKOUTS+1)-1:0] CLKOUT_PHASES_INT = 0;

generate
genvar j;
for (j = 0; j <= NUM_CLKOUTS; j = j + 1) begin : PHASE_SHIFT
  assign CLKOUT_PHASES_CNT[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] = CLKOUT_PHASES_REG[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] + (phase_shift_dir ? 1 : -1);
  always @ (posedge scanclk or negedge resetn) begin
    if (!resetn) begin
      #0.001 CLKOUT_PHASES_REG[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] <= CLKOUT_PHASES_ALL[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j];
    end else if (phase_counter_en[j]) begin
      CLKOUT_PHASES_REG[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] <= CLKOUT_PHASES_CNT[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j];
    end
  end
  always @ (negedge vco_clkout[j] or negedge resetn) begin
    if (!resetn) begin
      #0.001 CLKOUT_PHASES_INT[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] <= CLKOUT_PHASES_ALL[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j];
    end else if (phase_counter_en[j] & !scanclk) begin
      CLKOUT_PHASES_INT[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j] <= CLKOUT_PHASES_CNT[CLKOUT_PHASE_BITS*(j+1)-1:CLKOUT_PHASE_BITS*j];
      phase_update <= 1'b0;
    end
  end
end
endgenerate

assign phasedone = !phase_update;

alta_pll_core #(
  .NUM_CLKOUTS      (NUM_CLKOUTS+1    ),
  .TOTAL_FBDIV_BITS (CLKOUT_DIV_BITS+1),
  .CLKOUT_PHASE_BITS(CLKOUT_PHASE_BITS)
) core_inst (
  .pllen        (resetn       ),
  .pfden        (pfden        ),
  .pfd_clkin    (pfd_clkin    ),
  .pfd_clkfb    (pfd_clkfb    ),
  .vco_clkout   (vco_clkout   ),
  .vco_taps     (             ),
  .lock         (lock_int     ),
  .TOTAL_FBDIV  (TOTAL_FBDIV  ), // Regardless of VCO_POST_DIV
  .CLKOUT_PHASES(CLKOUT_PHASES_INT)
);

parameter LOCK_COUNTER_BITS = 7;
reg [LOCK_COUNTER_BITS-1:0] lock_counter = {LOCK_COUNTER_BITS{1'b0}};
always @(posedge pfd_clkfb or negedge resetn or negedge lock_int) begin
  if (!resetn || !lock_int) begin
    lock <= 1'b0;
    lock_counter <= {LOCK_COUNTER_BITS{1'b0}};
  end else if (lock_counter == {LOCK_COUNTER_BITS{1'b1}}) begin
    lock <= 1'b1;
  end else if (!lock) begin
    lock_counter <= lock_counter + 1;
  end
end

endmodule
`endif

module pll_clk_trim (
  input  clkin, divclk,
  input  TRIM, BYPASS, CFG_EN,
  output clkout
);
reg trim_clk = 1'b1;
always @ (clkin or divclk) begin
  if (!clkin ^ divclk) begin
    trim_clk = clkin;
  end
end
assign clkout = BYPASS ? (clkin & CFG_EN) : TRIM ? trim_clk : divclk;
endmodule

module alta_pllv (
  input  clkin, clkfb,
  input  pllen, resetn,
  input  clkout0en, clkout1en, clkout2en, clkout3en, clkout4en,
  output clkout0, clkout1, clkout2, clkout3, clkout4,
  output clkfbout, lock
) /* synthesis syn_black_box */;
parameter coord_x         = 0;
parameter coord_y         = 0;
parameter coord_z         = 0;
parameter CLKIN_FREQ      = "20.0";
parameter CLKIN_DIV       = 9'b0;
parameter CLKFB_DIV       = 9'b0;
parameter CLKDIV0_EN      = 1'b0;
parameter CLKDIV1_EN      = 1'b0;
parameter CLKDIV2_EN      = 1'b0;
parameter CLKDIV3_EN      = 1'b0;
parameter CLKDIV4_EN      = 1'b0;
parameter CLKOUT0_HIGH    = 8'b0;
parameter CLKOUT0_LOW     = 8'b0;
parameter CLKOUT0_TRIM    = 1'b0;
parameter CLKOUT0_BYPASS  = 1'b0;
parameter CLKOUT1_HIGH    = 8'b0;
parameter CLKOUT1_LOW     = 8'b0;
parameter CLKOUT1_TRIM    = 1'b0;
parameter CLKOUT1_BYPASS  = 1'b0;
parameter CLKOUT2_HIGH    = 8'b0;
parameter CLKOUT2_LOW     = 8'b0;
parameter CLKOUT2_TRIM    = 1'b0;
parameter CLKOUT2_BYPASS  = 1'b0;
parameter CLKOUT3_HIGH    = 8'b0;
parameter CLKOUT3_LOW     = 8'b0;
parameter CLKOUT3_TRIM    = 1'b0;
parameter CLKOUT3_BYPASS  = 1'b0;
parameter CLKOUT4_HIGH    = 8'b0;
parameter CLKOUT4_LOW     = 8'b0;
parameter CLKOUT4_TRIM    = 1'b0;
parameter CLKOUT4_BYPASS  = 1'b0;
parameter CLKOUT0_DEL     = 8'b0;
parameter CLKOUT1_DEL     = 8'b0;
parameter CLKOUT2_DEL     = 8'b0;
parameter CLKOUT3_DEL     = 8'b0;
parameter CLKOUT4_DEL     = 8'b0;
parameter CLKOUT0_PHASE   = 3'b0;
parameter CLKOUT1_PHASE   = 3'b0;
parameter CLKOUT2_PHASE   = 3'b0;
parameter CLKOUT3_PHASE   = 3'b0;
parameter CLKOUT4_PHASE   = 3'b0;
parameter CLKFB_DEL       = 8'b0;
parameter CLKFB_PHASE     = 3'b0;
parameter CLKFB_TRIM      = 1'b0;
parameter FEEDBACK_MODE   = 3'b0;
parameter FBDELAY_VAL     = 3'b0;
parameter PLLOUTP_EN      = 1'b0;
parameter PLLOUTN_EN      = 1'b0;
parameter CLKOUT1_CASCADE = 1'b0;
parameter CLKOUT2_CASCADE = 1'b0;
parameter CLKOUT3_CASCADE = 1'b0;
parameter CLKOUT4_CASCADE = 1'b0;
parameter CP              = 3'b111;
parameter RREF            = 2'b00;
parameter RVI             = 2'b00;
`ifdef ALTA_SIM
  alta_pll_sim_v #(
    .NUM_CLKOUTS      (5),
    .CLKIN_DIV_BITS   (9),
    .CLKFB_DIV_BITS   (9),
    .CLKOUT_DIV_BITS  (8),
    .CLKOUT_DEL_BITS  (8),
    .CLKOUT_PHASE_BITS(3)
  ) sim_inst (
    .clkin        (clkin                                                  ),
    .clkfb        (clkfb                                                  ),
    .clkfbout     (clkfbout                                               ),
    .pllen        (pllen                                                  ),
    .resetn       (resetn                                                 ),
    .clkout       ({clkout4  , clkout3  , clkout2  , clkout1  , clkout0  }),
    .clkouten     ({clkout4en, clkout3en, clkout2en, clkout1en, clkout0en}),
    .lock         (lock                                                   ),
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .CLKIN_DIV  (CLKIN_DIV  ),
    .CLKFB_DIV  (CLKFB_DIV  ),
    .CLKFB_DEL  (CLKFB_DEL  ),
    .CLKFB_TRIM (CLKFB_TRIM ),
    .CLKFB_PHASE(CLKFB_PHASE),
    .CLKDIV_EN     ({CLKDIV4_EN     , CLKDIV3_EN     , CLKDIV2_EN     , CLKDIV1_EN     , CLKDIV0_EN    }),
    .CLKOUT_DIVS_H ({CLKOUT4_HIGH   , CLKOUT3_HIGH   , CLKOUT2_HIGH   , CLKOUT1_HIGH   , CLKOUT0_HIGH  }),
    .CLKOUT_DIVS_L ({CLKOUT4_LOW    , CLKOUT3_LOW    , CLKOUT2_LOW    , CLKOUT1_LOW    , CLKOUT0_LOW   }),
    .CLKOUT_DELS   ({CLKOUT4_DEL    , CLKOUT3_DEL    , CLKOUT2_DEL    , CLKOUT1_DEL    , CLKOUT0_DEL   }),
    .CLKOUT_TRIM   ({CLKOUT4_TRIM   , CLKOUT3_TRIM   , CLKOUT2_TRIM   , CLKOUT1_TRIM   , CLKOUT0_TRIM  }),
    .CLKOUT_BYPASS ({CLKOUT4_BYPASS , CLKOUT3_BYPASS , CLKOUT2_BYPASS , CLKOUT1_BYPASS , CLKOUT0_BYPASS}),
    .CLKOUT_CASCADE({CLKOUT4_CASCADE, CLKOUT3_CASCADE, CLKOUT2_CASCADE, CLKOUT1_CASCADE, 1'b0          }),
    .CLKOUT_PHASES ({CLKOUT4_PHASE  , CLKOUT3_PHASE  , CLKOUT2_PHASE  , CLKOUT1_PHASE  , CLKOUT0_PHASE })
  );
`else
  assign clkout0 = clkout0en & clkin;
  assign clkout1 = clkout1en & clkin;
  assign clkout2 = clkout2en & clkin;
  assign clkout3 = clkout3en & clkin;
  assign clkout4 = clkout4en & clkin;
  assign lock    = pllen & resetn & clkfb;
`endif
endmodule

module alta_pllve (
  input  clkin, clkfb,
  input  pfden, resetn,
  input  [2:0] phasecounterselect,
  input  phaseupdown, phasestep,
  input  scanclk, scanclkena, scandata, configupdate,
  output scandataout, scandone, phasedone,
  output clkout0, clkout1, clkout2, clkout3, clkout4,
  output clkfbout, lock
) /* synthesis syn_black_box */;
parameter coord_x         = 0;
parameter coord_y         = 0;
parameter coord_z         = 0;
parameter CLKIN_FREQ      = "20.0";
parameter CLKIN_HIGH      = 8'b0;
parameter CLKIN_LOW       = 8'b0;
parameter CLKIN_BYPASS    = 1'b0;
parameter CLKIN_TRIM      = 1'b0;
parameter CLKFB_HIGH      = 8'b0;
parameter CLKFB_LOW       = 8'b0;
parameter CLKFB_BYPASS    = 1'b0;
parameter CLKFB_TRIM      = 1'b0;
parameter CLKDIV0_EN      = 1'b0;
parameter CLKDIV1_EN      = 1'b0;
parameter CLKDIV2_EN      = 1'b0;
parameter CLKDIV3_EN      = 1'b0;
parameter CLKDIV4_EN      = 1'b0;
parameter CLKOUT0_HIGH    = 8'b0;
parameter CLKOUT0_LOW     = 8'b0;
parameter CLKOUT0_TRIM    = 1'b0;
parameter CLKOUT0_BYPASS  = 1'b0;
parameter CLKOUT1_HIGH    = 8'b0;
parameter CLKOUT1_LOW     = 8'b0;
parameter CLKOUT1_TRIM    = 1'b0;
parameter CLKOUT1_BYPASS  = 1'b0;
parameter CLKOUT2_HIGH    = 8'b0;
parameter CLKOUT2_LOW     = 8'b0;
parameter CLKOUT2_TRIM    = 1'b0;
parameter CLKOUT2_BYPASS  = 1'b0;
parameter CLKOUT3_HIGH    = 8'b0;
parameter CLKOUT3_LOW     = 8'b0;
parameter CLKOUT3_TRIM    = 1'b0;
parameter CLKOUT3_BYPASS  = 1'b0;
parameter CLKOUT4_HIGH    = 8'b0;
parameter CLKOUT4_LOW     = 8'b0;
parameter CLKOUT4_TRIM    = 1'b0;
parameter CLKOUT4_BYPASS  = 1'b0;
parameter CLKOUT0_DEL     = 8'b0;
parameter CLKOUT1_DEL     = 8'b0;
parameter CLKOUT2_DEL     = 8'b0;
parameter CLKOUT3_DEL     = 8'b0;
parameter CLKOUT4_DEL     = 8'b0;
parameter CLKOUT0_PHASE   = 3'b0;
parameter CLKOUT1_PHASE   = 3'b0;
parameter CLKOUT2_PHASE   = 3'b0;
parameter CLKOUT3_PHASE   = 3'b0;
parameter CLKOUT4_PHASE   = 3'b0;
parameter CLKFB_DEL       = 8'b0;
parameter CLKFB_PHASE     = 3'b0;
parameter FEEDBACK_MODE   = 3'b0;
parameter FBDELAY_VAL     = 3'b0;
parameter PLLOUTP_EN      = 1'b0;
parameter PLLOUTN_EN      = 1'b0;
parameter CLKOUT1_CASCADE = 1'b0;
parameter CLKOUT2_CASCADE = 1'b0;
parameter CLKOUT3_CASCADE = 1'b0;
parameter CLKOUT4_CASCADE = 1'b0;
parameter VCO_POST_DIV    = 1'b0;
parameter REG_CTRL        = 2'b0;
parameter IVCO            = 3'b100;
parameter CP              = 3'b010;
parameter RREF            = 2'b01;
parameter RLPF            = 2'b01;
parameter RVI             = 2'b01;
parameter PLL_EN_FLAG     = 1'b0;

`ifdef ALTA_SIM
parameter [143:0] init_params = { IVCO, RVI, RREF, RLPF,
  VCO_POST_DIV, 5'b0 /* DUMMY */, CP,
  CLKIN_BYPASS,   CLKIN_HIGH,   CLKIN_TRIM,   CLKIN_LOW,
  CLKFB_BYPASS,   CLKFB_HIGH,   CLKFB_TRIM,   CLKFB_LOW,
  CLKOUT0_BYPASS, CLKOUT0_HIGH, CLKOUT0_TRIM, CLKOUT0_LOW,
  CLKOUT1_BYPASS, CLKOUT1_HIGH, CLKOUT1_TRIM, CLKOUT1_LOW,
  CLKOUT2_BYPASS, CLKOUT2_HIGH, CLKOUT2_TRIM, CLKOUT2_LOW,
  CLKOUT3_BYPASS, CLKOUT3_HIGH, CLKOUT3_TRIM, CLKOUT3_LOW,
  CLKOUT4_BYPASS, CLKOUT4_HIGH, CLKOUT4_TRIM, CLKOUT4_LOW};
reg [143:0] shift_reg = init_params;
reg [143:0] param_reg = init_params;
// Reconfigurable parameters
wire       RE_VCO_POST_DIV   = param_reg[134:134];
wire       RE_CLKIN_BYPASS   = param_reg[125:125];
wire [7:0] RE_CLKIN_HIGH     = param_reg[124:117];
wire       RE_CLKIN_TRIM     = param_reg[116:116];
wire [7:0] RE_CLKIN_LOW      = param_reg[115:108];
wire       RE_CLKFB_BYPASS   = param_reg[107:107];
wire [7:0] RE_CLKFB_HIGH     = param_reg[106:99];
wire       RE_CLKFB_TRIM     = param_reg[98:98];
wire [7:0] RE_CLKFB_LOW      = param_reg[97:90];
wire       RE_CLKOUT0_BYPASS = param_reg[89:89];
wire [7:0] RE_CLKOUT0_HIGH   = param_reg[88:81];
wire       RE_CLKOUT0_TRIM   = param_reg[80:80];
wire [7:0] RE_CLKOUT0_LOW    = param_reg[79:72];
wire       RE_CLKOUT1_BYPASS = param_reg[71:71];
wire [7:0] RE_CLKOUT1_HIGH   = param_reg[70:63];
wire       RE_CLKOUT1_TRIM   = param_reg[62:62];
wire [7:0] RE_CLKOUT1_LOW    = param_reg[61:54];
wire       RE_CLKOUT2_BYPASS = param_reg[53:53];
wire [7:0] RE_CLKOUT2_HIGH   = param_reg[52:45];
wire       RE_CLKOUT2_TRIM   = param_reg[44:44];
wire [7:0] RE_CLKOUT2_LOW    = param_reg[43:36];
wire       RE_CLKOUT3_BYPASS = param_reg[35:35];
wire [7:0] RE_CLKOUT3_HIGH   = param_reg[34:27];
wire       RE_CLKOUT3_TRIM   = param_reg[26:26];
wire [7:0] RE_CLKOUT3_LOW    = param_reg[25:18];
wire       RE_CLKOUT4_BYPASS = param_reg[17:17];
wire [7:0] RE_CLKOUT4_HIGH   = param_reg[16:9];
wire       RE_CLKOUT4_TRIM   = param_reg[8:8];
wire [7:0] RE_CLKOUT4_LOW    = param_reg[7:0];

reg scanclkena_reg = 1'b0, datain_reg = 1'b0, dataout_reg = 1'b0;
always @ (negedge scanclk) begin
  scanclkena_reg <= scanclkena;
end
wire scanclk_int = scanclk & scanclkena_reg;
always @ (*) begin
  if (scanclk_int)
    datain_reg <= scandata;
end

reg update_reg0, update_reg1, scandone_reg;
always @ (posedge scanclk) begin
  update_reg0 <= configupdate;
  update_reg1 <= update_reg0;
end
wire scandone_clk = update_reg0 & !update_reg1;
always @ (negedge scandone_clk or negedge resetn) begin
  if (!resetn) begin
    scandone_reg <= 1'b0;
  end else begin
    scandone_reg <= 1'b1;
  end
end
assign scandone = scandone_reg;

always @ (posedge scanclk) begin
  if (scanclkena) begin
    shift_reg <= {datain_reg, shift_reg[143:1]};
  end
  if (configupdate) begin
    param_reg <= shift_reg;
  end
end
wire dataout = shift_reg[0];
always @ (negedge scanclk_int) begin
  dataout_reg <= dataout;
end
assign scandataout = dataout_reg;

  alta_pll_sim_ve #(
    .NUM_CLKOUTS      (5),
    .CLKOUT_DIV_BITS  (8),
    .CLKOUT_DEL_BITS  (8),
    .CLKOUT_PHASE_BITS(3)
  ) sim_inst (
    .clkin             (clkin                                        ),
    .clkfb             (clkfb                                        ),
    .clkfbout          (clkfbout                                     ),
    .pfden             (pfden                                        ),
    .resetn            (resetn                                       ),
    .phasecounterselect(phasecounterselect                           ),
    .phaseupdown       (phaseupdown                                  ),
    .phasestep         (phasestep                                    ),
    .scanclk           (scanclk                                      ),
    .phasedone         (phasedone                                    ),
    .clkout            ({clkout4, clkout3, clkout2, clkout1, clkout0}),
    .lock              (lock                                         ),
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .VCO_POST_DIV(RE_VCO_POST_DIV),
    .CLKIN_DIV_H (RE_CLKIN_HIGH  ),
    .CLKIN_DIV_L (RE_CLKIN_LOW   ),
    .CLKIN_BYPASS(RE_CLKIN_BYPASS),
    .CLKFB_DIV_H (RE_CLKFB_HIGH  ),
    .CLKFB_DIV_L (RE_CLKFB_LOW   ),
    .CLKFB_BYPASS(RE_CLKFB_BYPASS),
    .CLKFB_TRIM  (RE_CLKFB_TRIM  ),
    .CLKFB_DEL   (CLKFB_DEL      ),
    .CLKFB_PHASE (CLKFB_PHASE    ),
    .CLKDIV_EN     ({CLKDIV4_EN       , CLKDIV3_EN       , CLKDIV2_EN       , CLKDIV1_EN       , CLKDIV0_EN       }),
    .CLKOUT_DIVS_H ({RE_CLKOUT4_HIGH  , RE_CLKOUT3_HIGH  , RE_CLKOUT2_HIGH  , RE_CLKOUT1_HIGH  , RE_CLKOUT0_HIGH  }),
    .CLKOUT_DIVS_L ({RE_CLKOUT4_LOW   , RE_CLKOUT3_LOW   , RE_CLKOUT2_LOW   , RE_CLKOUT1_LOW   , RE_CLKOUT0_LOW   }),
    .CLKOUT_TRIM   ({RE_CLKOUT4_TRIM  , RE_CLKOUT3_TRIM  , RE_CLKOUT2_TRIM  , RE_CLKOUT1_TRIM  , RE_CLKOUT0_TRIM  }),
    .CLKOUT_BYPASS ({RE_CLKOUT4_BYPASS, RE_CLKOUT3_BYPASS, RE_CLKOUT2_BYPASS, RE_CLKOUT1_BYPASS, RE_CLKOUT0_BYPASS}),
    .CLKOUT_CASCADE({CLKOUT4_CASCADE  , CLKOUT3_CASCADE  , CLKOUT2_CASCADE  , CLKOUT1_CASCADE  , 1'b0             }),
    .CLKOUT_DELS   ({CLKOUT4_DEL      , CLKOUT3_DEL      , CLKOUT2_DEL      , CLKOUT1_DEL      , CLKOUT0_DEL      }),
    .CLKOUT_PHASES ({CLKOUT4_PHASE    , CLKOUT3_PHASE    , CLKOUT2_PHASE    , CLKOUT1_PHASE    , CLKOUT0_PHASE    })
  );
`else
  assign clkout0 = clkin;
  assign clkout1 = clkin;
  assign clkout2 = clkin;
  assign clkout3 = clkin;
  assign clkout4 = clkin;
  assign lock    = pfden & resetn & clkfb;
`endif
endmodule

`timescale 1ns/10ps
module alta_sram (
  input WEna, WClk,
  input [3:0] Din,
  input [3:0] WAddr,
  input [3:0] RAddr,
  output reg [3:0] Dout
) /* synthesis syn_black_box */;

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter INIT_VAL = 64'h0;

`ifdef ALTA_SIM
  reg [3:0] mem[15:0];
  reg [3:0] init_word;
  integer i, j;

  initial
  begin
     for ( i = 0; i < 16; i = i + 1)
     begin
       for ( j = 0; j < 4; j = j + 1)
         init_word[j] = INIT_VAL[i * 4 + j];
       mem[i] = init_word;
     end
  end

  always @ (RAddr or mem[RAddr])
    Dout = mem[RAddr];

  always @ (posedge WClk)
  begin
    if (WEna)
      mem[WAddr] <= Din;
  end
`endif
endmodule

module alta_dpram16x4 (
  input WEna, WClk,
  input [3:0] Din,
  input [3:0] WAddr,
  input [3:0] RAddr,
  output [3:0] Dout);
alta_sram dpram_inst(
  .WEna (WEna ),
  .WClk (WClk ),
  .Din  (Din  ),
  .WAddr(WAddr),
  .RAddr(RAddr),
  .Dout (Dout )
);
parameter INIT_VAL = 64'h0;
defparam dpram_inst.INIT_VAL = INIT_VAL;
endmodule

module alta_spram16x4 (
  input WEna, WClk,
  input [3:0] Din,
  input [3:0] Addr,
  output [3:0] Dout);
alta_sram spram_inst(
  .WEna (WEna),
  .WClk (WClk),
  .Din  (Din ),
  .WAddr(Addr),
  .RAddr(Addr),
  .Dout (Dout)
);
parameter INIT_VAL = 64'h0;
defparam spram_inst.INIT_VAL = INIT_VAL;
endmodule

module alta_wram (
  input WEna, WClk,
  input [7:0] Din,
  input [3:0] WAddr,
  input [3:0] RAddr,
  output reg [7:0] Dout
) /* synthesis syn_black_box */;

parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter INIT_VAL = 128'h0;

`ifdef ALTA_SIM
  reg [7:0] mem[15:0];
  reg [7:0] init_word;
  integer i, j;

  initial
  begin
     for ( i = 0; i < 16; i = i + 1)
     begin
       for ( j = 0; j < 7; j = j + 1)
         init_word[j] = INIT_VAL[i * 8 + j];
       mem[i] = init_word;
     end
  end

  always @ (RAddr or mem[RAddr])
    Dout = mem[RAddr];

  always @ (posedge WClk)
  begin
    if (WEna)
      mem[WAddr] <= Din;
  end
`endif
endmodule

module alta_bram_pulse_generator #(parameter PULSE_DELAY = 1) (
  input Clk,
  input Ena,
  output reg Pulse
);
parameter PULSE_WIDTH = 1;
wire #(PULSE_DELAY) ClkDel = Clk;
wire #(PULSE_WIDTH) PulseDel = Pulse;
initial Pulse = 1'b0;
always @ (posedge ClkDel or posedge PulseDel) begin
  if (PulseDel)
    Pulse = 1'b0;
  else if (Ena && ClkDel)
    Pulse = 1'b1;
end
endmodule

module alta_bram (
  input  [17:0]  DataInA,  DataInB,
  input  [11:0] AddressA, AddressB,
  output [17:0] DataOutA, DataOutB,
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  WeRenA, WeRenB
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

parameter CLKMODE         = 1'b0; // 0: read/write mode, 1: input/output mode
parameter PORTA_WRITEMODE = 1'b0; // 0: normal, 1: read before write
parameter PORTB_WRITEMODE = 1'b0;
parameter PORTA_WRITETHRU = 1'b0;
parameter PORTB_WRITETHRU = 1'b0;
parameter PORTB_READONLY  = 1'b0;
parameter PORTA_OUTREG    = 1'b0;
parameter PORTB_OUTREG    = 1'b0;
parameter PORTA_WIDTH     = 4'b0;
parameter PORTB_WIDTH     = 4'b0;
parameter INIT_VAL        = 4608'b0;

localparam NORMAL            = 1'b0;
localparam READ_BEFORE_WRITE = 1'b1;

`ifdef ALTA_SIM
reg [17:0] mem [255:0];
reg [17:0] wrDataA, wrDataB, rdDataA, rdDataB;
integer i;

initial begin
  for (i = 0; i < 256; i = i + 1) begin
    mem[i] = INIT_VAL[i*18+17-:18];
  end
  rdDataA = 18'h3FFFF;
  rdDataB = 18'h3FFFF;
end

wire clkInt0, clkInt1;
alta_clkenctrl clkInt0_inst(.ClkIn(Clk0), .ClkEn(ClkEn0), .ClkOut(clkInt0));
alta_clkenctrl clkInt1_inst(.ClkIn(Clk1), .ClkEn(ClkEn1), .ClkOut(clkInt1));
wire clkInA  = CLKMODE ? clkInt0     : clkInt0;
wire clkInB  = CLKMODE ? clkInt0     : clkInt1;
wire clkOutA = CLKMODE ? clkInt1     : clkInt0;
wire clkOutB = CLKMODE ? clkInt1     : clkInt1;
wire rstInA  = CLKMODE ? AsyncReset0 : AsyncReset0;
wire rstInB  = CLKMODE ? AsyncReset0 : AsyncReset1;
wire rstOutA = CLKMODE ? AsyncReset1 : AsyncReset0;
wire rstOutB = CLKMODE ? AsyncReset1 : AsyncReset1;
wire wrClkA  = PORTA_WRITEMODE ? !clkInA : clkInA;
wire wrClkB  = PORTB_WRITEMODE ? !clkInB : clkInB;
wire [17:0] dataInRegA, dataInRegB;
wire [11:0] addrInRegA, addrInRegB;
wire werenRegA, werenRegB;

localparam BUF_DEL = 0;
wire [17:0] #BUF_DEL  DataInA_buf = DataInA;
wire [17:0] #BUF_DEL  DataInB_buf = DataInB;
wire [11:0] #BUF_DEL AddressA_buf = AddressA;
wire [11:0] #BUF_DEL AddressB_buf = AddressB;
wire        #BUF_DEL   WeRenA_buf = WeRenA;
wire        #BUF_DEL   WeRenB_buf = WeRenB;
alta_srff addrInRegA_inst[11:0](.Din(AddressA_buf), .Clk(clkInA), .ClkEn(1'b1), .AsyncReset(rstInA), .AsyncPreset(1'b0), .Q(addrInRegA));
alta_srff addrInRegB_inst[11:0](.Din(AddressB_buf), .Clk(clkInB), .ClkEn(1'b1), .AsyncReset(rstInB), .AsyncPreset(1'b0), .Q(addrInRegB));
alta_srff dataInRegA_inst[17:0](.Din(DataInA_buf),  .Clk(wrClkA), .ClkEn(1'b1), .AsyncReset(rstInA), .AsyncPreset(1'b0), .Q(dataInRegA));
alta_srff dataInRegB_inst[17:0](.Din(DataInB_buf),  .Clk(wrClkB), .ClkEn(1'b1), .AsyncReset(rstInB), .AsyncPreset(1'b0), .Q(dataInRegB));
alta_srff werenRegA_inst       (.Din(WeRenA_buf),   .Clk(clkInA), .ClkEn(1'b1), .AsyncReset(rstInA), .AsyncPreset(1'b0), .Q(werenRegA));
alta_srff werenRegB_inst       (.Din(WeRenB_buf),   .Clk(clkInB), .ClkEn(1'b1), .AsyncReset(rstInB), .AsyncPreset(1'b0), .Q(werenRegB));

// Generate read/write pulse
wire rdPulseA, rdPulseB, wrPulseA, wrPulseB;
alta_bram_pulse_generator genRdPulseA(
  .Clk(clkInA),
  .Ena(PORTA_WRITEMODE === NORMAL && !werenRegA || PORTA_WRITEMODE === READ_BEFORE_WRITE),
  .Pulse(rdPulseA)
);
alta_bram_pulse_generator genWrPulseA(
  .Clk(PORTA_WRITEMODE === NORMAL ? clkInA : !clkInA),
  .Ena(werenRegA),
  .Pulse(wrPulseA)
);
alta_bram_pulse_generator genRdPulseB(
  .Clk(clkInB),
  .Ena(PORTB_READONLY && werenRegB || !PORTB_READONLY && PORTB_WRITEMODE === NORMAL && !werenRegB || !PORTB_READONLY && PORTB_WRITEMODE === READ_BEFORE_WRITE),
  .Pulse(rdPulseB)
);
alta_bram_pulse_generator genWrPulseB(
  .Clk(PORTB_WRITEMODE === NORMAL ? clkInB : !clkInB),
  .Ena(!PORTB_READONLY && werenRegB),
  .Pulse(wrPulseB)
);

wire [7:0] wordAddrA = addrInRegA[11:4];
wire [7:0] wordAddrB = addrInRegB[11:4];
wire [1:0] byteEnA   = addrInRegA[1:0];
wire [1:0] byteEnB   = addrInRegB[1:0];
wire [17:0] maskA = PORTA_WIDTH == 4'b0000 ? { {9{byteEnA[1]}}, {9{byteEnA[0]}} } :
                    PORTA_WIDTH == 4'b1000 ? { {9{byteEnA[1] & addrInRegA[3]}}, {9{byteEnA[0] & !addrInRegA[3]}} } :
                    PORTA_WIDTH == 4'b1100 ? (4'b1111 << addrInRegA[3:2]*4+addrInRegA[3]) :
                    PORTA_WIDTH == 4'b1110 ? (2'b11   << addrInRegA[3:1]*2+addrInRegA[3]) :
                    PORTA_WIDTH == 4'b1111 ? (1'b1    << addrInRegA[3:0]*1+addrInRegA[3]) : 18'b0;
wire [17:0] maskB = PORTB_WIDTH == 4'b0000 ? { {9{byteEnB[1]}}, {9{byteEnB[0]}} } :
                    PORTB_WIDTH == 4'b1000 ? { {9{byteEnB[1] & addrInRegB[3]}}, {9{byteEnB[0] & !addrInRegB[3]}} } :
                    PORTB_WIDTH == 4'b1100 ? (4'b1111 << addrInRegB[3:2]*4+addrInRegB[3]) :
                    PORTB_WIDTH == 4'b1110 ? (2'b11   << addrInRegB[3:1]*2+addrInRegB[3]) :
                    PORTB_WIDTH == 4'b1111 ? (1'b1    << addrInRegB[3:0]*1+addrInRegB[3]) : 18'b0;
always @ (posedge rdPulseA or posedge wrPulseA or posedge rdPulseB or posedge wrPulseB) begin
  if (wrPulseA) begin
    wrDataA = mem[wordAddrA];
    for (i = 0; i < 18; i = i + 1) begin
      if (maskA[i]) begin
        wrDataA[i] = dataInRegA[i];
      end
    end
    mem[wordAddrA] = wrDataA;
    if (PORTA_WRITETHRU) begin
      rdDataA = dataInRegA;
    end
  end
  if (wrPulseB) begin
    wrDataB = mem[wordAddrB];
    for (i = 0; i < 18; i = i + 1) begin
      if (maskB[i]) begin
        wrDataB[i] = dataInRegB[i];
      end
    end
    mem[wordAddrB] = wrDataB;
    if (PORTB_WRITETHRU) begin
      rdDataB = dataInRegB;
    end
  end
  if (rdPulseA) begin
    rdDataA = mem[wordAddrA];
  end
  if (rdPulseB) begin
    rdDataB = mem[wordAddrB];
  end
end

wire [15:0] rdDataA_x16 = { rdDataA[16:9], rdDataA[7:0] };
wire [8:0]  rdDataA_x9  = addrInRegA[3] ? rdDataA[17:9] : rdDataA[8:0];
wire [3:0]  rdDataA_x4  = rdDataA_x16 >> addrInRegA[3:2]*4;
wire [1:0]  rdDataA_x2  = rdDataA_x16 >> addrInRegA[3:1]*2;
wire        rdDataA_x1  = rdDataA_x16 >> addrInRegA[3:0];
wire [17:0] dataOutSelA = PORTA_WIDTH == 4'b0000 ? rdDataA :
                          PORTA_WIDTH == 4'b1000 ? {  1'b1, rdDataA_x9[7:0], 1'b1, rdDataA_x9[8], 7'h7f } :
                          PORTA_WIDTH == 4'b1100 ? { 11'h7FF  , rdDataA_x4, 3'b111 } :
                          PORTA_WIDTH == 4'b1110 ? { 15'h7FFF , rdDataA_x2, 1'b1   } :
                          PORTA_WIDTH == 4'b1111 ? { 17'h1FFFF, rdDataA_x1         } : 18'bx;
wire [15:0] rdDataB_x16 = { rdDataB[16:9], rdDataB[7:0] };
wire [8:0]  rdDataB_x9  = addrInRegB[3] ? rdDataB[17:9] : rdDataB[8:0];
wire [3:0]  rdDataB_x4  = rdDataB_x16 >> addrInRegB[3:2]*4;
wire [1:0]  rdDataB_x2  = rdDataB_x16 >> addrInRegB[3:1]*2;
wire        rdDataB_x1  = rdDataB_x16 >> addrInRegB[3:0];
wire [17:0] dataOutSelB = PORTB_WIDTH == 4'b0000 ? rdDataB :
                          PORTB_WIDTH == 4'b1000 ? {  1'b1, rdDataB_x9[7:0], 1'b1, rdDataB_x9[8], 7'h7f } :
                          PORTB_WIDTH == 4'b1100 ? { 11'h7FF  , rdDataB_x4, 3'b111 } :
                          PORTB_WIDTH == 4'b1110 ? { 15'h7FFF , rdDataB_x2, 1'b1   } :
                          PORTB_WIDTH == 4'b1111 ? { 17'h1FFFF, rdDataB_x1         } : 18'bx;

wire [17:0] dataOutRegA, dataOutRegB;
alta_srff dataOutRegA_inst[17:0](.Din(dataOutSelA),  .Clk(clkOutA), .ClkEn(1'b1), .AsyncReset(rstOutA), .AsyncPreset(1'b0), .Q(dataOutRegA));
alta_srff dataOutRegB_inst[17:0](.Din(dataOutSelB),  .Clk(clkOutB), .ClkEn(1'b1), .AsyncReset(rstOutB), .AsyncPreset(1'b0), .Q(dataOutRegB));
assign DataOutA = PORTA_OUTREG ? dataOutRegA : dataOutSelA;
assign DataOutB = PORTB_OUTREG ? dataOutRegB : dataOutSelB;
`endif

endmodule

module alta_boot (
  input i_boot,
  input [1:0] im_vector_sel,
  input i_osc_enb,
  output o_osc
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifdef ALTA_SIM
`endif
endmodule

`timescale 1ns/10ps
module alta_osc (
  input  i_osc_enb,
  output o_osc
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter OSC_DEL = 20;
`ifdef ALTA_SIM
  reg osc_reg = 1'b0;
  always #OSC_DEL if (i_osc_enb == 1'b0) osc_reg = !osc_reg;
  assign o_osc = osc_reg;
`endif
endmodule

module alta_ufml (
  input  ufm_csn, ufm_sck, ufm_sdi,
  output ufm_sdo
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
endmodule

module alta_jtag (
  input  tdouser,
  output usr1user, runidleuser, updateuser, clkdruser, shiftuser, tdiutap, tckutap, tmsutap
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
endmodule

`ifdef ALTA_SIM
module alta_mult_int #(parameter DATA_WIDTH_A = 9, DATA_WIDTH_B = 9) (
  input [DATA_WIDTH_A-1:0] DataInA,
  input [DATA_WIDTH_B-1:0] DataInB,
  input SignA, SignB, Enable,
  output [DATA_WIDTH_A+DATA_WIDTH_B-1:0] DataOut
);

parameter DATAOUT_WIDTH = DATA_WIDTH_A + DATA_WIDTH_B;

wire [DATA_WIDTH_A-1:0] DataInA_buf = Enable ? DataInA : {DATA_WIDTH_A{1'b0}};
wire [DATA_WIDTH_B-1:0] DataInB_buf = Enable ? DataInB : {DATA_WIDTH_B{1'b0}};

wire isNegDataA = SignA & DataInA_buf[DATA_WIDTH_A-1];
wire isNegDataB = SignB & DataInB_buf[DATA_WIDTH_B-1];
wire [DATAOUT_WIDTH-1:0] DataInA_comp = isNegDataA ? -{ {DATA_WIDTH_B{1'b1}}, DataInA_buf } : DataInA_buf;
wire [DATAOUT_WIDTH-1:0] DataInB_comp = isNegDataB ? -{ {DATA_WIDTH_A{1'b1}}, DataInB_buf } : DataInB_buf;
wire [DATAOUT_WIDTH-1:0] DataOut_comp = DataInA_comp * DataInB_comp;

assign DataOut = (isNegDataA ^ isNegDataB) ? -DataOut_comp : DataOut_comp;

endmodule
`endif

module alta_mult (
  input  Clk, ClkEn, AsyncReset,
  input  SignA, SignB,
  input  [8:0] DataInA0, DataInB0, DataInA1, DataInB1,
  output [17:0] DataOut0, DataOut1
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

parameter MULT_MODE    = 1'b0; // 0: 18x18, 1: 9x9
parameter PORTA_INREG0 = 1'b0;
parameter PORTA_INREG1 = 1'b0;
parameter PORTB_INREG0 = 1'b0;
parameter PORTB_INREG1 = 1'b0;
parameter SIGNA_REG    = 1'b0;
parameter SIGNB_REG    = 1'b0;
parameter OUTREG0      = 1'b0;
parameter OUTREG1      = 1'b0;

`ifdef ALTA_SIM
alta_clkenctrl_rst clkInt_inst(.ClkIn(Clk), .ClkEn(ClkEn), .ClkOut(clkInt), .Rst(AsyncReset));

wire [8:0] dataInRegA0, dataInRegB0, dataInRegA1, dataInRegB1;
alta_dff dataInRegA0_inst[8:0] (.Din(DataInA0), .Clk(clkInt & PORTA_INREG0), .AsyncReset(AsyncReset), .Q(dataInRegA0));
alta_dff dataInRegA1_inst[8:0] (.Din(DataInA1), .Clk(clkInt & PORTA_INREG1), .AsyncReset(AsyncReset), .Q(dataInRegA1));
alta_dff dataInRegB0_inst[8:0] (.Din(DataInB0), .Clk(clkInt & PORTB_INREG0), .AsyncReset(AsyncReset), .Q(dataInRegB0));
alta_dff dataInRegB1_inst[8:0] (.Din(DataInB1), .Clk(clkInt & PORTB_INREG1), .AsyncReset(AsyncReset), .Q(dataInRegB1));
alta_dff signRegA_inst         (.Din(SignA),   .Clk(clkInt & SIGNA_REG), .AsyncReset(AsyncReset), .Q(signRegA));
alta_dff signRegB_inst         (.Din(SignB),   .Clk(clkInt & SIGNB_REG), .AsyncReset(AsyncReset), .Q(signRegB));
wire [17:0] dataInA_int = {PORTA_INREG1 ? dataInRegA1 : DataInA1, PORTA_INREG0 ? dataInRegA0: DataInA0};
wire [17:0] dataInB_int = {PORTB_INREG1 ? dataInRegB1 : DataInB1, PORTB_INREG0 ? dataInRegB0: DataInB0};
wire        signA_int   = SIGNA_REG ? signRegA   : SignA;
wire        signB_int   = SIGNB_REG ? signRegB   : SignB;

wire [17:0] dataOutX9_0, dataOutX9_1;
wire [35:0] dataOutX18;
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_0 (
  .DataInA(dataInA_int[8:0]),
  .DataInB(dataInB_int[8:0]),
  .SignA(signA_int),
  .SignB(signB_int),
  .Enable(MULT_MODE),
  .DataOut(dataOutX9_0)
);
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_1 (
  .DataInA(dataInA_int[17:9]),
  .DataInB(dataInB_int[17:9]),
  .SignA(signA_int),
  .SignB(signB_int),
  .Enable(MULT_MODE),
  .DataOut(dataOutX9_1)
);
alta_mult_int #(.DATA_WIDTH_A(18), .DATA_WIDTH_B(18)) mult18 (
  .DataInA(dataInA_int),
  .DataInB(dataInB_int),
  .SignA(signA_int),
  .SignB(signB_int),
  .Enable(!MULT_MODE),
  .DataOut(dataOutX18)
);

wire [35:0] dataOutInt = MULT_MODE ? { dataOutX9_1, dataOutX9_0 } : dataOutX18;
wire [35:0] dataOutReg;
alta_dff dataOutReg0[17:0] (.Din(dataOutInt[17:0] ), .Clk(clkInt & OUTREG0), .AsyncReset(AsyncReset), .Q(dataOutReg[17:0] ));
alta_dff dataOutReg1[17:0] (.Din(dataOutInt[35:18]), .Clk(clkInt & OUTREG1), .AsyncReset(AsyncReset), .Q(dataOutReg[35:18]));
assign DataOut0 = OUTREG0 ? dataOutReg[17:0]  : dataOutInt[17:0] ;
assign DataOut1 = OUTREG1 ? dataOutReg[35:18] : dataOutInt[35:18];
`endif

endmodule

module alta_dff_en (
  input Din, Clk, AsyncReset, En,
  output Q
);
alta_dff dff_inst (.Din(Din), .Clk(Clk), .AsyncReset(AsyncReset), .Q(dffOut));
assign Q = En ? dffOut : Din;
endmodule

module alta_multm_add (
  input [17:0] DataIn0, DataIn1,
  input [35:0] AccuIn, DataCin,
  input [35:0] MultData0, MultData1, MultData2,
  input Sign, AddSub0, AddSub1, X18Mode, X9Mode,
  input [1:0] AccuMode, // 00: Load, 01: Accu, 10: Cin, 11: Hold
  output [35:0] DataOut
);

wire [35:0] DataIn0_comp = {{18{Sign & DataIn0[17]}}, DataIn0};
wire [35:0] DataIn1_comp = {{18{Sign & DataIn1[17]}}, DataIn1};

wire [35:0] data0 = (X18Mode | X9Mode) ? MultData0 : AccuMode[0] ? AccuIn : AccuMode[1] ? DataCin : 36'b0;
wire [35:0] data1 = X18Mode ? MultData1 : (X9Mode | AccuMode[1]) ? 36'b0 : DataIn0_comp;
wire [35:0] data2 = X18Mode ? MultData2 : (X9Mode | AccuMode[1]) ? 36'b0 : DataIn1_comp;

wire [35:0] data1_int = AddSub0 ? (~data1 + 1) : data1;
wire [35:0] data2_int = AddSub1 ? (~data2 + 1) : data2;

assign DataOut = data0 + data1_int + data2_int;

endmodule

module alta_multm (
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  SignA, SignB, SignW,
  input  InModeA, InModeB, InModeW,
  input  AddSub0, AddSub1,
  input  [1:0] OpMode,
  input  [1:0] OutMode,
  input  [8:0] DataInA0, DataInA1, DataCinA0, DataCinA1,
  input  [8:0] DataInB0, DataInB1, DataCinB0, DataCinB1,
  input  [8:0] DataInW0, DataInW1, DataCinW0, DataCinW1,
  output [8:0] DataCoutA0, DataCoutA1,
  output [8:0] DataCoutB0, DataCoutB1,
  output [8:0] DataCoutW0, DataCoutW1,
  input  [35:0] DataOutCin0, DataOutCin1,
  output [35:0] DataOutCout0, DataOutCout1,
  output [17:0] DataOut0, DataOut1
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

parameter MULT_MODE     = 2'b0; // 0: 18x18, 1: 9x9, 2: 9x9 + accu
parameter PORTA_ASYNC   = 1'b0;
parameter PORTB_ASYNC   = 1'b0;
parameter PORTW_ASYNC   = 1'b0;
parameter SIGNA_ASYNC   = 1'b0;
parameter SIGNB_ASYNC   = 1'b0;
parameter SIGNW_ASYNC   = 1'b0;
parameter ADDSUB0_ASYNC = 1'b0;
parameter ADDSUB1_ASYNC = 1'b0;
parameter OPMODE_ASYNC  = 1'b0;
parameter MULTA_ASYNC   = 1'b0;
parameter MULTB_ASYNC   = 1'b0;
parameter ACCUA_ASYNC   = 1'b0;
parameter ACCUB_ASYNC   = 1'b0;
parameter OUT0_ASYNC    = 1'b0;
parameter OUT1_ASYNC    = 1'b0;
parameter PORTA0_CLK    = 2'b0; // 2'b00: No clock, 2'b01: Clk0, 2'b10, Clk1
parameter PORTA1_CLK    = 2'b0;
parameter PORTB0_CLK    = 2'b0;
parameter PORTB1_CLK    = 2'b0;
parameter PORTW0_CLK    = 2'b0;
parameter PORTW1_CLK    = 2'b0;
parameter SIGNA_CLK     = 2'b0;
parameter SIGNB_CLK     = 2'b0;
parameter SIGNW_CLK     = 2'b0;
parameter ADDSUB0_CLK   = 2'b0;
parameter ADDSUB1_CLK   = 2'b0;
parameter OPMODE_CLK    = 2'b0;
parameter MULTA_CLK     = 2'b0;
parameter MULTB_CLK     = 2'b0;
parameter ACCUA_CLK     = 2'b0;
parameter ACCUB_CLK     = 2'b0;
parameter OUT0_CLK      = 2'b0;
parameter OUT1_CLK      = 2'b0;

`ifdef ALTA_SIM
wire [2:0] clkInt;
assign clkInt[0] = 1'b0;
alta_clkenctrl clkInt0_inst(.ClkIn(Clk0), .ClkEn(ClkEn0), .ClkOut(clkInt[1]));
alta_clkenctrl clkInt1_inst(.ClkIn(Clk1), .ClkEn(ClkEn1), .ClkOut(clkInt[2]));
wire porta0Clk  = clkInt[PORTA0_CLK];
wire porta1Clk  = clkInt[PORTA1_CLK];
wire portb0Clk  = clkInt[PORTB0_CLK];
wire portb1Clk  = clkInt[PORTB1_CLK];
wire portw0Clk  = clkInt[PORTW0_CLK];
wire portw1Clk  = clkInt[PORTW1_CLK];
wire signaClk   = clkInt[SIGNA_CLK];
wire signbClk   = clkInt[SIGNB_CLK];
wire signwClk   = clkInt[SIGNW_CLK];
wire addsub0Clk = clkInt[ADDSUB0_CLK];
wire addsub1Clk = clkInt[ADDSUB1_CLK];
wire opmodeClk  = clkInt[OPMODE_CLK];

wire [1:0] asyncInt = { AsyncReset1, AsyncReset0 };
wire portaAsync   = asyncInt[PORTA_ASYNC];
wire portbAsync   = asyncInt[PORTB_ASYNC];
wire portwAsync   = asyncInt[PORTW_ASYNC];
wire signaAsync   = asyncInt[SIGNA_ASYNC];
wire signbAsync   = asyncInt[SIGNB_ASYNC];
wire signwAsync   = asyncInt[SIGNW_ASYNC];
wire addsub0Async = asyncInt[ADDSUB0_ASYNC];
wire addsub1Async = asyncInt[ADDSUB1_ASYNC];
wire opmodeAsync  = asyncInt[OPMODE_ASYNC];

wire [8:0] dataInA0_int, dataInA1_int, dataInB0_int, dataInB1_int, dataInW0_int, dataInW1_int;
alta_dff_en dataInRegA0[8:0] (.Din(InModeA ? DataCinA0 : DataInA0), .Clk(porta0Clk), .AsyncReset(portaAsync), .En(|PORTA0_CLK), .Q(dataInA0_int));
alta_dff_en dataInRegA1[8:0] (.Din(InModeA ? DataCinA1 : DataInA1), .Clk(porta1Clk), .AsyncReset(portaAsync), .En(|PORTA1_CLK), .Q(dataInA1_int));
alta_dff_en dataInRegB0[8:0] (.Din(InModeB ? DataCinB0 : DataInB0), .Clk(portb0Clk), .AsyncReset(portbAsync), .En(|PORTB0_CLK), .Q(dataInB0_int));
alta_dff_en dataInRegB1[8:0] (.Din(InModeB ? DataCinB1 : DataInB1), .Clk(portb1Clk), .AsyncReset(portbAsync), .En(|PORTB1_CLK), .Q(dataInB1_int));
alta_dff_en dataInRegW0[8:0] (.Din(InModeW ? DataCinW0 : DataInW0), .Clk(portw0Clk), .AsyncReset(portwAsync), .En(|PORTW0_CLK), .Q(dataInW0_int));
alta_dff_en dataInRegW1[8:0] (.Din(InModeW ? DataCinW1 : DataInW1), .Clk(portw1Clk), .AsyncReset(portwAsync), .En(|PORTW1_CLK), .Q(dataInW1_int));
assign DataCoutA0 = dataInA0_int;
assign DataCoutA1 = dataInA1_int;
assign DataCoutB0 = dataInB0_int;
assign DataCoutB1 = dataInB1_int;
assign DataCoutW0 = dataInW0_int;
assign DataCoutW1 = dataInW1_int;

alta_dff_en signRegA (.Din(SignA), .Clk(signaClk), .AsyncReset(signaAsync), .En(|SIGNA_CLK), .Q(signA_int));
alta_dff_en signRegB (.Din(SignB), .Clk(signbClk), .AsyncReset(signbAsync), .En(|SIGNB_CLK), .Q(signB_int));
alta_dff_en signRegW (.Din(SignW), .Clk(signwClk), .AsyncReset(signwAsync), .En(|SIGNW_CLK), .Q(signW_int));

wire x18_mode  = (MULT_MODE == 2'b00);
wire x9_mode   = (MULT_MODE == 2'b01);
wire accu_mode = (MULT_MODE[1] == 1'b1);

wire [1:0] opmode_int;
alta_dff_en addsubRegA0    (.Din(AddSub0), .Clk(addsub0Clk), .AsyncReset(addsub0Async), .En(|ADDSUB0_CLK), .Q(addsubA0_int));
alta_dff_en addsubRegA1    (.Din(AddSub1), .Clk(addsub1Clk), .AsyncReset(addsub1Async), .En(|ADDSUB1_CLK), .Q(addsubA1_int));
alta_dff_en addsubRegB0    (.Din(AddSub0), .Clk(addsub0Clk), .AsyncReset(addsub0Async), .En(|ADDSUB0_CLK), .Q(addsubB0_int));
alta_dff_en addsubRegB1    (.Din(AddSub1), .Clk(addsub1Clk), .AsyncReset(addsub1Async), .En(|ADDSUB1_CLK), .Q(addsubB1_int));
alta_dff_en opmodeReg[1:0] (.Din(OpMode),  .Clk(opmodeClk),  .AsyncReset(opmodeAsync),  .En(|OPMODE_CLK),  .Q(opmode_int));

wire [17:0] multOutX9_A0, multOutX9_A1;
wire [17:0] multOutX9_B0, multOutX9_B1;
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_A0 (
  .DataInA(dataInA0_int),
  .DataInB(dataInW0_int),
  .SignA(signA_int & !x18_mode),
  .SignB(signW_int & !x18_mode),
  .Enable(1'b1),
  .DataOut(multOutX9_A0)
);
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_A1 (
  .DataInA(dataInA1_int),
  .DataInB(dataInW1_int),
  .SignA(signA_int & !x18_mode),
  .SignB(signW_int),
  .Enable(1'b1),
  .DataOut(multOutX9_A1)
);
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_B0 (
  .DataInA(dataInB0_int),
  .DataInB(dataInW0_int),
  .SignA(signB_int),
  .SignB(signW_int & !x18_mode),
  .Enable(1'b1),
  .DataOut(multOutX9_B0)
);
alta_mult_int #(.DATA_WIDTH_A(9), .DATA_WIDTH_B(9)) mult9_B1 (
  .DataInA(dataInB1_int),
  .DataInB(dataInW1_int),
  .SignA(signB_int),
  .SignB(signW_int),
  .Enable(1'b1),
  .DataOut(multOutX9_B1)
);

wire multaClk = clkInt[MULTA_CLK];
wire multbClk = clkInt[MULTB_CLK];
wire multaAsync = asyncInt[MULTA_ASYNC];
wire multbAsync = asyncInt[MULTB_ASYNC];
wire [17:0] multA0_int, multA1_int, multB0_int, multB1_int;
alta_dff_en multRegA0[17:0] (.Din(multOutX9_A0), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multA0_int));
alta_dff_en multRegA1[17:0] (.Din(multOutX9_A1), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multA1_int));
alta_dff_en multRegB0[17:0] (.Din(multOutX9_B0), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multB0_int));
alta_dff_en multRegB1[17:0] (.Din(multOutX9_B1), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multB1_int));

alta_dff_en multSignRegA (.Din(signA_int|signW_int), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multSignA));
alta_dff_en multSignRegB (.Din(signB_int|signW_int), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multSignB));

alta_dff_en multAddSubRegA0 (.Din(addsubA0_int), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multAddSubA0));
alta_dff_en multAddSubRegA1 (.Din(addsubA1_int), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multAddSubA1));
alta_dff_en multAddSubRegB0 (.Din(addsubB0_int), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multAddSubB0));
alta_dff_en multAddSubRegB1 (.Din(addsubB1_int), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multAddSubB1));

wire [1:0] multOpModeA, multOpModeB;
alta_dff_en multOpModeRegA[1:0] (.Din(opmode_int), .Clk(multaClk), .AsyncReset(multaAsync), .En(|MULTA_CLK), .Q(multOpModeA));
alta_dff_en multOpModeRegB[1:0] (.Din(opmode_int), .Clk(multbClk), .AsyncReset(multbAsync), .En(|MULTB_CLK), .Q(multOpModeB));

wire [35:0] accua_int, accub_int;
wire [35:0] accua_out, accub_out;
wire [35:0] mult_data0 = {multOutX9_B1, multOutX9_A0};
wire [35:0] mult_data1 = {{9{signW_int & multOutX9_A1[17]}}, multOutX9_A1, 9'b0 };
wire [35:0] mult_data2 = {{9{signB_int & multOutX9_B0[17]}}, multOutX9_B0, 9'b0 };
wire [35:0] mult_data3 = {multOutX9_B0, multOutX9_A1};
alta_multm_add accua_inst (
  .DataIn0(multA0_int),
  .DataIn1(multA1_int),
  .AccuIn(accua_int),
  .DataCin(DataOutCin0),
  .MultData0(mult_data0),
  .MultData1(mult_data1),
  .MultData2(mult_data2),
  .Sign(multSignA),
  .AddSub0(multAddSubA0),
  .AddSub1(multAddSubA1),
  .X18Mode(x18_mode),
  .X9Mode(x9_mode),
  .AccuMode(multOpModeA),
  .DataOut(accua_out)
);

alta_multm_add accub_inst (
  .DataIn0(multB0_int),
  .DataIn1(multB1_int),
  .AccuIn(accub_int),
  .DataCin(DataOutCin1),
  .MultData0(mult_data3),
  .MultData1(36'b0),
  .MultData2(36'b0),
  .Sign(multSignB),
  .AddSub0(multAddSubB0),
  .AddSub1(multAddSubB1),
  .X18Mode(x18_mode),
  .X9Mode(x9_mode),
  .AccuMode(multOpModeB),
  .DataOut(accub_out)
);

wire accuaClk = clkInt[ACCUA_CLK];
wire accubClk = clkInt[ACCUB_CLK];
wire accuaAsync = asyncInt[ACCUA_ASYNC];
wire accubAsync = asyncInt[ACCUB_ASYNC];
alta_dff_en accuReg0[35:0] (.Din(accua_out), .Clk(accuaClk), .AsyncReset(accuaAsync), .En(|ACCUA_CLK), .Q(accua_int));
alta_dff_en accuReg1[35:0] (.Din(accub_out), .Clk(accubClk), .AsyncReset(accubAsync), .En(|ACCUB_CLK), .Q(accub_int));

wire out0Clk = clkInt[OUT0_CLK];
wire out1Clk = clkInt[OUT1_CLK];
wire out0Async = asyncInt[OUT0_ASYNC];
wire out1Async = asyncInt[OUT1_ASYNC];
wire [35:0] outRegIn0 = OutMode[1] ? DataOutCin0 : accua_int;
wire [35:0] outRegIn1 = OutMode[1] ? DataOutCin1 : accub_int;
wire [35:0] outRegOut0, outRegOut1;
alta_dff_en outReg0[35:0] (.Din(outRegIn0), .Clk(out0Clk), .AsyncReset(out0Async), .En(|OUT0_CLK), .Q(outRegOut0));
alta_dff_en outReg1[35:0] (.Din(outRegIn1), .Clk(out1Clk), .AsyncReset(out1Async), .En(|OUT1_CLK), .Q(outRegOut1));

assign DataOutCout0 = OutMode[1] ? outRegOut0 : accua_int;
assign DataOutCout1 = OutMode[1] ? outRegOut1 : accub_int;
assign {DataOut1, DataOut0} = OutMode[0] ? outRegOut1 : outRegOut0;
`endif
endmodule

module alta_i2c (
  input Clk, Rst,
  input WrRdn, Strobe,
  input Sdai, Scli,
  input [7:0] DataIn,
  input [7:0] Address,
  output Wakeup, Irq, Ack,
  output Sdao, Sclo,
  output [7:0] DataOut
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter SLOT_ID = 4'b0000;

`ifdef ALTA_SIM
i2c_top inst (
  .i_sys_clk  (Clk    ),
  .i_rst      (Rst    ),
  .i_sys_stb  (Strobe ),
  .i_sys_rw   (WrRdn  ),
  .im_sys_addr(Address),
  .im_sys_data(DataIn ),
  .i_scl      (Scli   ),
  .i_sda      (Sdai   ),
  .im_slot_id (SLOT_ID),
  .om_sys_data(DataOut),
  .o_sys_acko (Ack    ),
  .o_i2cirq   (Irq    ),
  .o_i2cwkup  (Wakeup ),
  .o_sclo     (Sclo   ),
  .o_sdao     (Sdao   )
);
`endif

endmodule

module alta_spi (
  input Clk, Rst,
  input WrRdn, Strobe,
  input [7:0] DataIn,
  input [7:0] Address,
  input Mi, Si, Scki, Csi,
  output Wakeup, Irq, Ack,
  output So, Soe, Mo, Moe, Scko, Sckoe,
  output [3:0] Cso,
  output [3:0] Csoe,
  output [7:0] DataOut
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter SLOT_ID = 4'b0000;

`ifdef ALTA_SIM
spi_top inst (
  .i_sys_clk  (Clk    ),
  .i_rst      (Rst    ),
  .i_sys_stb  (Strobe ),
  .i_sys_rw   (WrRdn  ),
  .im_sys_addr(Address),
  .im_sys_data(DataIn ),
  .im_slot_id (SLOT_ID),
  .i_spi_mi   (Mi     ),
  .i_spi_si   (Si     ),
  .i_spi_sck  (Scki   ),
  .i_spi_cs   (Csi    ),
  .om_sys_data(DataOut),
  .o_sys_acko (Ack    ),
  .o_spiirq   (Irq    ),
  .o_spiwkup  (Wakeup ),
  .o_spi_so   (So     ),
  .o_spi_soe  (Soe    ),
  .o_spi_mo   (Mo     ),
  .o_spi_moe  (Moe    ),
  .o_spi_scko (Scko   ),
  .o_spi_sckoe(Sckoe  ),
  .om_spi_cs  (Cso    ),
  .om_spi_csoe(Csoe   )
);
`endif

endmodule

module alta_irda (
  input ir_clk,
  input ir_reset,
  input cal_en,
  input pu_ivref,
  input pu_pga,
  input pu_dac,
  input tia_reset,
  input vip,
  input vin,
  output irx_data,
  output cal_ready,
  output [7:0] dac_cal_reg
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

endmodule

module alta_bram9k (
  input  [17:0]  DataInA,  DataInB,
  input  [12:0] AddressA, AddressB,
  input  [ 1:0]  ByteEnA,  ByteEnB,
  output [17:0] DataOutA,  DataOutB,
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  AddressStallA, WeA, ReA,
  input  AddressStallB, WeB, ReB
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

parameter CLKMODE         = 2'b0; // 00: independent mode, 01: input/output mode, 1x: read/write mode
parameter PORTA_CLKIN_EN  = 1'b0;
parameter PORTA_CLKOUT_EN = 1'b0;
parameter PORTB_CLKIN_EN  = 1'b0;
parameter PORTB_CLKOUT_EN = 1'b0;
parameter PORTA_RSTIN_EN  = 1'b0;
parameter PORTA_RSTOUT_EN = 1'b0;
parameter PORTB_RSTIN_EN  = 1'b0;
parameter PORTB_RSTOUT_EN = 1'b0;
parameter PORTA_OUTREG    = 1'b0;
parameter PORTB_OUTREG    = 1'b0;
parameter PORTA_WIDTH     = 5'b0;
parameter PORTB_WIDTH     = 5'b0;
parameter PACKEDMODE      = 1'b0;
parameter INIT_VAL        = 9216'b0;

parameter PORTA_WRITETHRU = 1'b0;
parameter PORTB_WRITETHRU = 1'b0;

parameter DLYTIME  = 2'b00;
parameter RSEN_DLY = 2'b00;

`ifdef ALTA_SIM
reg [17:0] mem [511:0];
reg [17:0] wrDataA, wrDataB, rdDataA, rdDataB;
integer i;

initial begin
  for (i = 0; i < 512; i = i + 1) begin
    mem[i] = INIT_VAL[i*18+17-:18];
  end
  rdDataA = 18'b0;
  rdDataB = 18'b0;
end

wire X36_MODE_A = PORTA_WIDTH[4];
wire X36_MODE_B = PORTB_WIDTH[4];
wire X36_MODE   = X36_MODE_A | X36_MODE_B;
wire INOUT_MODE = X36_MODE | CLKMODE[0] | CLKMODE[1];
wire RW_MODE    = CLKMODE[1];
wire clkInt0, clkInt1, rdAddrClkA, rdAddrClkB;
wire clkDataInA = PORTA_CLKIN_EN  ? (INOUT_MODE ? clkInt0 : clkInt0) : (INOUT_MODE ? Clk0 : Clk0);
wire clkDataInB = PORTB_CLKIN_EN  ? (INOUT_MODE ? clkInt0 : clkInt1) : (INOUT_MODE ? Clk0 : Clk1);
wire clkAddrInA = clkDataInA;
wire clkAddrInB = PORTB_CLKIN_EN  ? (INOUT_MODE & !RW_MODE ? clkInt0 : clkInt1) : (INOUT_MODE & !RW_MODE ? Clk0 : Clk1);
wire clkOutA    = PORTA_CLKOUT_EN ? (INOUT_MODE ? clkInt1 : clkInt0) : (INOUT_MODE ? Clk1 : Clk0);
wire clkOutB    = PORTB_CLKOUT_EN ? (INOUT_MODE ? clkInt1 : clkInt1) : (INOUT_MODE ? Clk1 : Clk1);
wire rstInA     = PORTA_RSTIN_EN  ? (INOUT_MODE ? AsyncReset0 : AsyncReset0) : 1'b0;
wire rstInB     = PORTB_RSTIN_EN  ? (INOUT_MODE & !RW_MODE ? AsyncReset0 : AsyncReset1) : 1'b0;
wire rstOutA    = PORTA_RSTOUT_EN ? (INOUT_MODE ? AsyncReset1 : AsyncReset0) : 1'b0;
wire rstOutB    = PORTB_RSTOUT_EN ? (INOUT_MODE ? AsyncReset1 : AsyncReset1) : 1'b0;
alta_clkenctrl clkInt0_inst   (.ClkIn(Clk0),       .ClkEn(ClkEn0), .ClkOut(clkInt0));
alta_clkenctrl clkInt1_inst   (.ClkIn(Clk1),       .ClkEn(ClkEn1), .ClkOut(clkInt1));
alta_clkenctrl rdAddrClkA_inst(.ClkIn(clkAddrInA), .ClkEn(ReA),    .ClkOut(rdAddrClkA));
alta_clkenctrl rdAddrClkB_inst(.ClkIn(clkAddrInB), .ClkEn(ReB),    .ClkOut(rdAddrClkB));

wire [17:0] dataInRegA, dataInRegB;
wire [12:0] addrInRegA0, addrInRegB0;
wire [ 3:0] addrRdRegA, addrRdRegB;
wire [ 1:0] byteEnRegA, byteEnRegB;
wire weRegA, reRegA, weRegB, reRegB;

localparam BUF_DEL = 0;
wire [17:0] #BUF_DEL  DataInA_buf = DataInA;
wire [17:0] #BUF_DEL  DataInB_buf = DataInB;
wire [12:0] #BUF_DEL AddressA_buf = AddressA;
wire [12:0] #BUF_DEL AddressB_buf = AddressB;
wire [ 1:0] #BUF_DEL  ByteEnA_buf = ByteEnA;
wire [ 1:0] #BUF_DEL  ByteEnB_buf = ByteEnB;
wire        #BUF_DEL      WeA_buf = WeA;
wire        #BUF_DEL      ReA_buf = ReA;
wire        #BUF_DEL      WeB_buf = WeB;
wire        #BUF_DEL      ReB_buf = ReB;
alta_dff_stall dataInRegA_inst[17:0](.Din(DataInA_buf)      , .Clk(clkDataInA), .AsyncReset(1'b0)  , .Stall(1'b0)         , .Q(dataInRegA));
alta_dff_stall dataInRegB_inst[17:0](.Din(DataInB_buf)      , .Clk(clkDataInB), .AsyncReset(1'b0)  , .Stall(1'b0)         , .Q(dataInRegB));
alta_dff_stall addrInRegA_inst[12:0](.Din(AddressA_buf)     , .Clk(clkAddrInA), .AsyncReset(rstInA), .Stall(AddressStallA), .Q(addrInRegA0));
alta_dff_stall addrInRegB_inst[12:0](.Din(AddressB_buf)     , .Clk(clkAddrInB), .AsyncReset(rstInB), .Stall(AddressStallB), .Q(addrInRegB0));
alta_dff_stall addrRdRegA_inst[ 3:0](.Din(AddressA_buf[3:0]), .Clk(rdAddrClkA), .AsyncReset(rstInA), .Stall(AddressStallA), .Q(addrRdRegA));
alta_dff_stall addrRdRegB_inst[ 3:0](.Din(AddressB_buf[3:0]), .Clk(rdAddrClkB), .AsyncReset(rstInB), .Stall(AddressStallB), .Q(addrRdRegB));
alta_dff          byteEnA_inst[ 1:0](.Din(ByteEnA_buf)      , .Clk(clkDataInA), .AsyncReset(1'b0)  , .Q(byteEnRegA));
alta_dff          byteEnB_inst[ 1:0](.Din(ByteEnB_buf)      , .Clk(clkDataInB), .AsyncReset(1'b0)  , .Q(byteEnRegB));
alta_dff           weRegA_inst      (.Din(WeA_buf)          , .Clk(clkDataInA), .AsyncReset(1'b0)  , .Q(weRegA));
alta_dff           weRegB_inst      (.Din(WeB_buf)          , .Clk(clkDataInB), .AsyncReset(1'b0)  , .Q(weRegB));
alta_dff           reRegA_inst      (.Din(ReA_buf)          , .Clk(clkAddrInA), .AsyncReset(1'b0)  , .Q(reRegA));
alta_dff           reRegB_inst      (.Din(ReB_buf)          , .Clk(clkAddrInB), .AsyncReset(1'b0)  , .Q(reRegB));

// Generate read/write pulse
wire rdPulseA, rdPulseB, wrPulseA, wrPulseB;
alta_bram_pulse_generator #(.PULSE_DELAY(1)) genRdPulseA (
  .Clk(clkAddrInA),
  .Ena(reRegA && !X36_MODE),
  .Pulse(rdPulseA)
);
alta_bram_pulse_generator #(.PULSE_DELAY(2)) genWrPulseA (
  .Clk(clkAddrInA),
  .Ena(weRegA),
  .Pulse(wrPulseA)
);
alta_bram_pulse_generator #(.PULSE_DELAY(1)) genRdPulseB (
  .Clk(clkAddrInB),
  .Ena(reRegB),
  .Pulse(rdPulseB)
);
alta_bram_pulse_generator #(.PULSE_DELAY(2)) genWrPulseB (
  .Clk(clkAddrInB),
  .Ena(weRegB && !X36_MODE),
  .Pulse(wrPulseB)
);

wire [12:0] addrInRegA = PACKEDMODE  ? {1'b0, addrInRegA0[11:0]} : addrInRegA0;
wire [12:0] addrInRegB = PACKEDMODE  ? {1'b1, addrInRegB0[11:0]} : addrInRegB0;
wire [8:0] wrWlAddrA  = X36_MODE_A ? {addrInRegA[12:5], 1'b0} : addrInRegA[12:4];
wire [8:0] wrWlAddrB  = X36_MODE_A ? {addrInRegA[12:5], 1'b1} : addrInRegB[12:4];
wire [8:0] rdWlAddrA  = X36_MODE_B ? {addrInRegB[12:5], 1'b0} : addrInRegA[12:4];
wire [8:0] rdWlAddrB  = X36_MODE_B ? {addrInRegB[12:5], 1'b1} : addrInRegB[12:4];
wire [3:0] wrBlkAddrA = addrInRegA[3:0];
wire [3:0] wrBlkAddrB = addrInRegB[3:0];
wire [3:0] rdBlkAddrA = addrRdRegA[3:0];
wire [3:0] rdBlkAddrB = addrRdRegB[3:0];

`ifdef BRAM_BYTEEN_FIX // Needed for AG10K and AG15K
  `define MASKA 18'h3ffff
  `define MASKB 18'h3ffff
`else
  `define MASKA maskA_x18
  `define MASKB maskB_x18
`endif
wire [17:0] maskA_x18 = { {9{byteEnRegA[1]}}, {9{byteEnRegA[0]}} };
wire [17:0] maskA_x9  = { {9{byteEnRegA[1] & wrBlkAddrA[3]}}, {9{byteEnRegA[0] & !wrBlkAddrA[3]}} };
wire [17:0] maskA_x4  = (4'b1111 << wrBlkAddrA[3:2] * 4 + wrBlkAddrA[3]) & `MASKA;
wire [17:0] maskA_x2  = (2'b11   << wrBlkAddrA[3:1] * 2 + wrBlkAddrA[3]) & `MASKA;
wire [17:0] maskA_x1  = (1'b1    << wrBlkAddrA[3:0] * 1 + wrBlkAddrA[3]) & `MASKA;
wire [17:0] maskB_x18 = { {9{byteEnRegB[1]}}, {9{byteEnRegB[0]}} };
wire [17:0] maskB_x9  = { {9{byteEnRegB[1] & wrBlkAddrB[3]}}, {9{byteEnRegB[0] & !wrBlkAddrB[3]}} };
wire [17:0] maskB_x4  = (4'b1111 << wrBlkAddrB[3:2] * 4 + wrBlkAddrB[3]) & `MASKB;
wire [17:0] maskB_x2  = (2'b11   << wrBlkAddrB[3:1] * 2 + wrBlkAddrB[3]) & `MASKB;
wire [17:0] maskB_x1  = (1'b1    << wrBlkAddrB[3:0] * 1 + wrBlkAddrB[3]) & `MASKB;

wire [17:0] maskA = PORTA_WIDTH == 5'b00000 ? maskA_x18 :
                    PORTA_WIDTH == 5'b01000 ? maskA_x9  :
                    PORTA_WIDTH == 5'b01100 ? maskA_x4  :
                    PORTA_WIDTH == 5'b01110 ? maskA_x2  :
                    PORTA_WIDTH == 5'b01111 ? maskA_x1  :
                    PORTA_WIDTH == 5'b10000 ? maskA_x18 : 18'b0;
wire [17:0] maskB = PORTB_WIDTH == 5'b00000 ? maskB_x18 :
                    PORTB_WIDTH == 5'b01000 ? maskB_x9  :
                    PORTB_WIDTH == 5'b01100 ? maskB_x4  :
                    PORTB_WIDTH == 5'b01110 ? maskB_x2  :
                    PORTB_WIDTH == 5'b01111 ? maskB_x1  :
                    PORTB_WIDTH == 5'b10000 ? maskB_x18 : 18'b0;

wire [17:0] wrMaskA = X36_MODE_A ? maskA     : maskA;
wire [17:0] wrMaskB = X36_MODE_A ? maskB_x18 : maskB;
wire [17:0] rdMaskA = X36_MODE   ? 18'b0     : maskA;
wire [17:0] rdMaskB = X36_MODE   ? 18'b0     : maskB;
wire noByteEnA = |PORTA_WIDTH[2:0];
wire noByteEnB = |PORTB_WIDTH[2:0];

always @ (posedge rdPulseA or posedge wrPulseA or posedge rdPulseB or posedge wrPulseB or posedge rstOutA or posedge rstOutB) begin
  if (wrPulseA) begin
    wrDataA = mem[wrWlAddrA];
    for (i = 0; i < 18; i = i + 1) begin
      if (wrMaskA[i]) begin
        wrDataA[i] = dataInRegA[i];
      end
    end
    mem[wrWlAddrA] = wrDataA;
  end
  if (wrPulseB || X36_MODE_A && wrPulseA) begin
    wrDataB = mem[wrWlAddrB];
    for (i = 0; i < 18; i = i + 1) begin
      if (wrMaskB[i]) begin
        wrDataB[i] = dataInRegB[i];
      end
    end
    mem[wrWlAddrB] = wrDataB;
  end
  if (rstOutA) begin
    rdDataA = 18'b0;
  end else if (rdPulseA || X36_MODE_B && rdPulseB) begin
    for (i = 0; i < 18; i = i + 1) begin
      rdDataA[i] = !rstOutA && weRegA && PORTA_WRITETHRU && rdMaskA[i] ? dataInRegA[i] : mem[rdWlAddrA][i];
    end
  end
  if (rstOutB) begin
    rdDataB = 18'b0;
  end else if (rdPulseB) begin
    for (i = 0; i < 18; i = i + 1) begin
      rdDataB[i] = !rstOutB && weRegB && PORTB_WRITETHRU && rdMaskB[i] ? dataInRegB[i] : mem[rdWlAddrB][i];
    end
  end
end

wire [4:0] rdPortWidthA = X36_MODE_B ? PORTB_WIDTH : PORTA_WIDTH;
wire [4:0] rdPortWidthB = PORTB_WIDTH;
wire [15:0] rdDataA_x16 = { rdDataA[16:9], rdDataA[7:0] };
wire [8:0]  rdDataA_x9  = rdBlkAddrA[3] ? rdDataA[17:9] : rdDataA[8:0];
wire [3:0]  rdDataA_x4  = rdDataA_x16 >> rdBlkAddrA[3:2]*4;
wire [1:0]  rdDataA_x2  = rdDataA_x16 >> rdBlkAddrA[3:1]*2;
wire        rdDataA_x1  = rdDataA_x16 >> rdBlkAddrA[3:0];
wire [17:0] dataOutSelA = rdPortWidthA == 5'b00000 ? rdDataA :
                          rdPortWidthA == 5'b01000 ? {  1'b1, rdDataA_x9[7:0], 1'b1, rdDataA_x9[8], 7'h7f } :
                          rdPortWidthA == 5'b01100 ? { 11'h7FF  , rdDataA_x4, 3'b111 } :
                          rdPortWidthA == 5'b01110 ? { 15'h7FFF , rdDataA_x2, 1'b1   } :
                          rdPortWidthA == 5'b01111 ? { 17'h1FFFF, rdDataA_x1         } :
                          rdPortWidthA == 5'b10000 ? rdDataA                           : 18'bx;
wire [15:0] rdDataB_x16 = { rdDataB[16:9], rdDataB[7:0] };
wire [8:0]  rdDataB_x9  = rdBlkAddrB[3] ? rdDataB[17:9] : rdDataB[8:0];
wire [3:0]  rdDataB_x4  = rdDataB_x16 >> rdBlkAddrB[3:2]*4;
wire [1:0]  rdDataB_x2  = rdDataB_x16 >> rdBlkAddrB[3:1]*2;
wire        rdDataB_x1  = rdDataB_x16 >> rdBlkAddrB[3:0];
wire [17:0] dataOutSelB = rdPortWidthB == 5'b00000 ? rdDataB :
                          rdPortWidthB == 5'b01000 ? {  1'b1, rdDataB_x9[7:0], 1'b1, rdDataB_x9[8], 7'h7f } :
                          rdPortWidthB == 5'b01100 ? { 11'h7FF  , rdDataB_x4, 3'b111 } :
                          rdPortWidthB == 5'b01110 ? { 15'h7FFF , rdDataB_x2, 1'b1   } :
                          rdPortWidthB == 5'b01111 ? { 17'h1FFFF, rdDataB_x1         } :
                          rdPortWidthB == 5'b10000 ? rdDataB                           : 18'bx;

wire [17:0] dataOutRegA, dataOutRegB;
alta_dff dataOutRegA_inst[17:0](.Din(dataOutSelA),  .Clk(clkOutA), .AsyncReset(rstOutA), .Q(dataOutRegA));
alta_dff dataOutRegB_inst[17:0](.Din(dataOutSelB),  .Clk(clkOutB), .AsyncReset(rstOutB), .Q(dataOutRegB));
assign DataOutA = PORTA_OUTREG ? dataOutRegA : dataOutSelA;
assign DataOutB = PORTB_OUTREG ? dataOutRegB : dataOutSelB;
`endif

endmodule

module alta_mcu (
//inputs
    //clock and reset
    input CLK,
    input JTCK,
    input POR_n,
    input EXT_CPU_RST_n,
    input JTRST_n,
    //uart
    input UART_RXD,
    input UART_CTS_n,
    //jtag
    input JTDI,
    input JTMS,
    //ram access
    input EXT_RAM_EN,
    input EXT_RAM_WR,
    input [13:0] EXT_RAM_ADDR, //in word
    input [3:0] EXT_RAM_BYTE_EN,
    input [31:0] EXT_RAM_WDATA,
    //ext ahb slave
    input [1:0] HRESP_EXT,
    input HREADY_OUT_EXT,
    input [31:0] HRDATA_EXT,
    output [1:0] HTRANS_EXT,
    output [31:0] HADDR_EXT,
    output HWRITE_EXT,
    output HSEL_EXT,
    output [31:0] HWDATA_EXT,
    output [2:0] HSIZE_EXT,
    output HREADY_IN_EXT,
//outputs
    //flash
    output FLASH_SCK,
    output FLASH_CS_n,
    //uart
    output UART_TXD,
    output UART_RTS_n,
    //jtag
    output JTDO,
    //ram access
    output [31:0] EXT_RAM_RDATA,
//inouts
    //flash
    output FLASH_IO0_SI,
    output FLASH_IO1_SO,
    output FLASH_IO2_WPn,
    output FLASH_IO3_HOLDn,
    input  FLASH_IO0_SI_i,
    input  FLASH_IO1_SO_i,
    input  FLASH_IO2_WPn_i,
    input  FLASH_IO3_HOLDn_i,
    output FLASH_SI_OE,
    output FLASH_SO_OE,
    output WPn_IO2_OE,
    output HOLDn_IO3_OE,
    //gpio
    input [7:0]  GPIO0_I,
    input [7:0]  GPIO1_I,
    input [7:0]  GPIO2_I,
    output [7:0] GPIO0_O,
    output [7:0] GPIO1_O,
    output [7:0] GPIO2_O,
    output [7:0] nGPEN0,
    output [7:0] nGPEN1,
    output [7:0] nGPEN2
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter [23:0] FLASH_BIAS = 24'b0;
`ifdef ALTA_SIM
M3_SYS_TOP mcu_inst(
  .CLK              (CLK              ),
  .JTCK             (JTCK             ),
  .POR_n            (POR_n            ),
  .EXT_CPU_RST_n    (EXT_CPU_RST_n    ),
  .JTRST_n          (JTRST_n          ),
  .UART_RXD         (UART_RXD         ),
  .UART_CTS_n       (UART_CTS_n       ),
  .JTDI             (JTDI             ),
  .JTMS             (JTMS             ),
  .EXT_RAM_EN       (EXT_RAM_EN       ),
  .EXT_RAM_WR       (EXT_RAM_WR       ),
  .EXT_RAM_ADDR     (EXT_RAM_ADDR     ),
  .EXT_RAM_BYTE_EN  (EXT_RAM_BYTE_EN  ),
  .EXT_RAM_WDATA    (EXT_RAM_WDATA    ),
  .FLASH_BIAS       (FLASH_BIAS       ),
  .HRESP_EXT        (HRESP_EXT        ),
  .HREADY_OUT_EXT   (HREADY_OUT_EXT   ),
  .HRDATA_EXT       (HRDATA_EXT       ),
  .HTRANS_EXT       (HTRANS_EXT       ),
  .HADDR_EXT        (HADDR_EXT        ),
  .HWRITE_EXT       (HWRITE_EXT       ),
  .HSEL_EXT         (HSEL_EXT         ),
  .HWDATA_EXT       (HWDATA_EXT       ),
  .HSIZE_EXT        (HSIZE_EXT        ),
  .HREADY_IN_EXT    (HREADY_IN_EXT    ),
  .FLASH_SCK        (FLASH_SCK        ),
  .FLASH_CS_n       (FLASH_CS_n       ),
  .UART_TXD         (UART_TXD         ),
  .UART_RTS_n       (UART_RTS_n       ),
  .JTDO             (JTDO             ),
  .EXT_RAM_RDATA    (EXT_RAM_RDATA    ),
  .FLASH_IO0_SI     (FLASH_IO0_SI     ),
  .FLASH_IO1_SO     (FLASH_IO1_SO     ),
  .FLASH_IO2_WPn    (FLASH_IO2_WPn    ),
  .FLASH_IO3_HOLDn  (FLASH_IO3_HOLDn  ),
  .FLASH_IO0_SI_i   (FLASH_IO0_SI_i   ),
  .FLASH_IO1_SO_i   (FLASH_IO1_SO_i   ),
  .FLASH_IO2_WPn_i  (FLASH_IO2_WPn_i  ),
  .FLASH_IO3_HOLDn_i(FLASH_IO3_HOLDn_i),
  .FLASH_SI_OE      (FLASH_SI_OE      ),
  .FLASH_SO_OE      (FLASH_SO_OE      ),
  .WPn_IO2_OE       (WPn_IO2_OE       ),
  .HOLDn_IO3_OE     (HOLDn_IO3_OE     ),
  .GPIO0_I          (GPIO0_I          ),
  .GPIO1_I          (GPIO1_I          ),
  .GPIO2_I          (GPIO2_I          ),
  .GPIO0_O          (GPIO0_O          ),
  .GPIO1_O          (GPIO1_O          ),
  .GPIO2_O          (GPIO2_O          ),
  .nGPEN0           (nGPEN0           ),
  .nGPEN1           (nGPEN1           ),
  .nGPEN2           (nGPEN2           )
);
`endif
endmodule

module alta_mcu_m3 (
//inputs
    //clock and reset
    input CLK,
    input JTCK,
    input POR_n,
    input EXT_CPU_RST_n,
    input JTRST_n,
    //uart
    input UART_RXD,
    input UART_CTS_n,
    //jtag
    input JTDI,
    input JTMS,
	//swd                  
	output SWDO,         
	output SWDOEN,         
    //ram access
    input EXT_RAM_EN,
    input EXT_RAM_WR,
    input [14:0] EXT_RAM_ADDR, //in word
    input [3:0] EXT_RAM_BYTE_EN,
    input [31:0] EXT_RAM_WDATA,
    //ext ahb slave
    input [1:0] HRESP_EXT,
    input HREADY_OUT_EXT,
    input [31:0] HRDATA_EXT,
    output [1:0] HTRANS_EXT,
    output [31:0] HADDR_EXT,
    output HWRITE_EXT,
    output HSEL_EXT,
    output [31:0] HWDATA_EXT,
    output [2:0] HSIZE_EXT,
    output HREADY_IN_EXT,
	//ext ahb master
	output [1:0] HRESP_EXTM,
	output HREADY_OUT_EXTM,
    output [31:0] HRDATA_EXTM,
    input [1:0] HTRANS_EXTM,
	input [31:0] HADDR_EXTM,
	input HWRITE_EXTM,
	input HSEL_EXTM,
	input [31:0] HWDATA_EXTM,
	input [2:0] HSIZE_EXTM,
    input HREADY_IN_EXTM,	
    input [2:0]   HBURSTM,
	input [3:0]   HPROTM,
//outputs
    //flash
    output FLASH_SCK,
    output FLASH_CS_n,
    //uart
    output UART_TXD,
    output UART_RTS_n,
    //jtag
    output JTDO,
    //ram access
    output [31:0] EXT_RAM_RDATA,
//inouts
    //flash
    output FLASH_IO0_SI,
    output FLASH_IO1_SO,
    output FLASH_IO2_WPn,
    output FLASH_IO3_HOLDn,
    input  FLASH_IO0_SI_i,
    input  FLASH_IO1_SO_i,
    input  FLASH_IO2_WPn_i,
    input  FLASH_IO3_HOLDn_i,
    output FLASH_SI_OE,
    output FLASH_SO_OE,
    output WPn_IO2_OE,
    output HOLDn_IO3_OE,
    //gpio
    input [7:0]  GPIO0_I,
    input [7:0]  GPIO1_I,
    input [7:0]  GPIO2_I,
    output [7:0] GPIO0_O,
    output [7:0] GPIO1_O,
    output [7:0] GPIO2_O,
    output [7:0] nGPEN0,
    output [7:0] nGPEN1,
    output [7:0] nGPEN2
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter [23:0] FLASH_BIAS = 24'b0;
parameter [7:0]  CLK_FREQ   = 8'b0;
parameter [0:0]  BOOT_DELAY = 1'b0;
`ifdef ALTA_SIM
M3_SYS_TOP mcu_inst (
  .CLK              (CLK              ),
  .JTCK             (JTCK             ),
  .POR_n            (POR_n            ),
  .EXT_CPU_RST_n    (EXT_CPU_RST_n    ),
  .JTRST_n          (JTRST_n          ),
  .UART_RXD         (UART_RXD         ),
  .UART_CTS_n       (UART_CTS_n       ),
  .JTDI             (JTDI             ),
  .JTMS             (JTMS             ),
  .SWDO             (SWDO             ),
  .SWDOEN           (SWDOEN           ),
  .EXT_RAM_EN       (EXT_RAM_EN       ),
  .EXT_RAM_WR       (EXT_RAM_WR       ),
  .EXT_RAM_ADDR     (EXT_RAM_ADDR     ),
  .EXT_RAM_BYTE_EN  (EXT_RAM_BYTE_EN  ),
  .EXT_RAM_WDATA    (EXT_RAM_WDATA    ),
  .FLASH_BIAS       (FLASH_BIAS       ),
  .CLK_FREQ         (CLK_FREQ         ),
  .BOOT_DELAY       (BOOT_DELAY       ),
  .HRESP_EXT        (HRESP_EXT        ),
  .HREADY_OUT_EXT   (HREADY_OUT_EXT   ),
  .HRDATA_EXT       (HRDATA_EXT       ),
  .HTRANS_EXT       (HTRANS_EXT       ),
  .HADDR_EXT        (HADDR_EXT        ),
  .HWRITE_EXT       (HWRITE_EXT       ),
  .HSEL_EXT         (HSEL_EXT         ),
  .HWDATA_EXT       (HWDATA_EXT       ),
  .HSIZE_EXT        (HSIZE_EXT        ),
  .HREADY_IN_EXT    (HREADY_IN_EXT    ),
  .HRESP_EXTM       (HRESP_EXTM       ),
  .HREADY_OUT_EXTM  (HREADY_OUT_EXTM  ),
  .HRDATA_EXTM      (HRDATA_EXTM      ),
  .HTRANS_EXTM      (HTRANS_EXTM      ),
  .HADDR_EXTM       (HADDR_EXTM       ),
  .HWRITE_EXTM      (HWRITE_EXTM      ),
  .HSEL_EXTM        (HSEL_EXTM        ),
  .HWDATA_EXTM      (HWDATA_EXTM      ),
  .HSIZE_EXTM       (HSIZE_EXTM       ),
  .HREADY_IN_EXTM   (HREADY_IN_EXTM   ),
  .HBURSTM          (HBURSTM          ),
  .HPROTM           (HPROTM           ),
  .FLASH_SCK        (FLASH_SCK        ),
  .FLASH_CS_n       (FLASH_CS_n       ),
  .UART_TXD         (UART_TXD         ),
  .UART_RTS_n       (UART_RTS_n       ),
  .JTDO             (JTDO             ),
  .EXT_RAM_RDATA    (EXT_RAM_RDATA    ),
  .FLASH_IO0_SI     (FLASH_IO0_SI     ),
  .FLASH_IO1_SO     (FLASH_IO1_SO     ),
  .FLASH_IO2_WPn    (FLASH_IO2_WPn    ),
  .FLASH_IO3_HOLDn  (FLASH_IO3_HOLDn  ),
  .FLASH_IO0_SI_i   (FLASH_IO0_SI_i   ),
  .FLASH_IO1_SO_i   (FLASH_IO1_SO_i   ),
  .FLASH_IO2_WPn_i  (FLASH_IO2_WPn_i  ),
  .FLASH_IO3_HOLDn_i(FLASH_IO3_HOLDn_i),
  .FLASH_SI_OE      (FLASH_SI_OE      ),
  .FLASH_SO_OE      (FLASH_SO_OE      ),
  .WPn_IO2_OE       (WPn_IO2_OE       ),
  .HOLDn_IO3_OE     (HOLDn_IO3_OE     ),
  .GPIO0_I          (GPIO0_I          ),
  .GPIO1_I          (GPIO1_I          ),
  .GPIO2_I          (GPIO2_I          ),
  .GPIO0_O          (GPIO0_O          ),
  .GPIO1_O          (GPIO1_O          ),
  .GPIO2_O          (GPIO2_O          ),
  .nGPEN0           (nGPEN0           ),
  .nGPEN1           (nGPEN1           ),
  .nGPEN2           (nGPEN2           )
);
`endif
endmodule

module alta_remote (
  input  clk, shift, update, din, reconfig,
  output dout
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifdef ALTA_SIM
`endif
endmodule

module alta_saradc (
  input  adcenb, sclk,
  input  [3:0] insel,
  input  refsel, refin, divvi8, bgenb,
  input  [8:0] ain,
  output eoc,
  output [11:0] db
) /* synthesis syn_black_box */;
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifdef ALTA_SIM
`endif
endmodule

module alta_gclksw (
  input  resetn, ena, clkin0, clkin1, clkin2, clkin3,
  input  tri0 [1:0] select,
  output clkout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
parameter ENA_REG_MODE = 1'b0;
`ifdef ALTA_SIM
wire [3:0] inclk = {clkin3, clkin2, clkin1, clkin0};
wire [3:0] clken;
wire [3:0] outclk;
genvar g;
generate
for (g = 0; g < 4; g = g + 1) begin
  alta_dff d0(.Din(select == g && (clken & ~(4'b1 << g)) == 0), .Clk(inclk[g]), .AsyncReset(!resetn), .Q(clkreg));
  alta_dff d1(.Din(clkreg), .Clk(~inclk[g]), .AsyncReset(!resetn), .Q(clken[g]));
  assign outclk[g] = clken[g] & inclk[g];
end
endgenerate
assign clkout = |outclk;
`else
cycloneive_clkctrl #(.clock_type("global clock"), .ena_register_mode(ENA_REG_MODE ? "falling edge" : "none")) gclk_switch(
  .ena(ena),
  .inclk({clkin3, clkin2, 1'b0, clkin0}),
  .clkselect(select),
  .outclk(clkout)
);
`endif
endmodule

module alta_rv32 (
  input         sys_clk,
  output        mem_ahb_hready,
  input         mem_ahb_hreadyout,
  output [1:0]  mem_ahb_htrans,
  output [2:0]  mem_ahb_hsize,
  output [2:0]  mem_ahb_hburst,
  output        mem_ahb_hwrite,
  output [31:0] mem_ahb_haddr,
  output [31:0] mem_ahb_hwdata,
  input         mem_ahb_hresp,
  input  [31:0] mem_ahb_hrdata,
  input         slave_ahb_hsel,
  input         slave_ahb_hready,
  output        slave_ahb_hreadyout,
  input  [1:0]  slave_ahb_htrans,
  input  [2:0]  slave_ahb_hsize,
  input  [2:0]  slave_ahb_hburst,
  input         slave_ahb_hwrite,
  input  [31:0] slave_ahb_haddr,
  input  [31:0] slave_ahb_hwdata,
  output        slave_ahb_hresp,
  output [31:0] slave_ahb_hrdata,
  input  [7:0]  gpio0_io_in,
  output [7:0]  gpio0_io_out_data,
  output [7:0]  gpio0_io_out_en,
  input  [7:0]  gpio1_io_in,
  output [7:0]  gpio1_io_out_data,
  output [7:0]  gpio1_io_out_en,
  output [1:0]  sys_ctrl_clkSource,
  output        sys_ctrl_hseEnable,
  output        sys_ctrl_hseBypass,
  output        sys_ctrl_pllEnable,
  input         sys_ctrl_pllReady,
  output        sys_ctrl_sleep,
  output        sys_ctrl_stop,
  output        sys_ctrl_standby,
  input  [7:0]  gpio2_io_in,
  output [7:0]  gpio2_io_out_data,
  output [7:0]  gpio2_io_out_en,
  input  [7:0]  gpio3_io_in,
  output [7:0]  gpio3_io_out_data,
  output [7:0]  gpio3_io_out_en,
  input  [7:0]  gpio4_io_in,
  output [7:0]  gpio4_io_out_data,
  output [7:0]  gpio4_io_out_en,
  input  [7:0]  gpio5_io_in,
  output [7:0]  gpio5_io_out_data,
  output [7:0]  gpio5_io_out_en,
  input  [7:0]  gpio6_io_in,
  output [7:0]  gpio6_io_out_data,
  output [7:0]  gpio6_io_out_en,
  input  [7:0]  gpio7_io_in,
  output [7:0]  gpio7_io_out_data,
  output [7:0]  gpio7_io_out_en,
  input  [7:0]  gpio8_io_in,
  output [7:0]  gpio8_io_out_data,
  output [7:0]  gpio8_io_out_en,
  input  [7:0]  gpio9_io_in,
  output [7:0]  gpio9_io_out_data,
  output [7:0]  gpio9_io_out_en,
  input         ext_resetn,
  output        resetn_out,
  output        dmactive,
  output        swj_JTAGNSW,
  output [3:0]  swj_JTAGSTATE,
  output [3:0]  swj_JTAGIR,
  input  [7:0]  ext_int,
  input  [3:0]  ext_dma_DMACBREQ,
  input  [3:0]  ext_dma_DMACLBREQ,
  input  [3:0]  ext_dma_DMACSREQ,
  input  [3:0]  ext_dma_DMACLSREQ,
  output [3:0]  ext_dma_DMACCLR,
  output [3:0]  ext_dma_DMACTC,
  input  [3:0]  local_int,
  input  [1:0]  test_mode,
  input         usb0_xcvr_clk,
  input         usb0_id
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;

`ifdef ALTA_SIM
alta_rv32_top mcu_inst(
  .sys_clk            (sys_clk            ),
  .mem_ahb_hready     (mem_ahb_hready     ),
  .mem_ahb_hreadyout  (mem_ahb_hreadyout  ),
  .mem_ahb_htrans     (mem_ahb_htrans     ),
  .mem_ahb_hsize      (mem_ahb_hsize      ),
  .mem_ahb_hburst     (mem_ahb_hburst     ),
  .mem_ahb_hwrite     (mem_ahb_hwrite     ),
  .mem_ahb_haddr      (mem_ahb_haddr      ),
  .mem_ahb_hwdata     (mem_ahb_hwdata     ),
  .mem_ahb_hresp      (mem_ahb_hresp      ),
  .mem_ahb_hrdata     (mem_ahb_hrdata     ),
  .slave_ahb_hsel     (slave_ahb_hsel     ),
  .slave_ahb_hready   (slave_ahb_hready   ),
  .slave_ahb_hreadyout(slave_ahb_hreadyout),
  .slave_ahb_htrans   (slave_ahb_htrans   ),
  .slave_ahb_hsize    (slave_ahb_hsize    ),
  .slave_ahb_hburst   (slave_ahb_hburst   ),
  .slave_ahb_hwrite   (slave_ahb_hwrite   ),
  .slave_ahb_haddr    (slave_ahb_haddr    ),
  .slave_ahb_hwdata   (slave_ahb_hwdata   ),
  .slave_ahb_hresp    (slave_ahb_hresp    ),
  .slave_ahb_hrdata   (slave_ahb_hrdata   ),
  .gpio0_io_in        (gpio0_io_in        ),
  .gpio0_io_out_data  (gpio0_io_out_data  ),
  .gpio0_io_out_en    (gpio0_io_out_en    ),
  .gpio1_io_in        (gpio1_io_in        ),
  .gpio1_io_out_data  (gpio1_io_out_data  ),
  .gpio1_io_out_en    (gpio1_io_out_en    ),
  .sys_ctrl_clkSource (sys_ctrl_clkSource ),
  .sys_ctrl_hseEnable (sys_ctrl_hseEnable ),
  .sys_ctrl_hseBypass (sys_ctrl_hseBypass ),
  .sys_ctrl_pllEnable (sys_ctrl_pllEnable ),
  .sys_ctrl_pllReady  (sys_ctrl_pllReady  ),
  .sys_ctrl_sleep     (sys_ctrl_sleep     ),
  .sys_ctrl_stop      (sys_ctrl_stop      ),
  .sys_ctrl_standby   (sys_ctrl_standby   ),
  .gpio2_io_in        (gpio2_io_in        ),
  .gpio2_io_out_data  (gpio2_io_out_data  ),
  .gpio2_io_out_en    (gpio2_io_out_en    ),
  .gpio3_io_in        (gpio3_io_in        ),
  .gpio3_io_out_data  (gpio3_io_out_data  ),
  .gpio3_io_out_en    (gpio3_io_out_en    ),
  .gpio4_io_in        (gpio4_io_in        ),
  .gpio4_io_out_data  (gpio4_io_out_data  ),
  .gpio4_io_out_en    (gpio4_io_out_en    ),
  .gpio5_io_in        (gpio5_io_in        ),
  .gpio5_io_out_data  (gpio5_io_out_data  ),
  .gpio5_io_out_en    (gpio5_io_out_en    ),
  .gpio6_io_in        (gpio6_io_in        ),
  .gpio6_io_out_data  (gpio6_io_out_data  ),
  .gpio6_io_out_en    (gpio6_io_out_en    ),
  .gpio7_io_in        (gpio7_io_in        ),
  .gpio7_io_out_data  (gpio7_io_out_data  ),
  .gpio7_io_out_en    (gpio7_io_out_en    ),
  .gpio8_io_in        (gpio8_io_in        ),
  .gpio8_io_out_data  (gpio8_io_out_data  ),
  .gpio8_io_out_en    (gpio8_io_out_en    ),
  .gpio9_io_in        (gpio9_io_in        ),
  .gpio9_io_out_data  (gpio9_io_out_data  ),
  .gpio9_io_out_en    (gpio9_io_out_en    ),
  .ext_resetn         (ext_resetn         ),
  .resetn_out         (resetn_out         ),
  .dmactive           (dmactive           ),
  .swj_JTAGNSW        (swj_JTAGNSW        ),
  .swj_JTAGSTATE      (swj_JTAGSTATE      ),
  .swj_JTAGIR         (swj_JTAGIR         ),
  .ext_int            (ext_int            ),
  .ext_dma_DMACBREQ   (ext_dma_DMACBREQ   ),
  .ext_dma_DMACLBREQ  (ext_dma_DMACLBREQ  ),
  .ext_dma_DMACSREQ   (ext_dma_DMACSREQ   ),
  .ext_dma_DMACLSREQ  (ext_dma_DMACLSREQ  ),
  .ext_dma_DMACCLR    (ext_dma_DMACCLR    ),
  .ext_dma_DMACTC     (ext_dma_DMACTC     ),
  .local_int          (local_int          ),
  .test_mode          (test_mode          ),
  .usb0_xcvr_clk      (usb0_xcvr_clk      ),
  .usb0_id            (usb0_id            )
);
`else
// Dummy connections.
assign mem_ahb_hready = mem_ahb_hresp;
assign mem_ahb_htrans = {2{mem_ahb_hresp}};
assign mem_ahb_hsize  = {3{mem_ahb_hresp}};
assign mem_ahb_hburst = {3{mem_ahb_hresp}};
assign mem_ahb_hwrite = mem_ahb_hresp;
assign mem_ahb_haddr  = mem_ahb_hrdata;
assign mem_ahb_hwdata = mem_ahb_hrdata;

assign slave_ahb_hreadyout = slave_ahb_hsel;
assign slave_ahb_hresp     = slave_ahb_hsel;
assign slave_ahb_hrdata    = slave_ahb_haddr;

assign sys_ctrl_clkSource = {sys_ctrl_pllReady, usb0_xcvr_clk};
assign sys_ctrl_hseEnable = sys_ctrl_pllReady;
assign sys_ctrl_hseBypass = sys_ctrl_pllReady;
assign sys_ctrl_pllEnable = sys_ctrl_pllReady;
assign sys_ctrl_sleep     = sys_ctrl_pllReady;
assign sys_ctrl_stop      = sys_ctrl_pllReady;
assign sys_ctrl_standby   = sys_ctrl_pllReady;

assign resetn_out      = ext_resetn;
assign ext_dma_DMACCLR = ext_dma_DMACBREQ;
assign ext_dma_DMACTC  = ext_dma_DMACBREQ;
`endif
endmodule

module alta_mipi_clk(
  input  tx_hs_ckclk,
  input  tx_hs_daclk,
  input  tx_hs_daclkdiv4,
  output tx_hs_ckclk_out,
  output tx_hs_daclk_out,
  output tx_hs_daclkdiv4_out
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
assign tx_hs_ckclk_out     = tx_hs_ckclk;
assign tx_hs_daclk_out     = tx_hs_daclk;
assign tx_hs_daclkdiv4_out = tx_hs_daclkdiv4;
endmodule

module alta_adc (
  input         enb,
  input         sclk,
  input         stop,
  input  [4:0]  insel,
  output [11:0] db,
  output        eoc
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifndef ALTA_SIM
assign db = {12{enb}};
assign eoc = sclk;
`else
wire reset = enb | stop;
reg [4:0] insel_reg;
reg [3:0] counter;
int values[22] = '{22{-1}};
reg [11:0] db_reg;
assign db = db_reg;

task set_value(input [4:0] channel, int v);
  values[channel] = v;
endtask

task set_value_random(input [4:0] channel);
  values[channel] = -1;
endtask

always @ (posedge sclk or posedge reset) begin
  if (reset) begin
    counter <= 0;
  end else if (counter < 13) begin
    counter <= counter + 1;
  end else begin
    counter <= 1;
  end
end

always @ (posedge sclk or posedge reset) begin
  if (reset) begin
    insel_reg <= 5'h0;
  end else if (counter == 0 || counter == 13) begin
    insel_reg <= insel;
  end
end

assign eoc = counter != 13;

always @ (negedge eoc or posedge reset) begin
  if (reset) begin
    db_reg = 0;
  end else begin
    db_reg = values[insel_reg] < 0 ? $urandom() : values[insel_reg];
`ifdef ANALOG_LOG
    $fdisplay(`ANALOG_LOG, "ADC %m channel %d %0s data: 0x%03x, @ %t", insel_reg, values[insel_reg] < 0 ? "random" : "input", db_reg, $time);
`endif
  end
end
`endif
endmodule

module alta_dac (
  input enb, bufenb, stop,
  input [9:0] din,
  output dout
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifndef ALTA_SIM
assign dout = enb;
`else
always @ (enb or stop or din) begin
  if (!enb && !stop) begin
`ifdef ANALOG_LOG
    $fdisplay(`ANALOG_LOG, "DAC %m output data: 0x%03x, @ %t", din, $time);
`endif
  end
end
`endif
endmodule

module alta_cmp (
  input enb1, enb2, hyst1, hyst2, mode1, mode2, stop,
  input [2:0] imsel1, imsel2,
  input [1:0] ipsel1, ipsel2,
  output out1, out2
);
parameter coord_x = 0;
parameter coord_y = 0;
parameter coord_z = 0;
`ifndef ALTA_SIM
assign out1 = enb1;
assign out2 = enb2;
`else
int pvalues1[4] = '{2047, -1, -1, 2047 /* 1/2 VREF */};
int mvalues1[8] = '{2047, -1, -1, -1, 372 /* 1/4 VREFINT */, 745 /* 1/2 VREFINT */, 1117 /* 3/4 VREFINT */, 1489 /* VREFINT */};
int pvalues2[4] = '{2047, -1, -1, 2047};
int mvalues2[8] = '{2047, -1, -1, -1, 372, 745, 1117, 1489};

task set_pvalue1(reg [1:0] psel,  int value);
  pvalues1[psel] = value;
endtask

task set_mvalue1(reg [2:0] msel,  int value);
  mvalues1[msel] = value;
endtask

task set_pvalue2(reg [1:0] psel,  int value);
  pvalues2[psel] = value;
endtask

task set_mvalue2(reg [2:0] msel,  int value);
  mvalues2[msel] = value;
endtask

always @ (*) begin
  if (!enb1 && !stop) begin
    force out1 = (pvalues1[ipsel1] >= 0 && mvalues1[imsel1] >= 0) ? (pvalues1[ipsel1] > mvalues1[imsel1]) : $urandom();
`ifdef ANALOG_LOG
    $fdisplay(`ANALOG_LOG, "CMP1 %m P channel %d %s M channel %d, @ %t", ipsel1, out1 ? ">" : "<", imsel1, $time);
`endif
  end
end

always @ (*) begin
  if (!enb2 && !stop) begin
    force out2 = (pvalues2[ipsel2] >= 0 && mvalues2[imsel2] >= 0) ? (pvalues2[ipsel2] > mvalues2[imsel2]) : $urandom();
`ifdef ANALOG_LOG
    $fdisplay(`ANALOG_LOG, "CMP2 %m P channel %d %s M channel %d, @ %t", ipsel2, out2 ? ">" : "<", imsel2, $time);
`endif
  end
end
`endif
endmodule
`endif

`ifndef ALTA_LIB
module alta_ram4k #(parameter DATA_WIDTH_A    = 18,
                              ADDR_WIDTH_A    = 8,
                              BYTE_WIDTH_A    = 2,
                              DATA_WIDTH_B    = 0,
                              ADDR_WIDTH_B    = 0,
                              BYTE_WIDTH_B    = 0,
                              INIT_VAL        = 4608'b0,
                              CLKMODE         = "read_write",
                              PORTA_WRITEMODE = "normal",
                              PORTB_WRITEMODE = "normal",
                              PORTB_READONLY  = "no",
                              PORTA_OUTREG    = "no",
                              PORTB_OUTREG    = "no",
                              INIT_PORT       = "a") (
  input  [DATA_WIDTH_A-1:0] DataInA,
  input  [DATA_WIDTH_B-1:0] DataInB,
  output [DATA_WIDTH_A-1:0] DataOutA,
  output [DATA_WIDTH_B-1:0] DataOutB,
  input  [ADDR_WIDTH_A-1:0] AddressA,
  input  [ADDR_WIDTH_B-1:0] AddressB,
  input  [BYTE_WIDTH_A-1:0] ByteEnA,
  input  [BYTE_WIDTH_B-1:0] ByteEnB,
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  WeRenA, WeRenB
);

initial
begin
`ifndef ALTA_SYN
  validate(DATA_WIDTH_A, ADDR_WIDTH_A, BYTE_WIDTH_A);
  validate(DATA_WIDTH_B, ADDR_WIDTH_B, BYTE_WIDTH_B);
`endif
end

localparam isSinglePort = DATA_WIDTH_A > 18;

wire portClk0        = Clk0;
wire portClk1        = isSinglePort ? Clk0 : Clk1;
wire portClkEn0      = ClkEn0;
wire portClkEn1      = isSinglePort ? ClkEn0 : ClkEn1;
wire portAsyncReset0 = AsyncReset0;
wire portAsyncReset1 = isSinglePort ? AsyncReset0 : AsyncReset1;
wire portWeRenA      = WeRenA;
wire portWeRenB      = isSinglePort ? WeRenA : WeRenB;

wire [17:0] portDataInA  = portDataIn(DATA_WIDTH_A, DataInA, DataInA[(DATA_WIDTH_A+1)/2-1:0]);
wire [17:0] portDataInB  = portDataIn(DATA_WIDTH_B, DataInB, DataInA[DATA_WIDTH_A-1:DATA_WIDTH_A/2]);
wire [11:0] portAddressA = portAddr(ADDR_WIDTH_A, AddressA, BYTE_WIDTH_A, ByteEnA, 1'b0, AddressA, ByteEnA);
wire [11:0] portAddressB = portAddr(ADDR_WIDTH_B, AddressB, BYTE_WIDTH_B, ByteEnB, 1'b1, AddressA, ByteEnA);
wire [17:0] portDataOutA, portDataOutB;
assign DataOutA = portDataOut(DATA_WIDTH_A, portDataOutA, portDataOutB);
assign DataOutB = portDataOut(DATA_WIDTH_B, portDataOutB, portDataOutB);

alta_bram ram_inst (
  .DataInA(portDataInA), .DataInB(portDataInB),
  .AddressA(portAddressA), .AddressB(portAddressB),
  .DataOutA(portDataOutA), .DataOutB(portDataOutB),
  .Clk0(portClk0), .ClkEn0(portClkEn0), .AsyncReset0(portAsyncReset0),
  .Clk1(portClk1), .ClkEn1(portClkEn1), .AsyncReset1(portAsyncReset1),
  .WeRenA(portWeRenA), .WeRenB(portWeRenB)
);
defparam ram_inst.PORTA_WIDTH     = portCfg(DATA_WIDTH_A);
defparam ram_inst.PORTB_WIDTH     = portCfg(DATA_WIDTH_B);
defparam ram_inst.CLKMODE         = (CLKMODE        == "read_write" ? 1'b0 : (CLKMODE         == "input_output" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_READONLY  = (PORTB_READONLY == "no"         ? 1'b0 : (PORTB_READONLY  == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_OUTREG    = (PORTA_OUTREG   == "no"         ? 1'b0 : (PORTA_OUTREG    == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_OUTREG    = (PORTB_OUTREG   == "no"         ? 1'b0 : (PORTB_OUTREG    == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_WRITEMODE = (PORTA_WRITEMODE == "normal" || PORTA_WRITEMODE == "write_thru" ? 1'b0 : (PORTA_WRITEMODE == "read_before_write" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_WRITEMODE = (PORTB_WRITEMODE == "normal" || PORTB_WRITEMODE == "write_thru" ? 1'b0 : (PORTB_WRITEMODE == "read_before_write" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_WRITETHRU = (PORTA_WRITEMODE == "normal" || PORTA_WRITEMODE == "read_before_write" ? 1'b0 : (PORTA_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_WRITETHRU = (PORTB_WRITEMODE == "normal" || PORTB_WRITEMODE == "read_before_write" ? 1'b0 : (PORTB_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.INIT_VAL        = (INIT_PORT == "a" ? portInitVal(DATA_WIDTH_A, INIT_VAL) : INIT_PORT == "b" ? portInitVal(DATA_WIDTH_B, INIT_VAL) : 4608'b0);

task validate(input integer data_width, input integer addr_width, input integer byte_width);
  reg error;
  begin
    error = 1'b0;
    case (data_width)
      36, 32: if (addr_width >  7 || byte_width != 4) error = 1'b1; // This is only supported in single port
      18, 16: if (addr_width >  8 || byte_width != 2) error = 1'b1;
       9,  8: if (addr_width >  9 || byte_width != 1) error = 1'b1;
           4: if (addr_width > 10 || byte_width >  1) error = 1'b1;
           2: if (addr_width > 11 || byte_width >  1) error = 1'b1;
           1: if (addr_width > 12 || byte_width >  1) error = 1'b1;
           0: error = 1'b0; // port not used
     default: $display("Illegal data width %0d specified", data_width);
    endcase
    if (error)
      $display("Illegal data/address/byte enable width sepcified: %0d/%0d/%0d", data_width, addr_width, byte_width);
    if (addr_width > 0 && addr_width < 7)
      $display("Illegal address width %0d specified", addr_width);
  end
endtask

function [3:0] portCfg(input integer data_width);
  begin
    case (data_width)
      36, 32: portCfg = 4'b0000;
      18, 16: portCfg = 4'b0000;
       9,  8: portCfg = 4'b1000;
           4: portCfg = 4'b1100;
           2: portCfg = 4'b1110;
           1: portCfg = 4'b1111;
           0: portCfg = 4'b0000;
    endcase
  end
endfunction

function [4607:0] portInitVal(input integer data_width, input [4607:0] initVal);
begin : initval
  integer i;
  case (data_width)
    36, 18, 9:
      portInitVal = initVal;
    32, 16, 8, 4, 2, 1:
      for (i = 0; i < 256; i = i + 1)
        portInitVal[i*18+17-:18] = { 1'b0, initVal[i*16+15-:8], 1'b0, initVal[i*16+7-:8] };
    0:
      portInitVal = 4608'b0;
  endcase
end
endfunction

function [17:0] portDataIn(input integer data_width, input [17:0] data, input [17:0] data0);
begin
  case (data_width)
    36: portDataIn = data0[17:0];
    32: portDataIn = { 1'b1, data0[15:8], 1'b1, data0[7:0] };
    18: portDataIn = data[17:0];
    16: portDataIn = { 1'b1, data[15:8], 1'b1, data[7:0] };
     9: portDataIn = { 2{ data[8:0] } };
     8: portDataIn = { 2{ 1'b1, data[7:0] } };
     4: portDataIn = { 2{ 1'b1, { 2{ data[3:0] } } } };
     2: portDataIn = { 2{ 1'b1, { 4{ data[1:0] } } } };
     1: portDataIn = { 2{ 1'b1, { 8{ data[0:0] } } } };
     0: portDataIn = ~18'b0;
  endcase
end
endfunction

function [11:0] portAddr(input integer addr_width, input [11:0] addr, input integer byte_width, input [1:0] byteEn, input portId, input [6:0] addr0, input [3:0] byteEn0);
begin
  case (addr_width)
    12: portAddr = addr;
    11: portAddr = { addr[10:0], 1'b1    };
    10: portAddr = { addr[ 9:0], 2'b11   };
     9: portAddr = { addr[ 8:0], 3'b111  }; // Data width  8 or  9, default byte enable is 2'b11
     8: portAddr = { addr[ 7:0], 4'b1111 }; // Data width 16 or 18, default byte enable is 2'b11
     7: portAddr = { { addr0, portId }, 4'b1111 }; // Data width 32 or 36, lsb is 0/1 depends on port
     0: portAddr = ~12'b0;
  endcase
  case (byte_width)
    4: portAddr[1:0] = byteEn0[(portId+1)*2-1-:2];
    2: portAddr[1:0] = byteEn;
    1: portAddr[1:0] = { 2{ byteEn[0] } };
  endcase
end
endfunction

function [35:0] portDataOut(input integer data_width, input [17:0] data, input [17:0] data0);
begin
  case (data_width)
    36: portDataOut = { data0, data };
    32: portDataOut = { data0[16:9], data0[7:0], data[16:9], data[7:0] };
    18: portDataOut = data;
    16: portDataOut = { data[16:9], data[7:0] };
     9: portDataOut = { data[7], data[16:9] };
     8: portDataOut = data[16:9];
     4: portDataOut = data[ 6:3];
     2: portDataOut = data[ 2:1];
     1: portDataOut = data[ 0:0];
     0: portDataOut = 36'b0;
  endcase
end
endfunction

endmodule

module alta_ram9k #(parameter DATA_WIDTH_A    = 18,
                              ADDR_WIDTH_A    = 9,
                              BYTE_WIDTH_A    = 2,
                              DATA_WIDTH_B    = 0,
                              ADDR_WIDTH_B    = 0,
                              BYTE_WIDTH_B    = 0,
                              INIT_VAL        = 9216'b0,
                              CLKMODE         = "read_write",
                              OPERATION_MODE  = "single_port",
                              PACKEDMODE      = "no",
                              PORTA_CLKIN_EN  = "yes",
                              PORTA_CLKOUT_EN = "yes",
                              PORTB_CLKIN_EN  = "yes",
                              PORTB_CLKOUT_EN = "yes",
                              PORTA_RSTIN_EN  = "yes",
                              PORTA_RSTOUT_EN = "yes",
                              PORTB_RSTIN_EN  = "yes",
                              PORTB_RSTOUT_EN = "yes",
                              PORTA_WRITEMODE = "normal",
                              PORTB_WRITEMODE = "normal",
                              PORTA_OUTREG    = "no",
                              PORTB_OUTREG    = "no",
                              INIT_PORT       = "a") (
  input  [DATA_WIDTH_A-1:0] DataInA,
  input  [DATA_WIDTH_B-1:0] DataInB,
  output [DATA_WIDTH_A-1:0] DataOutA,
  output [DATA_WIDTH_B-1:0] DataOutB,
  input  [ADDR_WIDTH_A-1:0] AddressA,
  input  [ADDR_WIDTH_B-1:0] AddressB,
  input  [BYTE_WIDTH_A-1:0] ByteEnA,
  input  [BYTE_WIDTH_B-1:0] ByteEnB,
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  AddressStallA, WeA, ReA,
  input  AddressStallB, WeB, ReB
);

initial
begin
`ifndef ALTA_SYN
  validate(DATA_WIDTH_A, ADDR_WIDTH_A, BYTE_WIDTH_A);
  validate(DATA_WIDTH_B, ADDR_WIDTH_B, BYTE_WIDTH_B);
`endif
end

localparam isSinglePort  = OPERATION_MODE == "single_port" && DATA_WIDTH_A > 18 ;
localparam isSingleClock = OPERATION_MODE == "single_port" && CLKMODE != "input_output";
// Use packed mode in single port with each data port providing half the total data width
localparam DATA_WIDTH_P  = isSinglePort ? DATA_WIDTH_A / 2 : DATA_WIDTH_A;

wire portClk0        = Clk0;
wire portClk1        = isSingleClock ? Clk0 : Clk1;
wire portClkEn0      = ClkEn0;
wire portClkEn1      = isSingleClock ? ClkEn0 : ClkEn1;
wire portAsyncReset0 = AsyncReset0;
wire portAsyncReset1 = isSingleClock ? AsyncReset0 : AsyncReset1;
wire portWeA         = WeA;
wire portWeB         = isSinglePort ? WeA : WeB;
wire portReA         = ReA;
wire portReB         = isSinglePort ? ReA : ReB;

wire [17:0] portDataInA  = portDataIn(DATA_WIDTH_A, DataInA, DATA_WIDTH_A, DataInA[(DATA_WIDTH_A+1)/2-1:0]);
wire [17:0] portDataInB  = portDataIn(DATA_WIDTH_B, DataInB, DATA_WIDTH_A, DataInA[DATA_WIDTH_A-1:DATA_WIDTH_A/2]);
wire [12:0] portAddressA = portAddr(DATA_WIDTH_P, AddressA);
wire [12:0] portAddressB = isSinglePort ? portAddressA : portAddr(DATA_WIDTH_B, AddressB);
wire [ 1:0] portByteEnA  = portByteEn(BYTE_WIDTH_A, ByteEnA, BYTE_WIDTH_A, 1'b0, ByteEnA);
wire [ 1:0] portByteEnB  = portByteEn(BYTE_WIDTH_B, ByteEnB, BYTE_WIDTH_A, 1'b1, ByteEnA);
wire [17:0] portDataOutA, portDataOutB;
assign DataOutA = portDataOut(DATA_WIDTH_A, portDataOutA, portDataOutB);
assign DataOutB = portDataOut(DATA_WIDTH_B, DATA_WIDTH_B > 18 ? portDataOutA : portDataOutB, portDataOutB);

alta_bram9k ram_inst (
  .DataInA(portDataInA), .DataInB(portDataInB),
  .AddressA(portAddressA), .AddressB(portAddressB),
  .DataOutA(portDataOutA), .DataOutB(portDataOutB),
  .Clk0(portClk0), .ClkEn0(portClkEn0), .AsyncReset0(portAsyncReset0),
  .Clk1(portClk1), .ClkEn1(portClkEn1), .AsyncReset1(portAsyncReset1),
  .ByteEnA(portByteEnA), .ByteEnB(portByteEnB),
  .WeA(portWeA), .WeB(portWeB),
  .ReA(portReA), .ReB(portReB),
  .AddressStallA(AddressStallA), .AddressStallB(AddressStallB)
);
defparam ram_inst.PORTA_WIDTH     = portCfg(DATA_WIDTH_P);
defparam ram_inst.PORTB_WIDTH     = portCfg(isSinglePort ? DATA_WIDTH_P : DATA_WIDTH_B);
defparam ram_inst.CLKMODE         = (CLKMODE == "independent" ? 2'b00 : (CLKMODE == "input_output" ? 2'b01 : (CLKMODE == "read_write" ? 2'b10: 2'bx)));
defparam ram_inst.PACKEDMODE      = isSinglePort ? 1'b1 : (PACKEDMODE == "no" ? 1'b0 : (PACKEDMODE == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_CLKIN_EN  = (PORTA_CLKIN_EN  == "no" ? 1'b0 : (PORTA_CLKIN_EN  == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_CLKOUT_EN = (PORTA_CLKOUT_EN == "no" ? 1'b0 : (PORTA_CLKOUT_EN == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_CLKIN_EN  = (PORTB_CLKIN_EN  == "no" ? 1'b0 : (PORTB_CLKIN_EN  == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_CLKOUT_EN = (PORTB_CLKOUT_EN == "no" ? 1'b0 : (PORTB_CLKOUT_EN == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_RSTIN_EN  = (PORTA_RSTIN_EN  == "no" ? 1'b0 : (PORTA_RSTIN_EN  == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_RSTOUT_EN = (PORTA_RSTOUT_EN == "no" ? 1'b0 : (PORTA_RSTOUT_EN == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_RSTIN_EN  = (PORTB_RSTIN_EN  == "no" ? 1'b0 : (PORTB_RSTIN_EN  == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_RSTOUT_EN = (PORTB_RSTOUT_EN == "no" ? 1'b0 : (PORTB_RSTOUT_EN == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_OUTREG    = (PORTA_OUTREG    == "no" ? 1'b0 : (PORTA_OUTREG    == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_OUTREG    = (PORTB_OUTREG    == "no" ? 1'b0 : (PORTB_OUTREG    == "yes" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_WRITETHRU = (PORTA_WRITEMODE == "normal" || PORTA_WRITEMODE == "read_before_write" ? 1'b0 : (PORTA_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_WRITETHRU = (PORTB_WRITEMODE == "normal" || PORTB_WRITEMODE == "read_before_write" ? 1'b0 : (PORTB_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.INIT_VAL        = (INIT_PORT == "a" ? portInitVal(DATA_WIDTH_A, INIT_VAL) : INIT_PORT == "b" ? portInitVal(DATA_WIDTH_B, INIT_VAL) : 9216'b0);

task validate(input integer data_width, input integer addr_width, input integer byte_width);
  reg error;
  begin
    error = 1'b0;
    case (data_width)
      36, 32: if (addr_width >  8 || byte_width != 4) error = 1'b1;
      18, 16: if (addr_width >  9 || byte_width != 2) error = 1'b1;
       9,  8: if (addr_width > 10 || byte_width != 1) error = 1'b1;
           4: if (addr_width > 11 || byte_width >  1) error = 1'b1;
           2: if (addr_width > 12 || byte_width >  1) error = 1'b1;
           1: if (addr_width > 13 || byte_width >  1) error = 1'b1;
           0: error = 1'b0; // port not used
     default: $display("Memory %m has illegal data width %0d specified", data_width);
    endcase
    if (error)
      $display("Memory %m has illegal data/address/byte enable width sepcified: %0d/%0d/%0d", data_width, addr_width, byte_width);
    if (addr_width > 0 && addr_width < 8)
      $display("Memory %m has illegal address width %0d specified", addr_width);
  end
endtask

function [4:0] portCfg(input integer data_width);
  begin
    case (data_width)
      36, 32: portCfg = 5'b10000;
      18, 16: portCfg = 5'b00000;
       9,  8: portCfg = 5'b01000;
           4: portCfg = 5'b01100;
           2: portCfg = 5'b01110;
           1: portCfg = 5'b01111;
           0: portCfg = 5'b00000;
    endcase
  end
endfunction

function [9215:0] portInitVal(input integer data_width, input [9215:0] initVal);
begin : initval
  integer i;
  if (isSinglePort) begin
    for (i = 0; i < 256; i = i + 1) begin
      portInitVal[i*18     +:18] = data_width == 36 ? initVal[i*36   +:18] : { 1'b0, initVal[i*32+ 8+:8], 1'b0, initVal[i*32   +:8] };
      portInitVal[i*18+4608+:18] = data_width == 36 ? initVal[i*36+18+:18] : { 1'b0, initVal[i*32+24+:8], 1'b0, initVal[i*32+16+:8] };
    end
  end else begin
    case (data_width)
      36, 18, 9:
        portInitVal = initVal;
      32, 16, 8, 4, 2, 1:
        for (i = 0; i < 512; i = i + 1)
          portInitVal[i*18+:18] = { 1'b0, initVal[i*16+8+:8], 1'b0, initVal[i*16+:8] };
      0:
        portInitVal = 9216'b0;
    endcase
  end
end
endfunction

function [17:0] portDataIn(input integer data_width, input [17:0] data, input integer data_width0, input [17:0] data0);
begin
  case (data_width0)
    36: portDataIn = data0[17:0];
    32: portDataIn = { 1'b1, data0[15:8], 1'b1, data0[7:0] };
    default:
      case(data_width)
        18: portDataIn = data[17:0];
        16: portDataIn = { 1'b1, data[15:8], 1'b1, data[7:0] };
         9: portDataIn = { 2{ data[8:0] } };
         8: portDataIn = { 2{ 1'b1, data[7:0] } };
         4: portDataIn = { 2{ 1'b1, { 2{ data[3:0] } } } };
         2: portDataIn = { 2{ 1'b1, { 4{ data[1:0] } } } };
         1: portDataIn = { 2{ 1'b1, { 8{ data[0:0] } } } };
         0: portDataIn = ~18'b0;
      endcase
  endcase
end
endfunction

function [12:0] portAddr(input integer data_width, input [13:0] addr);
begin
  case (data_width)
    1:     portAddr = addr;
    2:     portAddr = { addr[11:0], 1'b1     };
    4:     portAddr = { addr[10:0], 2'b11    };
    8,9:   portAddr = { addr[ 9:0], 3'b111   };
    16,18: portAddr = { addr[ 8:0], 4'b1111  };
    32,36: portAddr = { addr[ 7:0], 5'b11111 };
    0:     portAddr = ~13'b0;
  endcase
end
endfunction

function [1:0] portByteEn(input integer byte_width, input [3:0] byteEn, input integer byte_width0, input integer portId, input [3:0] byteEn0);
begin
  case (byte_width0)
    4: portByteEn[1:0] = byteEn0[portId*2+1-:2];
    default:
      case(byte_width)
        2: portByteEn[1:0] = byteEn;
        1: portByteEn[1:0] = { 2{ byteEn[0] } };
        0: portByteEn[1:0] = 2'b11;
      endcase
  endcase
end
endfunction

function [35:0] portDataOut(input integer data_width, input [17:0] data, input [17:0] data0);
begin
  case (data_width)
    36: portDataOut = { data0, data };
    32: portDataOut = { data0[16:9], data0[7:0], data[16:9], data[7:0] };
    18: portDataOut = data;
    16: portDataOut = { data[16:9], data[7:0] };
     9: portDataOut = { data[7], data[16:9] };
     8: portDataOut = data[16:9];
     4: portDataOut = data[ 6:3];
     2: portDataOut = data[ 2:1];
     1: portDataOut = data[ 0:0];
     0: portDataOut = 36'b0;
  endcase
end
endfunction

endmodule
`endif
