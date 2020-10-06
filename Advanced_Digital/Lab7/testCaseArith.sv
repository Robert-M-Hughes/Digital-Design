task TestCaseArith(logic inWrite, logic[5:0] expectOut, logic z, logic v, logic n);	

		logic [5:0] temp;
		logic expectV;

	@(negedge clk)begin
			ALUOp <= $urandom_range(0, 1);
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
			if (ALUOp == 0) begin //add
				temp <= B;
			end
			else begin
				temp <= ~B + 1; 
			end
		

			assign expectV =  v;
		end

		

		
		if( !(n == expectOut[5])) begin
			$display("ALU OP %b", ALUOp);
			$error("NEGATIVE:  Failed test @ A(%b), B(%b), Y(%b),  n(%b)", A, B, expectOut, n);

		end
		if( ( (z == 0) && (expectOut == 6'b0)) || ( (z == 1) && (expectOut != 6'b0)) )begin // make sure that the values match
			$display("ALU OP %b", ALUOp);
			$error("ZERO:  Failed test @ A(%b), B(%b), Y(%b), z(%b)", A, B, expectOut, z);

		end
		if( v != expectV )begin
			$display("ALU OP %b", ALUOp);
			$error("OVERFLOW:  Failed test @ A(%b), B(%b), Y(%b), v(%b): was expecting v(%b)", A, B, expectOut, v, expectV);

		end
		
endtask