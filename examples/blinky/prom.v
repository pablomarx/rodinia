`timescale 1ns/1ps
module prom(
   input clka,
   input clkb,

   input [10:0] addra,
   input [10:0] addrb,

   output [31:0] dout,

   input wea,
   input [31:0] din
);

wire [6:0] addr;

always @(*) begin
	if (clka) addr <= addra;
	else addr <= addrb;
end

alta_bram ram_inst (
  .AddressA({addra,1'b0}), .DataInA({2'b0, din[15:0]}), .DataOutA(dout[15:0]),
  .AddressB({addrb,1'b1}), .DataInB({2'b0, din[31:16]}), .DataOutB(dout[31:16]),

  .Clk0(clka), .ClkEn0(1'b1), .AsyncReset0(1'b0),
  .Clk1(clka), .ClkEn1(1'b1), .AsyncReset1(1'b0),
  .WeRenA(wea), .WeRenB(wea)
);

defparam ram_inst.CLKMODE         = 1'b1;	/* read_write, input_output */
defparam ram_inst.PORTA_WIDTH     = 4'b1111;
defparam ram_inst.PORTB_WIDTH     = 4'b1111;
defparam ram_inst.PORTA_WRITEMODE = 1'b0;	/* normal, read_before_write, write_thru */
defparam ram_inst.PORTB_WRITEMODE = 1'b0;
defparam ram_inst.PORTA_WRITETHRU = 1'b0;
defparam ram_inst.PORTB_WRITETHRU = 1'b0;
defparam ram_inst.PORTA_OUTREG    = 1'b1;	/* no, yes */
defparam ram_inst.PORTB_OUTREG    = 1'b1;
defparam ram_inst.PORTB_READONLY  = 1'b0;
defparam ram_inst.Clk0CFG         = 2'b00;
defparam ram_inst.Clk1CFG         = 2'b00;
defparam ram_inst.INIT_VAL        = 4608'h00ff00ff00ffff00ff00000000ff00000000000000ff0000000000000000000000ff000000000000ff00000000000000ff000000ff0000ff0000ff00ff00ff00ff00ff00000000ff0000000000000000000000ff000000ff000000ff000000ff00000000ff00000000ff0000000000ff000000000000ff000000000000ffff00000000000000ffff00000000000000ffff00000000000000000000ffff0000000000000000000000ffff00000000000000000000000000ffffff00000000000000000000000000000000ffffffff000000000000000000000000000000000000ffffffffff000000000000000000000000000000000000000000000000ffffffffffff000000000000000000000000000000000000000000000000000000000000ffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000;

endmodule
