module TestBench_sevSeg_Disp();
	
	// Create clock signal
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM input and outputs
	logic [5:0] in;
	logic [6:0] outL, outR;
	
	task TestCase(logic [5:0] inputNum, logic [6:0] expectMSB, logic [6:0] expectLSB);
		@(negedge clk);
				in <= inputNum;
				
		@(posedge clk);
			tc: assert(outL == expectMSB && outR == expectLSB)
					$display("%b got expected output of %d %d", inputNum, expectMSB, expectLSB);
				else
					$error("%b got UNEXPECTED of %d %d were expecting output of %d %d ", inputNum, expectMSB, expectLSB, outL, outR);
	endtask
	
	// Connect device to test
	sevenSeg_Disp xsevenSeg_Disp(.in(in), .outL(outL), .outR(outR));
	
	initial begin	
			
		TestCase(0, 64, 64);
		TestCase(88, 36, 25);
		TestCase(14, 121, 25);
		TestCase(33, 48, 121);
		TestCase(50, 121, 25);
		TestCase(26, 36, 2);
		TestCase(9, 64, 16);
		TestCase(4, 64, 25);
		TestCase(44, 36, 64);
		TestCase(11, 121, 121);
		

//check unexpected outs
		TestCase(45, 3, 22);
		TestCase(57, 46, 15);
		TestCase(24, 32, 35);

	end
	
endmodule