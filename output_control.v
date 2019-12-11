module output_control (
    input [1:0] current_state,
    input clock,
    input reset,
    output reg [9:0] LEDR,
    output [7:0] HEX0
);

wire [2:0] led_assignment;
wire [5:0] hazard_assignment;

wire light_enable;
assign light_enable = current_state[1] ^ current_state[0];

wire hazard_enable;
assign hazard_enable = current_state[1] & current_state[0];

always @ (hazard_enable or light_enable or reset) begin
    if (reset == 0) begin
        LEDR = 0;
    end

    else if (hazard_enable) begin
        LEDR[9:7] = hazard_assignment[5:3];
        LEDR[2:0] = hazard_assignment[2:0];
    end

    else if (light_enable) begin
        if (left_right) begin
            LEDR[9:7] = led_assignment[2:0];
        end

        else begin
            LEDR[2:0] = led_assignment[2:0];
        end
    end

    else begin
        LEDR = 0;
    end
end

wire left_right;
assign left_right = current_state[0]; // 0 means state 2 (right), 1 means state 1 (left)

sevenseg currentstate (
    .value({4'b0, current_state}),
    .display(HEX0)
);

turn_lights control (
    .clock(clock),
    .left_right(left_right),
    .reset_n(reset),
    .enable(light_enable),
    .lights_out(led_assignment)
);

hazard_lights hazard_control(
    .clock(clock), 
    .enable(hazard_enable),
    .reset(reset),
    .hazard_out(hazard_assignment)
);

endmodule