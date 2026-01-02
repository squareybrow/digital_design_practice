module comlog (
    input  a,
    b,
    c,
    output y
);

  assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule

module gates (
    input  [2:0] a,
    b,
    output [4:0] y1,
    y2,
    y3,
    y4,
    y5,
    y6
);

  assign y1 = a & b;
  assign y2 = a | b;
  assign y3 = a ^ b;
  assign y4 = ~y1;
  assign y5 = ~y2;
  assign y6 = ~y3;
endmodule

module and8 (
    input [7:0] a,
    output y
);
  assign y = &a;
  // instead of:
  //assign y = a[7] & a[6] & a[5] & a[4] & a[3] & a[2] & a[1] & a[0];
endmodule

module mux2 (
    input [3:0] d0,
    d1,
    input s,
    output [3:0] y
);
  assign y = s ? d1 : d0;
endmodule

module fulladder (
    input  a,
    b,
    cin,
    output s,
    cout
);
  wire p, g;

  assign p = a ^ b;
  assign g = a & b;
  assign s = p ^ cin;
  assign cout = g | (p & cin);
endmodule

module tristate (
    input [3:0] a,
    input en,
    output [3:0] y
);
  assign y = en ? a : 4'bz;
endmodule

module example (
    input  a,
    b,
    c,
    output y
);

  wire ab, bb, cb, n1, n2, n3;

  assign #1{ab, bb, cb} = ~{a, b, c};
  assign #2 n1 = ab & bb & cb;
  assign #2 n2 = a & bb & cb;
  assign #4 y = n1 | n2 | n3;
endmodule

module mux4 (
    input  [3:0] d0,
    d1,
    d2,
    d3,
    input  [1:0] s,
    output [3:0] y
);
  wire [3:0] low, high;

  mux2 lowmux (
      d0,
      d1,
      s[0],
      low
  );
  mux2 highmux (
      d2,
      d3,
      s[0],
      high
  );
  mux2 finalmux (
      low,
      high,
      s[1],
      y
  );
endmodule

module mux2_8 (
    input [7:0] d0,
    d1,
    input s,
    output [7:0] y
);

  mux2 lsbmux (
      d0[3:0],
      d1[3:0],
      s,
      y[3:0]
  );
  mux2 msbmux (
      d0[7:4],
      d1[7:4],
      s,
      y[7:4]
  );
endmodule

module flop (
    input clk,
    input [3:0] d,
    output reg [3:0] q
);
  always @(posedge clk) q <= d;
endmodule

module floprasync (
    input [3:0] d,
    input clk,
    reset,
    output reg [3:0] q
);

  always @(posedge clk, posedge reset)
    if (reset) begin
      q <= 4'b0;
    end else begin
      q <= d;
    end
endmodule

module floprsync (
    input [3:0] d,
    input clk,
    reset,
    output reg [3:0] q
);

  always @(posedge clk)
    if (reset) begin
      q <= 4'b0;
    end else begin
      q <= d;
    end
endmodule

module flopren (
    input [3:0] d,
    input en,
    reset,
    clk,
    output reg [3:0] q
);

  always @(posedge clk, posedge reset)
    if (reset) begin
      q <= 4'b0;
    end else if (en) begin
      q <= d;
    end
endmodule

module sync (
    input [3:0] d,
    input clk,
    en,
    reset,
    output reg [3:0] q
);

  reg [3:0] n1;

  always @(posedge clk) begin
    if (reset) begin
      n1 <= 4'b0;
      q  <= 4'b0;
    end else if (en) begin
      n1 <= d;
      q  <= n1;
    end
  end
endmodule

module latch (
    input clk,
    input [3:0] d,
    output reg [3:0] q
);
  always @(clk, d) if (clk) q <= d;
endmodule

module fulladderb (
    input [3:0] a,
    b,
    cin,
    output reg [3:0] s,
    cout
);

  reg [3:0] p, g;

  always @(*) begin
    p = a ^ b;
    g = a & b;

    s = p ^ cin;
    cout = g | (p & cin);
  end
endmodule

