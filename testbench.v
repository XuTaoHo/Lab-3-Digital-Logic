
`timescale 1 ns / 100 ps

module testbench();

wire [7:0] disp0;
wire [7:0] disp1;
wire [7:0] disp2;
wire [7:0] disp3;
wire [7:0] disp4;
wire [7:0] disp5;


reg [1:0] KEY;
wire [9:0] LEDR;
reg  [9:0] SW;
reg system_clock;

Lab3 test
(
  .KEY(KEY),
  .LEDR(LEDR),
  .SW(SW),
  .HEX0(disp0),
  .HEX1(disp1),
  .HEX2(disp2),
  .HEX3(disp3),
  .HEX4(disp4),
  .HEX5(disp5),
  .ADC_CLK_10(system_clock)
);

always begin 
#1 system_clock = ~system_clock;
end

initial begin
$monitor($time, " display0 = %b, LED = %b button = %b, switch = %b, clock = %b", disp0[7:0],, LEDR[9:0], KEY[1:0], SW[9:0], system_clock); 
end


initial
  begin
    $dumpfile("out.vcd");
	  $dumpvars;
    $display($time, "<< Lab 3 >>");
    KEY[0] = 1'b1;
    KEY[1] = 1'b1;
    system_clock = 0;
    SW = 10'b0000000000;
    #5;
    KEY[0] = 1'b0; // generate a negative edge to reset system
    #5;
    KEY[0] = 1'b1; // let go of push button
    #5;
    KEY[0] = 1'b0; // generate another negative edge to turn reset off
    #5;
    KEY[0] = 1'b1;
    #5;
    SW[1] = 1'b1; // enable turn lights
    #5;
    KEY[1] = 1'b1; // right turn signal
    #100;
    KEY[1] = 0; // left turn signal
    #5;
    KEY[1] = 1'b1;
    //SW[0] = 1'b1; // enable hazard lights
    #100;
	#100 $finish;
  end
endmodule
