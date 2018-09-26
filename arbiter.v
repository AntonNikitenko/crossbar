module arbiter(
	input clk, req0, req1,
	output reg grant0, grant1
);

reg [1:0] mask=2'b01;

always@(posedge clk) begin
	case({req1,req0})
	2'b00:	begin
					grant0<=0;
					grant1<=0;
				end
	2'b01:	begin
					grant0<=1;
					grant1<=0;
				end
	2'b10:	begin
					grant0<=0;
					grant1<=1;
				end
	2'b11:	begin
					grant0<=mask[0];
					grant1<=mask[1];
					mask<=~mask;
				end
	endcase
end
endmodule
