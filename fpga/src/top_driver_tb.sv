//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/15/2026
//Purpose: Tests the scanner led driving 
//         functionality contained in lab2_EK.sv
`timescale 1 ns/10 ps

module top_driver_tb();
	logic           reset;  // active low reset
    logic [3:0]     cols;       // 4 input columns
	logic 			clk;	// clk for sim
	logic [7:0]     s;      // 8-bit input switches
	logic [3:0]     led;    // 4 output LEDs
	logic [6:0]	    seg;	// 7 output segments
    logic [3:0]     rows;       // 4 output rows
	logic multBlink; //multiplexer output


    lab2_EK dut (
		.reset(reset),
        .s(s),
		.clk(clk),
        .led(led),
		.seg(seg),
        .rows(rows),
        .cols(cols),
		.multBlink(multBlink)
    );

  // apply stimuli and check outputs
	initial begin
		reset = 0;
		#20.83 reset = 1;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
    // in this case, the leds use combinational logic, so we don't *need* to wait
    // a full clock cycle (#20.83) (1s/48MHz = 20.83 ns)

	//scanner driver test 1
        cols = 4'b1111;
		#20.83;   
		assert (led == 4'b0000)
	        $display("PASSED! The scanner LED driver behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner LED driver behaves incorrectly at time: %0t.", $time); 
    
	//scanner driver test 2
        cols = 4'b1110;
		#20.83;   
		assert (led == 4'b0001)
	        $display("PASSED! The scanner LED driver behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner LED driver behaves incorrectly at time: %0t.", $time); 

	//scanner driver test 3
        cols = 4'b1101;
		#20.83;   
		assert (led == 4'b0010)
	        $display("PASSED! The scanner LED driver behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner LED driver behaves incorrectly at time: %0t.", $time); 
    

	//scanner driver test 4
        cols = 4'b1011;
		#20.83;   
		assert (led == 4'b0100)
	        $display("PASSED! The scanner LED driver behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner LED driver behaves incorrectly at time: %0t.", $time); 

	//scanner driver test 5
        cols = 4'b0111;
		#20.83;   
		assert (led == 4'b1000)
	        $display("PASSED! The scanner LED driver behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner LED driver behaves incorrectly at time: %0t.", $time); 


  end
endmodule