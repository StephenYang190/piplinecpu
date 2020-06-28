module mux2_5(a, b, s, y);
input s;
input [4:0] a, b;
output[4:0] y;

assign y = (s==0) ? a : b;
endmodule
