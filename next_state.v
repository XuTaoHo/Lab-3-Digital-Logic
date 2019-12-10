module next_state(
    input clock,
    input reset,
    input [9:0] SW,
    input [1:0] KEY,
    output reg [1:0] current_state
);

always @ (posedge clock or negedge reset) begin
    if (reset == 0) begin
        current_state = 0; // reset sets next state to idle state, state 0
    end

    else if (reset == 1) begin
        if (KEY[0] == 1) begin
            current_state = 2'b11; // sets next state to hazard state, state 3
        end

        else if ((KEY[0] == 0) && (SW[1] == 1)) begin // hazard off and turn enable on, state 1 or 2
            if (KEY[1] == 0) begin
                current_state = 2'b01; // left turn signal, state 1
            end

            else if (KEY[1] == 1) begin
                current_state = 2'b10; // right turn signal, state 2
            end
        end

        else if ((KEY[0] == 0) && (SW[1] == 0)) begin // hazard off and turn enable off
            current_state = 0; // idle state, state 0
        end
    end
end
endmodule