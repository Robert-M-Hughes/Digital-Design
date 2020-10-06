module State_Machine(input logic clk,
				input logic [2:0] w_inputs,
				output logic [3:0] lights);

				
//Need to have the 3 inputs for the on off and the two switchd to control the state
//4 bit output to control the lights
	typedef enum logic[2:0]{
	
	OFF, ALL, CHASE1, CHASE2, CHASE3, CHASE4, ALT1, ALT2	
	
	}state_index;
	
	logic [2:0] state, next;
	
	
	
always_ff @(posedge clk)
begin

	state <= next;

end
	
	
always_comb begin

	case(state)
	OFF: if(w_inputs == 3'b000)begin
			next = OFF;
			end
			else begin
			next = ALL;
			end
	
	ALL: if(w_inputs == 3'b100) begin
				next = ALL;
			end
			else begin
			 next = OFF;
			 end
	CHASE1: if( w_inputs == 3'b110) begin
					next = CHASE2;
					end
	CHASE2: if( w_inputs == 3'b110) begin
					next = CHASE3;
					end
	CHASE3: if( w_inputs == 3'b110) begin
					next = CHASE4;
					end
	CHASE4: if( w_inputs == 3'b110) begin
					next = CHASE1;
					end
	ALT1:	if(w_inputs == 3'b111)begin
				next = ALT2;
				end
	ALT2:	if(w_inputs == 3'b111)begin
				next = ALT1;
				end
	default: next = OFF;
	
	endcase
	


end
	
	

always_ff @(posedge clk)//make output assignments
begin



	case(state)
	
	OFF:     lights = 4'b0000;
	ALL:     lights = 4'b1111;
	CHASE1:  lights = 4'b0001;
	CHASE2:  lights = 4'b0010;
	CHASE3:  lights = 4'b0100;
	CHASE4:  lights = 4'b1000;
	ALT1:	   lights = 4'b0101;
	ALT2:	   lights = 4'b1010;
	default: lights = 4'b0000;
	endcase


end



endmodule