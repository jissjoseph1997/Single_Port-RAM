`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2023 11:17:07
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );
    
    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 16;
    parameter DEPTH = 16;
    
    reg clk_tb;
    reg cs;
    reg we;
    reg oe;
    integer i;
    
    reg [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data;
    reg [DATA_WIDTH-1:0] tb_data;
    
    single_port_sync_ram dut (.DATA_WIDTH(DATA-WIDTH), .clk(clk_tb), .addr(addr), .cs(cs), .we(we), .oe(oe), .data(data));
    
    always #10 clk_tb = ~clk_tb;
    assign data = oe ? tb_data: 'hz;
    initial begin
    {clk_tb,cs,we,addr,tb_data,oe} <=0;
    repeat(2)@ (posedge clk_tb);
    //WRITE OPERATION TO RAM
    for (i =0;i<2**ADDR_WIDTH;i=i+1) begin
    repeat(1)@(posedge clk_tb) addr<=i;we<=1;cs<=1;oe<=0;tb_data<=$random;
    end
    //READ OPERATION TO THE RAM
    for (i =0;i<2**ADDR_WIDTH;i=i+1) begin
    repeat(1)@(posedge clk_tb) addr<=i;we<=0;cs<=1;oe<=1;
    end
    
    #20 $finish;
    
    end 
    
    
endmodule
