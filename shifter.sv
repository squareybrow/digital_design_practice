module shifter (
    input  logic [7:0] in,
    input  logic [3:0] shamt,
    input  logic [1:0] shtype,
    output logic [7:0] out
);

  wire [7:0] logical_shift_r, arithmatic_shift_r, shift_l;

  assign shift_l = in << shamt;
  assign logical_shift_r = in >> shamt;
  assign arithmatic_shift_r = $signed(in) >>> shamt;

  always_comb begin
    case (shtype)
      2'b00:   out = shift_l;
      2'b01:   out = logical_shift_r;
      2'b10:   out = arithmatic_shift_r;
      default: out = 8'b0;
    endcase
  end
endmodule
