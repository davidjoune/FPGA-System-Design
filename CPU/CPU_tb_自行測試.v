`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:14:11 05/04/2025
// Design Name:   CPU
// Module Name:   C:/Users/A Kun/final_term/CPU_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_tb;

	// Inputs
	reg clk;
	reg reset;
	reg test_normal;
	reg test_write_mem;
	reg [15:0] ext_addr;
	reg [15:0] ext_data;

	// Outputs
	wire done;
	wire [15:0] mem_out;
	wire [15:0] OutR;
	wire [15:0] instruction;
	
	// parameter
   parameter clk_period = 20;
   parameter delay_factor = 2;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset), 
		.test_normal(test_normal), 
		.test_write_mem(test_write_mem), 
		.ext_addr(ext_addr), 
		.ext_data(ext_data), 
		.done(done), 
		.mem_out(mem_out), 
		.OutR(OutR), 
		.instruction(instruction)
	);

   always begin
      #(clk_period/2) clk <= 1'b0;
      #(clk_period/2) clk <= 1'b1;
   end
   initial begin
		reset = 0;
		clk = 0;
		ext_addr = 0;
		test_normal = 0;
		ext_data = 0;
		test_write_mem = 0;
		
		repeat (3) @(posedge clk)
         #(clk_period/delay_factor) reset <= 1'b1;
      reset <= 1'b0; 
		
		
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
		write_mem(16'h32,16'b1110_0001_0011_0001); // HLT
		
		write_mem(16'h25,16'h47);// data (25h, 47h)
		write_mem(16'h26,16'h89);// data (26h, 89h)
		write_mem(16'hD0,16'h36);// data (D0h, 36h)
		
		// delay one clock to ensure the proper write to memory
      @(posedge clk) #(clk_period/delay_factor) test_write_mem = 1'b0;
		
		// start the cpu to execute the program in memory
      reset = 1'b0;
      repeat (3) @(posedge clk)
         #(clk_period/delay_factor) reset = 1'b1;
      reset = 1'b0;
		test_normal = 0;
   end
	task write_mem;
      input [15:0] addr, data;
      begin
         @(posedge clk) #(clk_period/delay_factor) begin
            test_normal = 1'b1;
            test_write_mem = 1'b1;
            ext_addr = addr;
            ext_data = data;
         end
      end
   endtask
	initial #3500 $finish;
      
endmodule

