module TestBench_lab7();
	
	// Create clock signals
	logic clk = 1'b0;
	always #50 clk <= ~clk;
	
	logic[5:0] A,B;
	logic[2:0] ALUOp;
	logic reset = 1'b1;
	logic mode = 0;
	logic readWrite = 1;
	logic[5:0] Y, outA, outB, arithout, compout;
	logic empty, full, z, v, n;
	
	
	`include "testCaseArith.sv"
	`include "testCaseComp.sv"
	
	//-32 to 31 is the range for 6bit numbers

	// Connect device(s) to test
	lab7 xtop(.readWrite(readWrite), .clk(clk), .A(A), .B(B), .ALUOp(ALUOp), .reset(reset), .inSig(readWrite), .mode(mode), .Y(Y),.arithout(arithout), .compout(compout), .outA(outA), .outB(outB), .empty(empty), .full(full), .z(z), .v(v), .n(n));
	
	
	initial begin
		
		
	/*
		for( int i = 0; i < 50; i ++) begin
			TestCaseArith(1, arithout, z, v, n);
			TestCaseArith(0, arithout, z, v, n);
		
		end
		$display("Done Arithmetic Works!");
	*/
		for( int i = 0; i < 20; i ++) begin
			TestCaseComp(1, compout);
			TestCaseComp(0, compout);
		
		end
		$display("Done Comparison Works!");
		
		
	
		
	end
	
endmodule