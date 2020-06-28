module Adder(x1, x2, y);
  input [31:0] x1, x2;

  output [31:0] y;

  assign y = x1 + x2;

endmodule
