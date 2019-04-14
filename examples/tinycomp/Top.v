`timescale 1ns / 1ps 
module Top (
	input wire clk,
	output wire[7:0] bank0,
	output wire[7:0] bank1,
	output wire[7:0] bank2,
	output wire[7:0] bank3
);

// TinyComp I/O
wire [31:0] IOvalue;
wire [31:0] IOaddr;
wire IOread;
wire IOwrite;

wire writeLED;
reg [7:0] LEDs;

assign writeLED = IOwrite & (IOaddr == 32'h000003ff);
assign bank0 = LEDs;
assign bank1 = LEDs;
assign bank2 = LEDs;
assign bank3 = LEDs;

// The CPU
TinyComp tc(
	.Ph0(clk), .Ph1(~clk), .Reset(1'b0), 
	.IOaddr(IOaddr), .OutData(IOvalue), 
	.InData(32'b0), .InRdy(1'b1), .InStrobe(IOread), .OutStrobe(IOwrite)
);

always @(posedge clk) begin
	if (writeLED) begin
		LEDs <= IOvalue[7:0];
	end
end

endmodule
