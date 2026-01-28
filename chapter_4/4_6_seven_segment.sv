module hex_to_seven_segment (
    input  logic [3:0] num,
    output logic [6:0] seven_seg
);
  always_comb begin
    case (num)
      4'h0: seven_seg = 7'b0000001;
      4'h1: seven_seg = 7'b1001111;
      4'h2: seven_seg = 7'b0010010;
      4'h3: seven_seg = 7'b0000110;
      4'h4: seven_seg = 7'b1001100;
      4'h5: seven_seg = 7'b0100100;
      4'h6: seven_seg = 7'b0100000;
      4'h7: seven_seg = 7'b0001111;
      4'h8: seven_seg = 7'b0000000;
      4'h9: seven_seg = 7'b0000100;
      4'hA: seven_seg = 7'b0001000;
      4'hB: seven_seg = 7'b1100000;
      4'hC: seven_seg = 7'b0110001;
      4'hD: seven_seg = 7'b1000010;
      4'hE: seven_seg = 7'b0110000;
      4'hF: seven_seg = 7'b0111000;
      default: seven_seg = 7'b1111111;
    endcase
  end
endmodule


module hex_to_seven_seg_testbench;
  logic [6:0] seven_seg;
  logic [3:0] num;
  hex_to_seven_segment DUT (
      .num(num),
      .seven_seg(seven_seg)
  );

  initial begin
    $monitor($time, "num = %h, seven_seg = %b", num, seven_seg);
    num = 4'h0;
    #5 num = 4'h1;
    #5 num = 4'h2;
    #5 num = 4'h3;
    #5 num = 4'h4;
    #5 num = 4'h5;
    #5 num = 4'h6;
    #5 num = 4'h7;
    #5 num = 4'h8;
    #5 num = 4'h9;
    #5 num = 4'hA;
    #5 num = 4'hB;
    #5 num = 4'hC;
    #5 num = 4'hD;
    #5 num = 4'hE;
    #5 num = 4'hF;
    #5 $finish;
  end
endmodule
