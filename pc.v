module pc (clk, reset, topc, toIU, busAtoMe, jr, loadad, correctPC, jumpSuccess);
  input clk, reset;
  input [31:0] topc;
  input [31:0] busAtoMe;
  input jr;
  input loadad;
  input jumpSuccess;
  input [31:0] correctPC;

  output [31:0] toIU;

  reg [31:0] pc;

  always @ (negedge clk or reset) begin
    if (reset == 1)
      pc = 32'h0000_3000;
    else if (jr == 1 & loadad == 0)
      pc = busAtoMe;
    else if(loadad == 0)
      pc <= topc;
    else if(jumpSuccess == 1)
      pc <= correctPC;
  end

  assign toIU = pc;

endmodule // pc
