module TestBench_dualPortMemory();
	
	// Create clock signals
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM inputs
	logic enable;
	logic [2:0] address;
	logic [14:0] writeData;
	
	// FSM inouts
	logic [14:0] readData;
	
	
	task TestCase(logic inEnable, logic [3:0] inAddress, logic [14:0] inWriteData, logic [14:0] expectedReadData, logic readDataIsHighZ);			
		@(negedge clk);
			enable <= inEnable;
			address <= inAddress;
			writeData <= inWriteData;
		@(posedge clk);
			tc: assert(readData == expectedReadData || readDataIsHighZ == 1'b1)
					$display("Sucessful test was ran");
				else
					$display("Failure @ enable(%b) address(%d) writeData(%d)", enable, address, writeData);
	endtask
	
	// Connect device(s) to test
	dualPortMemory memory(.clk(clk), .enA(enable), .addrA(address), .dataA(writeData), .qA(readData));
	
	initial begin
	
	// Write blocked by en
		TestCase(0, 0, 20, 88, 0);
		TestCase(0, 0, 20, 21, 0);
		TestCase(0, 1, 20, 88, 0);
		TestCase(0, 1, 20, 22, 0);
		TestCase(0, 2, 20, 88, 0);
		TestCase(0, 2, 20, 23, 0);
		TestCase(0, 3, 20, 88, 0);
		TestCase(0, 3, 20, 24, 0);
		TestCase(0, 4, 20, 88, 0);
		TestCase(0, 4, 20, 25, 0);
		TestCase(0, 5, 20, 88, 0);
		TestCase(0, 5, 20, 26, 0);
		TestCase(0, 6, 20, 88, 0);
		TestCase(0, 6, 20, 27, 0);
		TestCase(0, 7, 20, 88, 0);
		TestCase(0, 7, 20, 28, 0);
	
		
		// Write to each 
		TestCase(1, 0, 21,  0, 1);
		TestCase(1, 0, 21,  0, 1);
		TestCase(1, 0, 21, 21, 0);
		TestCase(1, 1, 22,  0, 1);
		TestCase(1, 1, 22,  0, 1);
		TestCase(1, 1, 22, 22, 0);
		TestCase(1, 2, 23,  0, 1);
		TestCase(1, 2, 23,  0, 1);
		TestCase(1, 2, 23, 23, 0);
		TestCase(1, 3, 24,  0, 1);
		TestCase(1, 3, 24,  0, 1);
		TestCase(1, 3, 24, 24, 0);
		TestCase(1, 4, 25,  0, 1);
		TestCase(1, 4, 25,  0, 1);
		TestCase(1, 4, 25, 25, 0);
		TestCase(1, 5, 26,  0, 1);
		TestCase(1, 5, 26,  0, 1);
		TestCase(1, 5, 26, 26, 0);
		TestCase(1, 6, 27,  0, 1);
		TestCase(1, 6, 27,  0, 1);
		TestCase(1, 6, 27, 27, 0);
		TestCase(1, 7, 28,  0, 1);
		TestCase(1, 7, 28,  0, 1);
		TestCase(1, 7, 28, 28, 0);
		
			// Write blocked by en
		TestCase(0, 0, 20, 88, 0);
		TestCase(0, 0, 20, 21, 0);
		TestCase(0, 1, 20, 88, 0);
		TestCase(0, 1, 20, 22, 0);
		TestCase(0, 2, 20, 88, 0);
		TestCase(0, 2, 20, 23, 0);
		TestCase(0, 3, 20, 88, 0);
		TestCase(0, 3, 20, 24, 0);
		TestCase(0, 4, 20, 88, 0);
		TestCase(0, 4, 20, 25, 0);
		TestCase(0, 5, 20, 88, 0);
		TestCase(0, 5, 20, 26, 0);
		TestCase(0, 6, 20, 88, 0);
		TestCase(0, 6, 20, 27, 0);
		TestCase(0, 7, 20, 88, 0);
		TestCase(0, 7, 20, 28, 0);
	
		
		
		
	end
	
endmodule