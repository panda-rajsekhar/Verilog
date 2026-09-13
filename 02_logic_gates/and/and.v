module and_gate (
    input A,B,
    output Y,W

);
   
   assign Y = A && B; // Logical 
   assign W = A & B; // Bitwise

endmodule


module tb_and_gate ;
      
    reg A,B;
    wire Y,W;

    and_gate uut (.A(A),.B(B),.Y(Y),.W(W));

    initial begin

        $dumpfile("and.vcd");
        $dumpvars(0, tb_and_gate);

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