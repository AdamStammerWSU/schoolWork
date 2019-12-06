`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module implement_clocks(
    input [1:0] SW,
    input CLK100MHZ,
    output LED[15:0]
    );
    
    wire[15:0] ctr;
    
    create_1_hz_counter(CLK100MHZ, ctr);
    assign LED[0] = ctr[0] | SW[0];
    assign LED[1] = ctr[1];
    assign LED[2] = ctr[2];
    assign LED[3] = ctr[3];
    assign LED[4] = ctr[4];
    assign LED[5] = ctr[5];
    assign LED[6] = ctr[6];
    assign LED[7] = ctr[7];
    assign LED[8] = ctr[8];
    assign LED[9] = ctr[9];
    assign LED[10] = ctr[10];
    assign LED[11] = ctr[11];
    assign LED[12] = ctr[12];
    assign LED[13] = ctr[13];
    assign LED[14] = ctr[14];
    assign LED[15] = ctr[15];
    
endmodule

module create_1_hz_counter(
    input incoming_CLK,
    output reg[15:0] outgoing_CLK
    );
    reg [63:0] ctr;
    
    always @ (posedge incoming_CLK) begin
        ctr <= ctr + 1;
        
        if(ctr == 99999999) begin
            outgoing_CLK <= outgoing_CLK+1;
            ctr <= 0;
        end
    end
 endmodule