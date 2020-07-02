module IFID(pcNewtoIF, instoIF, ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID, BtoID, MentoRegtoID,
  RegWrtoID, jrtoID, jartoID, JtoID, rs, rt, rd, ALUOptoID, shfsrctoID, shfttoID,
  immtoID, pcNewtoID, busAtoID, busBtoID, targettoID, jumpSuccess, instoID, clk,
  loadad, B_J_jump, Jr_jump);

  input [31:0] pcNewtoIF, instoIF;
  input clk;
  input jumpSuccess;
  input loadad;
  input B_J_jump, Jr_jump;

  output ExtoptoID, ALUSrctoID, RegDsttoID, MenWrtoID, BtoID, MentoRegtoID,
  RegWrtoID, jrtoID, jartoID, JtoID, shfsrctoID;
  output [4:0] rs, rt, rd, ALUOptoID, shfttoID;
  output [15:0] immtoID;
  output [31:0] pcNewtoID, busAtoID, busBtoID;
  output [25:0] targettoID;
  output [31:0] instoID;

  reg shfsrctoID, jrtoID;

  wire r, jr, shfsrc;
  wire [5:0] fun, op;
  wire [4:0] select;
  wire [4:0] aluop_m, aluop_a;

  reg [31:0] pc, ins;

  always @ (negedge clk) begin
    if (jumpSuccess == 1 | B_J_jump == 1 | Jr_jump == 1) begin
      pc <= 32'b0;
      ins <= {6'b111111, 26'b0};
    end
    else if (loadad == 0)
    begin
      pc <= pcNewtoIF;
      ins <= instoIF;
    end
  end

  aluControl aluc(fun, aluop_a, shfsrc, jartoID, jr);
  mainControl main(op, select, BtoID, JtoID, RegDsttoID, RegWrtoID, MenWrtoID,
    MentoRegtoID, ALUSrctoID, ExtoptoID, aluop_m, r);

  mux2_5 mux1(aluop_m, aluop_a, r, ALUOptoID);

  assign rs = ins[25:21];
  assign rt = (ins[31:26] == 6'b000011)?5'b11111:ins[20:16];
  assign rd = ins[15:11];
  assign immtoID = ins[15:0];
  assign shfttoID = ins[10:6];
  assign op = ins[31:26];
  assign fun = ins[5:0];
  assign select = ins[20:16];
  assign pcNewtoID = pc;
  assign targettoID = ins[25:0];
  assign instoID = ins;

  always @ ( * ) begin
    if (r == 1) begin
      shfsrctoID = shfsrc;
      jrtoID = jr;
    end
    else begin
      shfsrctoID = 0;
      jrtoID = 0;
    end
  end

endmodule
