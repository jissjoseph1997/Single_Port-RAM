`timescale 1ns / 1ps

module tb;
  
  // Parameters
  parameter ADDR_WIDTH = 4;
  parameter DATA_WIDTH = 32;
  parameter DEPTH = 16;
  
  // Signals
  reg clk;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data;
  reg cs;
  reg we;
  reg oe;
  
  wire [DATA_WIDTH-1:0] read_data;
  
  // Instantiate the DUT
  single_port_sync_ram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH))
    dut (.clk(clk), .addr(addr), .data(data), .cs(cs), .we(we), .oe(oe));
    
  // Clock generation
  always #5 clk = ~clk;
  
  // Monitor
  always @(posedge clk)
  begin
    if (cs & we)
      $display("[WRITE] Address = %0d, Data = 0x%h", addr, data);
    else if (cs & oe)
      $display("[READ] Address = %0d, Data = 0x%h", addr, read_data);
  end
  
  // Test stimulus
  initial begin
    clk = 0;
    cs = 1;
    we = 0;
    oe = 0;
    addr = 0;
    data = 0;
    
    // Write data
    #10 
    we = 1;
    addr = 3;
    data = 32'h12345678;
    
    
    // Read data
    #10 
    we = 0;
    addr = 3;
    oe = 1;
    #10 cs = 1;
    oe = 0;
    
    // Additional test cases...
    // Write and read more data
    
    // End simulation
    #10 $finish;
  end
  
endmodule
