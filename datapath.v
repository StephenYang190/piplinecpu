module datapath (clk, reset);
  input clk, reset;

  wire [31:0] toIU;
  wire [31:0] tomux5_0;
  wire [31:0] topc;
  wire [31:0] regpc;

  wire [31:0] pcNewtoIF, instoIF;

  wire ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID, BtoID, MentoRegtoID,
  RegWrtoID, jrtoID, jartoID, JtoID, shfsrctoID;
  wire [4:0] rs, rt, rd, ALUOptoID, shfttoID;
  wire [15:0] immtoID;
  wire [31:0] pcNewtoID, busAtoID, busBtoID;
  wire [25:0] targettoID;
  wire [31:0] instoID;
  wire [31:0] correctPC;
  wire [31:0] Bpcout, Jpcout;

  wire ExtoptoEX, ALUSrctoEX, RegDsttoEX, MenWrtoEX, BtoEX, MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX;
  wire zerotoEX, shfsrctoEX, loadad;
  wire [4:0] shfttoEX, ALUOptoEX, rwtoEX;
  wire [15:0] immtoEX;
  wire [31:0] pcNewtoEX, busAtoEX, busBtoEX, ALUouttoEX, JpctoEX, BpctoEX;
  wire [25:0] targettoEX;
  wire [31:0] instoEX;
  wire [4:0] rstoEX, rttoEX, rdtoEX;

  wire MenWrtoMe, BtoMe, MentoRegtoMe, RegWrtoMe, jrtoMe, jartoMe, JtoMe;
  wire zerotoMe;
  wire mux1selet, jumpSuccess;
  wire [4:0] rwtoMe, rstoMe, rttoMe;
  wire [31:0] pcNewtoMe, ALUouttoMe, busBtoMe, MenouttoMen, JpctoMe, BpctoMe;
  wire [31:0] instoMe, busAtoMe;
  wire [31:0] tomem;

  wire MentoRegtoRe, RegWrtoRe, jartoRe, JtoRe;
  wire [4:0] rwtoRe;
  wire [31:0] busW, ALUout, pcNewtoRe, MenouttoRe, tomux4_0;

//to deal with initial without value
  reg mux1selectI, mux5selectI, I1;

  initial begin
    mux1selectI = 0;
    mux5selectI = 0;
    I1 = 0;

    #605 begin
      mux1selectI = 1;
      mux5selectI = 1;
      I1 = 1;
    end

  end

  pc PC(clk, reset, topc, toIU, regpc, jrtoMe, I1&loadad, correctPC, jumpSuccess);

  IUnit iunit(toIU, pcNewtoIF, instoIF);

  IFID ifidRegister(pcNewtoIF, instoIF, ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID, BtoID, MentoRegtoID,
    RegWrtoID, jrtoID, jartoID, JtoID, rs, rt, rd, ALUOptoID, shfsrctoID, shfttoID,
    immtoID, pcNewtoID, busAtoID, busBtoID, targettoID, jumpSuccess, instoID, clk, I1&loadad);

  registers rgi(RegWrtoRe, rwtoRe, rs, rt, busW, busAtoID, busBtoID, clk);

  JumpPc jump(pcNewtoID, immtoID, targettoID, Bpcout, Jpcout);
  predict pre(BpctoMe, pcNewtoMe, BtoMe, zerotoMe, BtoID, jumpSuccess, mux1select, correctPC);


  IDEX idex(ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID,
    BtoID, MentoRegtoID, RegWrtoID, jrtoID, jartoID, JtoID,
    ALUOptoID, shfsrctoID, shfttoID, immtoID,
    pcNewtoID, busAtoID, busBtoID,
    ExtoptoEX, ALUSrctoEX, RegDsttoEX, MenWrtoEX, BtoEX,
    MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX,
    shfsrctoEX, shfttoEX, ALUOptoEX, immtoEX,
    pcNewtoEX, busAtoEX, busBtoEX, clk, targettoID, targettoEX,
    jumpSuccess, instoID, instoEX, rs, rt, rd, rstoEX, rttoEX, rdtoEX, I1&loadad);

  ExecUnit execu(ExtoptoEX, ALUSrctoEX, shfsrctoEX, shfttoEX, ALUOptoEX, immtoEX,
    pcNewtoEX, busAtoEX, busBtoEX, ALUouttoEX, JpctoEX, BpctoEX, zerotoEX, targettoEX,
    rstoEX, rttoEX, rwtoMe, rwtoRe, ALUouttoMe, busW,
    RegWrtoMe, MentoRegtoMe, RegWrtoRe, loadad);

  ExMem exmen(MenWrtoEX, BtoEX, MentoRegtoEX, RegWrtoEX, jrtoEX, jartoEX, JtoEX,
    zerotoEX, rwtoEX, pcNewtoEX, busBtoEX, ALUouttoEX, JpctoEX, BpctoEX,
    MenWrtoMe, BtoMe, MentoRegtoMe, RegWrtoMe, jrtoMe, jartoMe, JtoMe,
    zerotoMe, rwtoMe, ALUouttoMe, busBtoMe, JpctoMe, BpctoMe, clk,
    instoEX, instoMe, pcNewtoMe, jumpSuccess, busAtoEX, busAtoMe,
    rstoEX, rstoMe, rttoEX, rttoMe, I1&loadad);

  DM dm(MenWrtoMe, ALUouttoMe, tomem, MenouttoMen, instoMe[31:26], clk);

  MemWr memwr1(MentoRegtoMe, RegWrtoMe, jartoMe, JtoMe, rwtoMe, pcNewtoMe,
    ALUouttoMe, MentoRegtoRe, RegWrtoRe, jartoRe, JtoRe, rwtoRe, pcNewtoRe,
    ALUout, clk, MenouttoMen, MenouttoRe);

  //assign mux1selet = BtoMe & zerotoMe;
  //assign jumpSuccess = mux1selet | JtoMe | jrtoMe;

  mux2_32 mux1(pcNewtoIF, Bpcout, mux1selet&mux1selectI, tomux5_0);
  mux2_5 mux2(rttoEX, rdtoEX, RegDsttoEX, rwtoEX);
  mux2_32 mux3(ALUout, MenouttoRe, MentoRegtoRe, tomux4_0);
  mux2_32 mux4(tomux4_0, pcNewtoRe, jartoRe|JtoRe, busW);
  mux2_32 mux5(tomux5_0, Jpcout, JtoID&mux5selectI, topc);

  //for register jump
  mux2_32 mux6(busAtoMe, busW, RegWrtoRe&(rwtoRe == rstoMe), regpc);

  //for memrory wirte
  mux2_32 mux7(busBtoMe, busW, RegWrtoRe&(rwtoRe == rttoMe), tomem);


endmodule // datapath
