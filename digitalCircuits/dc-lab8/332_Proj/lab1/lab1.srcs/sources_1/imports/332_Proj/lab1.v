`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module implement_clocks(
    input [1:0] swt,
    input CLK100MHZ,
    output led[5:0]
    );
    
    wire CLK1MHZ;
    
    assign led[1] = CLK1MHZ;
    assign led[0] = 1;
    
    create_1_MHZ_clock(CLK100MHZ, CLK1MHZ);
    
endmodule
module create_1_MHZ_clock(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK1MHZ
    );
    
    reg [7:0] ctr;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr == 49) begin
            outgoing_CLK1MHZ <= 1'b0;
        end else if (ctr==99) begin
            outgoing_CLK1MHZ <= 1'b1;
        end else begin
            ctr <= 8'b0000_0000;
        end
        ctr <= ctr + 1;
    end
    
endmodule