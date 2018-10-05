module crossbar(
	input  clk, master_0_req, master_1_req, master_0_cmd, master_1_cmd, slave_0_ack, slave_1_ack,
	input  [31:0] master_0_wdata, master_1_wdata, master_0_addr, master_1_addr, slave_0_rdata, slave_1_rdata,
	output master_0_ack, master_1_ack, master_0_resp, master_1_resp, slave_0_resp, slave_1_resp,
	output slave_0_cmd, slave_0_req, slave_1_cmd, slave_1_req,
	output [31:0] master_0_rdata, master_1_rdata, 
	output [31:0] slave_0_wdata, slave_1_wdata,
	output [30:0] slave_0_addr, slave_1_addr
);

wire slave_0_ack0_w, slave_1_ack0_w; 
wire slave_0_ack1_w, slave_1_ack1_w; 
wire [31:0] slave_0_rdata_w, slave_1_rdata_w;
wire master_0_req0, master_0_req0_w, master_0_req1, master_0_req1_w;
wire master_1_req0, master_1_req0_w, master_1_req1, master_1_req1_w;

wire master_0_granted=master_0_req0_w | master_0_req1_w;
wire master_1_granted=master_1_req0_w | master_1_req1_w;

assign master_0_ack=slave_0_ack0_w | slave_1_ack0_w;
assign master_1_ack=slave_0_ack1_w | slave_1_ack1_w;

toMaster master_0(.clk(clk), .slave_0_resp(slave_0_resp), .slave_1_resp(slave_1_resp),
	.slave_0_rdata(slave_0_rdata), .slave_1_rdata(slave_1_rdata), .granted(master_0_granted),
	.req(master_0_req), .addr(master_0_addr[31]),
	.resp(master_0_resp), 
	.rdata(master_0_rdata));


toMaster master_1(.clk(clk), .slave_0_resp(slave_0_resp), .slave_1_resp(slave_1_resp),
	.slave_0_rdata(slave_0_rdata), .slave_1_rdata(slave_1_rdata), .granted(master_1_granted),
	.req(master_1_req), .addr(master_1_addr[31]),
	.resp(master_1_resp), 
	.rdata(master_1_rdata));


arbiter #(.num(0)) a0(.clk(clk), 
	.req0(master_0_req), .addr0(master_0_addr), 
	.cmd0(master_0_cmd), .wdata0(master_0_wdata),
	.req1(master_1_req), .addr1(master_1_addr), 
	.cmd1(master_1_cmd), .wdata1(master_1_wdata),
	.grant0(master_0_req0_w), .grant1(master_1_req0_w),
	.req(slave_0_req), .addr(slave_0_addr),
	.cmd(slave_0_cmd), .wdata(slave_0_wdata),
	.ack_i(slave_0_ack),	.ack_o_0(slave_0_ack0_w),
	.ack_o_1(slave_0_ack1_w));



arbiter #(.num(1)) a1(.clk(clk), 
	.req0(master_0_req), .addr0(master_0_addr), 
	.cmd0(master_0_cmd), .wdata0(master_0_wdata),
	.req1(master_1_req), .addr1(master_1_addr), 
	.cmd1(master_1_cmd), .wdata1(master_1_wdata),
	.grant0(master_0_req1_w), .grant1(master_1_req1_w),
	.req(slave_1_req), .addr(slave_1_addr),
	.cmd(slave_1_cmd), .wdata(slave_1_wdata),
	.ack_i(slave_1_ack),	.ack_o_0(slave_1_ack0_w),
	.ack_o_1(slave_1_ack1_w));

endmodule
