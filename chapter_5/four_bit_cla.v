module four_bit_cla (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
);
  wire [3:0] G, P;
  wire [3:0] C;

  assign G = A & B;
  assign P = A ^ B;

  assign C[0] = Cin;
  assign C[1] = G[0] | (P[0] & C[0]);
  assign C[2] = G[1] | (P[1] & C[1]);
  assign C[3] = G[2] | (P[2] & C[2]);
  assign Cout = G[3] | (P[3] & C[3]);

  assign S[0] = P[0] ^ C[0];
  assign S[1] = P[1] ^ C[1];
  assign S[2] = P[2] ^ C[2];
  assign S[3] = P[3] ^ C[3];

endmodule
