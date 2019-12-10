module turn_lights(
    input clock,
    input left_right,
    input reset_n,
    input enable,
    output reg [2:0] lights_out
);

reg [2:0] lights;

always @ (posedge clock or negedge reset_n) begin
    if (reset_n == 0) begin
        lights = 3'b0;
        lights_out = 3'b0;
    end

    else if (enable == 0) begin
        lights = 3'b0;
        lights_out = 3'b0;
    end

    else if ((reset_n == 1) && (enable == 1)) begin
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
            lights_out = lights;
        end

        else if (left_right == 1'b1) begin // right lights, reverse the order of lights
            lights_out [2] = lights[0];
            lights_out [1] = lights[1];
            lights_out [0] = lights[2];
        end
    end
end
endmodule