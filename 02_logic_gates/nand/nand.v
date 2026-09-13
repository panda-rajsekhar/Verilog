module nand_gate (
    input A,B,
    output Y,W

);
   
   assign Y = ~(A && B); // Logical 
   assign W = ~(A & B); // Bitwise

endmodule


module tb_nand_gate ;
      
    reg A,B;
    wire Y,W;

    nand_gate uut (.A(A),.B(B),.Y(Y),.W(W));

    integer i;

    initial begin

        $dumpfile("nand.vcd");
        $dumpvars(0, tb_nand_gate);

        $display("Time\tA B |Y W");
        $display("______________");
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

Output:

panda@Panda:~/Verilog/02_logic_gates/nand$ vvp nand.out
VCD info: dumpfile nand.vcd opened for output.
Time    A B |Y W
______________
10      0 0 | 1 1
20      0 1 | 1 1
30      1 0 | 1 1
40      1 1 | 0 0
nand.v:37: $finish called at 40 (1s)


*/ 

