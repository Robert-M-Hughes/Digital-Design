module arith(
			input logic [2:0] ALUOp,
			input logic [5:0] A, B,
			output logic [5:0] arithout,
			output logic z, v, n);

//Temporary Variable		
reg [5:0] temp;
//Changes B to 2's complement
always_comb
begin 
	if (ALUOp == 0) //add
		temp <= B;
	else 
		temp <= ~B + 1; 
end 

//Makes addition of 2's complement numbers
assign arithout = A+temp;


assign v =  (
	((A[5] == 1'b0) && (temp[5] == 1'b0) && (arithout[5] == 1'b1)) ||
	(A[5] == 1'b1) && (temp[5] == 1'b1) && (arithout[5] == 1'b0)

);
assign z = arithout == 6'b0;
assign n = arithout[5] == 1'b1;

//Determine v, z, and n

endmodule 