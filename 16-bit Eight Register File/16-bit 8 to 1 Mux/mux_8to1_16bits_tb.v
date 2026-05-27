`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:21:02 04/30/2025
// Design Name:   mux_8to1_16bits
// Module Name:   C:/Users/A Kun/final_term/mux_8to1_16bits_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_8to1_16bits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_8to1_16bits_tb;

	// Inputs
	reg [2:0] sel;
	reg [15:0] D0;
	reg [15:0] D1;
	reg [15:0] D2;
	reg [15:0] D3;
	reg [15:0] D4;
	reg [15:0] D5;
	reg [15:0] D6;
	reg [15:0] D7;

	// Outputs
	wire [15:0] data;

	// Instantiate the Unit Under Test (UUT)
	mux_8to1_16bits uut (
		.sel(sel), 
		.D0(D0), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.D4(D4), 
		.D5(D5), 
		.D6(D6), 
		.D7(D7), 
		.data(data)
	);

	initial begin
	   D0=16'h0001;
		D1=16'h0041;
		D2=16'h0701;
		D3=16'h9201;
		D4=16'h0ab1;
		D5=16'hc051;
		D6=16'h0d23;
		D7=16'h428a;
		
		sel=3'b000;
		#10 sel=3'b001;
		#10 sel=3'b010;
		#10 sel=3'b011;
		#10 sel=3'b100;
		#10 sel=3'b101;
		#10 sel=3'b110;
		#10 sel=3'b111;
		#10 $finish;
	end
endmodule

