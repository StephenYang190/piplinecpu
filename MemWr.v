module MemWr (MentoRegtoMe, RegWrtoMe, jartoMe, JtoMe, rwtoMe, pcNewtoMe,
  ALUouttoMe, MentoRegtoRe, RegWrtoRe, jartoRe, JtoRe, rwtoRe, pcNewtoRe,
  ALUout, clk, MenouttoMen, MenouttoRe);

  input MentoRegtoMe, RegWrtoMe, jartoMe, JtoMe;
  input [4:0] rwtoMe;
  input [31:0] pcNewtoMe, ALUouttoMe, MenouttoMen;
  input clk;

  output MentoRegtoRe, RegWrtoRe, jartoRe, JtoRe;
  output [4:0] rwtoRe;
  output [31:0] pcNewtoRe, ALUout, MenouttoRe;

  reg MentoRegtoRe, RegWrtoRe, jartoRe, JtoRe;
  reg [4:0] rwtoRe;
  reg [31:0] pcNewtoRe, ALUout, MenouttoRe;

  always @ (negedge clk) begin

    MentoRegtoRe <= MentoRegtoMe;
    RegWrtoRe <= RegWrtoMe;
    pcNewtoRe <= pcNewtoMe;
    jartoRe <= jartoMe;
    rwtoRe <= rwtoMe;
    ALUout <= ALUouttoMe;
    JtoRe <= JtoMe;

    MenouttoRe <= MenouttoMen;
  end


endmodule // MenWr
