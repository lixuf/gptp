module  tempalet(
input [7:0] send_addr,
input [79:0] send_data,
output [351:0] gptp_ts_data
);


wire [3:0] massagetype=({4{send_addr[0]}}&4'h0)
							  |({4{send_addr[1]}}&4'h8)
							  |({4{send_addr[2]}}&4'h2)
							  |({4{send_addr[3]}}&4'h3)
							  |({4{send_addr[4]}}&4'ha)
							  ;
wire [271:0] head={268'd0,massagetype};
assign gptp_ts_data={send_data,head};

endmodule
