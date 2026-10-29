//Author: Enzo Katzen - ekatzen@hmc.edu
//Date: 9/2/2026
//Purpose: Takes in four bits of input,
//		   interprets it as a 4 bit hex 
//		   number, and sets bits to 
//		   illuminate a seven segment
//		   display based on the input.
module sevenSeg(
	input logic [3:0] bitsIn,
	output logic [6:0] diodeSeg
);
	//View the input as hex to make it more readable
	//Each input corresponds with a specific set of segments
	//As the display uses a common positive, bitwise invert the segments that are desired to be illuminated
	always_comb 
	begin
		case(bitsIn)
			4'h0: diodeSeg = ~(7'b0111111);
			4'h1: diodeSeg = ~(7'b0000110);
			4'h2: diodeSeg = ~(7'b1011011);
			4'h3: diodeSeg = ~(7'b1001111);
			4'h4: diodeSeg = ~(7'b1100110);
			4'h5: diodeSeg = ~(7'b1101101);
			4'h6: diodeSeg = ~(7'b1111101);
			4'h7: diodeSeg = ~(7'b0000111);
			4'h8: diodeSeg = ~(7'b1111111);
			4'h9: diodeSeg = ~(7'b1101111);
			4'hA: diodeSeg = ~(7'b1110111);
			4'hB: diodeSeg = ~(7'b1111100);
			4'hC: diodeSeg = ~(7'b0111001);
			4'hD: diodeSeg = ~(7'b1011110);
			4'hE: diodeSeg = ~(7'b1111001);
			4'hF: diodeSeg = ~(7'b1110001);
			default: diodeSeg = ~(7'b0000000);
		endcase
	end
endmodule