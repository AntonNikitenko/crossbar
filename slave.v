module slave(
	input clk, req, cmd, 
	input [30:0] addr,
	input [31:0] wdata,
	output reg ack,
	output reg [31:0] rdata
);
	

reg [31:0] mem[15:0];
reg [31:0] rdata_r=32'bx;

always@(posedge clk) begin
	rdata<=rdata_r;
	if (req) begin
		if (cmd)
			mem[addr]<=wdata;
		else 
			rdata_r<=mem[addr];
	end
	else
		rdata_r<=32'bx;
end

always@(posedge clk) begin
if (req)
	ack<=1;
else if (!req)
	ack<=0;
if (ack&(!req))
	ack<=0;
end

endmodule
