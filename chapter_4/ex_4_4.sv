`timescale 1ns / 1ps

module ex_4_4 ();
  logic a, b, c, d;
  logic y;
  logic y_expected;
  logic [4:0] testvectors[15:0];
  logic clk;
  integer vectornum, errors;

  ex_4_3 dut (
      .a(a),
      .b(b),
      .c(c),
      .d(d),
      .y(y)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $display("Reading test vectors...");  // Added debug line
    $readmemb("test_vectors_4_4.txt", testvectors);
    $display("First vector: %b", testvectors[0]);  // Added debug line
    vectornum = 0;
    errors = 0;
  end

  always @(posedge clk) begin
    #1;
    if (vectornum < 16) begin
      {a, b, c, d, y_expected} = testvectors[vectornum];
      if (y !== y_expected) begin
        $display("Error: inputs = %b%b%b%b, expected y = %b, got y = %b", a, b, c, d, y_expected,
                 y);
        errors += 1;
      end
      vectornum += 1;
    end else begin
      $display("\n=== Test Complete ===");
      $display("Total vectors: %0d", vectornum);
      $display("Errors found: %0d", errors);

      if (errors === 0) $display("TEST PASSED!");
      else $display("TEST FAILED!");
      $finish;
    end
  end

  initial begin
    $display("Starting testbench for ex_4_3");
    $display("Time\ta b c d | y_expected y | Status");
    $display("----------------------------------------");
  end

  always @(posedge clk) begin
    if (vectornum < 16) begin
      #2;
      $display("%0t\t%b %b %b %b | %b %b | %s", $time, a, b, c, d, y_expected, y,
               (y === y_expected) ? "PASS" : "FAIL");
    end
  end
endmodule
