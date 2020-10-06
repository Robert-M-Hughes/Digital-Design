module sevSeg(
	input logic [3:0] in,
	output logic [6:0] out 
);

	always_comb begin
		case(in)
			0: begin
				out <= 7'b1000000;
			end
			1: begin
				out <= 7'b1111001;
			end
			2: begin
				out <= 7'b0100100;
			end
			3: begin
				out <= 7'b0110000;
			end
			4: begin
				out <= 7'b0011001;
			end
			5: begin
				out <= 7'b0010010;
			end
			6: begin
				out <= 7'b0000010;
			end
			7: begin
				out <= 7'b1111000;
			end
			8: begin
				out <= 7'b0000000;
			end
			9: begin
				out <= 7'b0010000;
			end
			default: begin
				out <= 7'b1111111;
			end
		endcase
	end
endmodule