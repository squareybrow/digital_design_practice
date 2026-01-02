module alu #(
    parameter N = 8
) (
    input [N-1 : 0] a, b,
    input [2:0] f,
    output reg [N-1 : 0] y,
    output reg eq,
    neq,
    lt,
    lte,
    gt,
    gte
);

  always_comb begin

    y   = {N{1'b0}};
    eq  = 1'b0;
    neq = 1'b0;
    lt  = 1'b0;
    lte = 1'b0;
    gt  = 1'b0;
    gte = 1'b0;

    case (f)
      3'b000:  y = a & b;
      3'b001:  y = a | b;
      3'b010:  y = a + b;
      3'b100:  y = a & ~b;
      3'b101:  y = a | ~b;
      3'b110:  y = a - b;
      3'b111: begin
        eq  = (a == b);
        neq = (a != b);
        lt  = (a < b);
        lte = (a <= b);
        gt  = (a > b);
        gte = (a >= b);
      end
      default: y = {N{1'b0}};
    endcase
  end
endmodule
