`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module tryAfter(
    input [7:0] swt,
    output [7:0] led
    );
    
    wire [4:0] c_in;
    wire [3:0] out;
    
    fullAdder bit0(swt[0], swt[4], 0, c_in[0], out[0]);
    fullAdder bit1(swt[1], swt[5], c_in[0], c_in[1], out[1]);
    fullAdder bit2(swt[2], swt[6], c_in[1], c_in[2], out[2]);
    fullAdder bit3(swt[3], swt[7], c_in[2], c_in[3], out[3]);
    
    
    
//    assign led[0] = out[0];
//    assign led[1] = out[1];
//    assign led[2] = out[2];
//    assign led[3] = out[3];
//    assign led[4] = c_in[3];
    
    //led[8] = c_in[4];
    
endmodule

module digitDisp(
    input [4:0] x
    );
    
    
    
endmodule

module fullAdder(
    input A,
    input B,
    input c_in,
    output c_out,
    output sum
    );
    
    wire C = c_in;
    
    assign c_out =  A & (B | C) | (B & C);
    assign sum = (~A & ~B & C) | (~A&B&~C) | (A&B&C) | (A&~B&~C);
    
    
endmodule