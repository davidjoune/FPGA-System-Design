`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:52 05/03/2025 
// Design Name: 
// Module Name:    controller 
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
module controller(
   input [15:0] I,
	input clk, reset,
	output IorD, RegDst, ALUSrcA, JAorJR, LLorLH, imm5or8, Branch, PCWrite, MemWrite, IRWrite, RegWrite, PSWEn, OutREn, done,
	output [1:0] ALUSrcB, ALUop, PCSrc, MemtoReg
    );
	 
	reg IorD, RegDst, ALUSrcA, JAorJR, LLorLH, imm5or8, Branch, PCWrite, MemWrite, IRWrite, RegWrite, PSWEn, OutREn, done;
	reg [1:0] ALUSrcB, ALUop, PCSrc, MemtoReg;
	reg [4:0] current_state, next_state;
	
	always@(posedge clk)begin
	  if(reset)
	     current_state <= 5'd0;
	  else
	     current_state <= next_state;
	end
	
	always@(*)begin
	   case(current_state)
		   5'd0: next_state = 5'd1;
			5'd1: begin
			   if(I[15:11]==5'b00001 || I[15:11]==5'b00011 || I[15:11]==5'b00101 || I[15:11]==5'b10011)
				   next_state = 5'd2;
				else if(I[15:11]==5'b00010)
				   next_state = 5'd8;
				else if((I[15:11]==5'b00100 && I[1:0]==2'b00) || (I[15:11]==5'b00110 && I[1:0]==2'b00))
				   next_state = 5'd9;
				else if(I[15:11]==5'b00000 && I[1:0]==2'b00)
				   next_state = 5'd12;
				else if(I[15:11]==5'b00000 && I[1:0]==2'b01)
				   next_state = 5'd14;
				else if((I[15:11]==5'b00000 && I[1:0]==2'b10) || (I[15:11]==5'b00110 && I[1:0]==2'b01))
				   next_state = 5'd15;
				else if(I[15:11]==5'b00000 && I[1:0]==2'b11)
				   next_state = 5'd16;
				else if(I[15:11]==5'b00111)
				   next_state = 5'd17;
				else if(I[15:11]==5'b01000)
				   next_state = 5'd18;
				else if(I[15:11]==5'b01011)
				   next_state = 5'd19;
				else if(I[15:8]==8'b11000011 || I[15:8]==8'b11000010 || I[15:8]==8'b11000001 || I[15:8]==8'b11000000)
				   next_state = 5'd20;
				else if(I[15:8]==8'b11001110)
				   next_state = 5'd21;
				else if(I[15:11]==5'b10000)
				   next_state = 5'd22;
				else if(I[15:11]==5'b10001)
				   next_state = 5'd23;
				else if(I[15:11]==5'b10010)
				   next_state = 5'd24;
				else if(I[15:11]==5'b11100 && I[1:0]==2'b00)
				   next_state = 5'd25;
				else
				   next_state = 5'd26;
			end
			5'd2: begin
			   if(I[15:11]==5'b00001)
				   next_state = 5'd3;
				else if(I[15:11]==5'b00011)
				   next_state = 5'd4;
				else if(I[15:11]==5'b00101)
				   next_state = 5'd6;
				else
				   next_state = 5'd7;
			end
			5'd3: next_state = 5'd0;
			5'd4: next_state = 5'd5;
			5'd5: next_state = 5'd0;
			5'd6: next_state = 5'd0;
			5'd7: next_state = 5'd0;
			5'd8: next_state = 5'd0;
			5'd9: begin
			   if(I[15:11]==5'b00100 && I[1:0]==2'b00)
				   next_state = 5'd10;
				else
				   next_state = 5'd11;
			end
			5'd10: next_state = 5'd5;
			5'd11: next_state = 5'd0;
			5'd12: next_state = 5'd13;
			5'd13: next_state = 5'd0;
			5'd14: next_state = 5'd13;
			5'd15: begin
			   if(I[15:11]==5'b00000 && I[1:0]==2'b10)
				   next_state = 5'd13;
				else
				   next_state = 5'd0;
			end
			5'd16: next_state = 5'd13;
			5'd17: next_state = 5'd13;
			5'd18: next_state = 5'd13;
			5'd19: next_state = 5'd13;
			5'd20: next_state = 5'd0;
			5'd21: next_state = 5'd0;
			5'd22: next_state = 5'd0;
			5'd23: next_state = 5'd0;
			5'd24: next_state = 5'd0;
			5'd25: next_state = 5'd0;
			default: next_state = 5'd0;
		endcase
	end
			
	always@(*)begin
      case(current_state)
         5'd0: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd1: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b10; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 1;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd2: begin	
            IorD = 0; RegDst = 1; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd3: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 1; MemtoReg = 2'b10; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd4: begin	
            IorD = 1; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd5: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b01; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd6: begin	
            IorD = 1; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 1; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd7: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b11; JAorJR = 1; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 1; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd8: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b10; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd9: begin	
            IorD = 0; RegDst = 1; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd10: begin	
            IorD = 1; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd11: begin	
            IorD = 1; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 1; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd12: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd13: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd14: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b01; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd15: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b10; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd16: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b11; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd17: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd18: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b10; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 1; OutREn = 0; done = 0;
         end
			5'd19: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 1; ALUSrcB = 2'b11; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd20: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b01; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 1; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd21: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b01; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 1; PCWrite = 1; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd22: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b10; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 1; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd23: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b10; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b11; imm5or8 = 1;
            Branch = 0; PCWrite = 1; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd24: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b11; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b11; imm5or8 = 0;
            Branch = 0; PCWrite = 1; MemWrite = 0; IRWrite = 0; RegWrite = 1; PSWEn = 0; OutREn = 0; done = 0;
         end
			5'd25: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 1; done = 0;
         end
			5'd26: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 1;
         end
			default: begin	
            IorD = 0; RegDst = 0; ALUSrcA = 0; ALUSrcB = 2'b00; ALUop = 2'b00; PCSrc = 2'b00; JAorJR = 0; LLorLH = 0; MemtoReg = 2'b00; imm5or8 = 0;
            Branch = 0; PCWrite = 0; MemWrite = 0; IRWrite = 0; RegWrite = 0; PSWEn = 0; OutREn = 0; done = 0;
         end
		endcase
	end
endmodule
