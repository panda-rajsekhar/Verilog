module mux_2to1 (
    input  wire a,
    input  wire b,
    input  wire sel,
    output wire y
);

    assign y = (a & ~sel) | (b & sel);
    
endmodule


`timescale 1ns/1ps

module mux2to1_tb;

    // Inputs
    reg a;
    reg b;
    reg sel;

    // Output
    wire y;

    // Instantiate the DUT  ← fixed name
    mux_2to1 dut (
        .a   (a),
        .b   (b),
        .sel (sel),
        .y   (y)
    );

    integer i;

    initial begin
        
        $dumpfile("2to1mux.vcd");
        $dumpvars(0, mux2to1_tb);
        $display("Time\t sel a b | y");
        $display("-------------------");
        $monitor("%0t\t  %b  %b %b | %b", $time, sel, a, b, y);

        // Exhaustive test using a loop (all 8 combinations)
        for (i = 0; i < 8; i = i + 1) begin
            {sel, a, b} = i;
            #10;
        end

        $display("-------------------");
        $display("Test completed.");
        $finish;
    end

endmodule