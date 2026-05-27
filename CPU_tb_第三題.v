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
		
		//3. Add ten numbers in consecutive memory locations.
		
		write_mem(16'h0,16'b0001_0000_0010_0101); // LLI  R0,#25     ; base address
		write_mem(16'h1,16'b0001_0010_0000_0000); // LLI  R2,#0x00   ; loop counter i = 0
		write_mem(16'h2,16'b0101_1001_0000_0000); // MOV  R1,R0      ; R1 = base address
		write_mem(16'h3,16'b0001_0011_0000_0000); // LLI  R3,#0x00   ; R3 = sum = 0
		write_mem(16'h4,16'b0001_0101_0000_1010); // LLI  R5,#0x0a   ; R5 = threshold 10
		
		// loop:
		write_mem(16'h5,16'b0010_0100_0010_1000); // LDR  R4, R1, R2  ; R4 = Mem[R1 + R2]
		write_mem(16'h6,16'b0000_0011_0111_0000); // ADD  R3, R3, R4  ; sum += R4
		write_mem(16'h7,16'b0011_1010_0100_0001); // ADDI R2, R2, #1  ; i++
		write_mem(16'h8,16'b0011_0000_0101_0101); // CMP  R2, R5      ; if i == 10
		write_mem(16'h9,16'b1100_0000_0000_0001); // BEQ  PC+1 (exit loop if i>=10)
		write_mem(16'ha,16'b1000_0000_0000_0101); // JMP  to loop @ 0x4
		write_mem(16'hb,16'b1110_0000_0110_0000); // OUT  R3
		write_mem(16'hc,16'b1110_0000_0000_0001); // HLT
		
		write_mem(16'h25,16'h1);// data (25h, 1h)
		write_mem(16'h26,16'h2);// data (26h, 2h)
		write_mem(16'h27,16'h3);// data (27h, 3h)
		write_mem(16'h28,16'h4);// data (28h, 4h)
		write_mem(16'h29,16'h5);// data (29h, 5h)
		write_mem(16'h2a,16'h6);// data (2ah, 6h)
		write_mem(16'h2b,16'h7);// data (2bh, 7h)
		write_mem(16'h2c,16'h8);// data (2ch, 8h)
		write_mem(16'h2d,16'h9);// data (2dh, 9h)
		write_mem(16'h2e,16'ha);// data (2eh, ah)
		
		
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
	initial #6000 $finish;
endmodule

