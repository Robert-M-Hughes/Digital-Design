module state(
	input logic clk, reset, mode, readWrite,
	input logic [5:0] A, B,
	input logic [2:0] ALUOp,
	output logic empty, full,
	output logic [14:0] dataOut
);



	// States
	typedef enum {
		IDLE,
      WRITE,
		READ
	} statetype;
	statetype state = IDLE, nextState = IDLE;

	/* Internal Signals */
	
	// Enable writes when not in IDLE
	logic enA;
	assign enA = state == WRITE;
	
	// Internal signals
    logic [3:0] readAddress = 0, writeAddress = 0;
	
    // Assign statements
    assign writeEnable = state === WRITE;
    assign full  = readAddress[2:0] == writeAddress[2:0] && readAddress[3] != writeAddress[3];
    assign empty = readAddress[2:0] == writeAddress[2:0] && readAddress[3] == writeAddress[3];
	 
	 
	
	// Create dataIn and assign input values to correct bits
	logic [14:0] dataIn;
	assign dataIn[14:12] = ALUOp;
	assign dataIn[11:6] = A;
	assign dataIn[5:0] = B;



	/* Subcomponents */
	dualPortMemory memory(.clk(clk), .enA(enA), .addrA(writeAddress[2:0]), .dataA(dataIn), .addrB(readAddress[2:0]), .qB(dataOut));
	

		
// Set next state
	always_ff @(posedge clk) begin
		case(state)
		WRITE: writeAddress <= writeAddress + 1;
		READ:  readAddress <= readAddress + 1;
		endcase	
		
	end
	
	always_ff @(posedge clk) begin
		state <= nextState;
	end
	
	/* Next state logic */
	always_comb begin
		case (state)
			IDLE: begin
            if (mode == 1'b1 && readWrite == 1'b1 && !full) begin
					nextState <= WRITE;
				end
				else if(mode == 1'b0 && readWrite == 1'b1 && !empty) begin
					nextState <= READ;
				end
				else begin
					nextState <= IDLE;
				end
			end

         WRITE: nextState <= IDLE;
				
         READ:  nextState <= IDLE;
				
		endcase
	end

endmodule
