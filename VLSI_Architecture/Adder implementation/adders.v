`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2020 17:59:11
// Design Name: 
// Module Name: adders
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



    module usedfourbitCLA(S, Cout,  A, B, Cin);
    output [3:0] S;
    output Cout;
    wire PG,GG;
    input [4:0] A,B;
    wire cpred_gi;
    wire cadd;
    wire kfromnextbit;
    wire select;
    wire selectbar;  
    wire andoneofSC; //selectbar and Cadd 
    wire andtwoofSC; //select and Cpred
    input Cin;
    wire [3:0]G,P,C;
    wire W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11;
    and (G[3],A[3],B[3]);//Generate
    and (G[2],A[2],B[2]);
    and (G[1],A[1],B[1]);
    and (G[0],A[0],B[0]);
    xor (P[3],A[3],B[3]);//Propagate
    xor (P[2],A[2],B[2]);
    xor (P[1],A[1],B[1]);
    xor (P[0],A[0],B[0]);
    buf (C[0],Cin);
    and (W1,P[0],C[0]);
    or (C[1],G[0],W1);
    and (W2,P[1],C[1]);
    or (C[2],G[1],W2);
    and (W3,P[2],C[2]);
    or (C[3],G[2],W3);
    and (W4,P[3],C[3]);
    or (cadd,G[3],W4);//Cout
    xor (S[3],P[3],C[3]);// Sum
    xor (S[2],P[2],C[2]);
    xor (S[1],P[1],C[1]);
    xor (S[0],P[0],C[0]);
    and (W5,P[3],P[2]);
    and (W6,P[1],W5);
    and (PG,P[0],W6);// Group Propagate
    and (W7,G[0],W6);
    and (W8,G[1],W5);
    and (W9,G[2],P[3]);
    or (W10,W8,W7);
    or (W11,W10,W9);
    or (GG,W11,G[3]);// Group Generate
    nor (kfromnextbit,A[4],B[4]);
    and (cpred_gi,A[3],B[3]);
    or(select,kfromnextbit,cpred_gi);
    and(andoneofSC,cadd,~select);
    and(andtwoofSC,cpred_gi,select);
    or(Cout,andoneofSC,andtwoofSC);
    endmodule

module normalfourbitCLA(S, Cout,  A, B, Cin);
output [3:0] S;
output Cout;
wire PG,GG;
input [3:0] A,B;
input Cin;
wire [3:0]G,P,C;
wire W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11;
and (G[3],A[3],B[3]);//Generate
and (G[2],A[2],B[2]);
and (G[1],A[1],B[1]);
and (G[0],A[0],B[0]);
xor (P[3],A[3],B[3]);//Propagate
xor (P[2],A[2],B[2]);
xor (P[1],A[1],B[1]);
xor (P[0],A[0],B[0]);
buf (C[0],Cin);
and (W1,P[0],C[0]);
or (C[1],G[0],W1);
and (W2,P[1],C[1]);
or (C[2],G[1],W2);
and (W3,P[2],C[2]);
or (C[3],G[2],W3);
and (W4,P[3],C[3]);
or (Cout,G[3],W4);//Cout
xor (S[3],P[3],C[3]);// Sum
xor (S[2],P[2],C[2]);
xor (S[1],P[1],C[1]);
xor (S[0],P[0],C[0]);
and (W5,P[3],P[2]);
and (W6,P[1],W5);
and (PG,P[0],W6);// Group Propagate
and (W7,G[0],W6);
and (W8,G[1],W5);
and (W9,G[2],P[3]);
or (W10,W8,W7);
or (W11,W10,W9);
or (GG,W11,G[3]);// Group Generate
endmodule

module error(S, A, B,Cin)
    input [4:0]A,B;
    input Cin;
    output [4:0]S;
    wire cpred_gi;
    wire cadd;
    wire kfromnextbit;
    wire W1,W2,W3,W4;
    wire [4:0]G,P,C;

//K(i+1)
    nor (kfromnextbit,A[4],B[4]);

//C(i+1)
    and (cpred_gi,A[3],B[3]);

//P(i+1)
    xor (P[4],A[4],B[4]);

//cout
    and (G[3],A[3],B[3]);
    and (G[2],A[2],B[2]);
    and (G[1],A[1],B[1]);
    and (G[0],A[0],B[0]);

    xor (P[3],A[3],B[3]);
    xor (P[2],A[2],B[2]);
    xor (P[1],A[1],B[1]);
    xor (P[0],A[0],B[0]);

    buf (C[0],Cin);

    and (W1,P[0],C[0]);
    or (C[1],G[0],W1);
    and (W2,P[1],C[1]);
    or (C[2],G[1],W2);
    and (W3,P[2],C[2]);
    or (C[3],G[2],W3);
    and (W4,P[3],C[3]);
    or (cadd,G[3],W4);

//s(i+1)
    and (X,kfromnextbit,cadd)
    xor (Y,P[4],cpred_gi)
    or (S[4],X,Y)

endmodule