`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module implement_clocks(
    input [1:0] SW,
    input CLK100MHZ,
    output LED[15:0]
    );
    
    wire CLK1_2;
    wire CLK1_2MS;
    
    create_1_2_hz_clk(CLK100MHZ, CLK1_2);
    create_1_2_ms_clk(CLK100MHZ, CLK1_2MS);
    assign LED[0] = CLK1_2 | SW[0];
    assign LED[1] = CLK1_2MS | SW[1];
    
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
    reg [25:0] ctr;
    
    always @ (posedge incoming_CLK) begin
        if (ctr==100000000) begin
            outgoing_CLK <= ~outgoing_CLK;
            ctr = 26'b0;
        end
        ctr <= ctr + 1;
    end
endmodule

module create_1_2_ms_clk(
    input incoming_CLK,
    output reg outgoing_CLK
    );
    reg [63:0] ctr;
    
    always @ (posedge incoming_CLK) begin
        ctr <= ctr +1;
        if(outgoing_CLK) begin
            if(ctr == 199999) begin
                outgoing_CLK <= 26'b0;
                ctr <= 0;
            end
        end else begin
            if(ctr == 99999) begin
                outgoing_CLK <= 26'b1;
                ctr <= 0;
            end
        end
    end
 endmodule

module create_1_2_hz_clk(
    input incoming_CLK,
    output reg outgoing_CLK
    );
    reg [63:0] ctr;
    
    always @ (posedge incoming_CLK) begin
        ctr <= ctr +1;
        if(outgoing_CLK) begin
            if(ctr == 99999999) begin
                outgoing_CLK <= 26'b0;
                ctr <= 0;
            end
        end else begin
            if(ctr == 49999999) begin
                outgoing_CLK <= 26'b1;
                ctr <= 0;
            end
        end
    end
 endmodule