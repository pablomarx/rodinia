`timescale 1ns/1ps

module alta_rv32_top (
  input         sys_clk,
  output        mem_ahb_hready,
  input         mem_ahb_hreadyout,
  output [1:0]  mem_ahb_htrans,
  output [2:0]  mem_ahb_hsize,
  output [2:0]  mem_ahb_hburst,
  output        mem_ahb_hwrite,
  output [31:0] mem_ahb_haddr,
  output [31:0] mem_ahb_hwdata,
  input         mem_ahb_hresp,
  input  [31:0] mem_ahb_hrdata,
  input         slave_ahb_hsel,
  input         slave_ahb_hready,
  output        slave_ahb_hreadyout,
  input  [1:0]  slave_ahb_htrans,
  input  [2:0]  slave_ahb_hsize,
  input  [2:0]  slave_ahb_hburst,
  input         slave_ahb_hwrite,
  input  [31:0] slave_ahb_haddr,
  input  [31:0] slave_ahb_hwdata,
  output        slave_ahb_hresp,
  output [31:0] slave_ahb_hrdata,
  input  [7:0]  gpio0_io_in,
  output [7:0]  gpio0_io_out_data,
  output [7:0]  gpio0_io_out_en,
  input  [7:0]  gpio1_io_in,
  output [7:0]  gpio1_io_out_data,
  output [7:0]  gpio1_io_out_en,
  output [1:0]  sys_ctrl_clkSource,
  output        sys_ctrl_hseEnable,
  output        sys_ctrl_hseBypass,
  output reg    sys_ctrl_pllEnable,
  input         sys_ctrl_pllReady,
  output tri0   sys_ctrl_sleep,
  output tri0   sys_ctrl_stop,
  output tri0   sys_ctrl_standby,
  input  [7:0]  gpio2_io_in,
  output [7:0]  gpio2_io_out_data,
  output [7:0]  gpio2_io_out_en,
  input  [7:0]  gpio3_io_in,
  output [7:0]  gpio3_io_out_data,
  output [7:0]  gpio3_io_out_en,
  input  [7:0]  gpio4_io_in,
  output [7:0]  gpio4_io_out_data,
  output [7:0]  gpio4_io_out_en,
  input  [7:0]  gpio5_io_in,
  output [7:0]  gpio5_io_out_data,
  output [7:0]  gpio5_io_out_en,
  input  [7:0]  gpio6_io_in,
  output [7:0]  gpio6_io_out_data,
  output [7:0]  gpio6_io_out_en,
  input  [7:0]  gpio7_io_in,
  output [7:0]  gpio7_io_out_data,
  output [7:0]  gpio7_io_out_en,
  input  [7:0]  gpio8_io_in,
  output [7:0]  gpio8_io_out_data,
  output [7:0]  gpio8_io_out_en,
  input  [7:0]  gpio9_io_in,
  output [7:0]  gpio9_io_out_data,
  output [7:0]  gpio9_io_out_en,
  input         ext_resetn,
  output        resetn_out,
  output        dmactive,
  output        swj_JTAGNSW,
  output [3:0]  swj_JTAGSTATE,
  output [3:0]  swj_JTAGIR,
  input  [7:0]  ext_int,
  input  [3:0]  ext_dma_DMACBREQ,
  input  [3:0]  ext_dma_DMACLBREQ,
  input  [3:0]  ext_dma_DMACSREQ,
  input  [3:0]  ext_dma_DMACLSREQ,
  output [3:0]  ext_dma_DMACCLR,
  output [3:0]  ext_dma_DMACTC,
  input  [3:0]  local_int,
  input  [1:0]  test_mode,
  input         usb0_xcvr_clk,
  input         usb0_id
);
parameter SRAM_BASE = 32'h2000_0000;
parameter SRAM_SIZE = 128 * 1024;

parameter MEM_AHB_BASE = 32'h6000_0000;
parameter MEM_AHB_SIZE = 32'h2000_0000;

parameter verbose = 0;
`define MSG(msg)  if (verbose > 0) $display("Msg: %0t %m: %s", $time, $sformatf msg)
`define INFO(msg) if (verbose > 1) $display("Info: %0t %m: %s", $time, $sformatf msg)
`define ERROR(msg) begin $display("Error: %0t %m: %s", $time, $sformatf msg); $finish; end

reg resetn = 1'b0;
initial #1000 resetn = 1'b1;
reg [1:0] clk_source = 2'b00;

reg [31:0] sram [SRAM_SIZE/4];

task init_sram();
  for (int i = 0; i < SRAM_SIZE / 4; i = i + 1) begin
    sram[i] = $urandom();
  end
endtask

initial begin
  sys_ctrl_pllEnable = 1'b0;
  init_sram();
end

task SYS_SetClkSource(input [1:0] source);
  wait (resetn_out);
  clk_source = source;
  idle(10);
endtask

