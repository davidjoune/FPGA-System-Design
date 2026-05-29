`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:22:54 05/03/2025
// Design Name:   datapath
// Module Name:   C:/Users/A Kun/final_term/datapath_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module datapath_tb;

	// Inputs
	reg Branch;
	reg PCWrite;
	reg IorD;
	reg MemWrite;
	reg IRWrite;
	reg RegDst;
	reg RegWrite;
	reg ALUSrcA;
	reg ext_we;
	reg PSWEn;
	reg JAorJR;
	reg LLorLH;
	reg imm5or8;
	reg test_normal;
	reg clk;
	reg reset;
	reg [1:0] ALUSrcB;
	reg [1:0] ALUop;
	reg [1:0] PCSrc;
	reg [1:0] MemtoReg;
	reg [15:0] ext_addr;
	reg [15:0] ext_data;

	// Outputs
	wire [15:0] instruction;
	wire [15:0] OutR;
	wire [15:0] mem_out;
	
	// parameter
    parameter clk_period = 20;
    parameter delay_factor = 2;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.Branch(Branch), 
		.PCWrite(PCWrite), 
		.IorD(IorD), 
		.MemWrite(MemWrite), 
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

   always begin
      #(clk_period/2) clk <= 1'b0;
      #(clk_period/2) clk <= 1'b1;
   end
	
   initial begin
		Branch = 0;
		PCWrite = 0;
		IorD = 0;
		MemWrite = 0;
		IRWrite = 0;
		RegDst = 0;
		RegWrite = 0;
		ALUSrcA = 0;
		ALUSrcB = 0;
		ALUop = 0;
		PCSrc = 0;
		ext_we = 0;
		PSWEn = 0;
		JAorJR = 0;
		LLorLH = 0;
		MemtoReg = 0;
		imm5or8 = 0;
		ext_addr = 0;
		test_normal = 0;
		ext_data = 0;
		clk = 0;
		reset = 0;
		
      repeat (3) @(posedge clk)
         #(clk_period/delay_factor) reset <= 1'b1;
      reset <= 1'b0; 
      
		ext_we = 1'b1;
		
		write_mem(16'h0,16'b0001_0000_0010_0101);  // LLI R0,#25
      write_mem(16'h1,16'b0000_1000_0110_0011);  // LHI R0,#63
      write_mem(16'h2,16'b1110_0000_0000_0000);  // OUT R0 (6325H)
      write_mem(16'h3,16'b0001_1001_0000_0000);  // LDR R1,R0,#0
      write_mem(16'h4,16'b0001_1010_0000_0001);  // LDR R2,R0,#1
      write_mem(16'h5,16'b1110_0000_0010_0000);  // OUT R1 (47H)
      write_mem(16'h6,16'b1110_0000_0100_0000);  // OUT R2 (89H)
      write_mem(16'h7,16'b0000_0011_0010_1000);  // ADD R3,R1,R2
      write_mem(16'h8,16'b1110_0000_0110_0000);  // OUT R3 (DOH)
      write_mem(16'h9,16'b0000_0011_0010_1010);  // SUB R3,R1,R2
      write_mem(16'hA,16'b1110_0000_0110_0000);  // OUT R3 (FFBEH)
      write_mem(16'hB,16'b0010_0100_0010_1000);  // LDR R4,R1,R2
		write_mem(16'hC,16'b1110_0000_1000_0000);  // OUT R4 (36H)
		write_mem(16'hD,16'b0010_1100_0000_0010);  // STR R4,R0,#2 (16'h27 = 36H)
		write_mem(16'hE,16'b0011_0011_0010_1000);  // STR R3,R1,R2 (16'hD0 = FFBEH)
		write_mem(16'hF,16'b0011_0000_0010_1001);  // CMP R1,R2 
		write_mem(16'h10,16'b0000_0011_0010_1001); // ADC R3,R1,R2
		write_mem(16'h11,16'b1110_0000_0110_0000); // OUT R3 (D0H)
		write_mem(16'h12,16'b1100_1110_0000_0010); // B[AL] PC < PC+2
		write_mem(16'h15,16'b1110_0000_0010_0000); // OUT R1 (47H)
		write_mem(16'h16,16'b0011_1001_0100_1000); // ADDI R1,R2,#8
		write_mem(16'h17,16'b1110_0000_0010_0000); // OUT R1 (91H)
		write_mem(16'h18,16'b0100_0001_1000_0111); // SUBI R1,R4,#7
		write_mem(16'h19,16'b1110_0000_0010_0000); // OUT R1 (2fH)
		write_mem(16'h1a,16'b0101_1001_0100_0000); // MOV R1,R2
		write_mem(16'h1b,16'b1110_0000_0010_0000); // OUT R1 (89H)
		write_mem(16'h1c,16'b0000_0000_0010_1011); // SBB R0,R1,R2
		write_mem(16'h1d,16'b1100_0000_0000_0011); // BEQ PC < PC+3
		write_mem(16'h21,16'b1110_0000_0000_0000); // OUT R0 (00H)
		write_mem(16'h22,16'b1000_0000_0011_0000); // JMP PC < 16'h30
		write_mem(16'h30,16'b1110_0000_0110_0000); // OUT R3 (D0H)
		write_mem(16'h31,16'b1001_1001_0011_0000); // JR  PC < 16'h89
		
		write_mem(16'h25,16'h47);// data (25h, 47h)
		write_mem(16'h26,16'h89);// data (26h, 89h)
		write_mem(16'hD0,16'h36);// data (D0h, 36h)
		
		// delay one clock to ensure the proper write to memory
      @(posedge clk) #(clk_period/delay_factor) MemWrite = 1'b0;
		//test_normal = 1'b0;
		
		// read data from the dual-port memory
		ext_we = 1'b1;
      for (i = 0; i < 14; i = i + 1)
         @(posedge clk) #(clk_period/delay_factor) ext_addr = i;
      //test_normal = 1'b0;
		//ext_we = 1'b0;
		
		// start the cpu to execute the program in memory
      reset = 1'b0;
      repeat (3) @(posedge clk)
         #(clk_period/delay_factor) reset = 1'b1;
      reset = 1'b0;
      //wait (done);
		
		//instruction test
		
		//// LLI R0,#25
				
		//T0 fetch
		@(posedge clk) #10; test_normal = 0; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; LLorLH = 0; MemtoReg = 2'b10;
		RegWrite = 1;
		
		//// LHI R0,#63
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; RegDst = 1;
		//T4 write back
		@(posedge clk) #10; LLorLH = 1; MemtoReg = 2'b10;
		RegWrite = 1;
		
		//// OutR R0 (6325H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// LDR R1,R0,#0
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 0;
		//T3 mem_addr
		@(posedge clk) #10; IorD = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b01;
		RegWrite = 1;
		
		//// LDR R2,R0,#1
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 0;
		//T3 mem_addr
		@(posedge clk) #10; IorD = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b01;
		RegWrite = 1;
		
		//// OutR R1 (47H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// OutR R2 (89H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// ADD R3,R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b00;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1;
		
		//// OutR R3 (D0H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// SUB R3,R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b10;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1;
		
		//// OutR R3 (FFBEH)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// LDR R4,R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b00;
		//T3 mem_addr
		@(posedge clk) #10; IorD = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b01;
		RegWrite = 1;
		
		//// OutR R4 (36H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// STR R4,R0,#2 (16'h27 = 36H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; RegDst = 1; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 0;
		//T3 mem_addr
		@(posedge clk) #10; IorD = 1;
		MemWrite = 1;
		
		//// STR R3,R1,R2 (16'hD0 = FFBEH)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; RegDst = 1; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b00;
		//T3 mem_addr
		@(posedge clk) #10; IorD = 1;
		MemWrite = 1;
		
		//// CMP R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b10;
		PSWEn = 1;
		
		//// ADC R3,R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b01;
		PSWEn = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1; PSWEn = 0;
		
		//// OUT R3 (D0H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// B[AL] PC < PC+2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; ALUSrcA = 0; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 1;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; PCSrc = 2'b01;
		Branch = 1; PCWrite = 1;
		
		//// OutR R1 (47H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// ADDI R1,R2,#8
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 0;
		PSWEn = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1; PSWEn = 0;
		
		//// OutR R1 (91H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// SUBI R1,R4,#7
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b10; ALUop = 2'b10; imm5or8 = 0;
		PSWEn = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1; PSWEn = 0;
		
		//// OutR R1 (2fH)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// MOV R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b11; ALUop = 2'b00;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1;
		
		//// OutR R1 (89H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// SBB R0,R1,R2
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; RegDst = 0;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ALUSrcA = 1; ALUSrcB = 2'b00; ALUop = 2'b11;
		PSWEn = 1;
		//T4 write_back
		@(posedge clk) #10; MemtoReg = 2'b00;
		RegWrite = 1; PSWEn = 0;
		
		//// BEQ PC < PC+3
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; ALUSrcA = 0; ALUSrcB = 2'b10; ALUop = 2'b00; imm5or8 = 1;
		PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; PCSrc = 2'b01;
		Branch = 1;
		
		//// OutR R0 (00H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// JMP PC < 16'h30
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; PCSrc = 2'b10;
		PCWrite = 1;
		
		//// OutR R3 (D0H)
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; ext_we = 1;
		
		//// JR PC < 16'h89
		
		//T0 fetch
		@(posedge clk) #10; IorD = 0; ALUSrcA = 0; ALUSrcB = 2'b01; ALUop = 2'b00; PCSrc = 2'b00; 
    	Branch = 0;	PCWrite = 1; MemWrite = 0; IRWrite = 1; RegWrite = 0; PSWEn = 0; ext_we = 0;
		//T1 decode
		@(posedge clk) #10; PCWrite = 0; IRWrite = 0;
		//T2 execution
		@(posedge clk) #10; RegDst = 2'b1;
		//T3 
		@(posedge clk) #10; PCSrc = 2'b11; JAorJR = 1;
		PCWrite = 1;
	   

   end
	
	task write_mem;
      input [15:0] addr, data;
      begin
         @(posedge clk) #(clk_period/delay_factor) begin
            test_normal = 1'b1;
            MemWrite = 1'b1;
            ext_addr = addr;
            ext_data = data;
         end
      end
   endtask
	
	initial #3500 $finish;
      
endmodule

