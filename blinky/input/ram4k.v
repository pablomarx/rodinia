module alta_ram4k #(parameter DATA_WIDTH_A    = 18,
                              ADDR_WIDTH_A    = 8,
                              BYTE_WIDTH_A    = 2,
                              DATA_WIDTH_B    = 0,
                              ADDR_WIDTH_B    = 0,
                              BYTE_WIDTH_B    = 0,
                              INIT_VAL        = 4608'b0,
                              CLKMODE         = "read_write",
                              PORTA_WRITEMODE = "normal",
                              PORTB_WRITEMODE = "normal",
                              PORTB_READONLY  = "no",
                              PORTA_OUTREG    = "no",
                              PORTB_OUTREG    = "no",
                              INIT_PORT       = "a") (
  input  [DATA_WIDTH_A-1:0] DataInA,
  input  [DATA_WIDTH_B-1:0] DataInB,
  output [DATA_WIDTH_A-1:0] DataOutA,
  output [DATA_WIDTH_B-1:0] DataOutB,
  input  [ADDR_WIDTH_A-1:0] AddressA,
  input  [ADDR_WIDTH_B-1:0] AddressB,
  input  [BYTE_WIDTH_A-1:0] ByteEnA,
  input  [BYTE_WIDTH_B-1:0] ByteEnB,
  input  Clk0, ClkEn0, AsyncReset0,
  input  Clk1, ClkEn1, AsyncReset1,
  input  WeRenA, WeRenB
);

localparam isSinglePort = DATA_WIDTH_A > 18;

wire portClk0        = Clk0;
wire portClk1        = isSinglePort ? Clk0 : Clk1;
wire portClkEn0      = ClkEn0;
wire portClkEn1      = isSinglePort ? ClkEn0 : ClkEn1;
wire portAsyncReset0 = AsyncReset0;
wire portAsyncReset1 = isSinglePort ? AsyncReset0 : AsyncReset1;
wire portWeRenA      = WeRenA;
wire portWeRenB      = isSinglePort ? WeRenA : WeRenB;

