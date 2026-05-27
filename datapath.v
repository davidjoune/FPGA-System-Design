`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:56 05/02/2025 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input Branch, PCWrite, IorD, MemWrite, IRWrite, RegDst, RegWrite, ALUSrcA, ext_we, PSWEn, JAorJR, LLorLH, imm5or8, test_normal, clk, reset,
	input [1:0] ALUSrcB, ALUop, PCSrc, MemtoReg,
	input [15:0] ext_addr, ext_data,
	output [15:0] instruction, OutR, mem_out
    );
	
	
	wire branch_net, C, Z, EN0, c_flag_bar, z_flag_bar, m11_data;
	wire [15:0] PC_next, ALUResult, PCJump, jajr, m3_data, m4_data, m5_data, Ex_data, m8_data, m7_data, LL, LH, m9_data, m10_data;
	wire [2:0] m6_data;
	
	reg c_flag, z_flag;
	wire [15:0] ALUOut, PC, RA_data, RB_data, mem_data, D3_Q, RF_A, RF_B;
	
	always@(posedge clk)begin
	   if(PSWEn)begin
		   c_flag <= C;
			z_flag <= Z;
      end
	end
	
	assign c_flag_bar = !c_flag;
	assign z_flag_bar = !z_flag;
	assign EN0 = PCWrite | (Branch & branch_net);
	
	assign PCJump = {PC[15:11],instruction[10:0]};
	
	assign LL = {{8{1'b0}},instruction[7:0]};
	assign LH = {instruction[7:0],RB_data[7:0]};
	
	MUX_4to1 m2(.sel(instruction[9:8]), .D0(z_flag), .D1(z_flag_bar), .D2(c_flag), .D3(c_flag_bar), .data(branch_net));
	
	DFF_16bits D0(.D(PC_next), .clk(clk), .reset(reset), .enable(EN0), .Q(PC));
	
	MUX_2to1_16bits m3(.sel(IorD), .D0(PC), .D1(ALUOut), .data(m3_data));
	MUX_2to1_16bits m4(.sel(test_normal), .D0(m3_data), .D1(ext_addr), .data(m4_data));
	MUX_2to1_16bits m5(.sel(test_normal), .D0(RB_data), .D1(ext_data), .data(m5_data));
	
	A_256x16_Memory Mem(.D(m5_data), .addr(m4_data[7:0]), .clk(clk), .WE(MemWrite), .data(mem_data));
	
	DFF_16bits D1(.D(mem_data), .clk(clk), .reset(reset), .enable(ext_we), .Q(mem_out));
	DFF_16bits D2(.D(mem_data), .clk(clk), .reset(reset), .enable(IRWrite), .Q(instruction));
	DFF_16bits D3(.D(mem_data), .clk(clk), .reset(reset), .enable(1'b1), .Q(D3_Q));
	
	Extend_16bits Ex(.D5(instruction[4:0]), .D8(instruction[7:0]), .sel(imm5or8), .data(Ex_data));
	
	MUX_2to1_3bits m6(.sel(RegDst), .D0(instruction[4:2]), .D1(instruction[10:8]), .data(m6_data));
	MUX_4to1_16bits m7(.sel(MemtoReg), .D0(ALUOut), .D1(D3_Q), .D2(m8_data), .D3(PC), .data(m7_data));
	MUX_2to1_16bits m8(.sel(LLorLH), .D0(LL), .D1(LH), .data(m8_data));
	
	A_16bits_eight_register_file RF(.WR_data(m7_data), .WR_addr(instruction[10:8]), .RA_addr(instruction[7:5]), .RB_addr(m6_data), .WE(RegWrite), .clk(clk), .reset(reset), .RA_data(RF_A), .RB_data(RF_B));
   
	DFF_16bits D4(.D(RF_A), .clk(clk), .reset(reset), .enable(ext_we), .Q(OutR));
	DFF_16bits D5(.D(RF_A), .clk(clk), .reset(reset), .enable(1'b1), .Q(RA_data));
	DFF_16bits D6(.D(RF_B), .clk(clk), .reset(reset), .enable(1'b1), .Q(RB_data));
	
	MUX_2to1_16bits m9(.sel(ALUSrcA), .D0(PC), .D1(RA_data), .data(m9_data));
	MUX_4to1_16bits m10(.sel(ALUSrcB), .D0(RB_data), .D1(16'd1), .D2(Ex_data), .D3(16'b0), .data(m10_data));
	MUX_2to1 m11(.sel(ALUop[0]), .D0(1'b0), .D1(c_flag), .data(m11_data));
	
	A_16bits_ALU ALU(.A(m9_data), .B(m10_data), .ALUop(ALUop), .C_flag(m11_data), .S(ALUResult), .C(C), .Z(Z));
	
	DFF_16bits D7(.D(ALUResult), .clk(clk), .reset(reset), .enable(1'b1), .Q(ALUOut));
	
	MUX_2to1_16bits m0(.sel(JAorJR), .D0(RA_data), .D1(RB_data), .data(jajr));
	MUX_4to1_16bits m1(.sel(PCSrc), .D0(ALUResult), .D1(ALUOut), .D2(PCJump), .D3(jajr), .data(PC_next));
	
endmodule
