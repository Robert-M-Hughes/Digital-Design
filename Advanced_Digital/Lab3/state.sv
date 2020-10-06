module state(
	input logic clock,
   input logic a,
	input logic b,
	input logic c,
	output logic lock
);
	 
	 // States and their outputs
	 typedef enum {
		INIT,
		B,
		BC,
		BCA,
		BCAB
	 } statetype;
    
    statetype state = INIT, nextState = INIT;
    
	always_ff @(posedge clock)
	begin
		 state <= nextState;
	end
	
	/* Next state logic */
	always_comb begin
		case (state)
			INIT: begin
				if (a == 1'b1 && b == 1'b0 && c == 1'b1) begin
					nextState <= B;
				end
				else begin
					nextState <= INIT;
				end
			end
			
			B: begin
				if (a == 1'b1 && b == 1'b1 && c == 1'b1) begin
					nextState <= B;
				end
				else if (a == 1'b1 && b == 1'b1 && c == 1'b0) begin
					nextState <= BC;
				end
				else begin
					nextState <= INIT;
				end
			end
			
			BC: begin
				if(a == 1'b1 && b == 1'b1 && c == 1'b1) begin
					nextState <= BC;
				end
				else if (a == 1'b0 && b == 1'b1 && c == 1'b1) begin
					nextState <= BCA;
				end
				else begin
					nextState <= INIT;
				end
			end
			
			BCA: begin
				if (a == 1'b1 && b == 1'b1 && c == 1'b1) begin
					nextState <= BCA;
				end
				else if (a == 1'b1 && b == 1'b0 && c == 1'b1) begin
					nextState <= BCAB;
				end
				else begin
					nextState <= INIT;
				end
			end
			
			BCAB: begin
				if (a == 1'b1 && b == 1'b1 && c == 1'b1) begin
					nextState <= BCAB;
				end
				else begin
					nextState <= INIT;
				end
			end
		endcase
	end
	
	//set the outputs
	always_comb begin
		case (state)
			BCAB: begin
				lock <= 1'b1;
			end
			default:
				lock <= 1'b0;
		endcase
	end
endmodule
