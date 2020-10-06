module TestBench_fsm();
	
	// Create clock signals
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	// FSM inputs
	logic mode, readWrite;
	logic [5:0] A, B;
	logic [2:0] Op;

	
	// FSM inouts
	logic full, empty;
	logic [14:0] readData;
	
	
	task TestCase(logic inWrite);			
		@(negedge clk)begin
			ALUOp <= $urandom_range(0, 1);
		end
		repeat(4) @(negedge clk);
		@(negedge clk) begin
			A <= $urandom_range(-32, 31);
			end
		repeat(4) @(negedge clk);
		@(negedge clk) begin
			B <= $urandom_range(-32, 31);
			end
		@(negedge clk) begin
			mode <= $urandom_range(0, 1);
			end
		repeat(4) @(negedge clk);
		@(negedge clk) begin
			readWrite <= inWrite;
			end
		
	endtask
	
	// Connect device(s) to test
	state xMem(.clk(clk), .reset(1'b0), .mode(mode), .readWrite(readWrite), .A(A), .B(B), .ALUOp(OP), .full(full), .empty(empty), .readData(readData));


	
	initial begin
		//try to read at the begining
		

		for( int i = 0; i < 20; i ++) begin
			TestCaseComp(1);
			TestCaseComp(0);
		
		end

		$display("Done!");
	end
	
endmodule