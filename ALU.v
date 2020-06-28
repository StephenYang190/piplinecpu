module ALU(A, B, y, zero, ovflow, aluctr);
input[31:0] A, B;
input [4:0] aluctr;

output[31:0] y;
output zero, ovflow;

reg[31:0] y;
reg ovflow;

wire signed [31:0] sign_a, sign_b;

assign sign_a = A;
assign sign_b = B;

always@ (*) begin

  case(aluctr)
  5'b00000 : {ovflow, y} = A + B; //addu
  5'b00001 : y = A - B; //subu
  5'b00010 : y = (sign_a < sign_b)?1:0; //sign compare
  5'b00011 : y = A & B; //and
  5'b00100 : y = ~(A | B); //not or
  5'b00101 : y = A | B; //or
  5'b00110 : y = A ^ B; //xor
  5'b00111 : y = B << A; //sll
  5'b01000 : y = (A < B)?1:0; //sltiu
  5'b01001 : y = sign_b >>> A; //sra
  5'b01010 : y = B >> A; //srlv
  5'b10000 : y = (sign_a >= 0)?0:1; //BGEZ
  5'b10001 : y = (sign_a > 0)?0:1; //BGTZ
  5'b10010 : y = (sign_a <= 0)?0:1; //BLEZ
  5'b10011 : y = (sign_a < 0)?0:1; //BLTZ
  5'b10100 : y = B << 16; //lui
  5'b10101 : y = sign_b >>> A; //srav
  5'b10110 : y = (A != B)?0:1;//bne
  5'b10111 : y = A + 32'h0000_3000;//jr, jar
  default : y = 32'b0;
  endcase

end

assign zero = (y == 0)?1 : 0;

endmodule
