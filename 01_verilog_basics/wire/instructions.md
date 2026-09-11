# how to run code 

```

panda@Panda:~/01_verilog_basics/wire$ iverilog -g2012 -o wire.out wire.v
panda@Panda:~/01_verilog_basics/wire$ vvp wire.out
VCD info: dumpfile wave.vcd opened for output.
wire.v:27: $finish called at 30 (1s)
panda@Panda:~/01_verilog_basics/wire$ gtkwave 'wave.vcd'

GTKWave Analyzer v3.3.116 (w)1999-2023 BSI

[0] start time.
[30] end time.
WM Destroy
panda@Panda:~/01_verilog_basics/wire$ 

```