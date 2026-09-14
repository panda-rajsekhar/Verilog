module nor_gate (
    input A,B,
    output Y,W
);
    assign Y = ~(A|B);
    assign W = ~(A||B);
endmodule

module tb_nor_gate ;

    reg A,B;
    wire W,Y;

    nor_gate uut (.A(A),.B(B),.Y(Y),.W(W));

    integer i;

    initial begin

        $dumpfile("nor.vcd");
        $dumpvars(0, tb_nor_gate);

        $display("Time\tA B |Y W");
        $display("=================");
        //testing with a loop 
        for (i =0 ;i<4 ;i = i+1 ) begin
            {A,B} = i;
            #10;
            $display("%0t\t%b %b | %b %b", $time, A, B, Y, W);            
            
        end

        $finish;

    end

    
endmodule


/* 
Output

panda@Panda:~/Verilog/02_logic_gates/nor$ vvp nor.out
VCD info: dumpfile nor.vcd opened for output.
Time    A B |Y W
=================
10      0 0 | 1 1
20      0 1 | 0 0
30      1 0 | 0 0
40      1 1 | 0 0
nor.v:33: $finish called at 40 (1s)

*/ 
