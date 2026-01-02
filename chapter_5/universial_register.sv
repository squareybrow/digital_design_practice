module universial_register #(
    parameter int N = 8
) (
    input logic [N-1:0] D,
    input logic [1:0] mode,
    input logic clk, reset, Sin_left, Sin_right,
    output logic [N-1:0] Q,
    output logic Sout
);

  always_ff @(posedge clk, posedge reset) begin
    if (reset) Q <= 0;
    else begin
      case (mode)
        2'b00: Q <= Q;
        2'b01: Q <= {Q[N-2:0], Sin_left};
        2'b10: Q <= {Sin_right, Q[N-1:1]};
        2'b11: Q <= D;
        default: Q <= Q;
      endcase
    end
  end

  assign Sout = (mode == 2'b01) ? Q[N-1] : ((mode == 2'b10) ? Q[0] : 1'b0);
endmodule
