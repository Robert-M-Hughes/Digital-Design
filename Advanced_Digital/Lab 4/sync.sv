module sync(
	input logic clock, in,
	output logic out
);
	 
	logic ff1, ff2, sync;
	

	always @ (posedge clock) begin
		ff1 <= in;
		ff2 <= ff1;
		sync <= ff2;
	end
	
	assign out = ff2 & !sync;
endmodule
