`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:27 04/30/2025 
// Design Name: 
// Module Name:    decoder_3to8 
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
module decoder_3to8(
   input [2:0] addr,
	input EN,
	output [7:0] D
    );
	 
	reg [7:0] D;
	
	always@(*)begin
	   if (EN==1) begin
		   case(addr)
			   3'b000: D = 8'b00000001;
				3'b001: D = 8'b00000010;
				3'b010: D = 8'b00000100;
				3'b011: D = 8'b00001000;
				3'b100: D = 8'b00010000;
				3'b101: D = 8'b00100000;
				3'b110: D = 8'b01000000;
				3'b111: D = 8'b10000000;
				default:D = 8'b00000000;
			endcase
		end
		else D = 8'b00000000;
	end
endmodule










