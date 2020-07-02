module ExMem (MenWrtoEX, BtoEX, MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX,
  zerotoEX, rwtoEX, pcNewtoEX, busBtoEX, ALUouttoEX, JpctoEX, BpctoEX,
  MenWrtoMe, BtoMe, MentoRegtoMe, RegWrtoMe, jrtoMe, jartoMe, JtoMe,
  zerotoMe, rwtoMe, ALUout, busBtoMe, JpctoMe, BpctoMe, clk,
  instoEX, instoMe, pcNewtoMe, jumpSuccess, busAtoEX, busAtoMe,
  rstoEX, rstoMe, rttoEX, rttoMe, loadad, Jr_jump);

  input MenWrtoEX, BtoEX, MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX,
    zerotoEX;
  input [4:0] rwtoEX, rstoEX, rttoEX;
  input [31:0] pcNewtoEX, busBtoEX, ALUouttoEX, JpctoEX, BpctoEX;
  input jumpSuccess;
  input [31:0] busAtoEX;
  input loadad;
  input Jr_jump;

  output MenWrtoMe, BtoMe, MentoRegtoMe, RegWrtoMe, jrtoMe, jartoMe, JtoMe,
    zerotoMe;
  output [4:0] rwtoMe, rstoMe, rttoMe;
  output [31:0] pcNewtoMe, busBtoMe, ALUout, JpctoMe, BpctoMe;
  output [31:0] busAtoMe;

  input clk;

  input [31:0] instoEX;
  output [31:0] instoMe;

  reg MenWrtoMe, BtoMe, MentoRegtoMe, RegWrtoMe, jrtoMe, jartoMe, JtoMe,
    zerotoMe;
  reg [4:0] rwtoMe, rstoMe, rttoMe;
  reg [31:0] pcNewtoMe, busBtoMe, ALUout, JpctoMe, BpctoMe;
  reg [31:0] instoMe, busAtoMe;

  always @ (negedge clk) begin
    if (jumpSuccess == 1 | loadad == 1 | Jr_jump == 1) begin

      MentoRegtoMe <= 0;
      MenWrtoMe <= 0;
      RegWrtoMe <= 0;
      pcNewtoMe <= 0;
      busBtoMe <= 0;
      zerotoMe <= 0;
      jartoMe <= 0;
      JpctoMe <= 0;
      BpctoMe <= 0;
      jrtoMe <= 0;
      rwtoMe <= 0;
      ALUout <= 0;
      JtoMe <= 0;
      BtoMe <= 0;
      instoMe <= 0;
      busAtoMe <= 0;
      rstoMe <= 0;
      rttoMe <= 0;

    end
    else begin

      MentoRegtoMe <= MentoRegtoEX;
      MenWrtoMe <= MenWrtoEX;
      RegWrtoMe <= RegWrtoEX;
      pcNewtoMe <= pcNewtoEX;
      busBtoMe <= busBtoEX;
      zerotoMe <= zerotoEX;
      jartoMe <= jartoEX;
      JpctoMe <= JpctoEX;
      BpctoMe <= BpctoEX;
      jrtoMe <= jrtoEX;
      rwtoMe <= rwtoEX;
      ALUout <= ALUouttoEX;
      JtoMe <= JtoEX;
      BtoMe <= BtoEX;
      instoMe <= instoEX;
      busAtoMe <= busAtoEX;
      rstoMe <= rstoEX;
      rttoMe <= rttoEX;

    end

  end

endmodule // ExMem
