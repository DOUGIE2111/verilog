module EXP_Gate (A,B,C1,C2,C3,C4);
input A,B;
output C1,C2,C3,C4;
assign C1= A|B;
assign C2= A^B;
assign C3= ~(A&B);
assign C4= ~(A|B);
endmodule