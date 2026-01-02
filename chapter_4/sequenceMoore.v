module sequenceMoore(input in, clk, reset,
                    output out);
    reg [2:0] state, next_state;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    always @ (posedge clk, posedge reset)
        if (reset) state <= S0;
        else state <= next_state;
    
    always @ (*)
            case(state)
                S0: if (in) next_state = S0;
                    else next_state = S1;
                S1: if (in) next_state = S2;
                    else next_state = S1;
                S2: if (in) next_state = S3;
                    else next_state = S1;
                S3: if (in) next_state = S0;
                    else next_state = S4;
                S4: if (in) next_state = S2;
                    else next_state = S1;
                default: next_state = S0;
            endcase
    assign out = (state == S4);
endmodule