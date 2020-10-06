module sync(input logic clk, rst,
	input logic inSig,  
	output logic flip_3, rising_edge, falling_edge);
	
	 // For flip-flop 1 - metastability
	logic flip_1, flip_2;
	
// Synchronizes inputs 
always_ff @(posedge clk or negedge rst)
begin
	if (!rst)
	begin
		flip_1 <= 1'b0;
		flip_2 <= 1'b0;
		flip_3 <= 1'b0;

	end else begin
		flip_1 <= inSig; 
		flip_2 <= flip_1;
		flip_3 <= flip_2;
	end
end

// Determines if there is a rising or falling edge on the input
always_comb begin
	rising_edge = flip_2 & !flip_3;
	falling_edge = !flip_2 & flip_3;
end


endmodule
