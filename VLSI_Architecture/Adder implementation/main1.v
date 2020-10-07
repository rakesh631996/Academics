`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 14:48:15
// Design Name: 
// Module Name: main1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main1(
    input [15:0] A,
    input [15:0] B,
    output [15:0] Sum,
    output carry
    
    );
    wire CARRY0, CARRY1, CARRY2;
    
    usedfourbitCLA firstcall(Sum[3:0],CARRY0,A[4:0],B[4:0],0);
    error firstcall(Sum[4:0],A[4:0],B[4:0],CARRY0);
    usedfourbitCLA secondcall(Sum[7:4],CARRY1,A[8:4],B[8:4],CARRY0);
    error firstcall(Sum[8:4],A[8:4],B[8:4],CARRY1);
    usedfourbitCLA thirdcall(Sum[11:8],CARRY2,A[12:8],B[12:8],CARRY1);
    error firstcall(Sum[15:12],A[12:8],B[12:8],CARRY2);
    normalfourbitCLA finalcall(Sum[15:12],carry,A[15:12],B[15:12],CARRY2);
    
endmodule

module error(