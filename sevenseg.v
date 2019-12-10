module sevenseg(value, display);
input [5:0] value;
output reg [7:0] display; 

always @(value)
    begin
        casex(value) 
            6'b1xxxxx: display = 8'b1111_1111; // blank
            6'b01xxxx: display = 8'b1011_1111; // negative sign
            6'b000000: display = 8'b1100_0000; // 0
            6'b000001: display = 8'b1111_1001; // 1
            6'b000010: display = 8'b1010_0100; // 2
            6'b000011: display = 8'b1011_0000; // 3
            6'b000100: display = 8'b1001_1001; // 4
            6'b000101: display = 8'b1001_0010; // 5
            6'b000110: display = 8'b1000_0010; // 6
            6'b000111: display = 8'b1111_1000; // 7
            6'b001000: display = 8'b1000_0000; // 8
            6'b001001: display = 8'b1001_1000; // 9
            6'b001010: display = 8'b1000_1000; // A
            6'b001011: display = 8'b1000_0011; // b
            6'b001100: display = 8'b1100_0110; // C
            6'b001101: display = 8'b1010_0001; // d
            6'b001110: display = 8'b1000_0110; // E
            6'b001111: display = 8'b1000_1110; // F
            default: display = 8'b1000_0110; // ERROR 
        endcase
    end
endmodule