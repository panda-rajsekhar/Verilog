module or_gate (
    input A,B,
    output Y,W
);
    assign Y = A||B;//logical
    assign W = A|B; //bitwise
endmodule


module tb_or_gate;

     reg A,B;
     wire Y,W;

     or_gate uut (.A(A),.B(B),.Y(Y),.W(W));

        initial begin

            $dumpfile("or.vcd");
            $dumpvars(0, tb_or_gate);

            // Test 1
            A = 0; B = 0;
            #10;

            // Test 2
            A = 0; B = 1;
            #10;

            // Test 3
            A = 1; B = 0;
            #10;

            // Test 4
            A = 1; B = 1;
            #10;

            $finish;

        end


    
endmodule

