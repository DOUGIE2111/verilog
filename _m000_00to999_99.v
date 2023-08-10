module _m000_00to999_99 (ck,ep,nrste,P,Q);
input ck,ep,nrste;
output  [7:0] P;
output  [4:0] Q;
wire fx;
wire [1:0]fy;
wire [2:0]fout;
wire [3:0]q11,q22,q33,q44,q55;
f_400hz (ck,fx); 
f_100hz (fx,fy);
_3bit_plus_mc(fx,fout);
ms_00000to99999_rst_EP (fy[1],ep,q11,q22,q33,q44,q55,nrste);
_12345_lgt (q11,q22,q33,q44,q55,fout,P); 
_2in4out (fout,Q);

endmodule
      		

module f_400hz (clk,f0);       		//400hz的时钟脉冲
input clk;
output reg  f0;
reg [16:0] scan;
always@(posedge clk)
    begin
		if(scan==62499)
			begin 
				scan<=0;
				f0<=!f0;
			end
		else   
			scan<=scan+1;
			end
endmodule

module _2bit_plus_mc(clk,out);
input clk;
output reg [1:0]out;
always@(posedge clk)
out=out+1;
endmodule


module _3bit_plus_mc(clk1,out);  //输入为400hz的脉冲，3bit加法计数器,输出位选码。
input clk1;
output reg [2:0]out;
always@(posedge clk1)
   if(out!=4)
   out[2:0]<=out[2:0]+1;
   else
   out<=0;
endmodule



module f_100hz (clk2,f2);     //100hz
	input clk2;
	output [1:0] f2;
	_2bit_plus_mc(clk2,f2);
endmodule



module ms_00000to99999_rst_EP (clk5,ep,q,scan,ta,tb,tc,nrst);
input clk5;
input ep;
input nrst;
wire fk;
output [3:0] q,scan,ta,tb,tc;
kongzhi (clk5,fk,ep);
ms_00to99 (fk,q,scan,ta,tb,tc,nrst);
endmodule


module kongzhi (clk4,I,Q);
input  Q;
input clk4;
output reg I;
always@(clk4)
begin
    if(Q==1)
	I=0;
	else
	I=clk4;
	end
endmodule


module _2in4out (slc,bit4_output);       //_3bit_plus_mcz的out作为输入，控制5个数码管的com门
output reg [4:0]  bit4_output;
input[2:0] slc;
always@(slc)
	case(slc)
		3'b000:	bit4_output=5'b01111;
		3'b001:	bit4_output=5'b10111;
		3'b010:	bit4_output=5'b11011;
		3'b011:	bit4_output=5'b11101;
		3'b100:	bit4_output=5'b11110;
		default:	 bit4_output=5'b11111;
	endcase
endmodule



module ms_00to99 (clk3,scan,q,t1,t2,t3,nrst);
input clk3;
output reg    [3:0]q;
output reg  [3:0]  scan ;
output reg [3:0]   t1,t2,t3;
input nrst;
always@(posedge clk3 or negedge nrst)
  
    begin
	   if(nrst==0)
	begin	q<=0;
		   scan<=0;
		   t1<=0;
		   t2<=0;
		   t3<=0;
			end
	else begin	if(scan==9)
			begin 
				scan<=0;
				q<=q+1;
			end
		else
		scan<=scan+1;
		if(q==9 & scan==9)
		   begin
					q<=0;
					t1<=t1+1;
		  end
		   if(t1==9 & q==9 & scan==9)
		  begin
					t1<=0;
					t2<=t2+1;
		  end
		  else if (t2==9 & scan==9 & q==9  & t1==9)
		  begin
					t2<=0;
					t3<=t3+1;
		   end
		   else if(t3==9 & scan==9 & q==9 & t1==9 & t2==9)
		   begin
		   q<=0;
		   scan<=0;
		   t1<=0;
		   t2<=0;
		   t3<=0;
		   end
			end
		end
endmodule


module _12345_lgt (q1,q2,q3,q4,q5,clk6,T);        //五个灯所选则的数字0-9.
input [3:0]q1,q2,q3,q4,q5;
input [2:0]  clk6;
output  reg [7:0] T;
wire [7:0] A,S,D,F,G;
BCD7(q1,A,clk6);
BCD7(q2,S,clk6);
BCD7(q3,D,clk6);
BCD7(q4,F,clk6);
BCD7(q5,G,clk6);
always@(clk6)
	begin 
	if(clk6==0)
	    T=A;
	else if (clk6==3'd1)
		T=S;
	else if (clk6==3'd2)
		T=D;
	else if (clk6==3'd3)
		T=F;
	else  T=G;
	end
endmodule


module BCD7(sel,out,clk6);
input [3:0]sel;
input [2:0]clk6;
output reg [7:0]out;
always@(sel)
begin if(clk6!==3'd2)
	begin
	case(sel)         
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
end
else if (clk6==3'd2)
begin
case(sel)         
		4'd0:	out=8'b0100_0000;
		4'd1:	out=8'b0111_1001;
		4'd2:	out=8'b0010_0100;
		4'd3:	out=8'b0011_0000;
		4'd4:	out=8'b0001_1001;
		4'd5:	out=8'b0001_0010;
		4'd6:	out=8'b0000_0010;
		4'd7:	out=8'b0111_1000;
		4'd8:	out=8'b0000_0000;
		4'd9:	out=8'b0001_0000;
default: out=8'b1111_1111;
endcase
end
end
endmodule