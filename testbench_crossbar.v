`timescale 1 ns/ 1 ns
`define CLK_PERIOD 20

module testbench_crossbar();


wire  clk, master_0_req,  master_0_cmd, master_1_req,  master_1_cmd, slave_0_ack, slave_1_ack;
wire  [31:0] master_0_wdata, master_0_addr, master_1_wdata, master_1_addr, slave_0_rdata, slave_1_rdata;
wire  master_0_ack, master_1_ack, slave_0_cmd, slave_1_cmd, slave_0_req, slave_1_req;
wire  [31:0] master_0_rdata, master_1_rdata, slave_0_wdata, slave_1_wdata;
wire  [30:0] slave_0_addr, slave_1_addr;


reg [31:0] wdata_0, wdata_1, addr_1, addr_0;
reg clk_reg;
reg cmd_0, cmd_1;
reg req_0, req_1;


initial begin
	clk_reg<=0;
	req_0<=0;
	cmd_0<=0;
	addr_0<=0;
	wdata_0<=0;
	req_1<=0;
	cmd_1<=0;
	addr_1<=0;
	wdata_1<=0;
end


always #(`CLK_PERIOD/2) clk_reg=(clk_reg==1)?0:1;

crossbar c1(.clk(clk), 
	.master_0_req(master_0_req),		.master_0_cmd(master_0_cmd), 
	.master_0_wdata(master_0_wdata),	.master_0_addr(master_0_addr),
	.master_0_ack(master_0_ack),		.master_0_rdata(master_0_rdata),
	
	.master_1_req(master_1_req),		.master_1_cmd(master_1_cmd), 
	.master_1_wdata(master_1_wdata),	.master_1_addr(master_1_addr),
	.master_1_ack(master_1_ack),		.master_1_rdata(master_1_rdata),
	
	.slave_0_req(slave_0_req),		.slave_0_cmd(slave_0_cmd),
	.slave_0_addr(slave_0_addr),	.slave_0_wdata(slave_0_wdata), 
	.slave_0_ack(slave_0_ack),		.slave_0_rdata(slave_0_rdata),
	
	.slave_1_req(slave_1_req),		.slave_1_cmd(slave_1_cmd), 
	.slave_1_addr(slave_1_addr),	.slave_1_wdata(slave_1_wdata),
	.slave_1_ack(slave_1_ack),		.slave_1_rdata(slave_1_rdata));
 
slave slave_0(.clk(clk), .req(slave_0_req), .cmd(slave_0_cmd), .addr(slave_0_addr), .wdata(slave_0_wdata), .ack(slave_0_ack), .rdata(slave_0_rdata));
slave slave_1(.clk(clk), .req(slave_1_req), .cmd(slave_1_cmd), .addr(slave_1_addr), .wdata(slave_1_wdata), .ack(slave_1_ack), .rdata(slave_1_rdata));


assign clk=clk_reg;
assign master_0_req=req_0;
assign master_0_cmd=cmd_0;
assign master_0_wdata=wdata_0;
assign master_0_addr=addr_0;

assign master_1_req=req_1;
assign master_1_cmd=cmd_1;
assign master_1_wdata=wdata_1;
assign master_1_addr=addr_1;


initial begin

// запись в слэйв1 от мастера1 и чтение
	#10 req_0<=0; cmd_0<=0; addr_0<=0; wdata_0<=0;
	#20 req_0<=1; cmd_0<=1; addr_0<=1; wdata_0<=1;
	#20 req_0<=1; cmd_0<=1; addr_0<=2; wdata_0<=2;
	#20 req_0<=1; cmd_0<=1; addr_0<=3; wdata_0<=3;
	#20 req_0<=0;
	#40 req_0<=1; cmd_0<=0; addr_0<=1; wdata_0<=1;
	#20 req_0<=1; cmd_0<=0; addr_0<=2; wdata_0<=2;
	#20 req_0<=1; cmd_0<=0; addr_0<=3; wdata_0<=3;
	#20 req_0<=0;
	
// запись в слэйв1 от мастера2 и чтение	
	#80 req_1<=0; cmd_1<=0; addr_1<=0; wdata_1<=0;
	#20 req_1<=1; cmd_1<=1; addr_1<=1; wdata_1<=7;
	#20 req_1<=1; cmd_1<=1; addr_1<=2; wdata_1<=8;
	#20 req_1<=1; cmd_1<=1; addr_1<=3; wdata_1<=9;
	#20 req_1<=0;
	#40 req_1<=1; cmd_1<=0; addr_1<=3; wdata_1<=7;
	#20 req_1<=1; cmd_1<=0; addr_1<=2; wdata_1<=8;
	#20 req_1<=1; cmd_1<=0; addr_1<=1; wdata_1<=9;
	#20 req_1<=0;
	
	
	
	
// запись в слэйв2 от мастера1 и чтение	
	#160 req_0<=0; cmd_0<=0; addr_0<=2147483648; wdata_0<=0;
	#20 req_0<=1; cmd_0<=1; addr_0<=2147483649; wdata_0<=1;
	#20 req_0<=1; cmd_0<=1; addr_0<=2147483650; wdata_0<=2;
	#20 req_0<=1; cmd_0<=1; addr_0<=2147483651; wdata_0<=3;
	#20 req_0<=0;
	#40 req_0<=1; cmd_0<=0; addr_0<=2147483649; wdata_0<=1;
	#20 req_0<=1; cmd_0<=0; addr_0<=2147483650; wdata_0<=2;
	#20 req_0<=1; cmd_0<=0; addr_0<=2147483651; wdata_0<=3;
	#20 req_0<=0;

// запись в слэйв2 от мастера2 и чтение		
	#80 req_1<=0; cmd_1<=0; addr_1<=2147483648; wdata_1<=0;
	#20 req_1<=1; cmd_1<=1; addr_1<=2147483649; wdata_1<=7;
	#20 req_1<=1; cmd_1<=1; addr_1<=2147483650; wdata_1<=8;
	#20 req_1<=1; cmd_1<=1; addr_1<=2147483651; wdata_1<=9;
	#20 req_1<=0;
	#40 req_1<=1; cmd_1<=0; addr_1<=2147483651; wdata_1<=7;
	#20 req_1<=1; cmd_1<=0; addr_1<=2147483650; wdata_1<=8;
	#20 req_1<=1; cmd_1<=0; addr_1<=2147483649; wdata_1<=9;
	#20 req_1<=0;
	

// чтение из слэйва1 одновременно обоими мастерами	
	#300 req_0<=1; cmd_0<=0; addr_0<=1; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=1; wdata_1<=1;
	#20  req_0<=1; cmd_0<=0; addr_0<=2; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=2; wdata_1<=1;
	#20  req_0<=1; cmd_0<=0; addr_0<=3; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=3; wdata_1<=1;
	#20  req_0<=0; req_1<=0;
// чтение из слэйва2 одновременно обоими мастерами
	#300 req_0<=1; cmd_0<=0; addr_0<=2147483649; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=2147483649; wdata_1<=1;
	#20  req_0<=1; cmd_0<=0; addr_0<=2147483650; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=2147483650; wdata_1<=1;
	#20  req_0<=1; cmd_0<=0; addr_0<=2147483651; wdata_0<=1; req_1<=1; cmd_1<=0; addr_1<=2147483651; wdata_1<=1;
	#20  req_0<=0; req_1<=0;
	
	#200 $stop;
end

endmodule
