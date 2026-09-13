module not_gate (
    input A,
    output Y
);

assign Y = ~A;
    
endmodule


// Testbench

module tb_not_gate ;
    reg A;
    wire Y;
    not_gate uut( .A(A),.Y(Y) );


// here uut means unit under test 
// .A refers to port A inside not gate , A is signal A in testbench 

     initial begin
        $dumpfile("not.vcd");
        $dumpvars(0,tb_not_gate);
        A = 0;#10;
        A = 1;#10;
        A = 0;#10;
        A = 0;#10;
        A = 1;#10;
        A = 1;#10;
        A = 0;#10;

        $finish;
     end    
endmodule