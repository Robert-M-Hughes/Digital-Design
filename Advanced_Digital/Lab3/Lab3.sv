module Lab3(
	input logic clock, inA, inB, inC,
	output logic lock
);
	 
	logic a, b, c;
	
	sync syncA(.clock(clock), .in(inA), .out(a));
	sync syncB(.clock(clock), .in(inB), .out(b));
	sync syncC(.clock(clock), .in(inC), .out(c));
	state state(.clock(clock), .a(a), .b(b), .c(c), .lock(lock));
	
endmodule
