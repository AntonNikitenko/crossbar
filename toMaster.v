module toMaster(
	input clk, slave_0_ack, slave_1_ack,
	input [31:0] slave_0_rdata, slave_1_rdata,
	input req, addr, granted,
	output reg [31:0] rdata,
	output reg ack, req0, req1
);
	
reg req0_r, req0_rr, req0_rrr, req0_rrrr, req0_rrrrr, req1_rrrrr, req1_r, req1_rr, req1_rrr, req1_rrrr;
reg gr_r, gr_rr, gr_rrr, gr_rrrr;
always@(posedge clk) begin
	req0_r<=req0;
	req0_rr<=req0_r;
	req0_rrr<=req0_rr;
	req0_rrrr<=req0_rrr;
	req0_rrrrr<=req0_rrrr;
	
	req1_r<=req1;
	req1_rr<=req1_r;
	req1_rrr<=req1_rr;
	req1_rrrr<=req1_rrr;
	req1_rrrrr<=req1_rrrr;
	
	gr_r<=granted;
	gr_rr<=gr_r;
	gr_rrr<=gr_rr;
	gr_rrrr<=gr_rrr;
end


//формирование запросов слэйв-устройствам
always@(posedge clk) begin
	case({req, addr})
	2'b10:	begin
					req0<=1;
					req1<=0;
				end
	2'b11:	begin
					req0<=0;
					req1<=1;
				end
	default:	begin
					req0<=0;
					req1<=0;
				end
	endcase
end

//формирование сигналов мастер-устройству
always@(posedge clk) begin
if (gr_rrr) begin
	case({req1_rrrr,req0_rrrr})
	2'b01:	ack<=slave_0_ack;
	2'b10:	ack<=slave_1_ack;
	default: ack<=0;
	endcase	
	end
else begin
	ack<=0;
	end
end

always@(posedge clk) begin
if (gr_rrrr) begin
	case({req1_rrrrr,req0_rrrrr})
	2'b01:	rdata<=slave_0_rdata;
	2'b10:	rdata<=slave_1_rdata;
	default: rdata<=32'bx;
	endcase	
	end
else begin
	rdata<=32'bx;
end
end

endmodule
