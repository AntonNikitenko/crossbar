module toMaster(
	input clk, slave_0_resp, slave_1_resp,
	input [31:0] slave_0_rdata, slave_1_rdata,
	input req, addr, granted,
	output reg [31:0] rdata,
	output reg resp
);

reg req0, req1;	
reg req0_r, req0_rr, req1_r, req1_rr;
reg gr_r, gr_rr;
always@(posedge clk) begin
	req0_r<=req0;
	req0_rr<=req0_r;
	
	req1_r<=req1;
	req1_rr<=req1_r;
	
	gr_r<=granted;
	gr_rr<=gr_r;
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
if (gr_r) begin
	case({req1_r,req0_r})
	2'b01:	begin
					resp<=slave_0_resp;
				end
	2'b10:	begin
					resp<=slave_1_resp;
				end
	default: begin
					resp<=0;
				end
	endcase	
	end
else begin
	resp<=0;
	end
end

always@(posedge clk) begin
if (gr_r) begin
	case({req1_r,req0_r})
	2'b01:	begin
					rdata<=slave_0_rdata;
				end
	2'b10:	begin
					rdata<=slave_1_rdata;
				end
	default: begin
					rdata<=32'bx;
				end
	endcase	
	end
else begin
	rdata<=32'bx;
	end
end
endmodule
