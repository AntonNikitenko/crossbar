module slave(
	input clk, req, cmd, 
	input [30:0] addr,
	input [31:0] wdata,
	output reg ack, resp,
	output reg [31:0] rdata
);
	

reg [31:0] mem[15:0];

always@(posedge clk) begin
	if (req) begin
		if (cmd) begin
			mem[addr]<=wdata;
			resp<=0;
		end
		else begin
			rdata<=mem[addr];
			resp<=1;
		end
	ack<=1;
	end
	else begin
		rdata<=32'bx;
		resp<=0;
		ack<=0;
	end
end

endmodule
