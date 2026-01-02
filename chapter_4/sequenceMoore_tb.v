module sequenceMoore_tb;
    reg clk;
    reg reset;
    reg in;
    wire out;

    // Instantiate the Unit Under Test (UUT)
    sequenceMoore uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1;
        in = 0;
        #10;
        reset = 0;

        // Sequence: 1 0 1 1 0 1 1 0 1 1 1
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;
        in = 1; #10;

        #10;
        $finish;
    end
endmodule