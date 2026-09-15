module mux_4to1 (
    input wire a,//I0
    input wire b,//I1
    input wire c,//I2
    input wire d,//I3
    input wire S0,//S0 select line 
    input wire S1,// S1 select line 
    output wire y
);

assign y = (~S1 & ~S0 & a) |
           (~S1 &  S0 & b) |
           ( S1 & ~S0 & c) |
           ( S1 &  S0 & d);
    
endmodule

`timescale 1ps/1ps

module mux_4to1_tb;

    // Inputs
    reg a;
    reg b;
    reg c;
    reg d;
    reg S0;
    reg S1;

    // Output
    wire y;

    // Instantiate the DUT  ← fixed name
    mux_4to1 dut (
        .a   (a),
        .b   (b),
        .c   (c),
        .d   (d),
        .S0 (S0),
        .S1 (S1),
        .y   (y)
    );

    integer i;

    initial begin
        
        $dumpfile("4to1mux.vcd");
        $dumpvars(0, mux_4to1_tb);
        $display("Time\t S1 S0 a b c d | y");
        $display("-------------------");
        $monitor("%0t\t  %b  %b %b %b %b %b | %b", $time, S1 ,S0 , a, b, c, d, y);

        // Exhaustive test using a loop (all 8 combinations)
        for (i = 0; i < 64; i = i + 1) begin
            {S1,S0,a,b,c,d} = i;
            #10;
        end

        $display("-------------------");
        $display("Test completed.");
        $finish;
    end

endmodule




/* 

Output
panda@Panda:~/Verilog/03_combinational_circuits/mux/4to1mux$ vvp 4to1mux.out
VCD info: dumpfile 4to1mux.vcd opened for output.
Time     S1 S0 a b c d | y
-------------------
0         0  0 0 0 0 0 | 0
10        0  0 0 0 0 1 | 0
20        0  0 0 0 1 0 | 0
30        0  0 0 0 1 1 | 0
40        0  0 0 1 0 0 | 0
50        0  0 0 1 0 1 | 0
60        0  0 0 1 1 0 | 0
70        0  0 0 1 1 1 | 0
80        0  0 1 0 0 0 | 1
90        0  0 1 0 0 1 | 1
100       0  0 1 0 1 0 | 1
110       0  0 1 0 1 1 | 1
120       0  0 1 1 0 0 | 1
130       0  0 1 1 0 1 | 1
140       0  0 1 1 1 0 | 1
150       0  0 1 1 1 1 | 1
160       0  1 0 0 0 0 | 0
170       0  1 0 0 0 1 | 0
180       0  1 0 0 1 0 | 0
190       0  1 0 0 1 1 | 0
200       0  1 0 1 0 0 | 1
210       0  1 0 1 0 1 | 1
220       0  1 0 1 1 0 | 1
230       0  1 0 1 1 1 | 1
240       0  1 1 0 0 0 | 0
250       0  1 1 0 0 1 | 0
260       0  1 1 0 1 0 | 0
270       0  1 1 0 1 1 | 0
280       0  1 1 1 0 0 | 1
290       0  1 1 1 0 1 | 1
300       0  1 1 1 1 0 | 1
310       0  1 1 1 1 1 | 1
320       1  0 0 0 0 0 | 0
330       1  0 0 0 0 1 | 0
340       1  0 0 0 1 0 | 1
350       1  0 0 0 1 1 | 1
360       1  0 0 1 0 0 | 0
370       1  0 0 1 0 1 | 0
380       1  0 0 1 1 0 | 1
390       1  0 0 1 1 1 | 1
400       1  0 1 0 0 0 | 0
410       1  0 1 0 0 1 | 0
420       1  0 1 0 1 0 | 1
430       1  0 1 0 1 1 | 1
440       1  0 1 1 0 0 | 0
450       1  0 1 1 0 1 | 0
460       1  0 1 1 1 0 | 1
470       1  0 1 1 1 1 | 1
480       1  1 0 0 0 0 | 0
490       1  1 0 0 0 1 | 1
500       1  1 0 0 1 0 | 0
510       1  1 0 0 1 1 | 1
520       1  1 0 1 0 0 | 0
530       1  1 0 1 0 1 | 1
540       1  1 0 1 1 0 | 0
550       1  1 0 1 1 1 | 1
560       1  1 1 0 0 0 | 0
570       1  1 1 0 0 1 | 1
580       1  1 1 0 1 0 | 0
590       1  1 1 0 1 1 | 1
600       1  1 1 1 0 0 | 0
610       1  1 1 1 0 1 | 1
620       1  1 1 1 1 0 | 0
630       1  1 1 1 1 1 | 1
-------------------
Test completed.
4to1mux.v:62: $finish called at 640 (1ps)

*/ 

