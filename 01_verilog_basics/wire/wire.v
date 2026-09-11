// Design Under Test 

module single_wire (
    input logic a , output logic b
);

  assign b = a;

    
endmodule

// Testbench 

module tb_single_wire ;
     
     logic a,b;

     single_wire dut(.*);

     initial begin 
        $dumpfile("wave.vcd");
        $dumpvars(0,tb_single_wire);

        a = 0 ;#10;
        a = 1 ;#10;
        a = 0 ;#10;
        $finish;

     end    
endmodule


