`timescale 1ns/1ps
module PLL40(
   input clkin,
   input resetn,
   input clkout0en,
  output clkout0,
  output lock
);

wire PLL40_clkout0;
wire PLL40_lock;

alta_pllx PLL40_AD8D879E(
  .clkin(clkin),
  .pllen(1'b1),
  .resetn(resetn),
  .clkout0en(clkout0en),
  .clkout0(PLL40_clkout0),
  .lock(PLL40_lock)
);
defparam PLL40_AD8D879E.CLKIN_DIV = 6'h01;
defparam PLL40_AD8D879E.CLKFB_DIV = 6'h3F;
defparam PLL40_AD8D879E.CLKDIV0_EN = 1'h1;
defparam PLL40_AD8D879E.CLKOUT0_DIV = 6'h08;
defparam PLL40_AD8D879E.CLKOUT0_DEL = 6'h00;
defparam PLL40_AD8D879E.CLKOUT0_PHASE = 3'h0;
defparam PLL40_AD8D879E.CLKDIV1_EN = 1'h0;
defparam PLL40_AD8D879E.CLKOUT1_DIV = 6'h3F;
defparam PLL40_AD8D879E.CLKOUT1_DEL = 6'h00;
defparam PLL40_AD8D879E.CLKOUT1_PHASE = 3'h0;
defparam PLL40_AD8D879E.CLKDIV2_EN = 1'h0;
defparam PLL40_AD8D879E.CLKOUT2_DIV = 6'h3F;
defparam PLL40_AD8D879E.CLKOUT2_DEL = 6'h00;
defparam PLL40_AD8D879E.CLKOUT2_PHASE = 3'h0;
defparam PLL40_AD8D879E.CLKDIV3_EN = 1'h0;
defparam PLL40_AD8D879E.CLKOUT3_DIV = 6'h3F;
defparam PLL40_AD8D879E.CLKOUT3_DEL = 6'h00;
defparam PLL40_AD8D879E.CLKOUT3_PHASE = 3'h0;
defparam PLL40_AD8D879E.FEEDBACK_MODE = 1'b0;
defparam PLL40_AD8D879E.FEEDBACK_CLOCK = 2'b00;

assign clkout0 = PLL40_clkout0;
assign lock = PLL40_lock;

endmodule

