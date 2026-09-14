module xor_gate (
    input A,B,
    output Y
);
    assign Y = A^B;
endmodule

// Testbench

module tb_xor;

    reg A,B;
    wire Y;

    xor_gate uut (.A(A),.B(B),.Y(Y));

    integer i;

    initial begin

        $dumpfile("xor.vcd");
        $dumpvars(0, tb_xor);

        $display("Time\tA B |Y ");
        $display("=================");
        //testing with a loop 
        for (i =0 ;i<4 ;i = i+1 ) begin
            {A,B} = i;
            #10;
            $display("%0t\t%b %b | %b", $time, A, B, Y);            
            
        end

        $finish;

    end


    
endmodule


/* Output 

panda@Panda:~/Verilog/02_logic_gates/xor$ vvp xor.out
VCD info: dumpfile xor.vcd opened for output.
Time    A B |Y 
=================
10      0 0 | 0
20      0 1 | 1
30      1 0 | 1
40      1 1 | 0
xor.v:34: $finish called at 40 (1s)

*/