wire [17:0] portDataInA  = portDataIn(DATA_WIDTH_A, DataInA, DataInA[(DATA_WIDTH_A+1)/2-1:0]);
wire [17:0] portDataInB  = portDataIn(DATA_WIDTH_B, DataInB, DataInA[DATA_WIDTH_A-1:DATA_WIDTH_A/2]);
wire [11:0] portAddressA = portAddr(ADDR_WIDTH_A, AddressA, BYTE_WIDTH_A, ByteEnA, 1'b0, AddressA, ByteEnA);
wire [11:0] portAddressB = portAddr(ADDR_WIDTH_B, AddressB, BYTE_WIDTH_B, ByteEnB, 1'b1, AddressA, ByteEnA);
wire [17:0] portDataOutA, portDataOutB;
assign DataOutA = portDataOut(DATA_WIDTH_A, portDataOutA, portDataOutB);
assign DataOutB = portDataOut(DATA_WIDTH_B, portDataOutB, portDataOutB);

alta_bram ram_inst (
  .DataInA(portDataInA), .DataInB(portDataInB),
  .AddressA(portAddressA), .AddressB(portAddressB),
  .DataOutA(portDataOutA), .DataOutB(portDataOutB),
  .Clk0(portClk0), .ClkEn0(portClkEn0), .AsyncReset0(portAsyncReset0),
  .Clk1(portClk1), .ClkEn1(portClkEn1), .AsyncReset1(portAsyncReset1),
  .WeRenA(portWeRenA), .WeRenB(portWeRenB)
);
defparam ram_inst.PORTA_WIDTH     = portCfg(DATA_WIDTH_A);
defparam ram_inst.PORTB_WIDTH     = portCfg(DATA_WIDTH_B);
defparam ram_inst.CLKMODE         = (CLKMODE        == "read_write" ? 1'b0 : (CLKMODE         == "input_output" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_READONLY  = (PORTB_READONLY == "no"         ? 1'b0 : (PORTB_READONLY  == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_OUTREG    = (PORTA_OUTREG   == "no"         ? 1'b0 : (PORTA_OUTREG    == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_OUTREG    = (PORTB_OUTREG   == "no"         ? 1'b0 : (PORTB_OUTREG    == "yes"          ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_WRITEMODE = (PORTA_WRITEMODE == "normal" || PORTA_WRITEMODE == "write_thru" ? 1'b0 : (PORTA_WRITEMODE == "read_before_write" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_WRITEMODE = (PORTB_WRITEMODE == "normal" || PORTB_WRITEMODE == "write_thru" ? 1'b0 : (PORTB_WRITEMODE == "read_before_write" ? 1'b1 : 1'bx));
defparam ram_inst.PORTA_WRITETHRU = (PORTA_WRITEMODE == "normal" || PORTA_WRITEMODE == "read_before_write" ? 1'b0 : (PORTA_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.PORTB_WRITETHRU = (PORTB_WRITEMODE == "normal" || PORTB_WRITEMODE == "read_before_write" ? 1'b0 : (PORTB_WRITEMODE == "write_thru" ? 1'b1 : 1'bx));
defparam ram_inst.INIT_VAL        = (INIT_PORT == "a" ? portInitVal(DATA_WIDTH_A, INIT_VAL) : INIT_PORT == "b" ? portInitVal(DATA_WIDTH_B, INIT_VAL) : 4608'b0);

function [17:0] portDataIn(input integer data_width, input [17:0] data, input [17:0] data0);
begin
  case (data_width)
    36: portDataIn = data0[17:0];
    32: portDataIn = { 1'b1, data0[15:8], 1'b1, data0[7:0] };
    18: portDataIn = data[17:0];
    16: portDataIn = { 1'b1, data[15:8], 1'b1, data[7:0] };
     9: portDataIn = { 2{ data[8:0] } };
     8: portDataIn = { 2{ 1'b1, data[7:0] } };
     4: portDataIn = { 2{ 1'b1, { 2{ data[3:0] } } } };
     2: portDataIn = { 2{ 1'b1, { 4{ data[1:0] } } } };
     1: portDataIn = { 2{ 1'b1, { 8{ data[0:0] } } } };
     0: portDataIn = ~18'b0;
  endcase
end
endfunction

function [11:0] portAddr(input integer addr_width, input [11:0] addr, input integer byte_width, input [1:0] byteEn, input portId, input [6:0] addr0, input [3:0] byteEn0);
begin
  case (addr_width)
    12: portAddr = addr;
    11: portAddr = { addr[10:0], 1'b1    };
    10: portAddr = { addr[ 9:0], 2'b11   };
     9: portAddr = { addr[ 8:0], 3'b111  }; // Data width  8 or  9, default byte enable is 2'b11
     8: portAddr = { addr[ 7:0], 4'b1111 }; // Data width 16 or 18, default byte enable is 2'b11
     7: portAddr = { { addr0, portId }, 4'b1111 }; // Data width 32 or 36, lsb is 0/1 depends on port
     0: portAddr = ~12'b0;
  endcase
  case (byte_width)
    4: portAddr[1:0] = byteEn0[(portId+1)*2-1-:2];
    2: portAddr[1:0] = byteEn;
    1: portAddr[1:0] = { 2{ byteEn[0] } };
  endcase
end
endfunction

function [35:0] portDataOut(input integer data_width, input [17:0] data, input [17:0] data0);
begin
  case (data_width)
    36: portDataOut = { data0, data };
    32: portDataOut = { data0[16:9], data0[7:0], data[16:9], data[7:0] };
    18: portDataOut = data;
    16: portDataOut = { data[16:9], data[7:0] };
     9: portDataOut = { data[7], data[16:9] };
     8: portDataOut = data[16:9];
     4: portDataOut = data[ 6:3];
     2: portDataOut = data[ 2:1];
     1: portDataOut = data[ 0:0];
     0: portDataOut = 36'b0;
  endcase
end
endfunction

function [3:0] portCfg(input integer data_width);
  begin
    case (data_width)
      36, 32: portCfg = 4'b0000;
      18, 16: portCfg = 4'b0000;
       9,  8: portCfg = 4'b1000;
           4: portCfg = 4'b1100;
           2: portCfg = 4'b1110;
           1: portCfg = 4'b1111;
           0: portCfg = 4'b0000;
    endcase
  end
endfunction

function [4607:0] portInitVal(input integer data_width, input [4607:0] initVal);
begin : initval
  //integer i;
  case (data_width)
    36, 18, 9:
      portInitVal = initVal;
    32, 16, 8, 4, 2, 1:
      for (i = 0; i < 256; i = i + 1)
        portInitVal[i*18+17-:18] = { 1'b0, initVal[i*16+15-:8], 1'b0, initVal[i*16+7-:8] };
    0:
      portInitVal = 4608'b0;
  endcase
end
endfunction

endmodule
