`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:53:41 04/30/2025
// Design Name:   A_16bits_eight_register_file
// Module Name:   C:/Users/A Kun/final_term/A_16bits_eight_register_file_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: A_16bits_eight_register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module A_16bits_eight_register_file_tb;

	// Inputs
	reg [15:0] WR_data;
	reg [2:0] WR_addr;
	reg [2:0] RA_addr;
	reg [2:0] RB_addr;
	reg WE;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] RA_data;
	wire [15:0] RB_data;

	// Instantiate the Unit Under Test (UUT)
	A_16bits_eight_register_file uut (
		.WR_data(WR_data), 
		.WR_addr(WR_addr), 
		.RA_addr(RA_addr), 
		.RB_addr(RB_addr), 
		.WE(WE), 
		.clk(clk), 
		.reset(reset), 
		.RA_data(RA_data), 
		.RB_data(RB_data)
	);

	always #20 clk = ~clk;

   initial begin  
      clk = 0;
      reset = 1;
      WE = 0;
      WR_data = 0;
      WR_addr = 0;
      RA_addr = 0;
      RB_addr = 0;
    
    // 1. 加上 reset
      #40 reset = 0;
    
    // 2. 對 8 個暫存器寫入值
      WE = 1;
      WR_addr = 3'b000; WR_data = 16'h0140; #40;
      WR_addr = 3'b001; WR_data = 16'h8854; #40;
      WR_addr = 3'b010; WR_data = 16'h7abc; #40;
      WR_addr = 3'b011; WR_data = 16'hbeef; #40;
      WR_addr = 3'b100; WR_data = 16'h543f; #40;
      WR_addr = 3'b101; WR_data = 16'h5640; #40;
      WR_addr = 3'b110; WR_data = 16'hdef9; #40;
      WR_addr = 3'b111; WR_data = 16'h7564; #40;
    
    // 關掉 WE 訊號
      WE = 0; WR_addr = 3'b000;
    
    // 分別讀取 8 個暫存器的值
      RB_addr = 3'b111; #40;
      RA_addr = 3'b001; RB_addr = 3'b110; #40;
      RA_addr = 3'b010; RB_addr = 3'b101; #40;
      RA_addr = 3'b011; RB_addr = 3'b100; #40;
      RA_addr = 3'b100; RB_addr = 3'b011; #40;
      RA_addr = 3'b101; RB_addr = 3'b010; #40;
      RA_addr = 3'b110; RB_addr = 3'b001; #40;
      RA_addr = 3'b111; RB_addr = 3'b000; #40;
		
	  reset = 1;
      #50; $finish;
   end
endmodule

