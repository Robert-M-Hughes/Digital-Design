module TestBench_arith();
	
	// Create clock signal
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM input and outputs
	logic [5:0] A, B, arithout;
	logic v, z, n, operation, enable;
	
	task TestCase( logic inEn,logic inOp, logic [5:0] inA, logic [5:0] inB, logic [5:0] expectedOut, logic expectedz, logic expectedv, logic expectedN);
		@(negedge clk);
				enable <= inEn;
				A <= inA;
				B <= inB;
				
		@(posedge clk);
			tc: assert(arithout == expectedOut && v == expectedv && n == expectedN)
					$display("%b + %b got expected output of %b with v(%b) with n %b", inA, inB, arithout, v, n);
				else
					$error("%b + %b got UNEXPECTED output of %b with v(%b) with n %b", inB, inB, arithout, v, n);
	endtask
	
	// Connect device to test
	arith arithTest(.enable(enable), .ALUOp(operation), .A(A), .B(B), .arithout(arithout), .z(z), .v(v), .n(n));
	
	initial begin	
	
		// Add tests w/o v
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