`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:53:21 05/02/2025
// Design Name:   fulladder
// Module Name:   C:/Users/A Kun/final_term/fulladder_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fulladder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fulladder_tb;

	// Inputs
	reg A;
	reg B;
	reg Cin;

	// Outputs
	wire S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	fulladder uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.S(S), 
		.Cout(Cout)
	);

   initial begin
		A = 0;
		B = 0;
		Cin = 0;
		#10 A=0;B=0;Cin=1;
		#10 A=0;B=1;Cin=0;
		#10 A=0;B=1;Cin=1;
		#10 A=1;B=0;Cin=0;
		#10 A=1;B=0;Cin=1;
		#10 A=1;B=1;Cin=0;
		#10 A=1;B=1;Cin=1;
		#10 $finish;
   end
endmodule

