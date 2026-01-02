module statemc (
    input  in,
    clk,
    reset,
    output out
);
  reg [1:0] state, next_state;
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  always @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else state <= next_state;

  always_comb
    case (state)
      S0:
      if (in) next_state = S0;
      else next_state = S1;
      S1:
      if (in) next_state = S2;
      else next_state = S1;
      S2:
      if (in) next_state = S3;
      else next_state = S1;
      S3:
      if (in) next_state = S0;
      else next_state = S1;
      default: next_state = S0;
    endcase
  assign out = (state == S3) & (in == 0);
endmodule
