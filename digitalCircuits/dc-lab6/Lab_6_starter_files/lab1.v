`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
// this is the file we used in Lab 4.  Lab 6 can be built in a similar way.  
//
//////////////////////////////////////////////////////////////////////////////////


module lab1(
    input [7:0] swt,
     output [7:0] led
    );
    
    assign led[0] = ~swt[0];
    assign led[1] = swt[1] & ~swt[2];
    assign led[3] = swt[2] & swt[3];
    assign led[2] = led[1] | led[3];
    
    assign led[7:4] = swt[7:4];
    
endmodule