task SYS_SwitchHSIClock();
  SYS_SetClkSource(2'b00);
  sys_ctrl_pllEnable = 1'b0;
endtask

task SYS_SwitchHSEClock();
  SYS_SwitchHSIClock();
  SYS_SetClkSource(2'b01);
  sys_ctrl_pllEnable = 1'b0;
endtask

task SYS_SwitchPLLClock();
  SYS_SwitchHSIClock();
  sys_ctrl_pllEnable = 1'b1;
  while (!sys_ctrl_pllReady) begin
    idle(1);
  end
  SYS_SetClkSource(2'b10);
endtask

task automatic idle(int cycles);
  for (int i = 0; i < cycles; i += 1) begin
    @(posedge sys_clk);
  end
endtask

assign resetn_out         = resetn;
assign sys_ctrl_clkSource = clk_source;

reg        slave_hresp  = 1'b0;
reg [31:0] slave_hrdata = 32'h0;
reg        slave_hwrite = 1'b0;
reg [2:0]  slave_hsize  = 3'b0;
reg [31:0] slave_haddr  = 32'h0;

parameter SLAVE_AHB_LATENCY = 10;
integer slave_latency_cnt = 0;

assign slave_ahb_hreadyout = slave_latency_cnt == 0;
assign slave_ahb_hresp     = slave_hresp;
assign slave_ahb_hrdata    = slave_hrdata;

always @ (posedge sys_clk) begin
  if (slave_ahb_hsel && slave_ahb_htrans == 2'b10 && slave_ahb_hreadyout) begin
    slave_latency_cnt <= SLAVE_AHB_LATENCY;
  end else if (slave_latency_cnt != 0) begin
    slave_latency_cnt <= slave_latency_cnt - 1;
  end
end

always @ (posedge sys_clk) begin
  if (slave_ahb_hsel && slave_ahb_htrans[1] && slave_ahb_hready) begin
    slave_haddr  <= slave_ahb_haddr;
    slave_hwrite <= slave_ahb_hwrite;
    slave_hsize  <= slave_ahb_hsize;
  end else if (slave_ahb_hreadyout) begin
    slave_haddr <= 32'h0;
  end
end

wire [31:0] slave_mask = slave_hsize == 2 ? ~32'h0 : slave_hsize == 1 ? (16'hffff << (slave_haddr[1] * 16)) : (8'hff << (slave_haddr[1:0] * 8));
wire [31:0] slave_sram_rd = sram[(slave_haddr-SRAM_BASE)/4];
always @ (*) begin
  if (slave_ahb_hreadyout && slave_haddr != 0) begin
    if (slave_haddr >= SRAM_BASE && slave_haddr < SRAM_BASE + SRAM_SIZE) begin
      if (slave_ahb_hwrite) begin
        #1 sram[(slave_haddr-SRAM_BASE)/4] = slave_sram_rd & ~slave_mask | slave_ahb_hwdata & slave_mask;
      end else begin
        #1 slave_hrdata = slave_hsize == 2 ? slave_sram_rd : slave_hsize == 1 ? {2{slave_sram_rd[slave_haddr[1]*16+:16]}} : {4{slave_sram_rd[slave_haddr[1:0]*8+:8]}};
      end
    end
  end else begin
    slave_hrdata = 32'h0;
  end
end

always @ (posedge sys_clk) begin
  if (slave_ahb_hreadyout && slave_haddr != 0) begin
    `INFO(("received %0s @ 0x%08x, hsize: %d, data: 0x%08x", slave_hwrite ? "write" : "read", slave_haddr, slave_hsize, slave_hwrite ? slave_ahb_hwdata : slave_hrdata));
  end
end

reg [1:0]  mem_htrans = 2'b0;
reg [2:0]  mem_hsize  = 3'b010;
reg [2:0]  mem_hburst = 3'b0;
reg        mem_hwrite = 1'b0;
reg [31:0] mem_haddr  = 32'h0;
reg [31:0] mem_hwdata = 32'h0;

assign mem_ahb_hready = mem_ahb_hreadyout;
assign mem_ahb_htrans = mem_htrans;
assign mem_ahb_hsize  = mem_hsize;
assign mem_ahb_hburst = mem_hburst;
assign mem_ahb_hwrite = mem_hwrite;
assign mem_ahb_haddr  = mem_haddr;
assign mem_ahb_hwdata = mem_hwdata;

semaphore mem_ahb_sem = new(1);

task automatic burst(
  input        write,
  input [31:0] addr,
  input [31:0] count,
  input [2:0]  size,
  inout [7:0]  data []
);
  reg [31:0] data_cnt;
  reg [31:0] data_addr;
  reg [31:0] hwdata;
  `INFO(("issued %0s @ 0x%08x, count: %0d hsize: %d", write ? "write" : "read", addr, count, size));
  mem_ahb_sem.get();
  if (addr != ((addr >> size) << size)) begin
    `ERROR(("Address 0x%08x needs to be %0d bits aligned", addr, (1 << size) * 8));
    return;
  end
  do begin
    @(posedge sys_clk);
  end while (!mem_ahb_hreadyout || mem_htrans != 0);
  mem_htrans <= 2;
  mem_hwrite <= write;
  mem_hburst <= count > 1 ? 1 : 0;
  mem_hsize  <= size;
  mem_haddr  <= addr;
  data_cnt = 0;
  while (data_cnt <= count) begin
    @(posedge sys_clk);
    if (mem_ahb_hresp) begin
      mem_htrans <= 0; // Go to IDLE with any error
    end else if (data_cnt < count) begin
      if (mem_ahb_hreadyout && data_cnt == count - 1) begin // Last xfer in this burst
        mem_htrans <= 0;
      end else if (mem_ahb_hreadyout) begin
        mem_htrans <= 3;
      end
    end else begin
      mem_htrans <= 0;
    end

    if (mem_ahb_hreadyout) begin
      if (mem_ahb_hresp) begin
        `ERROR(("error response from issued %0s", write ? "write" : "read"));
        break;
      end
      if (write && data_cnt < count) begin // Ignore last data for write
        hwdata = mem_hwdata;
        for (int i = 0; i < (1 << size); ++i) begin
          hwdata[addr[1:0]*8+i*8 +: 8] = data[(data_cnt << size) + (i % (1 << size))];
        end
        mem_hwdata <= hwdata;
        `INFO(("issued write @ 0x%08x, data: 0x%08x", addr, hwdata));
      end
      if (!write && data_cnt > 0) begin // Ignore first data for read
        for (int i = 0; i < (1 << size); ++i) begin
          data[((data_cnt - 1) << size) + i] = mem_ahb_hrdata[data_addr[1:0]*8+i*8 +: 8];
        end
        `INFO(("issued read @ 0x%08x, data: 0x%08x", data_addr, mem_ahb_hrdata));
      end
      data_addr = addr;
      data_cnt = data_cnt + 1;
      if (data_cnt < count) begin
        addr += (1 << size);
        mem_haddr <= addr;
      end
    end
  end
  while (!mem_ahb_hreadyout) begin
    @(posedge sys_clk);
  end
  mem_ahb_sem.put();
endtask

function [2:0] get_burst_size(input [31:0] addr, input [31:0] length);
  case (addr[1:0] | length[1:0])
    0:       get_burst_size = 2; // Word access
    2:       get_burst_size = 1; // Half access
    default: get_burst_size = 0; // Byte access
  endcase
endfunction

task automatic burst_write(
  input [31:0] addr,
  input [31:0] length,
  inout [7:0]  data []
);
reg [2:0] hsize = get_burst_size(addr, length);
burst(1, addr, length / (1 << hsize), hsize, data);
endtask

task automatic burst_read(
  input [31:0] addr,
  input [31:0] length,
  inout [7:0]  data []
);
reg [2:0] hsize = get_burst_size(addr, length);
burst(0, addr, length / (1 << hsize), hsize, data);
endtask

task automatic write_word(
  input [31:0] addr,
  input [31:0] data
);
reg [7:0] wrdata[4];
{<<byte{wrdata}} = data;
burst_write(addr, 4, wrdata);
endtask

task automatic read_word(
  input  [31:0] addr,
  output [31:0] data
);
reg [7:0] rddata[4];
burst_read(addr, 4, rddata);
data = {<<byte{rddata}};
endtask

task automatic modify_word(
    input [31:0] addr,
    input [31:0] clearmask,
    input [31:0] setmask
);
reg [31:0] data;
read_word(addr, data);
data &= ~clearmask;
data |= setmask;
write_word(addr, data);
endtask

task automatic wait_mask_cleared(
  input [31:0] addr,
  input [31:0] mask
);
  reg [31:0] data;
  do begin
    read_word(addr, data);
  end while ((data & mask) != 0);
endtask

task automatic wait_mask_set(
  input [31:0] addr,
  input [31:0] mask
);
  reg [31:0] data;
  do begin
    read_word(addr, data);
  end while ((data & mask) != mask);
endtask

task automatic write_half(
  input [31:0] addr,
  input [15:0] data
);
reg [7:0] wrdata[2];
{<<byte{wrdata}} = data;
burst_write(addr, 2, wrdata);
endtask

task automatic read_half(
  input  [31:0] addr,
  output [15:0] data
);
reg [7:0] rddata[2];
burst_read(addr, 2, rddata);
data = {<<byte{rddata}};
endtask

task automatic write_byte(
  input [31:0] addr,
  input [7:0] data
);
reg [7:0] wrdata[1];
{<<byte{wrdata}} = data;
burst_write(addr, 1, wrdata);
endtask

task automatic read_byte(
  input  [31:0] addr,
  output [7:0] data
);
reg [7:0] rddata[1];
burst_read(addr, 1, rddata);
data = {<<byte{rddata}};
endtask

task wait_ahb();
  // Wait until there is no outstanding AHB transfer.
  do begin
    idle(1);
  end while (!mem_ahb_hreadyout || !slave_ahb_hreadyout);
endtask

function is_sram_addr(input [31:0] addr);
  is_sram_addr = (addr >= SRAM_BASE && addr < SRAM_BASE + SRAM_SIZE);
endfunction

function is_mem_ahb_addr(input [31:0] addr);
  is_mem_ahb_addr = (addr >= MEM_AHB_BASE && addr < MEM_AHB_BASE + MEM_AHB_SIZE);
endfunction

function [31:0] get_sram_word(input [31:0] addr);
  get_sram_word = sram[(addr - SRAM_BASE) >> 2];
endfunction

function [15:0] get_sram_half(input [31:0] addr);
  get_sram_half = sram[(addr - SRAM_BASE) >> 2][addr[1]*16+:16];
endfunction

function [7:0] get_sram_byte(input [31:0] addr);
  get_sram_byte = sram[(addr - SRAM_BASE) >> 2][addr[1:0]*8+:8];
endfunction

function void set_sram_word(input [31:0] addr, input [31:0] data);
  sram[(addr - SRAM_BASE) >> 2] = data;
endfunction

function void set_sram_half(input [31:0] addr, input [15:0] data);
  sram[(addr - SRAM_BASE) >> 2][addr[1]*16+:16] = data;
endfunction

function void set_sram_byte(input [31:0] addr, input [7:0] data);
  sram[(addr - SRAM_BASE) >> 2][addr[1:0]*8+:8] = data;
endfunction

// For channel control register
parameter DMAC_TRANSFER_SIZE_OFFSET = 0;
parameter DMAC_MAX_TRANSFER_SIZE    = ((1 << 12) - 4); // Use a number that can be divided by 4 in case src/dst widths differ
parameter DMAC_SRC_BURST_OFFSET     = 12;
parameter DMAC_DST_BURST_OFFSET     = 15;
parameter DMAC_SRC_WIDTH_OFFSET     = 18;
parameter DMAC_DST_WIDTH_OFFSET     = 21;
parameter DMAC_SRC_MASTER_OFFSET    = 24;
parameter DMAC_DST_MASTER_OFFSET    = 25;
parameter DMAC_SRC_ADDR_INCR_OFFSET = 26;
parameter DMAC_DST_ADDR_INCR_OFFSET = 27;
parameter DMAC_TC_INT_ENABLE_OFFSET = 31;

// For channel configuration register
parameter DMAC_ENABLE_OFFSET         = 0;
parameter DMAC_SRC_PERIPHERAL_OFFSET = 1;
parameter DMAC_DST_PERIPHERAL_OFFSET = 6;
parameter DMAC_FLOW_CONTROL_OFFSET   = 11;
parameter DMAC_INT_ERROR_MASK_OFFSET = 14;
parameter DMAC_INT_TC_MASK_OFFSET    = 15;
parameter DMAC_CHANNEL_ACTIVE_OFFSET = 17;
parameter DMAC_CHANNEL_HALT_OFFSET   = 18;

parameter DMAC_TRANSFER_SIZE_MASK = ((1 << 12) - 1);
parameter DMAC_BURST_MASK         = 'h7;
parameter DMAC_WIDTH_MASK         = 'h7;
parameter DMAC_ADDR_INCR_MASK     = 'h1;
parameter DMAC_PERIPHERAL_MASK    = 'hf;
parameter DMAC_FLOW_CONTROL_MASK  = 'h7;
parameter DMAC_TC_INT_ENABLE_MASK = 'h7;

parameter DMAC_LATENCY_MIN = 16;
parameter DMAC_LATENCY_MAX = 40;

parameter EXT_DMA0_REQ = 1;
parameter EXT_DMA1_REQ = 2;
parameter EXT_DMA2_REQ = 3;
parameter EXT_DMA3_REQ = 4;

parameter DMAC_MEM_TO_MEM_DMA_CTRL                          = 0;
parameter DMAC_MEM_TO_PERIPHERAL_DMA_CTRL                   = 1;
parameter DMAC_PERIPHERAL_TO_MEM_DMA_CTRL                   = 2;
parameter DMAC_PERIPHERAL_TO_PERIPHERAL_DMA_CTRL            = 3;
parameter DMAC_PERIPHERAL_TO_PERIPHERAL_DST_PERIPHERAL_CTRL = 4;
parameter DMAC_MEM_TO_PERIPHERAL_PERIPHERAL_CTRL            = 5;
parameter DMAC_PERIPHERAL_TO_MEM_PERIPHERAL_CTRL            = 6;
parameter DMAC_PERIPHERAL_TO_PERIPHERAL_SRC_PERIPHERAL_CTRL = 7;

parameter DMAC_BURST_1   = 0;
parameter DMAC_BURST_4   = 1;
parameter DMAC_BURST_8   = 2;
parameter DMAC_BURST_16  = 3;
parameter DMAC_BURST_32  = 4;
parameter DMAC_BURST_64  = 5;
parameter DMAC_BURST_128 = 6;
parameter DMAC_BURST_256 = 7;

parameter DMAC_WIDTH_8_BIT  = 0;
parameter DMAC_WIDTH_16_BIT = 1;
parameter DMAC_WIDTH_32_BIT = 2;

parameter DMAC_ADDR_INCR_OFF = 0; // Address will not increment after each transfer
parameter DMAC_ADDR_INCR_ON  = 1; // Address will increment after each transfer

parameter DMAC_LLI_SIZE = 16; // 4 words

function void DMAC_SetLLISrcAddr(input [31:0] lli, input [31:0] src_addr);
  set_sram_word(lli, src_addr);
endfunction

function void DMAC_SetLLIDstAddr(input [31:0] lli, input [31:0] dst_addr);
  set_sram_word(lli + 4, dst_addr);
endfunction

function void DMAC_SetLLINext(input [31:0] lli, input [31:0] lli_next);
  set_sram_word(lli + 8, lli_next);
endfunction

function void DMAC_SetLLIControl(input [31:0] lli, input [31:0] control);
  set_sram_word(lli + 12, control);
endfunction

function [31:0] DMAC_MakeControl(
  input        src_incr,
  input        dst_incr,
  input [2:0]  src_width,
  input [2:0]  dst_width,
  input [2:0]  src_burst,
  input [2:0]  dst_burst,
  input [11:0] xfer_size,
  input        enable_inttc
);
  DMAC_MakeControl = { enable_inttc, 3'b0, dst_incr, src_incr, 2'b10, dst_width, src_width, dst_burst, src_burst, xfer_size };
endfunction

function int get_dmac_bytes(input [2:0] width);
  get_dmac_bytes = width == DMAC_WIDTH_8_BIT ? 1 : width == DMAC_WIDTH_16_BIT ? 2 : 4;
endfunction

function is_src_peripheral(input [2:0] xfer_type);
  is_src_peripheral = xfer_type == DMAC_PERIPHERAL_TO_MEM_DMA_CTRL                   ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_DMA_CTRL            ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_DST_PERIPHERAL_CTRL ||
                      xfer_type == DMAC_PERIPHERAL_TO_MEM_PERIPHERAL_CTRL            ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_SRC_PERIPHERAL_CTRL;
endfunction

function is_dst_peripheral(input [2:0] xfer_type);
  is_dst_peripheral = xfer_type == DMAC_MEM_TO_PERIPHERAL_DMA_CTRL                   ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_DMA_CTRL            ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_DST_PERIPHERAL_CTRL ||
                      xfer_type == DMAC_MEM_TO_PERIPHERAL_PERIPHERAL_CTRL            ||
                      xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_SRC_PERIPHERAL_CTRL;
endfunction

function is_src_ctrl(input [2:0] xfer_type);
  is_src_ctrl = xfer_type == DMAC_PERIPHERAL_TO_MEM_PERIPHERAL_CTRL ||
                xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_SRC_PERIPHERAL_CTRL;
endfunction

function is_dst_ctrl(input [2:0] xfer_type);
  is_dst_ctrl = xfer_type == DMAC_MEM_TO_PERIPHERAL_PERIPHERAL_CTRL ||
                xfer_type == DMAC_PERIPHERAL_TO_PERIPHERAL_DST_PERIPHERAL_CTRL;
endfunction

parameter DMAC_CHANNELS = 8;
reg        dmac_enabled[DMAC_CHANNELS] = '{DMAC_CHANNELS{0}};
reg        dmac_halt[DMAC_CHANNELS] = '{DMAC_CHANNELS{0}};
reg        dmac_active[DMAC_CHANNELS] = '{DMAC_CHANNELS{0}};
reg [31:0] dmac_src_addr[DMAC_CHANNELS];
reg [31:0] dmac_dst_addr[DMAC_CHANNELS];
reg        dmac_src_incr[DMAC_CHANNELS];
reg        dmac_dst_incr[DMAC_CHANNELS];
reg [2:0]  dmac_src_width[DMAC_CHANNELS];
reg [2:0]  dmac_dst_width[DMAC_CHANNELS];
reg [2:0]  dmac_src_burst[DMAC_CHANNELS];
reg [2:0]  dmac_dst_burst[DMAC_CHANNELS];
reg [11:0] dmac_xfer_size[DMAC_CHANNELS];
reg [2:0]  dmac_xfer_type[DMAC_CHANNELS];
reg [3:0]  dmac_src_per[DMAC_CHANNELS];
reg [3:0]  dmac_dst_per[DMAC_CHANNELS];
reg [31:0] dmac_lli[DMAC_CHANNELS];
int        dmac_xfer_counter[DMAC_CHANNELS];
reg [15:0] dmac_clr = 0;
reg [15:0] dmac_tc  = 0;

wire [15:0] dmac_breq  = ext_dma_DMACBREQ  << EXT_DMA0_REQ;
wire [15:0] dmac_lbreq = ext_dma_DMACLBREQ << EXT_DMA0_REQ;
wire [15:0] dmac_sreq  = ext_dma_DMACSREQ  << EXT_DMA0_REQ;
wire [15:0] dmac_lsreq = ext_dma_DMACLSREQ << EXT_DMA0_REQ;
wire [15:0] dmac_req = dmac_breq | dmac_lbreq | dmac_sreq | dmac_lsreq;
wire [15:0] dmac_lreq = dmac_lbreq | dmac_lsreq;

assign ext_dma_DMACCLR = dmac_clr[EXT_DMA3_REQ:EXT_DMA0_REQ];
assign ext_dma_DMACTC  = dmac_tc [EXT_DMA3_REQ:EXT_DMA0_REQ];

task automatic dmac_run(input [2:0] channel);
  int src_bytes, dst_bytes;
  reg [7:0] xfer_queue[$];
  reg [7:0] src_data[];

  wait(!dmac_active[channel]);
  dmac_active[channel] = 1'b1;
  src_bytes = get_dmac_bytes(dmac_src_width[channel]);
  dst_bytes = get_dmac_bytes(dmac_dst_width[channel]);
  src_data = new[src_bytes];

  if (is_src_peripheral(dmac_xfer_type[channel]) && (dmac_src_per[channel] < EXT_DMA0_REQ || dmac_src_per[channel] > EXT_DMA3_REQ)) begin
    `ERROR(("unsupported source peripheral %0d", dmac_src_per[channel]));
  end
  if (is_dst_peripheral(dmac_xfer_type[channel]) && (dmac_dst_per[channel] < EXT_DMA0_REQ || dmac_dst_per[channel] > EXT_DMA3_REQ)) begin
    `ERROR(("unsupported destination peripheral %0d", dmac_dst_per[channel]));
  end

  dmac_xfer_counter[channel] = dmac_xfer_size[channel];
  while (dmac_enabled[channel] && !dmac_halt[channel]) begin
    idle(1);
    if (dmac_xfer_type[channel][2] == 0 && dmac_xfer_counter[channel] == 0) begin // DMA_CTRL
      break;
    end

    if (is_src_peripheral(dmac_xfer_type[channel]) && !dmac_req[dmac_src_per[channel]] || is_dst_peripheral(dmac_xfer_type[channel]) && !dmac_req[dmac_dst_per[channel]]) begin
      continue;
    end
    idle($urandom_range(DMAC_LATENCY_MIN, DMAC_LATENCY_MAX));

    // Read source data into queue.
    if (is_sram_addr(dmac_src_addr[channel])) begin
      for (int b = 0; b < src_bytes; b += 1) begin
        src_data[b] = get_sram_byte(dmac_src_addr[channel] + b);
      end
    end else if (is_mem_ahb_addr(dmac_src_addr[channel])) begin
      `INFO(("DMA read %0d bytes @ 0x%08x", src_bytes, dmac_src_addr[channel]));
      burst_read(dmac_src_addr[channel], src_bytes, src_data);
    end else begin
      `ERROR(("unsupported source DMA address 0x%08x", dmac_src_addr[channel]));
    end
    xfer_queue = { xfer_queue, src_data };
    if (dmac_src_incr[channel]) begin
      dmac_src_addr[channel] += src_bytes;
    end

    // Write destination data from queue
    while (xfer_queue.size() >= dst_bytes) begin
      if (is_mem_ahb_addr(dmac_dst_addr[channel])) begin
        `INFO(("DMA write %0d bytes @ 0x%08x", dst_bytes, dmac_dst_addr[channel]));
        burst_write(dmac_dst_addr[channel], dst_bytes, xfer_queue[0:dst_bytes-1]);
      end else if (is_sram_addr(dmac_dst_addr[channel])) begin
        for (int b = 0; b < dst_bytes; b += 1) begin
          set_sram_byte(dmac_dst_addr[channel] + b, xfer_queue[b]);
        end
      end else begin
        `ERROR(("unsupported destination DMA address 0x%08x", dmac_dst_addr[channel]));
      end
      xfer_queue = xfer_queue[dst_bytes:$];
      if (dmac_dst_incr[channel]) begin
        dmac_dst_addr[channel] += dst_bytes;
      end
    end

    if (dmac_xfer_type[channel][2] == 0) begin // DMA_CTRL
      dmac_xfer_counter[channel] = dmac_xfer_counter[channel] - 1;
    end
    if (is_src_peripheral(dmac_xfer_type[channel])) begin
      idle(1);
      dmac_clr[dmac_src_per[channel]] <= 1'b1;
      if (dmac_lreq[dmac_src_per[channel]] && is_src_ctrl(dmac_xfer_type[channel])) begin
        dmac_halt[channel] = 1;
      end
      wait (!dmac_req[dmac_src_per[channel]]);
      idle(1);
      dmac_clr[dmac_src_per[channel]] <= 1'b0;
    end
    if (is_dst_peripheral(dmac_xfer_type[channel])) begin
      idle(1);
      dmac_clr[dmac_dst_per[channel]] <= 1'b1;
      if (dmac_lreq[dmac_dst_per[channel]] && is_dst_ctrl(dmac_xfer_type[channel])) begin
        dmac_halt[channel] = 1;
      end
      wait (!dmac_req[dmac_dst_per[channel]]);
      idle(1);
      dmac_clr[dmac_dst_per[channel]] <= 1'b0;
    end
  end
  if (dmac_halt[channel] || dmac_lli[channel] == 0) begin
    dmac_enabled[channel] = 0;
  end
  dmac_active[channel] = 1'b0;
endtask

function void dma_read_lli(input [2:0] channel, input [31:0] lli);
  reg [31:0] control;
  if (lli == 0) begin
    return;
  end else if (lli < SRAM_BASE || lli >= SRAM_BASE + SRAM_SIZE) begin
    `ERROR(("Unsupported DMAC LLI address: 0x%08x", lli));
  end
  dmac_src_addr[channel]  = get_sram_word(lli + 0);
  dmac_dst_addr[channel]  = get_sram_word(lli + 4);
  dmac_lli[channel]       = get_sram_word(lli + 8);
  control                 = get_sram_word(lli + 12);
  dmac_src_incr[channel]  = control[DMAC_SRC_ADDR_INCR_OFFSET];
  dmac_dst_incr[channel]  = control[DMAC_DST_ADDR_INCR_OFFSET];
  dmac_src_width[channel] = control[DMAC_SRC_WIDTH_OFFSET+:3];
  dmac_dst_width[channel] = control[DMAC_DST_WIDTH_OFFSET+:3];
  dmac_src_burst[channel] = control[DMAC_SRC_BURST_OFFSET+:3];
  dmac_dst_burst[channel] = control[DMAC_DST_BURST_OFFSET+:3];
  dmac_xfer_size[channel] = control[DMAC_TRANSFER_SIZE_OFFSET+:12];
endfunction

task automatic DMAC_Config(
  input [2:0]  channel,
  input [31:0] src_addr,
  input [31:0] dst_addr,
  input        src_incr,
  input        dst_incr,
  input [2:0]  src_width,
  input [2:0]  dst_width,
  input [2:0]  src_burst,
  input [2:0]  dst_burst,
  input [11:0] xfer_size,
  input [2:0]  xfer_type,
  input [3:0]  src_per,
  input [3:0]  dst_per
);
  wait(!dmac_active[channel]);
  dmac_src_addr[channel]  = src_addr;
  dmac_dst_addr[channel]  = dst_addr;
  dmac_src_incr[channel]  = src_incr;
  dmac_dst_incr[channel]  = dst_incr;
  dmac_src_width[channel] = src_width;
  dmac_dst_width[channel] = dst_width;
  dmac_src_burst[channel] = src_burst;
  dmac_dst_burst[channel] = dst_burst;
  dmac_xfer_size[channel] = xfer_size;
  dmac_xfer_type[channel] = xfer_type;
  dmac_src_per[channel]   = src_per;
  dmac_dst_per[channel]   = dst_per;
  dmac_lli[channel]       = 0;
  dmac_enabled[channel]   = 1;
  dmac_halt[channel]      = 0;
  fork
    dmac_run(channel);
  join_none
  idle(1);
endtask

task automatic DMAC_EnableChannel(input [2:0] channel);
  reg [31:0] lli;
  wait(!dmac_active[channel]);
  dmac_enabled[channel] = 1;
  dmac_halt[channel]    = 0;
  fork
    do begin
      dmac_run(channel);
      lli = dmac_lli[channel];
      dma_read_lli(channel, lli);
    end while (dmac_enabled[channel] && lli != 0);
  join_none
  idle(1);
endtask

task DMAC_DisableChannel(input [2:0] channel);
  dmac_enabled[channel] = 0; // May lose data in FIFO
  idle(1);
endtask

task DMAC_WaitChannel(input [2:0] channel);
  wait (dmac_enabled[channel] == 0);
  idle(1);
endtask

task DMAC_HaltChannel(input [2:0] channel);
  idle(5);
  dmac_halt[channel] = 1;
  idle(1);
endtask

task automatic DMAC_WaitedTransfer(
  input [2:0]  channel,
  input [31:0] src_addr,
  input [31:0] dst_addr,
  input        src_incr,
  input        dst_incr,
  input [2:0]  src_width,
  input [2:0]  dst_width,
  input [2:0]  src_burst,
  input [2:0]  dst_burst,
  input [31:0] xfer_size,
  input [2:0]  xfer_type,
  input [3:0]  src_per,
  input [3:0]  dst_per
);
while (xfer_size > 0) begin : xfer
  int size = xfer_size > DMAC_MAX_TRANSFER_SIZE ? DMAC_MAX_TRANSFER_SIZE : xfer_size;
  `MSG(("DMAC xfer %0d, 0x%08x to 0x%08x", size, src_addr, dst_addr));
  DMAC_Config(channel, src_addr, dst_addr, src_incr, dst_incr, src_width, dst_width, src_burst, dst_burst, size, xfer_type, src_per, dst_per);
  DMAC_WaitChannel(channel);
  xfer_size -= size;
  src_addr += src_incr ? (size * (1 << src_width)) : 0;
  dst_addr += dst_incr ? (size * (1 << src_width)) : 0;
end
endtask

task automatic DMAC_ConfigLLI(
  input [2:0]  channel,
  input [2:0]  xfer_type,
  input [3:0]  src_per,
  input [3:0]  dst_per,
  input [31:0] lli
);
  wait(!dmac_active[channel]);
  dmac_xfer_type[channel] = xfer_type;
  dmac_src_per[channel]   = src_per;
  dmac_dst_per[channel]   = dst_per;
  dma_read_lli(channel, lli);
  DMAC_EnableChannel(channel);
endtask

parameter GPIO_CNT  = 10;
parameter GPIO0 = 0;
parameter GPIO1 = 1;
parameter GPIO2 = 2;
parameter GPIO3 = 3;
parameter GPIO4 = 4;
parameter GPIO5 = 5;
parameter GPIO6 = 6;
parameter GPIO7 = 7;
parameter GPIO8 = 8;
parameter GPIO9 = 9;

parameter GPIO_BITS = 8;
parameter GPIO_BIT0 = (1 << 0);
parameter GPIO_BIT1 = (1 << 1);
parameter GPIO_BIT2 = (1 << 2);
parameter GPIO_BIT3 = (1 << 3);
parameter GPIO_BIT4 = (1 << 4);
parameter GPIO_BIT5 = (1 << 5);
parameter GPIO_BIT6 = (1 << 6);
parameter GPIO_BIT7 = (1 << 7);

reg  [GPIO_BITS-1:0] gpio_out_data [GPIO_CNT] = '{default: {GPIO_BITS{1'b0}}};
reg  [GPIO_BITS-1:0] gpio_out_en   [GPIO_CNT] = '{default: {GPIO_BITS{1'b0}}};
wire [GPIO_BITS-1:0] gpio_in       [GPIO_CNT];

