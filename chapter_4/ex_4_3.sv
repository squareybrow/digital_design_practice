module ex_4_3 (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic y
);
  assign y = a ^ b ^ c ^ d;
endmodule
