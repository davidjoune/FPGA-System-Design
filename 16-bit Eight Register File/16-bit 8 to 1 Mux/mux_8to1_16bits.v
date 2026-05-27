`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:00:00 04/30/2025 
// Design Name: 
// Module Name:    mux_8to1_16bits 
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
module mux_8to1_16bits(
   input [2:0] sel,
	input [15:0] D0,D1,D2,D3,D4,D5,D6,D7,
	output [15:0] data
    );
	
	reg [15:0] data;
	
	always@(*)begin
	   case(sel)
		   3'b000: data = D0;
			3'b001: data = D1;
			3'b010: data = D2;
			3'b011: data = D3;
			3'b100: data = D4;
			3'b101: data = D5;
			3'b110: data = D6;
			3'b111: data = D7;
			default:data = 16'b0;
		endcase
	end
endmodule
