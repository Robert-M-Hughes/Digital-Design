`timescale 1ns/1ns
module TestBench_lab3();
	
	// FSM input and outputs
	
	logic a, b, c;
	logic lock;
	logic [0:2] button1 = 3'b000;
	logic [0:2] button2 = 3'b000;
	logic [0:2] button3 = 3'b000;
	logic [0:2] button4 = 3'b000;


	// Create clock signal
	logic clock = 1'b0;
	always begin
		#50 clock <= ~clock;
	end

	





	
	task TestCase(logic in_a, logic in_b, logic in_c, logic lock);
		repeat(5)@(negedge clock);
				a <= in_a;
				b <= in_b;
				c <= in_c;
				
		@(posedge clock);
			tc: assert(lock == lock)
					$display("%b%b%b Expected output of %b", in_a, in_b, in_c, lock);
				else
					$display("%b%b%b UNEXPECTED output of %b", in_a, in_b, in_c, lock);
	endtask
	
	// Connect device to test
	state fsmLab3(.clock(clock), .a(a), .b(b), .c(c), .lock(lock));

	
	initial begin
    //loops to run through all of the iterations
		for(int i=0; i < 8; i++) begin
			
			TestCase(button1[0], button1[1], button1[2], 1'b0);
			
			button2 <= 3'b000;
			for(int j=0; j < 8; j++) begin
			
				TestCase(button2[0], button2[1], button2[2], 1'b0);
			
				button3 <= 3'b000;
				for(int k=0; k < 8; k++) begin
			
					TestCase(button3[0], button3[1], button3[2], 1'b0);
			
					button4 <= 3'b000;
					for(int e=0; e < 8; e++) begin
								
						TestCase(button4[0], button4[1], button4[2], (
                            //Check the correct combination and output it
                            //b
							button1[0] == 1 && 
							button1[1] == 0 &&
							button1[2] == 1 &&
							//c
							button2[0] == 1 && 
							button2[1] == 1 && 
							button2[2] == 0 && 
							//a
							button3[0] == 0 && 
							button3[1] == 1 && 
							button3[2] == 1 && 
							//b
							button4[0] == 1 && 
							button4[1] == 0 && 
							button4[2] == 1
						) ? 1'b1 : 1'b0);//ternary operation to execute to make sure we are passing in the correct value to be testing the output
				
						button4 <= button4 + 1;//how we will loop through the different 
					end
			
					button3 <= button3 + 1;
				end
				
				button2 <= button2 + 1;
			end
			
			button1 <= button1 + 1;
		end
	end

	

	
endmodule