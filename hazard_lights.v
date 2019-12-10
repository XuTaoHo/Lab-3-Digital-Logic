module hazard_lights(
    input clock,
    input enable,
    input reset,
    output reg [5:0] hazard_out
);

always @ (posedge clock or negedge reset) begin
    if (reset == 0) begin
        hazard_out = 0;
    end

    else if (enable == 0) begin
        hazard_out = 0;
    end
    
    else begin
        hazard_out = ~ hazard_out;
    end
end
endmodule