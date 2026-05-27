`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:21:49 04/30/2025
// Design Name:   decoder_3to8
// Module Name:   C:/Users/A Kun/final_term/decoder_3to8_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decoder_3to8
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decoder_3to8_tb;

	// Inputs
	reg [2:0] addr;
	reg EN;

	// Outputs
	wire [7:0] D;

	// Instantiate the Unit Under Test (UUT)
	decoder_3to8 uut (
		.addr(addr), 
		.EN(EN), 
		.D(D)
	);

	initial begin
		EN = 0;
		addr = 0;
		#10 EN=1;
		#10 addr=001;
		#10 addr=010;
		#10 addr=011;
		#10 addr=100;
		#10 addr=101;
		#10 addr=110;
		#10 addr=111;
		#10 $finish;
   end    
endmodule

