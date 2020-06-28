module IM(addr, out);
  input [31:0] addr;

  output [31:0] out;

  reg [31:0] im[1023:0];

  initial begin
    $readmemh("F:/code_personal/computer/mars/code.txt", im);
  end

  assign out = im[addr[11:2]];

endmodule
