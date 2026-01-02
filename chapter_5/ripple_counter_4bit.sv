module t_ff (
    input logic clk, reset,
    input logic t,
    output logic q
);

always_ff @(posedge clk, posedge reset) begin
    if (reset)  q <= 1'b0;
    else if (t) q <= ~q;
    else    q <= q;
end
endmodule

module ripple_counter_4bit(
    input logic clk, reset,
    output logic [3:0] Q
);

t_ff bit0 (.clk(clk), .reset(reset), .t(1'b1), .q(Q[0]));
t_ff bit1 (.clk(~Q[0]), .reset(reset), .t(1'b1), .q(Q[1]));
t_ff bit2 (.clk(~Q[1]), .reset(reset), .t(1'b1), .q(Q[2]));
t_ff bit3 (.clk(~Q[2]), .reset(reset), .t(1'b1), .q(Q[3]));

endmodule
