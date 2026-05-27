`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:41 05/02/2025 
// Design Name: 
// Module Name:    Extend_16bits 
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
module Extend_16bits(
   input [4:0] D5,
	input [7:0] D8,
	input sel,
	output [15:0] data
    );
	 
	wire [15:0] data;
	
	assign data = (sel) ? {{8{D8[7]}},D8} : {{11{1'b0}},D5};

endmodule
