module mux8to1 (
    input  wire [7:0] data_in,
    input  wire [2:0] sel,      // 3-bit select for 8-to-1 mux
    output wire       dout
);
    assign dout = data_in[sel];
endmodule


`timescale 1ps/1ps

module mux8to1_tb;

    // Testbench signals
    reg  [7:0] data_in;
    reg  [2:0] sel;
    wire       dout;

    integer i;   // loop variable

    // Instantiate the DUT
    mux8to1 uut (
        .data_in(data_in),
        .sel    (sel),
        .dout   (dout)
    );

    // Dumpfile and dumpvars for VCD
    initial begin
        $dumpfile("mux8to1.vcd");   // VCD file name
        $dumpvars(0, mux8to1_tb);   // Dump all signals in this module and below
    end

    // Stimulus with loop
    initial begin
        // Monitor signals
        $monitor("Time = %0t | data_in = %b | sel = %b | dout = %b",
                 $time, data_in, sel, dout);

        // First data pattern
        data_in = 8'b1010_1101;

        // Loop through all 8 select values
        for (i = 0; i < 8; i = i + 1) begin
            sel = i;
            #10;
        end

        // Second data pattern
        data_in = 8'b0101_0011;

        // Loop again
        for (i = 0; i < 8; i = i + 1) begin
            sel = i;
            #10;
        end

        $display("Simulation finished");
        $finish;
    end

endmodule