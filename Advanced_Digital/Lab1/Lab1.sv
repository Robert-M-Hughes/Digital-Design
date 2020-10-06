module Lab1(input logic clk,
				input logic [2:0] w_inputs,
				output logic [3:0] lights);
				
logic oclk;
				
clockdiv xclockdiv(.iclk(clk), .oclk(oclk));
	
    
State_Machine xState_Mach(.clk(oclk), .w_inputs(w_inputs), .lights(lights));



endmodule