module IUnit (toIU, pcNewtoIF, instoIF);
  input [31:0] toIU;
  output [31:0] pcNewtoIF, instoIF;

  Adder add(toIU, 4, pcNewtoIF);

  IM im(toIU, instoIF);

endmodule // IUnit
