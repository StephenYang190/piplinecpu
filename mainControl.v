module mainControl(op, select, B, J, RegDst, RegWr, MenWr, MentoReg, ALUSrc, Extop, ALUop, r);

  input [5:0] op;
  input [4:0] select;

  output B, J, RegDst, RegWr, MenWr, MentoReg, ALUSrc, Extop, r;
  output [4:0] ALUop;

  reg [4:0] ALUop;

  assign Extop = (!op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&!op[2]&&op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&!op[2]&&op[1]&&!op[0])||
  (op[5]&&!op[4]&&!op[3]&&!op[1]&&!op[0])||
  (op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&!op[0])||
  (op[5]&&!op[4]&&!op[2]&&op[1]&&op[0]);

  assign MenWr = (op[5]&&!op[4]&&op[3]&&!op[2]&&op[1]&&op[0])||
  (op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&!op[0]);

  assign RegWr =(!op[5]&&!op[4]&&!op[3]&&!op[2]&&!op[1]&&!op[0])||
  (!op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&op[0])||
  (op[5]&&!op[4]&&!op[3]&&!op[2]&&op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&!op[2]&&op[1])||
  (op[5]&&!op[4]&&!op[3]&&!op[1]&&!op[0])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&!op[1])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&op[1]&&!op[0])||
  (!op[5]&&!op[4]&&!op[3]&&!op[2]&&op[1]&&op[0]);

  assign MentoReg = (op[5]&&!op[4]&&!op[3]&&!op[2]&&op[1]&&op[0])||
  (op[5]&&!op[4]&&!op[3]&&!op[1]&&!op[0]);

  assign B=(!op[5]&&!op[4]&&!op[3]&&op[2])||
  (!op[5]&&!op[4]&&!op[3]&&!op[2]&&!op[1]&&op[0]);

  assign J=!op[5]&&!op[4]&&!op[3]&&!op[2]&&op[1];

  assign RegDst=(op==6'b000000)?1'b1:1'b0;

  assign ALUSrc=(!op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&op[0])||
  (op[5]&&!op[4]&&!op[2]&&op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&op[1]&&op[0])||
  (!op[5]&&!op[4]&&op[3]&&!op[2]&&op[1])||
  (op[5]&&!op[4]&&!op[3]&&!op[1]&&!op[0])||
  (op[5]&&!op[4]&&op[3]&&!op[2]&&!op[1]&&!op[0])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&!op[1])||
  (!op[5]&&!op[4]&&op[3]&&op[2]&&op[1]&&!op[0]);

  assign r=(op==6'b000000)?1'b1:1'b0;

  always @ (op) begin
    case (op)
    6'b000000 : ALUop = 5'b11111; //R type
    6'b001001 : ALUop = 5'b00000;	//ADDIU
    6'b000100 : ALUop = 5'b00001;	//BEQ
    6'b000101 : ALUop = 5'b10110;	//BNE
    6'b100011 : ALUop = 5'b00000;	//LW
    6'b101011 : ALUop = 5'b00000;	//SW
    6'b001111 :	ALUop = 5'b10100; //LUI
    6'b000010 :	ALUop = 5'b11111; //J
    6'b001010 :	ALUop = 5'b00010; //SLTI
    6'b001011 :	ALUop = 5'b01000; //SLTIU
    6'b000001 :	ALUop = (select == 1)?5'b10000:5'b10011; //BGEZ|BLTZ
    6'b000111 :	ALUop = 5'b10001; //BGTZ
    6'b000110 :	ALUop = 5'b10010; //BLEZ
    6'b100000 :	ALUop = 5'b00000; //LB
    6'b100100 :	ALUop = 5'b00000; //LBU
    6'b101000 :	ALUop = 5'b00000; //SB
    6'b001100 :	ALUop = 5'b00011; //ANDI
    6'b001101 :	ALUop = 5'b00101; //ORI
    6'b001110 :	ALUop = 5'b00110; //XORI
    6'b000011 :	ALUop = 5'b11111; //JALR
    default: ALUop = 5'b11111;
    endcase
  end


endmodule
