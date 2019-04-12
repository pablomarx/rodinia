module Blinky(
	input wire clk,
   output wire[7:0] bank0,
   output wire[7:0] bank1,
   output wire[7:0] bank2,
   output wire[7:0] bank3
);

reg [31:0] counter;
reg [35:0] data;

prom mem(.Clk0(clk), .ClkEn0(1'b1), .AddressA(counter[6:0]), .DataOutA(data));

assign bank0 = data[7:0];
assign bank1 = data[15:8];
assign bank2 = data[23:16];
assign bank3 = data[31:24];

always @(posedge clk) begin
        counter <= counter + 1;
end

endmodule
