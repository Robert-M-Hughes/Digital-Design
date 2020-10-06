module Lab6(
    input logic clk, mode, readWrite,
    input logic [14:0] writeData,
    output logic full, empty,
	 output logic [27:0] sevenSegments
);

   // Internal signals
   logic readWriteButton;
	logic [14:0] readData;
	logic rstSync = 1'b0;
	logic riseSend, fallSend, buttonSync;

   // SubcomponentsM
   sync xSyncButton(.clk(clk), .rst(rstSync), .inSig(readWrite), .falling_edge(buttonSync));
	
   memStateMachine xReadWrite(.clk(clk), .mode(mode), .readWrite(buttonSync), .writeData(writeData), .full(full), .empty(empty), .readData(readData));
	sevenSegment xSeg3(.in(readData[14:12]), .out(sevenSegments[27:21]));
	sevenSegment xSeg2(.in(readData[11:8]), .out(sevenSegments[20:14]));
	sevenSegment xSeg1(.in(readData[7:4]), .out(sevenSegments[13:7]));
	sevenSegment xSeg0(.in(readData[3:0]), .out(sevenSegments[6:0]));
	
endmodule
