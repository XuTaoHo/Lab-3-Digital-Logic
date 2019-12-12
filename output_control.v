module output_control (
    input [1:0] current_state,
    input clock,
    input reset,
    input [1:0] KEY,
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
            LEDR[2:0] = 0;
        end

        else begin
            LEDR[2:0] = led_assignment[2:0];
            LEDR[9:7] = 0;
        end
    end

    else begin
        LEDR = 0;
    end
end

reg left_right;

always @ (current_state) begin
    if (current_state == 2'b10) begin
        left_right = 0;
    end

    else if (current_state == 2'b01) begin
        left_right = 1;
    end
end

sevenseg currentstate (
    .value({4'b0, current_state}),
    .display(HEX0)
);

turn_lights control (
    .clock(clock),
    .left_right(left_right),
    .reset_n(reset),
    .KEY1(KEY[1]),
    .enable(light_enable),
    .lights_out(led_assignment_left),
    .lights_out_right(led_assignment_right)
);

hazard_lights hazard_control(
    .clock(clock), 
    .enable(hazard_enable),
    .reset(reset),
    .hazard_out(hazard_assignment)
);

endmodule