module IDEX (ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID,
  BtoID, MentoRegtoID, RegWrtoID, jrtoID, jartoID, JtoID,
  ALUOptoID, shfsrctoID, shfttoID, immtoID,
  pcNewtoID, busAtoID, busBtoID,
  ExtoptoEX, ALUSrctoEX, RegDsttoEX, MenWrtoEX, BtoEX,
  MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX,
  shfsrctoEX, shfttoEX, ALUOptoEX, immtoEX,
  pcNewtoEX, busAtoEX, busBtoEX, clk, targettoID, targettoEX, jumpSuccess,
  instoID, instoEX, rs, rt, rd, rstoEX, rttoEX, rdtoEX, loadad);

  input ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID,
    BtoID, MentoRegtoID, RegWrtoID, jrtoID, jartoID, JtoID, shfsrctoID;
  input [4:0] ALUOptoID, shfttoID;
  input [15:0] immtoID;
  input [31:0] pcNewtoID, busAtoID, busBtoID;
  input clk;
  input [25:0] targettoID;
  input jumpSuccess;
  input [4:0] rs, rt, rd;
  input loadad;

  output ExtoptoEX, ALUSrctoEX, RegDsttoEX, MenWrtoEX, BtoEX,
    MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX, shfsrctoEX;
  output [4:0] shfttoEX, ALUOptoEX;
  output [15:0] immtoEX;
  output [31:0] pcNewtoEX, busAtoEX, busBtoEX;
  output [25:0] targettoEX;
  output [4:0] rstoEX, rttoEX, rdtoEX;

  input [31:0] instoID;
  output [31:0] instoEX;

  reg ExtoptoEX, ALUSrctoEX, RegDsttoEX, MenWrtoEX, BtoEX,
    MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX, shfsrctoEX;
  reg [4:0] shfttoEX, ALUOptoEX;
  reg [15:0] immtoEX;
  reg [31:0] pcNewtoEX, busAtoEX, busBtoEX;
  reg [25:0] targettoEX;
  reg [31:0] instoEX;
  reg [4:0] rstoEX, rttoEX, rdtoEX;

  always @ (negedge clk) begin
    if (jumpSuccess == 1) begin
      MentoRegtoEX <= 0;
      ALUSrctoEX <= 0;
      RegDsttoEX <= 0;
      ExtoptoEX <= 0;
      MenWrtoEX <= 0;
      RegWrtoEX <= 0;
      jartoEX <= 0;
      jrtoEX <= 0;
      BtoEX <= 0;
      JtoEX <= 0;

      shfsrctoEX <= 0;
      pcNewtoEX <= 0;
      ALUOptoEX <= 0;
      shfttoEX <= 0;
      busAtoEX <= 0;
      busBtoEX <= 0;
      immtoEX <= 0;

      targettoEX <= 0;

      instoEX <= 0;

      rstoEX <= 0;
      rttoEX <= 0;
      rdtoEX <= 0;
    end

    else if(loadad == 0)
    begin
      MentoRegtoEX <= MentoRegtoID;
      ALUSrctoEX <= ALUSrctoID;
      RegDsttoEX <= RegDsttoID;
      ExtoptoEX <= ExtoptoID;
      MenWrtoEX <= MenWrtoID;
      RegWrtoEX <= RegWrtoID;
      jartoEX <= jartoID;
      jrtoEX <= jrtoID;
      BtoEX <= BtoID;
      JtoEX <= JtoID;

      shfsrctoEX <= shfsrctoID;
      pcNewtoEX <= pcNewtoID;
      ALUOptoEX <= ALUOptoID;
      shfttoEX <= shfttoID;
      busAtoEX <= busAtoID;
      busBtoEX <= busBtoID;
      immtoEX <= immtoID;

      targettoEX <= targettoID;

      instoEX <= instoID;

      rttoEX <= rt;
      rstoEX <= rs;
      rdtoEX <= rd;
    end
  end

endmodule // IDEX
