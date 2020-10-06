//Lab5 - Top Entity 
module Lab5(input logic clk, devB, startSig, rst, sendData,
				inout tri dataBus,  
				output logic devA, outB, outA, rstSync, starter, readData);

	//Variables 
	logic startSigSync, devBsync, riseB, riseSend, fallB, fallSend, oclk, intRst;
	
	// module declarations
	clkdiv clkdiv(.iclk(clk), .oclk(oclk));
	
	sync dutSend(.clk(oclk), .rst(rstSync), .inSig(startSig),.flip_3(startSigSync), .rising_edge(riseSend), .falling_edge(fallSend));
	sync dutDevB(.clk(oclk), .rst(rstSync), .inSig(devB), .flip_3(devBsync), .rising_edge(riseB),.falling_edge(fallB));
		
	asyncCom dutFSM(.clk(oclk), .rst(rstSync), .devB(devBsync), .startSig(riseSend), .dataIn(sendData), .dataBus(dataBus), .devA(devA), .dataOut(readData));

	
	//reset
	always_ff @(posedge clk or negedge rst)
	begin 
		if(!rst)
		begin 
			intRst <= 1'b0; 
			rstSync <= 1'b0; 
		end 
		else 
		begin 
			intRst <= rst; 
			rstSync <= intRst;
		end 
	end 
	

		 assign outB = !devBsync; 
		assign outA = devA; 
		assign starter = startSig;
	
	
endmodule 