module Ext(Extop, x, y);

  input Extop;
  input [15:0] x;
  output [31:0] y;

  reg [31:0] y;
  parameter ZERO = 32'b0, ONE = 32'hffff0000;

  always @(Extop or x)
  begin
    if (Extop == 0)
      y = ZERO + x;
    else
      if (x[15] == 0)
        y = ZERO + x;
      else
        y = ONE + x;
  end

endmodule
