`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:51:45 05/02/2025
// Design Name:   Extend_16bits
// Module Name:   C:/Users/A Kun/final_term/Extend_16bits_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Extend_16bits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Extend_16bits_tb;

	// Inputs
	reg [4:0] D5;
	reg [7:0] D8;
	reg sel;

	// Outputs
	wire [15:0] data;

	// Instantiate the Unit Under Test (UUT)
	Extend_16bits uut (
		.D5(D5), 
		.D8(D8), 
		.sel(sel), 
		.data(data)
	);

   initial begin
		D5 = 0;
		D8 = 0;
		sel = 0;
		
		#10 D5=5'b11111;D8=8'b11001100;
		#10 sel=1;
		#10 sel=0;D5=5'b001100;D8=8'b01010101;
		#10 sel=1;
		#10 $finish;
   end
      
endmodule

