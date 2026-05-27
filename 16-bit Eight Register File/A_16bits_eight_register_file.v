`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:03:41 04/30/2025 
// Design Name: 
// Module Name:    A_16bits_eight_register_file 
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
module A_16bits_eight_register_file(
   input [15:0] WR_data,
	input [2:0] WR_addr, RA_addr, RB_addr,
	input WE, clk, reset,
	output [15:0] RA_data, RB_data
    );
	 
	wire [7:0] D;
	wire [15:0] Q [7:0];
	decoder_3to8 m0(.addr(WR_addr), .EN(WE), .D(D));
	genvar i;
	generate for(i=0;i<8;i=i+1)begin:DFF
	   DFF_16bits D(.D(WR_data), .clk(clk), .reset(reset), .enable(D[i]), .Q(Q[i]));
   end endgenerate
   mux_8to1_16bits m1(.sel(RA_addr), .D0(Q[0]), .D1(Q[1]), .D2(Q[2]), .D3(Q[3]), .D4(Q[4]), .D5(Q[5]), .D6(Q[6]), .D7(Q[7]), .data(RA_data));
   mux_8to1_16bits m2(.sel(RB_addr), .D0(Q[0]), .D1(Q[1]), .D2(Q[2]), .D3(Q[3]), .D4(Q[4]), .D5(Q[5]), .D6(Q[6]), .D7(Q[7]), .data(RB_data));
endmodule
