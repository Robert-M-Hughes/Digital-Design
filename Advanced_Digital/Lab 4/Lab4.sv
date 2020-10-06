module Lab4(
	input logic clk, enable,
	input logic [5:0] A, B,
	input logic operation,
	output logic v, n, z,
	output logic [6:0] outL, outR
);

	// InternAl logic
	logic en = 1'B0;
	logic [5:0] arithout;
	

	// Connect device to test
	//synchronize the clock
	sync xSync(.clock(clk), .in(enable), .out(en));
	//calc and determine Display
	//logic ena = 1'b1;
	
	arith xArith(.enable(en), .ALUOp(operation), .A(A), .B(B), .arithout(arithout), .z(z), .v(v), .n(n));
	sevenSeg_Disp sevenSeg_6bit(.in(arithout), .outL(outL), .outR(outR));

endmodule
