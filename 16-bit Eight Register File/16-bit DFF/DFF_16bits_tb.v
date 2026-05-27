`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:45:48 04/30/2025
// Design Name:   DFF_16bits
// Module Name:   C:/Users/A Kun/final_term/DFF_16bits_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DFF_16bits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DFF_16bits_tb;

	// Inputs
	reg [15:0] D;
	reg clk;
	reg reset;
	reg enable;

	// Outputs
	wire [15:0] Q;

	// Instantiate the Unit Under Test (UUT)
	DFF_16bits uut (
		.D(D), 
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.Q(Q)
	);

	always #10 clk = ~clk;
   initial begin
       clk = 0;
       enable = 0;
       reset = 0;
       D = 16'h0000;
       // 1.  Reset
       #20 reset = 1;
       #20 reset = 0;
       // 2. 代刚 Enable = 0 
       #20 D = 16'hAAAA;
       #20 enable = 0;
       #20 D = 16'h5555;
       #20;
       // 3. 代刚 Enable = 1
       #20 enable = 1;
       #20 D = 16'h1234;
       #20 D = 16'h5678;
       #20 D = 16'h9ABC;
       // 4. 代刚 Reset
       #25 reset = 1;
       #20 reset = 0;
       // 5. 代刚 タ盽DFF 
       #20 D = 16'hDEAD;
       #20 D = 16'hBEEF;
	   
       #50 $finish;
   end
endmodule

