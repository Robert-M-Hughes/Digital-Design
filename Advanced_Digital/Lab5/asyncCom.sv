//Lab5 - FSM and a unit test confirming
module asyncCom(input logic clk, devB, startSig, rst, dataIn,
				inout tri dataBus, 
				output logic devA, dataOut);

	typedef enum logic [1:0]{IDLE, SEND, SEND_WAIT, READ} stateType;
	stateType state, nextState; 
	

	
		// Assign dataBus a value in the send state
	assign dataBus = (state == SEND) ? dataIn : 1'bz;
	
	// Set readData to 0 and assign it to dataOut
	logic readData = 1'b0;
	assign dataOut = readData;

	
	
always_ff @(posedge clk or negedge rst)
begin 
	if(!rst)
		state <= IDLE; 
	else 
		state <= nextState; 
end

//active low buttons 
	always_comb begin
		case (state)

			IDLE: begin
				if (!devB && startSig) begin
					nextState <= READ;
				end
				else if (!startSig && devB) begin
					nextState <= SEND;
				end
				else begin
					nextState <= IDLE;
				end
			end
			SEND: begin
				if (!devB) begin
					nextState <= SEND;
				end
				else begin
					nextState <= IDLE;
				end
			end
			SEND_WAIT: begin
				if (devB) begin
					nextState <= SEND_WAIT;
				end
				else begin
					nextState <= IDLE;
				end
			end
			READ: begin
				if (!devB) begin
					nextState <= READ;
				end
				else begin
					nextState <= IDLE;
				end
			end
		endcase
	end
	
		/* Read data on negative edge */
	always @(negedge clk) begin
		case (state)
			READ: begin
				readData <= dataBus;
			end
			IDLE: begin
				readData <= 0;
			end
		endcase
	end
	
	/* Output logic */
	always_comb begin
		case (state)
			IDLE, SEND_WAIT: begin
				devA <= 1'b0;
			end
			default: begin
				devA <= 1'b1;
			end
		endcase
	end


//assign devA = ((state == SEND) || (state == SENDBA)) ? 1'b1: 1'b0;


endmodule 