module mo_0_9 (clk,selectout,select);
input clk;
output [3:0]select;
output[7:0]selectout;
wire f;
wire [1:0]fout;
 _25bit_plus_mc_0 (clk,f);
add(f,fout);
_2to4(fout,select);
 BCD7 (select,selectout);
endmodule

module _25bit_plus_mc_0(clk,f);  //200hz
input clk;
output reg f;
reg [24:0] scan;
always@(posedge clk)
begin
if(scan == 125000)
begin
  scan <= 0;
  f <= ~f;
 end
 else scan <=1+scan;
 end
endmodule

module add(clk,f);   //2加法器
input clk;
output [1:0]f;
reg [5:0] scan;
always@(posedge clk)
begin
if(scan == 2'b11)
scan <=0;
else scan <=scan +1;
end
endmodule


module _2to4(A,out);  //2to4译码器  
input [1:0]A;
output reg [3:0] out;
always@(A)
case(A)
2'd0: out = 4'b1110;
2'd1: out = 4'b1101;
2'd2: out = 4'b1011;
2'd3: out = 4'b0111;
endcase
endmodule


module BCD7 (selectBCD,BCD_out);    //四选一控制BCD的4个灯，0，1，2，3.
input [3:0]selectBCD;
output reg [7:0] BCD_out;
always@(selectBCD)
case(selectBCD)                      //共阳极
4'd0:	BCD_out=8'b1100_0000;
4'd1:	BCD_out=8'b1111_1001;
4'd2:	BCD_out=8'b1010_0100;
4'd3:	BCD_out=8'b1011_0000;
4'd4:	BCD_out=8'b1001_1001;
4'd5:	BCD_out=8'b1001_0010;
4'd6:	BCD_out=8'b1000_0010;
4'd7:	BCD_out=8'b1111_1000;
4'd8:	BCD_out=8'b1000_0000;
4'd9:	BCD_out=8'b1001_0000;
default: BCD_out=8'b1111_1111;
endcase
endmodule
