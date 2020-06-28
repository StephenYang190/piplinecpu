module mux2_32(a, b, s, y);
input s;
input [31:0] a, b;
output[31:0] y;

assign y = (s==0) ? a : b;
endmodule
