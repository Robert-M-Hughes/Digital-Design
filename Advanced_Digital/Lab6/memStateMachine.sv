module memStateMachine (
    input logic clk, mode, readWrite,
    input logic [14:0] writeData,
    output logic full, empty,
	output logic [14:0] readData
);
    
	// States
	typedef enum {
		IDLE,
		WRITE_WAIT,
        WRITE,
		READ_WAIT,
		READ
	} statetype;
	statetype state = IDLE, nextState = IDLE;
	
	// Internal signals
    logic [3:0] readAddress = 0, writeAddress = 0;
	
    // Assign statements
    assign writeEnable = state === WRITE;
    assign full  = readAddress[2:0] == writeAddress[2:0] && readAddress[3] != writeAddress[3];
    assign empty = readAddress[2:0] == writeAddress[2:0] && readAddress[3] == writeAddress[3];

    // Subcomponents
    dualPortMemory memory(.clk(clk), .enA(writeEnable), .addrA(writeAddress[2:0]), .dataA(writeData), .addrB(readAddress[2:0]), .qB(readData));

	// Set next state
	always_ff @(posedge clk) begin
		if(state == WRITE) begin
			writeAddress <= writeAddress + 1;
		end
		else if(state == READ) begin
			readAddress <= readAddress + 1;
		end
		
		state <= nextState;
	end
	
	/* Next state logic */
	always_comb begin
		case (state)
			IDLE: begin
            if (mode == 1'b1) begin
					nextState <= WRITE_WAIT;
				end
				else begin
					nextState <= READ_WAIT;
				end
			end
         WRITE_WAIT: begin
				if (readWrite == 1'b1 && !full) begin
					nextState <= WRITE;
				end
				else if (mode == 1'b0) begin
					nextState <= READ_WAIT;
				end
				else
				begin
					nextState <= WRITE_WAIT;
				end
			end
         WRITE: begin
				if (mode == 1'b0) begin
					nextState <= READ_WAIT;
				end
				else begin
					nextState <= WRITE_WAIT;
				end
			end
         READ_WAIT: begin
				if (readWrite == 1'b1 && !empty) begin
					nextState <= READ;
				end
				else if (mode == 1'b1) begin
					nextState <= WRITE_WAIT;
				end
				
				else begin
					nextState <= READ_WAIT;
				end
			end
         READ: begin
				if (mode == 1'b1) begin
					nextState <= WRITE_WAIT;
				end
				else begin
					nextState <= READ_WAIT;
				end
			end
		endcase
	end
endmodule