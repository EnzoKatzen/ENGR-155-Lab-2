//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/15/2026
//Purpose: Tests the multiplexer 
//         functionality contained in lab2_EK.sv
`timescale 1 ns/10 ps

module top_multiplexer_tb();
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
    // a full multiplexer cycle (#10416666.67) (1s/96Hz = 10416666.67 ns)
    // a half multiplexer cylce (#5208333.34) (1s/(96Hz * 2) = 5208333.34 ns)
	
	//multiplexing test 1
		s = 8'h00;
		#20.83
		assert (seg == (~7'b0111111))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time); 
			
	//blinker test 2
		assert (multBlink == 0)
	        $display("PASSED! The multiplexer blinker behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer blinker behaves incorrectly at time: %0t.", $time); 
    
	//multiplexing test 2
        s = 8'h10;
		#20.83;   
		assert (seg == (~7'b0000110))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time); 
    
	//multiplexing test 3
        #5208333.335
		assert (seg == (~7'b0111111))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time); 
	
	//blinker test 2
		assert (multBlink == 1)
	        $display("PASSED! The multiplexer blinker behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer blinker behaves incorrectly at time: %0t.", $time); 

	//multiplexing test 4
        s = 8'h11;
		#20.83;   
		assert (seg == (~7'b0000110))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time); 

	//multiplexing test 5
        s = 8'h01;
		#20.83;
		assert (seg == (~7'b0000110))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time); 
    
	//multiplexing test 6
        s = 8'h00;
		#20.83;   
		assert (seg == (~7'b0111111))
	        $display("PASSED! The multiplexer assigned seg behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The multiplexer assigned seg behaves incorrectly at time: %0t.", $time);      


  end
endmodule