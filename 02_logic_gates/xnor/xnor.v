module xnor_gate (
    input A,B,
    output Y
);
    assign Y = ~(A^B);
endmodule

module tb_xnor_gate;

    reg A,B;
    wire Y;

    xnor_gate uut (.A(A),.B(B),.Y(Y));

    integer i;

    initial begin

        $dumpfile("xnor.vcd");
        $dumpvars(0, tb_xnor_gate);

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