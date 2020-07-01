module JumpPc (pcNewtoID, immtoID, targettoID, Bpcout, Jpcout);
  input [31:0] pcNewtoID;
  input [15:0] immtoID;
  input [25:0] targettoID;

  output [31:0] Bpcout, Jpcout;

  Adder add(pcNewtoID - 4, {{14{immtoID[15]}}, immtoID, 2'b0}, Bpcout);

  assign Jpcout = {pcNewtoID[31:28], targettoID, 2'b00};


endmodule // JumpPc
