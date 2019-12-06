`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab1
//////////////////////////////////////////////////////////////////////////////////
module implement_clocks(
    input [1:0] SW,
    input CLK100MHZ,
    output LED[15:0],
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
    );
    
    wire [7:0] CAs;
    assign CA=CAs[0];
    assign CB=CAs[1];
    assign CC=CAs[2];
    assign CD=CAs[3];
    assign CE=CAs[4];
    assign CF=CAs[5];
    assign CG=CAs[6];
    assign DP=CAs[7];
    
    wire[15:0] ctr;
    wire CLK1KHZ;
    
    create_1KHZ_clock(CLK100MHZ, CLK1KHZ);
    
    
    create_1_hz_counter(CLK100MHZ, ctr);
    
    
    write_17 w(CLK1KHZ, ctr[3:0], AN, CAs);
    
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
 
module digitCode(
    input[3:0] LED_BCD,
    output reg[7:0] LED_out
    //output reg[7:0] l
    );
    
    reg[7:0] l;
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
     case(LED_BCD)
     4'b0000: l = 8'b00000011; // "0"  
     4'b0001: l = 8'b10011111; // "1" 
     4'b0010: l = 8'b00100101; // "2" 
     4'b0011: l = 8'b00001101; // "3" 
     4'b0100: l = 8'b10011001; // "4" 
     4'b0101: l = 8'b01001001; // "5" 
     4'b0110: l = 8'b01000001; // "6" 
     4'b0111: l = 8'b00011111; // "7" 
     4'b1000: l = 8'b00000001; // "8"  
     4'b1001: l = 8'b00001001; // "9" 
     default: l = 8'b00000011; // "0"
     endcase
     
    LED_out[7] <= l[0];
    LED_out[6] <= l[1];
    LED_out[5] <= l[2];
    LED_out[4] <= l[3];
    LED_out[3] <= l[4];
    LED_out[2] <= l[5];
    LED_out[1] <= l[6];
    LED_out[0] <= l[7];
        
    end
    

endmodule
 
module write_17(input CLK,
    input wire[3:0] digit1,
    output reg [7:0] outAN,
    output reg [7:0] outCAs);
    
    reg[3:0] ctr = 0;
    wire[7:0] t8, t7, t6, t5, t4, t3, t2, t1;
    digitCode(digit1, t1);
    
    always @(posedge CLK) begin
        if(ctr==4'b0000) begin    
            // digit 8
            
            outAN <= 8'b1011_1111;
            outCAs <= t7;
            //outCAs <= 8'b0000_0001; // number 1, B,C
        
        end else if(ctr==4'b0001) begin
            //6
            outAN <= 8'b1101_1111;  // 1's place
            outCAs <= t6; // number 7, A,B,C
        
        end else if(ctr==4'b0010) begin
            //7
            outAN <= 8'b1110_1111;  // 1's place
            outCAs <= t5; // number 7, A,B,C
        
        end else if(ctr==4'b0011) begin
            //5
            outAN <= 8'b1111_0111;  // 1's place
            outCAs <= t4; // number 7, A,B,C
        
        end else if(ctr==4'b0100) begin
            //3
            outAN <= 8'b1111_1011;  // 1's place
            outCAs <= t3; // number 7, A,B,C
        
        end else if(ctr==4'b0101) begin
            //0
            outAN <= 8'b1111_1101;  // 1's place
            outCAs <= t2; // number 7, A,B,C
        
        end else if(ctr==4'b0110) begin
            //9
            outAN <= 8'b1111_1110;  // 1's place
            outCAs <= t1; // number 7, A,B,C
        
        end else begin
            outAN <= 8'b0111_1111;
            outCAs <= t8;
           
        end 
        
        // update the counter
        if(ctr==4'b1000) begin
            ctr <= 4'b0000;
        end else begin
            ctr <= ctr + 1;        
        end   
    end
    
endmodule

module create_1KHZ_clock(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK1KHZ
    );
    
    // 100MHZ is 10ns cycles.  If I want 1KHZ output, I need to count 100M/1K = 1e5 cycles = 100_000 cycles
    // 2^17 = 131_072
    reg[63:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr==49_999) begin
            outgoing_CLK1KHZ <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==99_999) begin
            outgoing_CLK1KHZ <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end         
    end
endmodule

module get_base10_digits(
    input CLK, 
    input [7:0] in_num, 
    output d100, 
    output d10,
    output d1);
    
    reg [3:0] d1,d10,d100;
    
    always @(*) begin
            d100 <= in_num/100;
            d10 <= (in_num%100)/10;
            d1 <= (in_num%10);          
    end
    
    
endmodule