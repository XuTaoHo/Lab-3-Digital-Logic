module turn_lights(
    input clock,
    input left_right,
    input reset_n,
    input enable,
    input current_state,
    output reg [2:0] lights_out_left,
    output reg [2:0] lights_out_right
);

reg [2:0] lights;

always @ (posedge clock or negedge reset_n or posedge current_state) begin
    if (reset_n == 0) begin
        lights = 3'b0;
        lights_out = 3'b0;
    end

    else if (current_state == 0) begin
        lights = 0;
        lights_out = 0;
    end

    else if (enable == 0) begin
        lights = 3'b0;
        lights_out = 3'b0;
    end

    else if ((reset_n == 1) && (enable == 1) && (KEY1 == 1)) begin
        if (lights == 3'b111) begin // all on, return to none on
            lights = 3'b0;
        end

        else if (lights == 3'b011) begin // two on, go to three on
            lights = 3'b111;
        end

        else if (lights == 3'b001) begin // one on, go to two on
            lights = 3'b011;
        end

        else if (lights == 3'b0) begin // none on, go to one on
            lights = 3'b001;
        end

        if (left_right == 1'b1) begin // left lights
            lights_out_left = lights;
            lights_out_right = 0;
        end

        else if (left_right == 1'b0) begin // right lights, reverse the order of lights
            lights_out_right [2] = lights[0];
            lights_out_right [1] = lights[1];
            lights_out_right [0] = lights[2];
            lights_out_left = 0;
        end
    end
end
endmodule