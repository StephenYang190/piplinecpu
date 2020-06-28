module ExecUnit (ExtoptoEX, ALUSrctoEX, shfsrctoEX, shfttoEX, ALUOptoEX, immtoEX,
  pcNewtoEX, busAtoEX, busBtoEX, ALUout, Jpc, Bpc, zero, target,
  rstoEX, rttoEX, rwtoMe, rwtoRe, ALUouttoMe, busW,
  RegWrtoMe, MentoRegtoMe, RegWrtoRe, loadad);

  input ExtoptoEX, ALUSrctoEX, shfsrctoEX;
  input [4:0] shfttoEX, ALUOptoEX;
  input [15:0] immtoEX;
  input [31:0] pcNewtoEX, busAtoEX, busBtoEX;
  input [25:0] target;

//to deal with the adventure
  input [4:0] rstoEX, rttoEX, rwtoMe, rwtoRe;
  input [31:0] ALUouttoMe, busW;
  input RegWrtoMe, MentoRegtoMe, RegWrtoRe; 

  output [31:0] ALUout, Jpc, Bpc;
  output zero, loadad;

  wire [31:0] tomux2_1, aluin, aluin1;
  wire [31:0] noTran, noTran1;
  wire o;

//to deal with the adventure
  wire [31:0] mux4out, mux6out;

//to deal with initial without value
  reg I1, I2, I3, I4;

  initial begin
    I1 <= 0;
    I2 <= 0;
    I3 <= 0;
    I4 <= 0; 

    #600 begin
      I3 <= 1;
      I4 <= 1;
    end

    #200 begin
      I1 <= 1;
      I2 <= 1;
    end
  end

  Adder add(pcNewtoEX - 4, {{14{immtoEX[15]}}, immtoEX, 2'b0}, Bpc);

  assign Jpc = {pcNewtoEX[31:28], target, 2'b00};

  Ext ext(ExtoptoEX, immtoEX, tomux2_1);

  mux2_32 mux1(busAtoEX, {27'b0, shfttoEX}, shfsrctoEX, noTran);
  mux2_32 mux2(busBtoEX, tomux2_1, ALUSrctoEX, noTran1);

//to deal with the adventure  
  mux2_32 mux4(noTran, ALUouttoMe, I3&(shfsrctoEX == 0)&RegWrtoMe&(rstoEX==rwtoMe), mux4out);
  mux2_32 mux5(mux4out, busW, I1&(shfsrctoEX == 0)&RegWrtoRe&(rstoEX==rwtoRe), aluin);
  
  mux2_32 mux6(noTran1, ALUouttoMe, I4&(ALUSrctoEX == 0)&RegWrtoMe&(rttoEX==rwtoMe), mux6out);
  mux2_32 mux7(mux6out, busW, I2&(ALUSrctoEX == 0)&RegWrtoRe&(rttoEX==rwtoRe), aluin1);

  assign loadad = (shfsrctoEX == 0)&RegWrtoMe&(rstoEX==rwtoMe)&MentoRegtoMe |
                  (ALUSrctoEX == 0)&RegWrtoMe&(rttoEX==rwtoMe)&MentoRegtoMe;

  ALU alu(aluin, aluin1, ALUout, zero, o, ALUOptoEX);

endmodule // ExecUnit
