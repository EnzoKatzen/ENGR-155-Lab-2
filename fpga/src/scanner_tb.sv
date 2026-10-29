//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/15/2026
//Purpose: Tests the scanner led driving 
//         functionality contained in scanner.sv
`timescale 1 ns/10 ps

module scanner_tb();
    logic reset; // active low reset
	logic clk; //clk signal
	logic enable; //enable pin
    logic [3:0] rows; //4 output rows

    scanner dut (
		.reset(reset),
		.clk(clk),
        .enable(enable),
        .rows(rows)
    );

    always begin
		clk = 0; #10.42;
		clk = 1; #10.42;
	end

  // apply stimuli and check outputs
	initial begin
		enable = 1;
		reset = 0;
		#20.83 reset = 1;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
    // in this case, the leds use combinational logic, so we don't *need* to wait
    // a full clock cycle (#20.83) (1s/48MHz = 20.83 ns)
    // a full multiplexer cycle (#500000000) (1s/96Hz = 500000000 ns)
    // a quarter multiplexer cycle (#125000000) (1s/(2Hz * 2) = 125000000 ns)
	//scanner test 1
		#20.83;   
		assert (rows == 4'b1000)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 
    
	//scanner test 2
        #125040500
		assert (rows == 4'b0100)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 

	//scanner test 3
        #125040500
		assert (rows == 4'b0010)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 
    

	//scanner test 4
        #125040500
		assert (rows == 4'b0001)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 


	//scanner test 5
        #125040500
		assert (rows == 4'b1000)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 

	//scanner test 6
        enable = 0;
        #125040500
		assert (rows == 4'b1000)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 

	//scanner test 7
        enable = 1;
        #125040500
		reset = 0;
		#20.83 reset = 1;
		assert (rows == 4'b1000)
	        $display("PASSED! The scanner behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The scanner behaves incorrectly at time: %0t.", $time); 


  end
endmodule