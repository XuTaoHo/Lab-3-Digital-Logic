module clock_divider (
    input clock, 
    input reset_n, 
    output reg out_clock
);

reg [23:0] counter;

parameter counter_limit = 2500000; // change when using test bench and downloading to board

always @ (posedge clock or negedge reset_n) begin
    if (reset_n == 0) begin
        counter = 0;
        out_clock = 0;
    end

    else begin
            if (counter == counter_limit - 1) begin
                counter <= 0;
                out_clock = ~out_clock;
            end 

            else counter <= counter + 1;
    end
end
endmodule