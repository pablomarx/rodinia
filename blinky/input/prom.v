/*
Dimension: ((1,1) - (1,1))
*/
`timescale 1ns/1ps
module prom(
   input Clk0,
   input ClkEn0,
   input AsyncReset0,
   input WeRenA,
   input [35:0] DataInA,
   input [7:0] AddressA,
  output [35:0] DataOutA
);

wire [35:0] output_muxA_Dout;
wire [35:0] prom_0_DataOutA;
wire [35:0] prom_0_DataOutB;

promA_Decoder0to1 write_decoderA_1D1E2770(
  .Enable(WeRenA),
  .Din(),
  .Dout(write_decoderA_Dout)
);

promA_Mux36to36 output_muxA_E078A5E9(
  .Select(),
  .Din(prom_0_DataOutA[35:0]),
  .Dout(output_muxA_Dout)
);

promA_Register0 registersA0_523B1262(
  .Clk(Clk0),
  .ClkEn(read_andA_Dout),
  .AsyncReset(AsyncReset0),
  .Din(),
  .Qout()
);

promA_not1 read_invA_0B5BE198(
  .Din(WeRenA),
  .Dout(read_invA_Dout)
);

readAndAand2 read_andA_37EBE007(
  .Din({ ClkEn0, read_invA_Dout }),
  .Dout(read_andA_Dout)
);

/*
Instance: X0, Y0
*/
alta_ram4k prom_0_6526DEFE(
  .Clk0(Clk0),
  .Clk1(~1'b0),
  .ClkEn0(ClkEn0),
  .ClkEn1(~1'b0),
  .AsyncReset0(AsyncReset0),
  .AsyncReset1(~1'b0),
  .AddressA(AddressA[7:0]),
  .DataInA(DataInA[35:0]),
  .WeRenA(write_decoderA_Dout),
  .ByteEnA({ 1'b1, 1'b1, 1'b1, 1'b1 }),
  .AddressB(~7'b0),
  .DataInB({ 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1 }),
  .WeRenB(~1'b0),
  .ByteEnB({ 1'b1, 1'b1, 1'b1, 1'b1 }),
  .DataOutA(prom_0_DataOutA),
  .DataOutB(prom_0_DataOutB)
);
defparam prom_0_6526DEFE.CLKMODE = "read_write";
defparam prom_0_6526DEFE.DATA_WIDTH_A = 36;
defparam prom_0_6526DEFE.ADDR_WIDTH_A = 7;
defparam prom_0_6526DEFE.BYTE_WIDTH_A = 4;
defparam prom_0_6526DEFE.PORTA_WRITEMODE = "normal";
defparam prom_0_6526DEFE.PORTA_OUTREG = "no";
defparam prom_0_6526DEFE.DATA_WIDTH_B = 36;
defparam prom_0_6526DEFE.ADDR_WIDTH_B = 7;
defparam prom_0_6526DEFE.BYTE_WIDTH_B = 4;
defparam prom_0_6526DEFE.PORTB_WRITEMODE = "normal";
defparam prom_0_6526DEFE.PORTB_OUTREG = "no";
defparam prom_0_6526DEFE.INIT_PORT = "a";
defparam prom_0_6526DEFE.INIT_VAL = 4608'hf70a825ca74b2de9ef0d77a973d13517857ad2b60ac1f6d468a97e57dc84305f5c444cc1ad08fa8cc8ec839a57d6a58f1f49916ea3015c6970698de2215ac5d1779ccab6fff7f630494953941150fa26da2455dea0288ee9003adf11ad2186ea58e16e618610f99d614d5ec815f6dceb6bc5f2a8c9823b2a0330c325ee1035bf65490321dd7a6f6173fe38204c86b4f2d71e40a4f554aaa572ba8e4a93652dada229bb1fb959930b2bdbe7950b69234219e233c5b0d99732948c5b810305e7734fc29270768687c32b36a91c631bb73816fe6ee45e1b0cce6794a2d331fdd83d1f9b491444324e1e7f6b6622ae71383e98427a3e5ee2b411f67c63ecf702cc3631fb44bf046e208d857dc556e717351e1a60be83cfcbcc509d58f16d8544fa0604eee66fcc6110350859cc95c86949286a81addf3fb88f2be190dcfbb5343f35abcf6890efcf2063d7137324356a0ad23ef44cce89fd36038bf5fe999db49b20ed733c4dbe4247d4d83a6ada678e40d4e0ea12c2837f1d7baaba2ff2c8c06bd5b13e4395371741fbc08b5b36784d3c180208a68c548f327d219a3a9e6c15d00727b2cd82a6172005fa2c394c2f4f9405d3b42e529713712dfa77620090f69cfd7d309d882cc8921fafb0e4a4f9f79ac6d04efb96f8ab5dd1c0d4de5bc4320518cb3dae391c977a73e70dda5f96ec156b9608cffcd99dae35e58c8bee6d3e918a05e386b07c8fc1c1b5c54d6d57908b72a3796da218f6ef4a48e81fdbbdca0e721e9f2120301c6ebc4cc51fc6a41a914eea1476525472a5d9880080747bf85007;

assign DataOutA = output_muxA_Dout[35:0];

endmodule

`timescale 1ns/1ps
module promA_not1(
   input Din,
  output Dout
);
not (Dout, Din);
endmodule

`timescale 1ns/1ps
module readAndAand2(
   input [1:0] Din,
  output Dout
);
and (Dout, Din[0], Din[1]);
endmodule

`timescale 1ns/1ps
module promA_Mux36to36(
   input [35:0] Din,
   input Select,
  output reg [35:0] Dout
);
always @ (Din)
  Dout = Din;
endmodule

`timescale 1ns/1ps
module promA_Decoder0to1(
   input Enable,
   input Din,
  output Dout
);
assign Dout = Enable;
endmodule

`timescale 1ns/1ps
module promA_Register0(
   input Clk,
   input ClkEn,
   input AsyncReset,
   input Din,
  output reg Qout
);
endmodule