assign gpio0_io_out_data = gpio_out_data[0];
assign gpio1_io_out_data = gpio_out_data[1];
assign gpio2_io_out_data = gpio_out_data[2];
assign gpio3_io_out_data = gpio_out_data[3];
assign gpio4_io_out_data = gpio_out_data[4];
assign gpio5_io_out_data = gpio_out_data[5];
assign gpio6_io_out_data = gpio_out_data[6];
assign gpio7_io_out_data = gpio_out_data[7];
assign gpio8_io_out_data = gpio_out_data[8];
assign gpio9_io_out_data = gpio_out_data[9];

assign gpio0_io_out_en = gpio_out_en[0];
assign gpio1_io_out_en = gpio_out_en[1];
assign gpio2_io_out_en = gpio_out_en[2];
assign gpio3_io_out_en = gpio_out_en[3];
assign gpio4_io_out_en = gpio_out_en[4];
assign gpio5_io_out_en = gpio_out_en[5];
assign gpio6_io_out_en = gpio_out_en[6];
assign gpio7_io_out_en = gpio_out_en[7];
assign gpio8_io_out_en = gpio_out_en[8];
assign gpio9_io_out_en = gpio_out_en[9];

assign gpio_in[0] = gpio0_io_in;
assign gpio_in[1] = gpio1_io_in;
assign gpio_in[2] = gpio2_io_in;
assign gpio_in[3] = gpio3_io_in;
assign gpio_in[4] = gpio4_io_in;
assign gpio_in[5] = gpio5_io_in;
assign gpio_in[6] = gpio6_io_in;
assign gpio_in[7] = gpio7_io_in;
assign gpio_in[8] = gpio8_io_in;
assign gpio_in[9] = gpio9_io_in;

parameter GPIO_LATENCY = 8;
task GPIO_SetInput(int gpio, reg [GPIO_BITS-1:0] bits);
  idle(GPIO_LATENCY);
  gpio_out_en[gpio] <= gpio_out_en[gpio] & ~bits;
endtask

task GPIO_SetOutput(int gpio, reg [GPIO_BITS-1:0] bits);
  idle(GPIO_LATENCY);
  gpio_out_en[gpio] <= gpio_out_en[gpio] | bits;
endtask

task GPIO_SetLow(int gpio, reg [GPIO_BITS-1:0] bits);
  idle(GPIO_LATENCY);
  gpio_out_data[gpio] <= gpio_out_data[gpio] & ~bits;
endtask

task GPIO_SetHigh(int gpio, reg [GPIO_BITS-1:0] bits);
  idle(GPIO_LATENCY);
  gpio_out_data[gpio] <= gpio_out_data[gpio] | bits;
endtask

function [7:0] GPIO_GetValue(int gpio, reg [GPIO_BITS-1:0] bits);
  GPIO_GetValue = gpio_in[gpio] & bits;
endfunction

endmodule
