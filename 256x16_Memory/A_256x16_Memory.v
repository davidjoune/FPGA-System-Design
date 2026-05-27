`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:33 05/02/2025 
// Design Name: 
// Module Name:    A_256x16_Memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module A_256x16_Memory(
   input [15:0] D,
	input [7:0] addr,
	input clk, WE,
	output [15:0] data
    );
	 
	 reg [15:0] mem [0:255];
	 wire [15:0] data;
	 
	 always@(posedge clk)begin
	    if(WE) mem[addr] <= D;
	 end
	 
	 assign data = mem[addr];
		
endmodule
