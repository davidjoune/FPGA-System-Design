`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:15:31 05/03/2025 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
   input clk, reset, test_normal, test_write_mem,
	input [15:0] ext_addr, ext_data,
	output done,
	output [15:0] mem_out, OutR, instruction
    );
	
	wire Branch, PCWrite, IorD, MemWrite, IRWrite, RegDst, RegWrite, ALUSrcA, ext_we, PSWEn, JAorJR, LLorLH, imm5or8, clk_b, m3_data;
	wire [1:0] ALUSrcB, ALUop, PCSrc, MemtoReg;
	
	assign clk_b = !clk;
	MUX_2to1 m3(.sel(test_write_mem), .D0(MemWrite), .D1(1'b1), .data(m3_data));
	
	datapath m0(.Branch(Branch), 
	            .PCWrite(PCWrite), 
					.IorD(IorD), 
					.MemWrite(m3_data), 
					.IRWrite(IRWrite), 
					.RegDst(RegDst), 
					.RegWrite(RegWrite), 
					.ALUSrcA(ALUSrcA), 
					.ext_we(ext_we), 
					.PSWEn(PSWEn), 
					.JAorJR(JAorJR), 
					.LLorLH(LLorLH), 
					.imm5or8(imm5or8), 
					.test_normal(test_normal), 
					.clk(clk), 
					.reset(reset),
					.ALUSrcB(ALUSrcB), 
					.ALUop(ALUop),
					.PCSrc(PCSrc), 
					.MemtoReg(MemtoReg),
					.ext_addr(ext_addr), 
					.ext_data(ext_data),
					.instruction(instruction), 
					.OutR(OutR), 
					.mem_out(mem_out)
	);
	
	controller m(.I(instruction),
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
					 .OutREn(ext_we), 
					 .done(done),
					 .ALUSrcB(ALUSrcB), 
					 .ALUop(ALUop), 
					 .PCSrc(PCSrc), 
					 .MemtoReg(MemtoReg)
	);
endmodule
