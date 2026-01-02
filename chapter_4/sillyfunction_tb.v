// filepath: /home/rishav/src/Hardware/verilog/sillyfunction_tb.v
`timescale 1ns/1ps

module sillyfunction_tb;
    reg a, b, c;
    wire y;

    sillyfunction uut (
        .a(a),
        .b(b),
        .c(c),
        .y(y)
    );

    initial begin
        a = 0; b = 0; c = 0;
        #10 a = 1;
        #10 b = 1;
        #10 c = 1;
        #10 $finish;
    end
endmodule