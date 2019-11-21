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
    
    
    //digitDisplay d0(out, a3, b3, c3, d3, e3, f3, g3, a3);
    
    
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

module digitDisplay(
    input[3:0] LED_BCD,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output anode
);
    reg[6:0] LED_out;
// Cathode patterns of the 7-segment LED display 
always @(*)
begin
 case(LED_BCD)
 4'b0000: LED_out = 7'b0000001; // "0"  
 4'b0001: LED_out = 7'b1001111; // "1" 
 4'b0010: LED_out = 7'b0010010; // "2" 
 4'b0011: LED_out = 7'b0000110; // "3" 
 4'b0100: LED_out = 7'b1001100; // "4" 
 4'b0101: LED_out = 7'b0100100; // "5" 
 4'b0110: LED_out = 7'b0100000; // "6" 
 4'b0111: LED_out = 7'b0001111; // "7" 
 4'b1000: LED_out = 7'b0000000; // "8"  
 4'b1001: LED_out = 7'b0000100; // "9" 
 default: LED_out = 7'b0000001; // "0"
 endcase
end

assign a = LED_out[0];
assign b = LED_out[1];
assign c = LED_out[2];
assign d = LED_out[3];
assign e = LED_out[4];
assign f = LED_out[5];
assign g = LED_out[6];
assign anode = 1;

endmodule