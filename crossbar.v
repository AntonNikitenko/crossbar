module crossbar(
	input  clk, master_0_req, master_1_req, master_0_cmd, master_1_cmd, slave_0_ack, slave_1_ack,
	input  [31:0] master_0_wdata, master_1_wdata, master_0_addr, master_1_addr, slave_0_rdata, slave_1_rdata,
	output master_0_ack, master_1_ack, 
	output slave_0_cmd, slave_0_req, slave_1_cmd, slave_1_req,
	output [31:0] master_0_rdata, master_1_rdata, 
	output [31:0] slave_0_wdata, slave_1_wdata,
	output [30:0] slave_0_addr, slave_1_addr
);

wire slave_0_ack_w, slave_1_ack_w; 
wire [31:0] slave_0_rdata_w, slave_1_rdata_w;
wire master_0_req0, master_0_req0_w, master_0_req1, master_0_req1_w;
wire master_1_req0, master_1_req0_w, master_1_req1, master_1_req1_w;

wire master_0_granted=master_0_req0_w | master_0_req1_w;
wire master_1_granted=master_1_req0_w | master_1_req1_w;

toMaster master_0(.clk(clk), .slave_0_ack(slave_0_ack_w), .slave_1_ack(slave_1_ack_w),
	.slave_0_rdata(slave_0_rdata_w), .slave_1_rdata(slave_1_rdata_w), .granted(master_0_granted),
	.req(master_0_req), .addr(master_0_addr[31]),
	.ack(master_0_ack), .rdata(master_0_rdata), .req0(master_0_req0), .req1(master_0_req1));


toMaster master_1(.clk(clk), .slave_0_ack(slave_0_ack_w), .slave_1_ack(slave_1_ack_w),
	.slave_0_rdata(slave_0_rdata_w), .slave_1_rdata(slave_1_rdata_w), .granted(master_1_granted),
	.req(master_1_req), .addr(master_1_addr[31]),
	.ack(master_1_ack), .rdata(master_1_rdata), .req0(master_1_req0), .req1(master_1_req1));

	
reg master_0_cmd_r;
reg [31:0] master_0_wdata_r;
reg [30:0] master_0_addr_r;
reg master_0_cmd_rr;
reg [31:0] master_0_wdata_rr;
reg [30:0] master_0_addr_rr;
	
reg master_1_cmd_r;
reg [31:0] master_1_wdata_r;
reg [30:0] master_1_addr_r;
reg master_1_cmd_rr;
reg [31:0] master_1_wdata_rr;
reg [30:0] master_1_addr_rr;


always@(posedge clk) begin
	master_0_cmd_r<=master_0_cmd;
	master_0_wdata_r<=master_0_wdata;
	master_0_addr_r<=master_0_addr;
	
	master_1_cmd_r<=master_1_cmd;
	master_1_wdata_r<=master_1_wdata;
	master_1_addr_r<=master_1_addr;
	
	master_0_cmd_rr<=master_0_cmd_r;
	master_0_wdata_rr<=master_0_wdata_r;
	master_0_addr_rr<=master_0_addr_r;
	
	master_1_cmd_rr<=master_1_cmd_r;
	master_1_wdata_rr<=master_1_wdata_r;
	master_1_addr_rr<=master_1_addr_r;
end


arbiter a0(.clk(clk), .req0(master_0_req0), .req1(master_1_req0), .grant0(master_0_req0_w), .grant1(master_1_req0_w));
arbiter a1(.clk(clk), .req0(master_0_req1), .req1(master_1_req1), .grant0(master_0_req1_w), .grant1(master_1_req1_w));


toSlave #(.num(0)) slave_0(.clk(clk), 
	.master_0_req(master_0_req0_w),		.master_0_cmd(master_0_cmd_rr), 
	.master_0_wdata(master_0_wdata_rr),	.master_0_addr(master_0_addr_rr),	
	
	.master_1_req(master_1_req0_w),		.master_1_cmd(master_1_cmd_rr), 
	.master_1_wdata(master_1_wdata_rr),	.master_1_addr(master_1_addr_rr),	
	
	.req(slave_0_req),		.cmd(slave_0_cmd),
	.addr(slave_0_addr),	.wdata(slave_0_wdata), 
	.ack_i(slave_0_ack),	.ack_o(slave_0_ack_w),
	.rdata_i(slave_0_rdata),	.rdata_o(slave_0_rdata_w));


	
toSlave #(.num(1)) slave_1(.clk(clk), 
	.master_0_req(master_0_req1_w),		.master_0_cmd(master_0_cmd_r), 
	.master_0_wdata(master_0_wdata_rr),	.master_0_addr(master_0_addr_rr),	

	.master_1_req(master_1_req1_w),		.master_1_cmd(master_1_cmd_r), 
	.master_1_wdata(master_1_wdata_rr),	.master_1_addr(master_1_addr_rr),	
	
	.req(slave_1_req),		.cmd(slave_1_cmd),
	.addr(slave_1_addr),	.wdata(slave_1_wdata), 
	.ack_i(slave_1_ack),	.ack_o(slave_1_ack_w),
	.rdata_i(slave_1_rdata),	.rdata_o(slave_1_rdata_w));
 

endmodule
