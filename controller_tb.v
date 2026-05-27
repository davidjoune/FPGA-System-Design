`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:50:40 05/03/2025
// Design Name:   controller
// Module Name:   C:/Users/A Kun/final_term/controller_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controller_tb;

	// Inputs
	reg [15:0] I;
	reg clk;
	reg reset;

	// Outputs
	wire IorD;
	wire RegDst;
	wire ALUSrcA;
	wire JAorJR;
	wire LLorLH;
	wire imm5or8;
	wire Branch;
	wire PCWrite;
	wire MemWrite;
	wire IRWrite;
	wire RegWrite;
	wire PSWEn;
	wire OutREn;
	wire done;
	wire [1:0] ALUSrcB;
	wire [1:0] ALUop;
	wire [1:0] PCSrc;
	wire [1:0] MemtoReg;
	
	// parameter
   parameter clk_period = 20;
   parameter delay_factor = 2;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.I(I), 
		.clk(clk), 
		.reset(reset), 
		.IorD(IorD), 
		.RegDst(RegDst), 
		.ALUSrcA(ALUSrcA), 
		.JAorJR(JAorJR), 
		.LLorLH(LLorLH), 
		.imm5or8(imm5or8), 
		.Branch(Branch), 
		.PCWrite(PCWrite), 
		.MemWrite(MemWrite), 
		.IRWrite(IRWrite), 
		.RegWrite(RegWrite), 
		.PSWEn(PSWEn), 
		.OutREn(OutREn), 
		.done(done), 
		.ALUSrcB(ALUSrcB), 
		.ALUop(ALUop), 
		.PCSrc(PCSrc), 
		.MemtoReg(MemtoReg)
	);

   always begin
      #(clk_period/2) clk <= 1'b0;
      #(clk_period/2) clk <= 1'b1;
   end
	
   initial begin
		I = 0;
		reset = 1;
		clk = 0;
		#10 reset = 0;
		#(clk_period*3)  I = 16'b0001_0000_0010_0101; //LLI
		#(clk_period*3)  I = 16'b0000_1000_0110_0011; //LHI
		#(clk_period*4)  I = 16'b1110_0000_0000_0000; //OUT
		#(clk_period*3)  I = 16'b0001_1001_0000_0000; //LDR(im)
		#(clk_period*5)  I = 16'b0010_0000_0000_0000; //LDR
		#(clk_period*5)  I = 16'b0010_1000_0000_0000; //STR(im)
		#(clk_period*4)  I = 16'b0011_0000_0000_0000; //STR
		#(clk_period*4)  I = 16'b0000_0000_0000_0000; //ADD
		#(clk_period*4)  I = 16'b0000_0000_0000_0001; //ADC
		#(clk_period*4)  I = 16'b0000_0000_0000_0010; //SUB
		#(clk_period*4)  I = 16'b0000_0000_0000_0011; //SBB
		#(clk_period*4)  I = 16'b0011_0000_0000_0001; //CMP
		#(clk_period*3)  I = 16'b0011_1000_0000_0001; //ADDI
		#(clk_period*4)  I = 16'b0100_0000_0000_0000; //SUBI
		#(clk_period*4)  I = 16'b0101_1000_0000_0001; //MOV
		#(clk_period*4)  I = 16'b1100_1110_0000_0000; //BAL
		#(clk_period*3)  I = 16'b1000_0110_0000_0000; //JMP
		#(clk_period*3)  I = 16'b1100_0000_0000_0000; //BEQ
		#(clk_period*3)  I = 16'b1000_1000_0000_0000; //JAL_label
		#(clk_period*3)  I = 16'b1001_1000_0000_0000; //JR
		#(clk_period*4)  I = 16'b1110_0000_0000_0001; //HLT
		#180 $finish;
	end
endmodule

