module ram #(
    parameter int ADDR_WIDTH = 6,
    parameter int DATA_WIDTH = 32
) (
    input logic clk,
    input logic write_en,
    input logic [N-1:0] adr,
    input logic [M-1:0] din,
    output logic [M-1:0] dout
);

  logic [DATA_WIDTH-1:0] mem[2**ADDR_WIDTH];

  always_ff @(posedge clk) begin
    if (write_en) begin
      mem[adr] <= din;
    end
  end

  assign dout = mem[adr];
endmodule
