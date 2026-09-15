// ============================================================
// 2048-to-1 Multiplexer
//   - 2048 single-bit data inputs (data_in[2047:0])
//   - 11-bit select line (2^11 = 2048)
//   - 1-bit output
// ============================================================
module mux2048to1 (
    input  wire [2047:0] data_in,   // 2048 data inputs, 1 bit each
    input  wire [10:0]   sel,       // select line, log2(2048) = 11 bits
    output wire          dout       // selected output bit
);

    // Simple bit-select implementation.
    // data_in[sel] picks out the single bit addressed by sel.
    assign dout = data_in[sel];

endmodule


`timescale 1ns / 1ps
// ============================================================
// Testbench for mux2048to1
//   - Drives a randomized 2048-bit data vector
//   - Sweeps the select line through every value 0..2047
//   - Checks dout against the expected bit each time
//   - Also runs a few random (data, sel) trials for extra coverage
// ============================================================
module mux2048to1_tb;

    reg  [2047:0] data_in;
    reg  [10:0]   sel;
    wire          dout;

    integer i;
    integer errors;
    reg     expected;

    // Instantiate the DUT (device under test)
    mux2048to1 DUT (
        .data_in (data_in),
        .sel     (sel),
        .dout    (dout)
    );

    initial begin
        // Waveform dump for viewing in GTKWave, if desired
        $dumpfile("mux2048to1_tb.vcd");
        $dumpvars(0, mux2048to1_tb);

        errors = 0;

        // ---- Randomize the full 2048-bit data vector ----
        for (i = 0; i < 64; i = i + 1) begin
            // Fill 32 bits at a time (2048 / 32 = 64 chunks)
            data_in[i*32 +: 32] = $random;
        end

        $display("=================================================");
        $display(" Starting exhaustive select sweep (0 to 2047)");
        $display("=================================================");

        // ---- Exhaustive sweep over every select value ----
        for (i = 0; i < 2048; i = i + 1) begin
            sel = i[10:0];
            #5; // allow combinational logic to settle
            expected = data_in[i];
            if (dout !== expected) begin
                errors = errors + 1;
                $display("MISMATCH at sel=%0d: dout=%b expected=%b",
                          i, dout, expected);
            end
        end

        $display("Exhaustive sweep complete. Errors so far: %0d", errors);

        // ---- A few extra random (data, sel) trials ----
        $display("=================================================");
        $display(" Running randomized trials");
        $display("=================================================");
        for (i = 0; i < 20; i = i + 1) begin
            data_in[i*32 +: 32] = $random; // re-randomize a chunk
            data_in[(63-i)*32 +: 32] = $random;
            sel = $random % 2048;
            #5;
            expected = data_in[sel];
            if (dout !== expected) begin
                errors = errors + 1;
                $display("RANDOM TRIAL MISMATCH at sel=%0d: dout=%b expected=%b",
                          sel, dout, expected);
            end else begin
                $display("Trial %0d OK: sel=%0d dout=%b", i, sel, dout);
            end
        end

        $display("=================================================");
        if (errors == 0)
            $display(" ALL TESTS PASSED (2048-to-1 mux verified)");
        else
            $display(" TESTS FAILED: %0d mismatches found", errors);
        $display("=================================================");

        $finish;
    end

endmodule