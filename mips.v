module mips();
  reg clk;
  reg reset;

  initial begin
    clk = 0;
    reset = 1;
    #200 reset = 0;
  end

  always #100 clk = ~clk;

  datapath cpu(clk, reset);

endmodule
