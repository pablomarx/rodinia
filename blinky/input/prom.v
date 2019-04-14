`timescale 1ns/1ps
module prom(
   input clka,
   input clkb,

   input [6:0] addra,
   input [6:0] addrb,

   output [35:0] douta,
   output [35:0] doutb,

   input wea,
   input [35:0] dina
);


alta_bram ram_inst (
  .DataInA(dina), 
  .AddressA(addra), .AddressB(addrb),
  .DataOutA(douta), .DataOutB(doutb),
  .Clk0(clka), .ClkEn0(1'b1), .AsyncReset0(1'b0),
  .Clk1(clkb), .ClkEn1(1'b1), .AsyncReset1(1'b0),
  .WeRenA(wea), .WeRenB(1'b0)
);

defparam ram_inst.PORTA_WIDTH     = 36;
defparam ram_inst.PORTB_WIDTH     = 36;
defparam ram_inst.CLKMODE         = "read_write";
defparam ram_inst.PORTB_READONLY  = 1'b1;
defparam ram_inst.PORTA_OUTREG    = 1'b0;
defparam ram_inst.PORTB_OUTREG    = 1'b0;
defparam ram_inst.PORTA_WRITEMODE = 1'b0;
defparam ram_inst.PORTB_WRITEMODE = 1'b0;
defparam ram_inst.PORTA_WRITETHRU = 1'b0;
defparam ram_inst.PORTB_WRITETHRU = 1'b0;
defparam ram_inst.INIT_VAL        = 4608'hf70a825ca74b2de9ef0d77a973d13517857ad2b60ac1f6d468a97e57dc84305f5c444cc1ad08fa8cc8ec839a57d6a58f1f49916ea3015c6970698de2215ac5d1779ccab6fff7f630494953941150fa26da2455dea0288ee9003adf11ad2186ea58e16e618610f99d614d5ec815f6dceb6bc5f2a8c9823b2a0330c325ee1035bf65490321dd7a6f6173fe38204c86b4f2d71e40a4f554aaa572ba8e4a93652dada229bb1fb959930b2bdbe7950b69234219e233c5b0d99732948c5b810305e7734fc29270768687c32b36a91c631bb73816fe6ee45e1b0cce6794a2d331fdd83d1f9b491444324e1e7f6b6622ae71383e98427a3e5ee2b411f67c63ecf702cc3631fb44bf046e208d857dc556e717351e1a60be83cfcbcc509d58f16d8544fa0604eee66fcc6110350859cc95c86949286a81addf3fb88f2be190dcfbb5343f35abcf6890efcf2063d7137324356a0ad23ef44cce89fd36038bf5fe999db49b20ed733c4dbe4247d4d83a6ada678e40d4e0ea12c2837f1d7baaba2ff2c8c06bd5b13e4395371741fbc08b5b36784d3c180208a68c548f327d219a3a9e6c15d00727b2cd82a6172005fa2c394c2f4f9405d3b42e529713712dfa77620090f69cfd7d309d882cc8921fafb0e4a4f9f79ac6d04efb96f8ab5dd1c0d4de5bc4320518cb3dae391c977a73e70dda5f96ec156b9608cffcd99dae35e58c8bee6d3e918a05e386b07c8fc1c1b5c54d6d57908b72a3796da218f6ef4a48e81fdbbdca0e721e9f2120301c6ebc4cc51fc6a41a914eea1476525472a5d9880080747bf85007;



endmodule
