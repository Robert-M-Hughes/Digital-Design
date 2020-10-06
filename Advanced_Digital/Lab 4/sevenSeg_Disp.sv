module sevenSeg_Disp(
	input logic [5:0] in,
	output logic [6:0] outL,outR  
);

	// Internal Logic
	logic [3:0] msb;
	logic [3:0] lsb;
	
	// Assignments
	assign msb = ((in < 32) ? in : ( in - ( (in-32) * 2) )) / 10;
	assign lsb = ((in < 32) ? in : ( in - ( (in-32) * 2) )) % 10;
	
	
	// Connect device to test
	sevSeg xMSB(.in(msb), .out(outL));
	sevSeg xLSB(.in(lsb), .out(outR));
endmodule