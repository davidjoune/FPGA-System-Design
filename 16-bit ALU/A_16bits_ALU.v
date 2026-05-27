`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:11 05/02/2025 
// Design Name: 
// Module Name:    A_16bits_ALU 
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
module A_16bits_ALU(
   input [15:0] A, B,
	input [1:0] ALUop,
	input C_flag,
	output [15:0] S,
	output C, Z
    );
	
	wire Cin, Z, C;
	wire [14:0] Cout;
	wire [15:0] B_bar;
	
	assign Cin = (ALUop[1]==1'b0)&&(ALUop[0]==1'b0)? ALUop[0]:
	             (ALUop[1]==1'b1)&&(ALUop[0]==1'b0)? ALUop[1]:
			     (ALUop[1]==1'b0)&&(ALUop[0]==1'b1)? C_flag : C_flag;
					 
    assign B_bar = B ^ {16{ALUop[1]}};
	
	assign Z = !(|S);
	
	genvar i;
	generate for(i=0;i<16;i=i+1)begin:ALU
	   if(i==0) 
		   fulladder f(.A(A[i]), .B(B_bar[i]), .Cin(Cin), .S(S[i]), .Cout(Cout[i]));
		else if(i==15)
		   fulladder f(.A(A[i]), .B(B_bar[i]), .Cin(Cout[i-1]), .S(S[i]), .Cout(C));
		else
		   fulladder f(.A(A[i]), .B(B_bar[i]), .Cin(Cout[i-1]), .S(S[i]), .Cout(Cout[i]));
	end endgenerate
endmodule
