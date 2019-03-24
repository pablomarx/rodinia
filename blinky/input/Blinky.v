module Blinky(
	input wire clk,
   output wire[7:0] bank0,
   output wire[7:0] bank1,
   output wire[7:0] bank2,
   output wire[7:0] bank3
);

reg [31:0] counter;

assign bank0[0] = counter[20];
assign bank0[1] = counter[21];
assign bank0[2] = counter[22];
assign bank0[3] = counter[23];
assign bank0[4] = counter[24];
assign bank0[5] = counter[25];
assign bank0[6] = counter[26];
assign bank0[7] = counter[27];

assign bank1 = bank0;
assign bank2 = bank1;
assign bank3 = bank2;

always @(posedge clk) begin
        counter <= counter + 1;
end

endmodule