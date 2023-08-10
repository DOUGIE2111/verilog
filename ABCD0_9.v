module ABCD0_9(sel,out,weima);
input [3:0]sel;
output reg [7:0]out;
output reg weima = 0;
always@(sel)
case(sel)                      //共阳极
4'd0:	out=8'b1100_0000;
4'd1:	out=8'b1111_1001;
4'd2:	out=8'b1010_0100;
4'd3:	out=8'b1011_0000;
4'd4:	out=8'b1001_1001;
4'd5:	out=8'b1001_0010;
4'd6:	out=8'b1000_0010;
4'd7:	out=8'b1111_1000;
4'd8:	out=8'b1000_0000;
4'd9:	out=8'b1001_0000;
default: out=8'b1111_1111;
endcase
endmodule