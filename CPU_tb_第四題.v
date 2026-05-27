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
		
		//4. Mov a memory block of N words from one place to another.
		
		write_mem(16'h0,16'b0001_0000_0011_0000); // LLI R0, #0x30     ; source base
		write_mem(16'h1,16'b0001_0001_0100_0000); // LLI R1, #0x40     ; destination base
		write_mem(16'h2,16'b0001_0010_0000_0000); // LLI R2, #0x00     ; index i = 0
		write_mem(16'h3,16'b0001_0100_0000_1010); // LLI R4, #0x0A     ; count = 10

		// loop:
		write_mem(16'h4,16'b0010_0011_0000_1000); // LDR R3, R0, R2    ; R3 = Mem[src + i]
		write_mem(16'h5,16'b0011_0011_0010_1000); // STR R3, R1, R2    ; Mem[dst + i] = R3
		write_mem(16'h6,16'b0011_1010_0100_0001); // ADDI R2, R2, #1   ; i++
		write_mem(16'h7,16'b0011_0000_0101_0001); // CMP R2, R4        ; if i == 10
		write_mem(16'h8,16'b1100_0000_0000_0001); // BEQ PC+1       (exit loop if i>=10)
		write_mem(16'h9,16'b1000_0000_0000_0100); // JMP loop 16'h4
		write_mem(16'ha,16'b0001_1101_0010_0000); // LDR R5,R1,#0
		write_mem(16'hb,16'b1110_0000_1010_0000); // OUT R5         (11H)
		write_mem(16'hc,16'b0001_1101_0010_0001); // LDR R5,R1,#1
		write_mem(16'hd,16'b1110_0000_1010_0000); // OUT R5         (22H)
		write_mem(16'he,16'b0001_1101_0010_0010); // LDR R5,R1,#2
		write_mem(16'hf,16'b1110_0000_1010_0000); // OUT R5         (33H)
		write_mem(16'h10,16'b0001_1101_0010_0011); // LDR R5,R1,#3
		write_mem(16'h11,16'b1110_0000_1010_0000); // OUT R5        (44H)
		write_mem(16'h12,16'b0001_1101_0010_0100); // LDR R5,R1,#4
		write_mem(16'h13,16'b1110_0000_1010_0000); // OUT R5        (55H)
		write_mem(16'h14,16'b0001_1101_0010_0101); // LDR R5,R1,#5
		write_mem(16'h15,16'b1110_0000_1010_0000); // OUT R5        (66H)
		write_mem(16'h16,16'b0001_1101_0010_0110); // LDR R5,R1,#6
		write_mem(16'h17,16'b1110_0000_1010_0000); // OUT R5        (77H)
		write_mem(16'h18,16'b0001_1101_0010_0111); // LDR R5,R1,#7
		write_mem(16'h19,16'b1110_0000_1010_0000); // OUT R5        (88H)
		write_mem(16'h1a,16'b0001_1101_0010_1000); // LDR R5,R1,#8
		write_mem(16'h1b,16'b1110_0000_1010_0000); // OUT R5        (99H)
		write_mem(16'h1c,16'b0001_1101_0010_1001); // LDR R5,R1,#9
		write_mem(16'h1d,16'b1110_0000_1010_0000); // OUT R5        (aaH)
		write_mem(16'h1e,16'b1110_0000_0000_0001); // HLT
		
		write_mem(16'h30,16'h11); // data (30h, 11H)
        write_mem(16'h31,16'h22); // data (31h, 22H)
		write_mem(16'h32,16'h33); // data (32h, 33H)
		write_mem(16'h33,16'h44); // data (33h, 44H)
		write_mem(16'h34,16'h55); // data (34h, 55H)
		write_mem(16'h35,16'h66); // data (35h, 66H)
		write_mem(16'h36,16'h77); // data (36h, 77H)
		write_mem(16'h37,16'h88); // data (37h, 88H)
		write_mem(16'h38,16'h99); // data (38h, 99H)
		write_mem(16'h39,16'haa); // data (39h, aaH)

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
	initial #8000 $finish;
endmodule

