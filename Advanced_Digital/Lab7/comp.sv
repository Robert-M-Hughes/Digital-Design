module comp(input logic [2:0] ALUOp,
	input logic [5:0] A, B,
	output logic[5:0] compout);

	//Module declarations

	//Output assignment
	always_comb
		begin
			
			case(ALUOp)
					3'b111	:	if (A == 6'b0) begin //cmpeq A = 0
							compout <= 6'b1;
						end
						else begin
							compout <= 6'b0;
						end
					3'b110	:	if((A[5] == 0 && B[5] == 1) || ((A[5] == 1 && B[5] == 1) && A[4:0] > B[4:0])|| ((A[5] == 0 && B[5] == 0) && A[4:0] < B[4:0]) )begin
							compout <= 6'b1;
						end	
						else begin
								compout <= 6'b0;
							end
					3'b101	:	if ((A[5] == 1 && B[5] == 0) || ((A[5] == 1 && B[5] == 1) && A[4:0] < B[4:0])|| ((A[5] == 0 && B[5] == 0) && A[4:0] > B[4:0]) ) begin//cmpgt
							compout <= 6'b1;					
					end
						else begin
								compout <= 6'b0;
							end
					3'b100	:	if (A==B) begin//cmpgt
							compout <= 6'b1;					
					end
						else begin
								compout <= 6'b0;
							end

					default	:	compout <= 6'b0;
				endcase

		end
endmodule

