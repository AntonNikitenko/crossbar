module toSlave #(parameter num=0) (
	input  clk, master_0_req, master_1_req, master_0_cmd, master_1_cmd, ack_i, 
	input  [31:0] master_0_wdata, master_1_wdata, master_0_addr, master_1_addr, rdata_i, 
	output reg ack_o, cmd, req,  
	output reg [31:0] rdata_o, wdata, 
	output reg [30:0] addr
);

reg req0, req1, req0_r, req0_rr, req1_rr, req1_r;

always@(posedge clk) begin
	req0<=master_0_req;
	req0_r<=req0;
	req0_rr<=req0_r;
	req1<=master_1_req;
	req1_r<=req1;
	req1_rr<=req1_r;
end

always@(posedge clk) begin
	case({master_1_req,master_0_req})
	2'b00:	begin
					req<=0;
					cmd<=0;
					addr<=0;
					wdata<=0;
				end
	2'b01:	begin
					req<=master_0_req;
					cmd<=master_0_cmd;
					addr<=master_0_addr;
					wdata<=master_0_wdata;
				end
	2'b10:	begin
					req<=master_1_req;
					cmd<=master_1_cmd;
					addr<=master_1_addr;
					wdata<=master_1_wdata;
				end
	endcase
end


always@(posedge clk) begin
	case({req1_r,req0_r})
	2'b01, 2'b10:	ack_o<=ack_i;
	default: ack_o<=0;
	endcase
end

always@(posedge clk) begin
	case({req1_rr,req0_rr})
	2'b01, 2'b10:	rdata_o<=rdata_i;
	default: rdata_o<=32'bx;
	endcase
end

endmodule
