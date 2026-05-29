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
		
		//1. Find the minimum and maximum from two numbers in memory.
		
		write_mem(16'h0,16'b0001_0000_0010_0101);  // LLI R0,#25
		write_mem(16'h1,16'b0001_1001_0000_0000);  // LDR R1,R0,#0
        write_mem(16'h2,16'b0001_1010_0000_0001);  // LDR R2,R0,#1
		write_mem(16'h3,16'b0011_0000_0010_1001);  // CMP R1,R2
		write_mem(16'h4,16'b1100_0010_0000_0011);  // BCS PC < PC + 3
		//R2 > R1
		write_mem(16'h6,16'b1110_0000_0100_0000);  // OUT R2
		write_mem(16'h7,16'b1110_0000_0010_0000);  // OUT R1
		write_mem(16'h8,16'b1110_0000_0000_0001);  // HLT
		//R1 > R2
		write_mem(16'h9,16'b1110_0000_0010_0000);  // OUT R1
		write_mem(16'ha,16'b1110_0000_0100_0000);  // OUT R2
		write_mem(16'hb,16'b1110_0000_0000_0001);  // HLT
		
		write_mem(16'h25,16'h88);// data (25h, 88h)
		write_mem(16'h26,16'h55);// data (26h, 55h)
		
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
	initial #2000 $finish;
endmodule

