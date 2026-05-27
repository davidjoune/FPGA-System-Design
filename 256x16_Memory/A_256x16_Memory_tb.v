`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:06:07 05/02/2025
// Design Name:   A_256x16_Memory
// Module Name:   C:/Users/A Kun/final_term/A_256x16_Memory_tb.v
// Project Name:  final_term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: A_256x16_Memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module A_256x16_Memory_tb;

	// Inputs
	reg [15:0] D;
	reg [7:0] addr;
	reg clk;
	reg WE;

	// Outputs
	wire [15:0] data;

	// Instantiate the Unit Under Test (UUT)
	A_256x16_Memory uut (
		.D(D), 
		.addr(addr), 
		.clk(clk), 
		.WE(WE), 
		.data(data)
	);

   always #10 clk = ~clk;

   initial begin
		D = 0;
		addr = 0;
		clk = 0;
		WE = 0;
		
		//WE測試
		#20 addr=8'd10;D=16'h9999; 

        //寫入測試
		#20 WE=1;addr=8'd10;D=16'h1111;
		#20 addr=8'd50;D=16'h5555;
		#20 addr=8'd90;D=16'h9999;
		#20 addr=8'd150;D=16'hffff;
		#20 addr=8'd210;D=16'habcd;
		
		//讀取測試
		#20 WE=0;addr=8'd0;D=16'h1616;
		#20 addr=8'd10;
		#20 addr=8'd50;
		#20 addr=8'd90;
		#20 addr=8'd150;
		#20 addr=8'd190;
		#20 addr=8'd210;
		
		#20 $finish;
	end
endmodule

