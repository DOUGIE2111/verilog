module LED_1to4_mov (clk1,YOUT,BCD_out); //主程序

input clk1 ; //50Mhz时钟脉冲

output  [3:0] YOUT; //2-4译码器选择数字0-3

output  [7:0] BCD_out;

wire [1:0]out; //点亮数码管a-h

wire clk;
 clk200hz (clk1,clk);

_2bit_plus_mc(clk,out[1:0]);

 u4_to_1 (out[1:0],YOUT);

 BCD7(out[1:0],BCD_out);

 endmodule

 

 

 

module clk200hz (tim,f);

input tim;

output reg f;

reg [25:0]scan ;

always@(posedge tim)

 begin  

  if(scan==500000)  

  begin

  scan <=0 ; 

  f <=!f;

  end

 else   

 scan<=scan+1;

  end

 endmodule

 

 

 

 

 

module _2bit_plus_mc(clk,out[1:0]); //2bit加法计数器

input clk;

output reg [1:0]out;

always@(posedge clk)

out[1:0]<=out[1:0]+1;

endmodule

 

 

 

 module u4_to_1 (sel,Y); //四选一控制BCD_7亮灯

  input [1:0]sel;

  output reg [3:0] Y;

   always@(sel)

   case(sel)

   2'b00: Y<=4'b0111;

   2'b01: Y<=4'b1011;

   2'b10: Y<=4'b1101;

   2'b11: Y<=4'b1110;

   endcase

endmodule

 


module BCD7(selectBCD,BCD_out); //四选一控制BCD的4个灯，1，2，3,4

input [3:0]selectBCD;

output reg [7:0]BCD_out;

always@(selectBCD)

case(selectBCD) //共阳极

 

4'd0: BCD_out=8'b1111_1001;

4'd1: BCD_out=8'b1010_0100;

4'd2: BCD_out=8'b1011_0000;

4'd3: BCD_out=8'b1001_1001;

 

default: BCD_out=8'b1111_1111;

endcase

endmodule
