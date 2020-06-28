module aluControl (func, aluc, shfsrc, jar, jr);
  input [5:0] func;
  output [4:0] aluc;
  output shfsrc;
  output jar, jr;

  reg [4:0] aluc;
  reg shfsrc, jar, jr;

  always @ (func) begin
    case (func)
      6'b100001: aluc = 5'b00000; //addu
      6'b100011: aluc = 5'b00001; //subu
      6'b101010: aluc = 5'b00010; //slt
      6'b100100: aluc = 5'b00011; //and
      6'b100111: aluc = 5'b00100; //nor
      6'b100101: aluc = 5'b00101; //or
      6'b100110: aluc = 5'b00110; //xor
      6'b000000: aluc = 5'b00111; //sll
      6'b101011: aluc = 5'b01000; //sltu
      6'b001001: aluc = 5'b10111; //jalr
      6'b001000: aluc = 5'b10111; //jr
      6'b000100: aluc = 5'b00111; //sllv
      6'b000011: aluc = 5'b10101; //sra
      6'b000111: aluc = 5'b10101; //srav
      6'b000110: aluc = 5'b01010; //srlv
      6'b000010: aluc = 5'b01010; //srl
      default: aluc = 5'b11111;
    endcase
  end

  always @ (func) begin
    case (func)
      6'b000000: shfsrc = 1; //sll
      6'b000010: shfsrc = 1; //srl
      6'b000011: shfsrc = 1; //sra
      default: shfsrc = 0;
    endcase
  end

  always @ ( * ) begin
    case (func)
      6'b001001: jar = 1;
      default: jar = 0;
    endcase
  end

  always @ ( * ) begin
    case (func)
      6'b001001: jr = 1;
      6'b001000: jr = 1;
      default: jr = 0;
    endcase
  end

endmodule // aluControl
