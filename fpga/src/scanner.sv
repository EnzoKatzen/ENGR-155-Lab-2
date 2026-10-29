//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/15/2026
//Purpose: Uses a 48mHz clock cycle to
//         cyle through powering each 
//         of 4 rows of a keypad at 2Hz.


module scanner(
    input logic reset,
	input logic clk,
	input logic enable,
    output logic [3:0] rows
);
    //Defining the blinking signal for the scanner. Using parameters to get it to blik at 8Hz
    logic [24:0] counter;
	Counter #(.WIDTH(25), .MAX(25'd24000000)) scannerCount(
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.counter(counter)
		);

    assign rows = ((counter <= 25'd6000000)&& reset)? 4'b1000:  //As the scanner blinks, it will alternate between powering each row
                  ((counter <= 25'd12000000) && reset)? 4'b0100:   //As the scanner swaps twice per scannerBlink cycle, it will swap rows at 8Hz
                  ((counter <= 25'd18000000) && reset)? 4'b0010:  //So it will complete a full cycle every 1/2 second, or 2Hz
                  ((counter <= 25'd24000000) && reset)? 4'b0001:
                  (~reset)? 4'b1000 : 4'b1000;                                   //At reset, set to starting state


endmodule