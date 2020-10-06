module lab7(input logic[5:0] A,B,
	input logic[2:0] ALUOp,
	input logic reset, inSig, mode, clk, readWrite,
	output logic[5:0] Y, outA, outB, arithout, compout,
	output logic empty, full, z, v, n);

	//Signal declarations

	logic[14:0] dataOut;
	logic[2:0] ALUOPOBJ;

	//Module declarations
	
	logic readWriteButton, rstSync;
	assign reset = 1'b1;
	logic riseSend, fallSend, buttonSync;

   // SubcomponentsM
	sync xSyncRST(.clk(clk), .rst(reset), .inSig(reset), .flip_3(rstSync));
	
   sync xSyncButton(.clk(clk), .rst(rstSync), .inSig(readWrite), .falling_edge(buttonSync));

	
	state xstate(.clk(clk), .reset(rstSync), .mode(mode), .readWrite(buttonSync),.A(A), .B(B), .ALUOp(ALUOp), .dataOut(dataOut), .empty(empty), .full(full));

	
	
	arith xarith(.ALUOp(dataOut[14:12]), .A(dataOut[11:6]), .B(dataOut[5:0]), .arithout(arithout), .z(z), .v(v), .n(n));
	
	comp xcomp(.ALUOp(dataOut[14:12]),.A(dataOut[11:6]), .B(dataOut[5:0]), .compout(compout));
	
	assign outA = dataOut[11:6];
	assign outB = dataOut[5:0];
	assign ALUOPOBJ = dataOut[14:12];
	
	logic [3:0] paddedA, paddedB, paddedC;
	assign paddedA[3] = 1'b0;
	assign paddedA[2] = 1'b0;
	assign paddedA[1] = A[5];
	assign paddedA[0] = A[4];
	assign paddedB[3] = 1'b0;
	assign paddedB[2] = 1'b0;
	assign paddedB[1] = B[5];
	assign paddedB[0] = B[4];
	assign paddedC[3] = 1'b0;
	assign paddedC[2] = 1'b0;
	assign paddedC[1] = Y[5];
	assign paddedC[0] = Y[4];

	// Assign signs based on output
	assign outSignA = outA[5] == 1'b1;
	assign outSignB = outB[5] == 1'b1;
	assign outSignC = Y[5] == 1'b1;
	
	
	sevenSegment msbA(.in(paddedA), .out(outMsbA));
	sevenSegment lsbA(.in(A[3:0]), .out(outLsbA));
	sevenSegment msbB(.in(paddedB), .out(outMsbB));
	sevenSegment lsbB(.in(B[3:0]), .out(outLsbB));
	sevenSegment msbC(.in(paddedC), .out(outMsbC));
	sevenSegment lsbC(.in(Y[3:0]), .out(outLsbC));


	//Output assignment

	always_comb
		begin
			if(ALUOp == 3'b000 || ALUOp == 3'b001) begin
				Y <= arithout;
			end
			else begin
				Y <= compout;
			end
		end
		
		
		
/*
		 // Output assignment
            assign Y = A;
            assign z = 1'b0; 
            assign v = 1'b0;
            assign n = 1'b0;

*/

endmodule

