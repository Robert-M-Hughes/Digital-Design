module Testbench_Lab4();
	
	// Create clock signal
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM input and outputs
	logic enable = 1'b1;
	always #30 enable <= ~enable;
	
	//alternate between add/subtract
	logic operation = 1'b1;
	always #200 operation <= ~operation;
	
	
	
	logic v, n, z;
	logic [5:0] A, B;
	logic [6:0] outL, outR;
	
	
	task TestCase( logic inEn,logic inOp, logic [5:0] inA, logic [5:0] inB, logic [5:0] expectedOut, logic expectedz, logic expectedv, logic expectedN);
		
		@(negedge clk);
				A <= inA;
				B <= inB;
				
		@(negedge clk);
				A <= inA;
				B <= inB;
				
		@(negedge clk);
				A <= inA;
				B <= inB;
				
		@(posedge clk);
			tc: assert(v == expectedv && n == expectedN)
					$display("%d + %d got expected output of %d %d ov(%B) neg(%B)", inA, inB, outR, outL, v, n);
				else
					$error("%d + %d got UNEXPECTED output of %d %d ov(%B) neg(%B) instead ov(%B) neg(%B)", inA, inB, outL, outR, v, n, expectedv, expectedN);
	endtask
	
	// Connect device to test 
	Lab4 xLab4(.enable(enable), .clk(clk), .A(A), .B(B), .operation(operation), .v(v), .n(n), .z(z), .outL(outL), .outR(outR));
	
	initial begin
		// Delay tests while synchronizer enable is in a metastable state
		@(negedge clk);
		@(negedge clk);

		operation <= 1'b0;
		TestCase(1, 0, 5, 5, 10, 0, 0, 0);
		TestCase(1, 0, 5, 15, 20, 0, 0, 0);
		TestCase(1, 0, 5, 3, 8, 0, 0, 0);
		
		// Tests w/ v
		TestCase(1, 0, 25, 15, 40, 0, 1, 0);
		TestCase(1, 0, 16, 23, 39, 0, 1, 0);
		TestCase(1, 0, 23, 15, 38, 0, 1, 0);

		
		// Sub tests w/o v
		operation <= 1'b1;
		TestCase(1, 1, 5, 5, 0, 1, 0, 0);
		TestCase(1, 1, 15, 5, 10, 0, 0, 0);
		TestCase(1, 1, 5, 15, 10, 0, 0, 1);
		
		
		// Sub tests w/ v
		TestCase(1, 1, -60, 5, 65, 1, 1, 1);

		//unenabled
		TestCase(0, 0, 5, 5, 10, 0, 0, 0);
		TestCase(0, 0, 5, 15, 20, 0, 0, 0);
		TestCase(0, 0, 5, 3, 8, 0, 0, 0);


	end
	
endmodule
