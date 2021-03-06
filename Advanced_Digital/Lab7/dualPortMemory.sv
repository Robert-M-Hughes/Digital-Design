/*

*/

module dualPortMemory (
   input logic clk, enA, enB,
   input logic [2:0] addrA, addrB,
   input logic [14:0] dataA, dataB,
	output logic [14:0] qA, qB
);
    
    // Create memory
    logic [14:0] memory [7:0];

    // A on posedge
    always_ff @(posedge clk) begin
        if(enA) begin
            memory[addrA] <= dataA;
        end

        qA <= memory[addrA];
    end
	 
	 // B on posedge
    always_ff @(posedge clk) begin
        if(enB) begin
            memory[addrB] <= dataB;
        end
		  
		  qB <= memory[addrB];
    end
endmodule
