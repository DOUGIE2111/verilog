module kanong (clk,beep,Q);
		song (I,beep);
		kongzhi (clk,I,Q);
input clk,Q;
output beep;
wire I;
endmodule

module song (clk,beep); //模块名称 song 
input clk; //系统时钟 50MHz 
output beep; //蜂鸣器输出端 
reg beep_r; //寄存器 
reg[7:0] state; //乐谱状态机 
reg[15:0]count,count_end; 
reg[23:0]count1; 
//乐谱参数:D=F/2K (D:参数,F:时钟频率,K:音高频率) 
parameter 
M_1 = 16'd47774, //中音 1 
M_2 = 16'd42567, //中音 2 
M_3 = 16'd37919, //中音 3 
M_4 = 16'd35791, //中音 4
M_5 = 16'd31888, //中音 5 
M_6 = 16'd28409, //中音 6 
M_7 = 16'd25309, //中音 7
H_1 = 16'd23912, //高音 1 
H_2 = 16'd21282, //高音 2
H_3 = 16'd18961, //高音 3
H_4 = 16'd17897, //高音 4
H_5 = 16'd15944; //高音 5
parameter 
TIME = 6250000;  //1/4拍
assign beep = beep_r; //输出音乐 
//   数控分频器，分频比由count_end决定//
always@(posedge clk) 
begin 
count <= count + 1'b1; //计数器加1，知道满足hz条件，作为蜂鸣器的输入频率
if(count == count_end) 
begin 
count <= 16'h0; //计数器清零
beep_r <= !beep_r; //输出取反，beep_r的值为0，取反为1，阻塞输入，本身值不变.
end 
end 

always @(posedge clk) 
begin 
if(count1 < TIME) //1/4拍 62.5mS 
count1 = count1 + 1'b1; 
else 
begin 
count1 = 24'd0; 
if(state == 8'd127) 
state = 8'd0; 
else 
state = state + 1'b1; 
case(state) 
8'd0,8'd1: count_end = H_5;     			//高音"5",持续 半个节拍 
8'd2: count_end = H_3;						//高音"3",持续  1/4个节拍 
8'd3: count_end = H_4;						//高音"4",持续 1/4 个节拍 
8'd4,8'd5: count_end = H_5;     			
8'd6: count_end = H_3;		
8'd7: count_end = H_4;
8'd8: count_end = H_5; 
8'd9: count_end = M_5; 
8'd10: count_end = M_6; 
8'd11: count_end = M_7; 
8'd12: count_end = H_1; 
8'd13: count_end = H_2; 
8'd14: count_end = H_3; 
8'd15: count_end = H_4; 
8'd16,8'd17: count_end = H_3; 
8'd18: count_end = H_1; 
8'd19: count_end = H_2; 
8'd20,8'd21: count_end = H_3; 
8'd22: count_end = M_3; 
8'd23: count_end = M_4; 
8'd24: count_end = M_5; 
8'd25: count_end = M_6; 
8'd26: count_end = M_5; 
8'd27: count_end = M_4; 
8'd28: count_end = M_5; 
8'd29: count_end = M_3; 
8'd30: count_end = M_4; 
8'd31: count_end = M_5; 
8'd32,8'd33: count_end = M_4; 
8'd34: count_end = M_6; 
8'd35: count_end = M_5; 
8'd36,8'd37: count_end = M_4; 
8'd38: count_end = M_3; 
8'd39: count_end = M_2; 
8'd40: count_end = M_3; 
8'd41: count_end = M_2; 
8'd42: count_end = M_1; 
8'd43: count_end = M_2; 
8'd44: count_end = M_3; 
8'd45: count_end = M_4; 
8'd46: count_end = M_5; 
8'd47: count_end = M_6; 
8'd48,8'd49: count_end = M_4; 
8'd50: count_end = M_6; 
8'd51: count_end = M_5; 
8'd52,8'd53: count_end = M_6; 
8'd54: count_end = M_7; 
8'd55: count_end = H_1; 
8'd56: count_end = M_5; 
8'd57: count_end = M_6; 
8'd58: count_end = M_7; 
8'd59: count_end = H_1;  
8'd60: count_end = H_2; 
8'd61: count_end = H_3; 
8'd62: count_end = H_4; 
8'd63: count_end = H_5; 
8'd64,8'd65: count_end = H_3; 
8'd66: count_end = H_1; 
8'd67: count_end = H_2; 
8'd68,8'd69: count_end = H_3; 
8'd70: count_end = H_2; 
8'd71: count_end = H_1; 
8'd72:count_end = H_2; 
8'd73:count_end = M_7; 
8'd74:count_end = H_1; 
8'd75:count_end = H_2;
8'd76:count_end = H_3; 
8'd77:count_end = H_2; 
8'd78:count_end = H_1; 
8'd79:count_end = M_7; 
8'd80,8'd81: count_end = H_1; 
8'd82: count_end = M_6; 
8'd83: count_end = M_7; 
8'd84,8'd85: count_end = H_1; 
8'd86: count_end = M_1; 
8'd87: count_end = M_2; 
8'd88: count_end = M_3; 
8'd89: count_end = M_4; 
8'd90: count_end = M_3; 
8'd91: count_end = M_2; 
8'd92: count_end = M_3; 
8'd93: count_end = H_1; 
8'd94: count_end = M_7; 
8'd95: count_end = H_1; 
8'd96,8'd97: count_end = M_6; 
8'd98: count_end = H_1; 
8'd99: count_end = M_7; 
8'd100,8'd101: count_end = M_6; 
8'd102: count_end = M_5; 
8'd103: count_end = M_4; 
8'd104: count_end = M_5; 
8'd105: count_end = M_4; 
8'd106: count_end = M_3; 
8'd107: count_end = M_4;
8'd108: count_end = M_5; 
8'd109: count_end = M_6; 
8'd110: count_end = M_7; 
8'd111: count_end = H_1; 
8'd112,8'd113: count_end = M_6; 
8'd114: count_end = H_1; 
8'd115: count_end = M_7;
8'd116,8'd117: count_end = H_1; 
8'd118: count_end = M_7; 
8'd119: count_end = M_6; 
8'd120: count_end = M_7; 
8'd121: count_end = H_1; 
8'd122: count_end = H_2; 
8'd123: count_end = H_1; 
8'd124: count_end = M_7; 
8'd125: count_end = H_1; 
8'd126: count_end = M_6; 
8'd127: count_end = M_7; 
default:count_end = 16'h0; 
endcase 
end 
end 
endmodule 

module kongzhi (clk1,I,Q);
input  Q;
input clk1;
output reg I;
always
begin
    if(Q==1)
	I=0;
	else
	I=clk1;
	end
endmodule