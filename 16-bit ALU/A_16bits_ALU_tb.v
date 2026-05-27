`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:35:29 05/02/2025
// Design Name:   A_16bits_ALU
// Module Name:   C:/Users/A Kun/final_term/A_16bits_ALU_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: A_16bits_ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module A_16bits_ALU_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [1:0] ALUop;
	reg C_flag;

	// Outputs
	wire [15:0] S;
	wire C;
	wire Z;

	// Instantiate the Unit Under Test (UUT)
	A_16bits_ALU uut (
		.A(A), 
		.B(B), 
		.ALUop(ALUop), 
		.C_flag(C_flag), 
		.S(S), 
		.C(C), 
		.Z(Z)
	);

   initial begin
		A = 0;
		B = 0;
		ALUop = 0;
		C_flag = 0;
		//ADD
	   #30 A=16'hffff;B=16'h0001;
		#30 A=16'haaaa;B=16'h1111;
		#30 A=16'h1515;B=16'h2222;
		//ADC
		#30 ALUop=2'b01;A=16'hffff;B=16'h0001;C_flag=0;
		#30 A=16'haaaa;B=16'h1111;C_flag=0;
		#30 A=16'h1515;B=16'h2222;C_flag=1;
		#30 A=16'h0001;B=16'h00ff;C_flag=1;
		//SUB
		#30 ALUop=2'b10;A=16'hffff;B=16'h0001;
		#30 A=16'haaaa;B=16'h1111;
		#30 A=16'h1515;B=16'h2222;
		//SBB
		#30 ALUop=2'b11;A=16'hffff;B=16'h0001;C_flag=0;
		#30 A=16'haaaa;B=16'h1111;C_flag=0;
		#30 A=16'h1515;B=16'h2222;C_flag=1;
		#30 A=16'h00ff;B=16'h0011;C_flag=1;
		#30 $finish;
   end 
endmodule

