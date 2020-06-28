module DM(wr, addr, Din, Dout, op, clk);
  input wr, clk;
  input [31:0] addr, Din;
  input [5:0] op;

  output [31:0] Dout;

  reg [31:0] dm[1023:0];
  reg [31:0] Dout;

  wire [1:0] bitepath;

  integer i;

  initial begin
    for (i=0; i < 1024; i=i+1) dm[i] = 0;
  end

  assign bitepath = addr[1:0];

  always @ (negedge clk) begin
    if (wr == 1)
      if (op == 6'b101000)
        case (bitepath)
          2'b00: dm[addr[11:2]][7:0] <= Din[7:0];
          2'b01: dm[addr[11:2]][15:8] <= Din[7:0];
          2'b10: dm[addr[11:2]][23:16] <= Din[7:0];
          2'b11: dm[addr[11:2]][31:24] <= Din[7:0];
          default: ;
        endcase
      else
        dm[addr[11:2]] <= Din;
  end

  always @ (addr) begin
    if (op == 6'b100000)

      case (bitepath)
        2'b00: Dout = {24'b0, dm[addr[11:2]][7:0]};
        2'b01: Dout = {24'b0, dm[addr[11:2]][15:8]};
        2'b10: Dout = {24'b0, dm[addr[11:2]][23:16]};
        2'b11: Dout = {24'b0, dm[addr[11:2]][31:24]};
      endcase

    else if (op == 6'b100100)
      if (dm[addr[11:2]][bitepath * 8 + 7] == 0)

        case (bitepath)
          2'b00: Dout = {24'b0, dm[addr[11:2]][7:0]};
          2'b01: Dout = {24'b0, dm[addr[11:2]][15:8]};
          2'b10: Dout = {24'b0, dm[addr[11:2]][23:16]};
          2'b11: Dout = {24'b0, dm[addr[11:2]][31:24]};
        endcase

      else

        case (bitepath)
          2'b00: Dout = {24'hfff_fff, dm[addr[11:2]][7:0]};
          2'b01: Dout = {24'hfff_fff, dm[addr[11:2]][15:8]};
          2'b10: Dout = {24'hfff_fff, dm[addr[11:2]][23:16]};
          2'b11: Dout = {24'hfff_fff, dm[addr[11:2]][31:24]};
        endcase

    else
      Dout = dm[addr[11:2]];
  end

endmodule
