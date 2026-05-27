`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:35 04/30/2025 
// Design Name: 
// Module Name:    DFF_16bits 
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
module DFF_16bits(
   input [15:0] D,
	input clk, reset, enable,
	output [15:0] Q
    );
	
	reg [15:0] Q;
	
	always@(posedge clk)begin
	   if(reset)begin
		   Q <= 16'b0;
		end
		else if(enable)begin
		   Q <= D;
	   end
	end
endmodule

