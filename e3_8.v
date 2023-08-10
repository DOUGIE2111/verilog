module e3_8 (sel,out);
input [2:0]sel;
output reg [7:0]out;
always@(sel)
case(sel)                      //共阳极
3'd0:	out=8'b1111_1110;
3'd1:	out=8'b1111_1101;
3'd2:	out=8'b1111_1011;
3'd3:	out=8'b1111_0111;
3'd4:	out=8'b1110_1111;
3'd5:	out=8'b1101_1111;
3'd6:	out=8'b1011_1111;
3'd7:	out=8'b0111_1111;
default: out=8'b1111_1111;
endcase
endmodule
