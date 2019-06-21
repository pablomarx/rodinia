module Blinky(
	input wire clk,
   output wire[7:0] bank0,
   output wire[7:0] bank1,
   output wire[7:0] bank2,
   output wire[7:0] bank3
);

reg [10:0] addr;
reg [31:0] data;
reg [14:0] counter;
reg ramclk;

prom prom(
	.clka(ramclk), .clkb(~ramclk),
	.addra(addr), .addrb(addr),
	.dout(data), .wea(1'b0),
	.din(32'b0)
);

assign bank0 = data[7:0];
assign bank1 = data[15:8];
assign bank2 = data[23:16];
assign bank3 = data[31:24];

always @(posedge ramclk) begin
	addr <= addr + 1;
end

always @(posedge clk) begin
	counter <= counter + 1;
	ramclk <= (counter == 0);
end

endmodule
