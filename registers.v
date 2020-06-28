module registers(RegWr, Rw, Ra, Rb, busW, busA, busB, clk);
  input RegWr, clk;
  input [4:0] Rw, Ra, Rb;
  input [31:0] busW;

  output [31:0] busA, busB;

  reg [31:0] regi[31:0];
  wire [31:0] busA, busB;

  integer i;

  initial begin
    for (i=0; i < 32; i=i+1) regi[i] = 0;
  end

  always@(posedge clk)
  begin
    if (RegWr == 1)
      regi[Rw] <= busW;
  end

  assign busA = regi[Ra];
  assign busB = regi[Rb];

endmodule
