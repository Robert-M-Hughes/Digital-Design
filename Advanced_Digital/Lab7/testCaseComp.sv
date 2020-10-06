task TestCaseComp(logic inWrite, logic[5:0] expectOut);	

	logic [5:0] compout;


	@(negedge clk)begin
			ALUOp <= $urandom_range(0, 8);
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
		@(negedge clk)begin
			compout <= 6'b0;
			case(ALUOp)
					3'b111	:	if (A == 6'b0) begin //cmpeq A = 0
							compout <= 6'b1;
						end
						else begin
							compout <= 6'b0;
						end
					3'b110	:	if((A[5] == 1 && B[5] == 0) || ((A[5] == 1 && B[5] == 1) && A[4:0] > B[4:0]) || ((A[5] == 0 && B[5] == 0) && A[4:0] < B[4:0]) )begin //less than
							compout <= 6'b1;
						end	
						else begin
								compout <= 6'b0;
							end
					3'b101	:	if ((A[5] == 0 && B[5] == 1) || ((A[5] == 1 && B[5] == 1) && A[4:0] < B[4:0])|| ((A[5] == 0 && B[5] == 0) && A[4:0] > B[4:0]) ) begin//cmpgt
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
			
			if(expectOut != compout) begin
				$display("ALU OP %b", ALUOp);
				$error("Comparison:  Failed test @ A(%b), B(%b), Y(%b): expecting Y(%b)", A, B, expectOut, compout);

			end

		end
		
		
endtask