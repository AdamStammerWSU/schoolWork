`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////


module lab1(
    input [7:0] swt,
     output [7:0] led
    );
    
    wire A1 = swt[6];
    wire A0 = swt[5];
    wire B1 = swt[1];
    wire B0 = swt[0];
    
    assign led[2] = (swt[6] & ~ swt[1])
                    | (swt[6] & swt[5] & ~swt[0])
                    | (swt[0] & ~swt[1] & ~swt[0]);
    assign led[1] = (~A0 & ~A1 & ~B0 & ~B1) 
                    | (A0 & ~A1 & B0 & ~B1) 
                    | (~A0 & A1 & ~B0 & B1) 
                    | (A0 & A1 & B0 & B1);
    assign led[0] = (~A1 & B1) 
                    | (B1 & B0 & ~A0) 
                    | (B0 & ~A1 & ~A0);
    
endmodule
