module arbiter #(parameter num=0)(
	input clk, req0, req1,
	input cmd0, cmd1, ack_i,
	input [31:0] wdata0, wdata1, addr0, addr1,
	output reg ack_o_0, ack_o_1,
	output reg grant0, grant1, cmd, req,
	output reg [31:0] wdata, addr
);

reg [1:0] mask=2'b01;

generate
if (num==0)
always@(posedge clk) begin
	case({(req1 & (~addr1[31])),(req0 & (~addr0[31]))})
	2'b00:	begin 
					grant0<=0;
					grant1<=0;
					req<=0;
					cmd<=0;
					wdata<=0;
					addr<=0;
					ack_o_0<=0;
					ack_o_1<=0;
				end
	2'b01:	begin
					grant0<=1;
					grant1<=0;
					req<=req0;
					cmd<=cmd0;
					addr<=addr0;
					wdata<=wdata0;
					ack_o_0<=1;
					ack_o_1<=0;
				end
	2'b10:	begin
					grant0<=0;
					grant1<=1;
					req<=req1;
					cmd<=cmd1;
					addr<=addr1;
					wdata<=wdata1;
					ack_o_0<=0;
					ack_o_1<=1;
				end
	2'b11:	begin
					if (mask[0]==1) begin
							grant0<=1;
							grant1<=0;
							req<=req0;
							cmd<=cmd0;
							addr<=addr0;
							wdata<=wdata0;
							ack_o_0<=1;
							ack_o_1<=0;
					end
					if (mask[1]==1) begin
							grant0<=0;
							grant1<=1;
							req<=req1;
							cmd<=cmd1;
							addr<=addr1;
							wdata<=wdata1;
							ack_o_0<=0;
							ack_o_1<=1;
					end
					mask<=~mask;
				end
	endcase
end
else
always@(posedge clk) begin
	case({(req1 & (addr1[31])),(req0 & (addr0[31]))})
	2'b00:	begin 
					grant0<=0;
					grant1<=0;
					req<=0;
					cmd<=0;
					wdata<=0;
					addr<=0;
					ack_o_0<=0;
					ack_o_1<=0;
				end
	2'b01:	begin
					grant0<=1;
					grant1<=0;
					req<=req0;
					cmd<=cmd0;
					addr<=addr0;
					wdata<=wdata0;
					ack_o_0<=1;
					ack_o_1<=0;
				end
	2'b10:	begin
					grant0<=0;
					grant1<=1;
					req<=req1;
					cmd<=cmd1;
					addr<=addr1;
					wdata<=wdata1;
					ack_o_0<=0;
					ack_o_1<=1;
				end
	2'b11:	begin
					if (mask[0]==1) begin
							grant0<=1;
							grant1<=0;
							req<=req0;
							cmd<=cmd0;
							addr<=addr0;
							wdata<=wdata0;
							ack_o_0<=1;
							ack_o_1<=0;
					end
					if (mask[1]==1) begin
							grant0<=0;
							grant1<=1;
							req<=req1;
							cmd<=cmd1;
							addr<=addr1;
							wdata<=wdata1;
							ack_o_0<=0;
							ack_o_1<=1;
					end
					mask<=~mask;
				end
	endcase
end
endgenerate
endmodule
