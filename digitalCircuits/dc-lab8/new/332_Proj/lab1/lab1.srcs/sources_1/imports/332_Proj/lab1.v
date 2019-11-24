`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module implement_clocks(
    input [1:0] SW,
    input CLK100MHZ,
    output LED[15:0]
    );
    
    wire CLK1MHZ;
    wire CLK10KHZ;
    wire CLK100HZ;
    wire CLK1HZ;
    
    assign LED[0] = CLK1MHZ;
    
    create_1_HUNDR_clk(CLK100MHZ, CLK1MHZ);
    create_1_HUNDR_clk(CLK1MHZ, CLK10KHZ);
    create_1_HUNDR_clk(CLK10KHZ, CLK100HZ);
    //create_1_HUNDR_clk(CLK100HZ, CLK1HZ);
    
    create_1_hz_clk(CLK100MHZ, CLK1HZ);
    
    assign LED[1] = CLK100MHZ;
    assign LED[2] = CLK1MHZ;
    assign LED[3] = CLK10KHZ;
    assign LED[4] = CLK100HZ;
    assign LED[5] = CLK1HZ;
    
endmodule
module create_1_HUNDR_clk(
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

module create_1_hz_clk(
    input incoming_CLK,
    output reg outgoing_CLK
);
    reg [26:0] ctr;
    
    always @ (posedge incoming_CLK) begin
        if (ctr==100000000) begin
            outgoing_CLK <= ~outgoing_CLK;
            ctr = 27'b0;
        end
        ctr <= ctr + 1;
    end
endmodule