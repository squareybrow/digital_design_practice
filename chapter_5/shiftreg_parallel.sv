module shiftreg_parallel #(
    localparam int N = 8
) (
    input clk,
    reset,
    load,
    Sin,
    input [N-1:0] D,
    output logic [N-1:0] Q,
    output logic Sout
);

  always_ff @(posedge clk, posedge reset) begin
    if (reset) Q <= 0;
    else if (load) Q <= D;
    else Q <= {Q[N-2:0], Sin};
  end

  assign Sout = Q[N-1];
endmodule