module sevenseg (
    input [3:0] data,
    output reg [6:0] segments
);

  always @(*)
    case (data)
      //               abc_defg
      0: segments = 7'b111_1110;
      1: segments = 7'b011_0000;
      2: segments = 7'b110_1101;
      3: segments = 7'b111_1001;
      4: segments = 7'b011_0011;
      5: segments = 7'b101_1011;
      6: segments = 7'b101_1111;
      7: segments = 7'b111_0000;
      8: segments = 7'b111_1111;
      9: segments = 7'b111_1011;
      default: segments = 7'b000_0000;
    endcase
endmodule

module decoder3_8 (
    input [2:0] in,
    output reg [7:0] out
);

  always @(*)
    case (in)
      3'b000: out = 8'b0000_0001;
      3'b001: out = 8'b0000_0010;
      3'b010: out = 8'b0000_0100;
      3'b011: out = 8'b0000_1000;
      3'b100: out = 8'b0001_0000;
      3'b101: out = 8'b0010_0000;
      3'b110: out = 8'b0100_0000;
      3'b111: out = 8'b1000_0000;
    endcase
endmodule

module decoder3_8_cl (
    input  [2:0] in,
    output [7:0] out
);

  assign out[0] = ~in[2] & ~in[1] & ~in[0];
  assign out[1] = ~in[2] & ~in[1] & in[0];
  assign out[2] = ~in[2] & in[1] & ~in[0];
  assign out[3] = ~in[2] & in[1] & in[0];
  assign out[4] = in[2] & ~in[1] & ~in[0];
  assign out[5] = in[2] & ~in[1] & in[0];
  assign out[6] = in[2] & in[1] & ~in[0];
  assign out[7] = in[2] & in[1] & in[0];
endmodule

module priority_encoder (
    input [3:0] in,
    output reg [1:0] out
);

  always @(*) begin
    casez (in)
      4'b0001: out = 4'b0001;
      4'b001?: out = 4'b0010;
      4'b01??: out = 4'b0100;
      4'b1???: out = 4'b1000;
      default: out = 4'b0000;
    endcase
  end
endmodule

module priority_en (
    input [3:0] a,
    output reg [3:0] y
);
  always @(*)
    if (a[3]) y = 4'b1000;
    else if (a[2]) y = 4'b0100;
    else if (a[1]) y = 4'b0010;
    else if (a[0]) y = 4'b0001;
    else y = 4'b0000;
endmodule

module sequenceMealy (
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

  always @(*)
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

module sequenceMoore (
    input  in,
    clk,
    reset,
    output out
);
  reg [2:0] state, next_state;
  parameter S0 = 3'b000;
  parameter S1 = 3'b001;
  parameter S2 = 3'b010;
  parameter S3 = 3'b011;
  parameter S4 = 3'b100;

  always @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else state <= next_state;

  always @(*)
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
      else next_state = S4;
      S4:
      if (in) next_state = S2;
      else next_state = S1;
      default: next_state = S0;
    endcase
  assign out = (state == S4);
endmodule

module testbench1 ();
  reg a, b, c;
  wire y;

  comlog dut (
      a,
      b,
      c,
      y
  );

  initial begin
    a = 0;
    b = 0;
    c = 0;
    #10;
    c = 1;
    #10;
    b = 1;
    c = 0;
    #10;
    c = 1;
    #10;
    a = 1;
    b = 0;
    c = 0;
    #10;
    c = 1;
    #10;
    b = 1;
    c = 0;
    #10;
    c = 1;
    #10;
  end
endmodule

module testbench2 ();
  reg a, b, c;
  wire y;

  comlog dut (
      a,
      b,
      c,
      y
  );

  initial begin
    a = 0;
    b = 0;
    c = 0;
    #10;
    if (y !== 1) $display("000 failed.");
    c = 1;
    #10;
    if (y !== 0) $display("001 failed.");
    b = 1;
    c = 0;
    #10;
    if (y !== 0) $display("010 failed.");
    c = 1;
    #10;
    if (y !== 0) $display("011 failed.");
    a = 1;
    b = 0;
    c = 0;
    #10;
    if (y !== 1) $display("100 failed.");
    c = 1;
    #10;
    if (y !== 1) $display("101 failed.");
    b = 1;
    c = 0;
    #10;
    if (y !== 0) $display("110 failed.");
    c = 1;
    #10;
    if (y !== 0) $display("111 failed.");
  end
endmodule
