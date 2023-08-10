module song1 (clk,beep); //模块名称 song 
input clk; //系统时钟 50MHz 
output beep; //蜂鸣器输出端 
reg beep_r; //寄存器 
reg[7:0] state; //乐谱状态机 
reg[15:0]count,count_end; 
reg[23:0]count1; 
//乐谱参数:D=F/2K (D:参数,F:时钟频率,K:音高频率) 
parameter 
Z_0 = 16'd0,     //空白音
M_5 = 16'd31888, //中音 5 
M_6 = 16'd28409, //中音 6 
M_7 = 16'd25309, //中音 7
H_1 = 16'd23912, //高音 1 
H_2 = 16'd21282, //高音 2
H_3 = 16'd18961, //高音 3
H_4 = 16'd17897, //高音 4
H_5 = 16'd15944, //高音 5
H_6 = 16'd14204; //高音 6
parameter 
TIME = 12500000;  //1/4拍
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
if(state == 8'd210) 
state = 8'd0; 
else 
state = state + 1'b1; 
case(state) 
8'd0: count_end = H_2;     			//高音"5",持续 半个节拍 
8'd1: count_end = H_3;						//高音"3",持续  1/4个节拍 
8'd2: count_end = H_2;						//高音"4",持续 1/4 个节拍 
8'd3: count_end = H_1;     			
8'd4,8'd5: count_end = H_2;		
8'd6,8'd7: count_end = M_6;
8'd8,8'd9: count_end = M_6; 
8'd10: count_end = M_5; 
8'd11: count_end = M_5; 
8'd12,8'd13,8'd14,8'd15: count_end = Z_0; 
8'd16: count_end = H_2;     	
8'd17: count_end = H_3;						 
8'd18: count_end = H_2;						
8'd19: count_end = H_1;     			
8'd20,8'd21: count_end = H_2;		
8'd22,8'd23: count_end = M_6;
8'd24,8'd25: count_end = M_6; 
8'd26,8'd27: count_end = H_1; 
8'd28,8'd29,8'd30,8'd31: count_end = Z_0; 
8'd32: count_end = H_2;     			
8'd33: count_end = H_3;						
8'd34: count_end = H_2;						
8'd35: count_end = H_1;     			
8'd36,8'd37: count_end = H_2;		
8'd38,8'd39: count_end = M_6;
8'd40,8'd41: count_end = M_6; 
8'd42: count_end = M_5; 
8'd43: count_end = M_5; 
8'd44,8'd45,8'd46,8'd47: count_end = Z_0; 
8'd48: count_end = H_1; 
8'd49: count_end = M_7; 
8'd50: count_end = M_6; 
8'd51: count_end = M_7; 
8'd52,8'd53: count_end = M_6; 
8'd54,8'd55: count_end = M_5; 
8'd56,8'd57,8'd58,8'd59: count_end = Z_0; 
8'd60,8'd61: count_end = H_3; 
8'd62,8'd63: count_end = H_4; 
8'd64,8'd65: count_end = H_5; 
8'd66,8'd67:  count_end = H_3;
8'd68,8'd69,8'd70: count_end = H_3; 
8'd71,8'd72,8'd73,8'd74,8'd75: count_end = H_2; 
8'd76,8'd77: count_end = H_3; 
8'd78,8'd79: count_end = H_4; 
8'd80,8'd81: count_end = H_5; 
8'd82,8'd83:  count_end = H_3;
8'd84,8'd85,8'd86,8'd87: count_end = H_3;
8'd88,8'd89,8'd90,8'd91: count_end = Z_0;
8'd92,8'd93: count_end = H_3; 
8'd94,8'd95: count_end = H_4; 
8'd96,8'd97: count_end = H_5; 
8'd98,8'd99:  count_end = H_3;
8'd100,8'd101,8'd102,8'd103: count_end = H_3; 
8'd104,8'd105: count_end = H_2; 
8'd106,8'd107: count_end = H_1; 
8'd108,8'd109: count_end = H_3; 
8'd110,8'd111: count_end = H_4; 
8'd112,8'd113: count_end = H_5; 
8'd114,8'd115:  count_end = H_3;
8'd116,8'd117,8'd118,8'd119: count_end = H_3; 
8'd120,8'd121,8'd122,8'd123: count_end = H_6; 
8'd124,8'd125: count_end = H_5; 
8'd126,8'd127:  count_end = H_4;
8'd128,8'd129: count_end = H_3; 
8'd130,8'd131:  count_end = H_2;
8'd132,8'd133: count_end = H_3; 
8'd134,8'd135,8'd136,8'd137: count_end = Z_0; 
8'd138,8'd139: count_end = Z_0; 
8'd140: count_end = H_2; 
8'd141: count_end = H_1; 
8'd142: count_end = H_2; 
8'd143: count_end = H_1; 
8'd144,8'd145: count_end = H_2; 
8'd146,8'd147: count_end = H_3; 
8'd148: count_end = M_6; 
8'd149,8'd150,8'd151,8'd152,8'd153,8'd154,: count_end = M_6; 
8'd155,8'd156,8'd157,8'd158,8'd159,8'd160: count_end = Z_0;
8'd161: count_end = H_2; 
8'd162: count_end = H_1; 
8'd163,8'd164: count_end = H_2; 
8'd165,8'd166: count_end = H_3; 
8'd167: count_end = M_6; 
8'd168,8'd169,8'd170,8'd171,8'd172: count_end = M_6; 
8'd173,8'd174,8'd175: count_end = Z_0; 
8'd176,8'd177,8'd178:count_end = Z_0; 
8'd179:count_end = H_1; 
8'd180: count_end = H_2; 
8'd181: count_end = H_1; 
8'd182,8'd182: count_end = H_2; 
8'd183,8'd184,8'd185,8'd186: count_end = H_3; 
8'd187,8'd188,8'd189,8'd190: count_end = H_6; 
8'd191,8'd192: count_end = H_5; 
8'd193,8'd194: count_end = H_4; 
8'd195,8'd196: count_end = H_3; 
8'd197,8'd198: count_end = H_2; 
8'd199,8'd200,8'd201,8'd202,8'd203,8'd204,8'd205,8'd206,8'd207,8'd208,8'd209,8'd210: count_end = Z_0; 
default:count_end = 16'h0; 
endcase 
end 
end 
endmodule 