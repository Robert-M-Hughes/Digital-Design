module TestBench_sevSeg();
	
	// Create clock signal
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM input and outputs
	logic [3:0] in;
	logic [6:0] out;
	
	task TestCase(logic [3:0] my_input, logic [6:0] guess);
		@(negedge clk);
				in <= my_input;
				
		@(posedge clk);
			tc: assert(out == guess)
					$display("%b got expected output of %b", my_input, out);
				else
					$display("%b got UNEXPECTED output of %b", my_input, out);
	endtask
	
	// Connect device to test
	sevSeg xsevSeg(.in(in), .out(out));
	
	initial begin	
	
		// Add tests w/o overflow
		TestCase(1, 7'b1111001);
		TestCase(2, 7'b0100100);
		TestCase(3, 7'b0110000);
		TestCase(4, 7'b0011001);
		TestCase(5, 7'b0010010);
		TestCase(6, 7'b0000010);
		TestCase(7, 7'b1111000);
		TestCase(8, 7'b0000000);
		TestCase(9, 7'b0010000);
		TestCase(10, 7'b1111111);
		TestCase(11, 7'b1111111);
		TestCase(12, 7'b1111111);
		TestCase(13, 7'b1111111);
		TestCase(14, 7'b1111111);
		TestCase(15, 7'b1111111);

	end
	
endmodule