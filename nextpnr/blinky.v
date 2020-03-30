module top;

	wire clk;
	(* BEL="IOTILE(01,07,00)", keep *)
	GENERIC_IOB #(.INPUT_USED(1), .OUTPUT_USED(0)) clk_ibuf (.O(clk));

	wire [7:0] leds;
	(* BEL="IOTILE(01,02,00)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led7_obuf (.I(leds[7]));
	(* BEL="IOTILE(01,02,01)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led6_obuf (.I(leds[6]));
	(* BEL="IOTILE(01,04,00)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led5_obuf (.I(leds[5]));
	(* BEL="IOTILE(01,04,01)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led4_obuf (.I(leds[4]));
	(* BEL="IOTILE(01,05,00)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led3_obuf (.I(leds[3]));
	(* BEL="IOTILE(01,05,01)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led2_obuf (.I(leds[2]));
	(* BEL="IOTILE(01,05,02)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led1_obuf (.I(leds[1]));
	(* BEL="IOTILE(01,05,03)", keep *)
	GENERIC_IOB #(.INPUT_USED(0), .OUTPUT_USED(1)) led0_obuf (.I(leds[0]));

reg [25:0] ctr;
always @(posedge clk)
	ctr <= ctr + 1'b1;

assign leds = ctr[25:18];

endmodule