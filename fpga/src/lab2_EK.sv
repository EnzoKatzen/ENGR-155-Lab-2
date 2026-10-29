//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/15/2026
//Purpose: Uses combinational logic to turn on LEDs
//		   on the uPs Dev Board based on the state
//		   of SW6. It also uses the state of SW6
//		   to set a 7 segment display.


module lab2_EK(
	input logic [7:0] s,
	input logic reset,
    input logic [3:0] cols,
    output logic multBlinkA,
	output logic multBlinkB,
	output logic clk,	//For testing
    output logic [3:0] rows,
	output logic [3:0] led,
	output logic [6:0] seg
);

	//Using template from iCE40 Oscillator Usage Guide
	HSOSC 
	#(
		.CLKHF_DIV ("0b00") //Setting this to 1 divides the frequency by two, setting it to 48 MHz so math is easier
	) OSCInst0 (
		.CLKHFPU(1'b1), 
		.CLKHFEN(1'b1), 
		.CLKHF(clk) //Setting clk to be the 48 MHz signal
	);
	
    //Generating a signal that powers each row for 1/8th of a second, so that there are 2 full scans per second, or 2Hz
    scanner keypadScanner(
        .reset(reset),
        .clk(clk),
        .enable(1'b1),
        .rows(rows)
    );

    //as a row recives power, if a button is pressed, the corresponding column will be low, and the corresponding LED will turn on
    assign led = (~cols);

    //Defining a multiplexer cycle to be at 96Hz
    Counter #(.WIDTH(18), .MAX(18'd250000)) multiplexerCount(
		.clk(clk),
		.reset(reset),
		.enable(1'b1),
		.blink(multBlinkA)
		);
		
	logic [3:0] tempSwitches;

    //As the cycle is 96Hz, each display is powered for 96 times a second, preventing blinking
    assign tempSwitches = multBlinkA? s[3:0] : s[7:4]; //When high, the right four switches are used, when low, the left four switches are used
    //assign seg = tempSeg; //When high, the display of lower signficance is used, when low, the last display of higher significance is used
	assign multBlinkB = ~(multBlinkA);
	sevenSeg segments(
		.bitsIn(tempSwitches),
		.diodeSeg(seg)
		);
	
endmodule	