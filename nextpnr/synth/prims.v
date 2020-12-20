// LUT and DFF are combined to a GENERIC_SLICE

module LUT #(
	parameter K = 4,
	parameter [2**K-1:0] INIT = 0,
) (
	input [K-1:0] I,
	output Q
);
	assign Q = INIT[I];
endmodule

module DFF (
	input CLK, D,
	output reg Q
);
	always @(posedge CLK)
		Q <= D;
endmodule

module GENERIC_SLICE #(
	parameter K = 4,
	parameter [2**K-1:0] INIT = 0,
	parameter FF_USED = 1'b0
) (
	input CLK,
	input [K-1:0] I,
	output F,
	output Q
);
	wire f_wire;
	
	LUT #(.K(K), .INIT(INIT)) lut_i(.I(I), .Q(f_wire));

	DFF dff_i(.CLK(CLK), .D(f_wire), .Q(Q));

	assign F = f_wire;
endmodule

module GENERIC_IOB #(
	parameter INPUT_USED = 1'b0,
	parameter OUTPUT_USED = 1'b0,
	parameter ENABLE_USED = 1'b0
) (
	inout PAD,
	input I, EN,
	output O
);
	generate if (OUTPUT_USED && ENABLE_USED)
		assign PAD = EN ? I : 1'bz;
	else if (OUTPUT_USED)
		assign PAD = I;
	endgenerate

	generate if (INPUT_USED)
		assign O = PAD;
	endgenerate
endmodule

module GENERIC_BRAM #(
	parameter INIT_VAL        = 4608'b0,
) (
	input  [17:0]  DataInA,  DataInB,
	input  [11:0] AddressA, AddressB,
	output [17:0] DataOutA, DataOutB,
	input  Clk0, ClkEn0, AsyncReset0,
	input  Clk1, ClkEn1, AsyncReset1,
	input  WeRenA, WeRenB
);
endmodule

module GENERIC_PLL #(
  parameter CLKOUT0_DIV = 6'b000000,
  parameter CLKOUT1_DIV = 6'b000000,
  parameter CLKOUT2_DIV = 6'b000000,
  parameter CLKOUT3_DIV = 6'b000000,
  parameter CLKOUT0_DEL = 6'b000000,
  parameter CLKOUT1_DEL = 6'b000000,
  parameter CLKOUT2_DEL = 6'b000000,
  parameter CLKOUT3_DEL = 6'b000000,
) (
	input clkin,
	input clkout0en, clkout1en, clkout2en, clkout3en,
	output clkout0, clkout1, clkout2, clkout3,
	input pllen,
	input resetn,
	input clkfb
);

endmodule

(* blackbox *)
module alta_boot (
  input i_osc_enb,
  output o_osc,
);
endmodule
