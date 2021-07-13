`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/23 11:12:06
// Design Name: 
// Module Name: fifo_one
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


module fifo_one
#( parameter width = 1)
(
 input wr_clk,
 input rd_clk,
 input [width-1:0] din,
 input wr_en,
 input rd_en,
 output reg [width-1:0] dout,
 output reg full,
 output reg empty
  );
  


endmodule
