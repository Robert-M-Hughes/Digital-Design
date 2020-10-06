module TestBench_fsm();
	
	// Create clock signals
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM inputs
	logic mode, readWrite;
	logic [14:0] writeData;
	
	// FSM inouts
	logic full, empty;
	logic [14:0] readData;
	
	
	task TestCase(logic inMode, logic inReadWrite, logic [14:0] inWriteData, logic expectedFull, logic expectedEmpty, logic [14:0] expectedReadData, logic readDataIsHighZ);			
		@(negedge clk);
			mode <= inMode;
			readWrite <= inReadWrite;
			writeData <= inWriteData;
		@(posedge clk);
			tc: assert((full == expectedFull && empty == expectedEmpty && readData == expectedReadData) || readDataIsHighZ == 1'b1)
					$display("Test Successful Congrats!");
				else
					$display("Failure @ mode(%b) writeData(%d) ", mode, writeData);
	endtask
	
	// Connect device(s) to test
	memStateMachine xMem(.clk(clk), .mode(mode), .readWrite(readWrite), .writeData(writeData), .full(full), .empty(empty), .readData(readData));
	
	initial begin
		//try to read at the begining
		TestCase(0, 0, 00001, 0, 1, 0, 0);
		TestCase(0, 1, 00001, 0, 1, 0, 0);

		
		// Write to each 
		TestCase(1, 0, 12345, 0, 1,     0, 1);
		TestCase(1, 1, 12345, 0, 1,     0, 1);
		TestCase(1, 0, 12345, 0, 1,     0, 1);
		TestCase(1, 0, 12345, 0, 1,     0, 1);
		TestCase(1, 0, 12345, 0, 0, 12345, 0);
		
		TestCase(1, 0, 32766, 0, 0, 12345, 0);
		TestCase(1, 1, 32766, 0, 0, 12345, 0);
		TestCase(1, 0, 32766, 0, 0, 12345, 0);
		TestCase(1, 0, 32766, 0, 0, 12345, 0);
		TestCase(1, 0, 32766, 0, 0, 12345, 0);
		
		TestCase(1, 0, 54321, 0, 0, 12345, 0);
		TestCase(1, 1, 54321, 0, 0, 12345, 0);
		TestCase(1, 0, 54321, 0, 0, 12345, 0);
		TestCase(1, 0, 54321, 0, 0, 12345, 0);
		TestCase(1, 0, 54321, 0, 0, 12345, 0);
		
		TestCase(1, 0, 00004, 0, 0, 12345, 0);
		TestCase(1, 1, 00004, 0, 0, 12345, 0);
		TestCase(1, 0, 00004, 0, 0, 12345, 0);
		TestCase(1, 0, 00004, 0, 0, 12345, 0);
		TestCase(1, 0, 00004, 0, 0, 12345, 0);
		
		TestCase(1, 0, 11111, 0, 0, 12345, 0);
		TestCase(1, 1, 11111, 0, 0, 12345, 0);
		TestCase(1, 0, 11111, 0, 0, 12345, 0);
		TestCase(1, 0, 11111, 0, 0, 12345, 0);
		TestCase(1, 0, 11111, 0, 0, 12345, 0);
		
		TestCase(1, 0, 11528, 0, 0, 12345, 0);
		TestCase(1, 1, 11528, 0, 0, 12345, 0);
		TestCase(1, 0, 11528, 0, 0, 12345, 0);
		TestCase(1, 0, 11528, 0, 0, 12345, 0);
		TestCase(1, 0, 11528, 0, 0, 12345, 0);
		
		TestCase(1, 0, 08258, 0, 0, 12345, 0);
		TestCase(1, 1, 08258, 0, 0, 12345, 0);
		TestCase(1, 0, 08258, 0, 0, 12345, 0);
		TestCase(1, 0, 08258, 0, 0, 12345, 0);
		TestCase(1, 0, 08258, 0, 0, 12345, 0);
		
		TestCase(1, 0, 51000, 0, 0, 12345, 0);
		TestCase(1, 1, 51000, 0, 0, 12345, 0);
		TestCase(1, 0, 51000, 0, 0, 12345, 0);
		TestCase(1, 0, 51000, 1, 0, 12345, 0);
		TestCase(1, 0, 51000, 1, 0, 12345, 0);
		
		// Read from each
		TestCase(0, 0, 00001, 1, 0, 12345, 0);
		TestCase(0, 1, 00001, 1, 0, 12345, 0);
		TestCase(0, 0, 00001, 1, 0, 12345, 0);
		TestCase(0, 0, 00001, 0, 0, 12345, 0);
		TestCase(0, 0, 00001, 0, 0, 32766, 0);
		
		TestCase(0, 1, 00001, 0, 0, 32766, 0);
		TestCase(0, 0, 00001, 0, 0, 32766, 0);
		TestCase(0, 0, 00001, 0, 0, 32766, 0);
		TestCase(0, 0, 00001, 0, 0, 54321, 0);
		
		TestCase(0, 1, 00001, 0, 0, 54321, 0);
		TestCase(0, 0, 00001, 0, 0, 54321, 0);
		TestCase(0, 0, 00001, 0, 0, 54321, 0);
		TestCase(0, 0, 00001, 0, 0, 00004, 0);
		
		TestCase(0, 1, 00001, 0, 0, 00004, 0);
		TestCase(0, 0, 00001, 0, 0, 00004, 0);
		TestCase(0, 0, 00001, 0, 0, 00004, 0);
		TestCase(0, 0, 00001, 0, 0, 11111, 0);
		
		TestCase(0, 1, 00001, 0, 0, 11111, 0);
		TestCase(0, 0, 00001, 0, 0, 11111, 0);
		TestCase(0, 0, 00001, 0, 0, 11111, 0);
		TestCase(0, 0, 00001, 0, 0, 11528, 0);
		
		TestCase(0, 1, 00001, 0, 0, 11528, 0);
		TestCase(0, 0, 00001, 0, 0, 11528, 0);
		TestCase(0, 0, 00001, 0, 0, 11528, 0);
		TestCase(0, 0, 00001, 0, 0, 08258, 0);
		
		TestCase(0, 1, 00001, 0, 0, 08258, 0);
		TestCase(0, 0, 00001, 0, 0, 08258, 0);
		TestCase(0, 0, 00001, 0, 0, 08258, 0);
		TestCase(0, 0, 00001, 0, 0, 51000, 0);

		$display("Done!");
	end
	
endmodule