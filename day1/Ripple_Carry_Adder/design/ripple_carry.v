module ripple_carry(a,b,ci,s,co);
input [3:0]a;
input [3:0]b;
input ci;
output [3:0]s;
output co;
wire w1,w2,w3;
fulladder fulladd1(a[0],b[0],ci,s[0],w1);
fulladder fulladd2(a[1],b[1],w1,s[1],w2);
fulladder fulladd3(a[2],b[3],w2,s[2],w3);
fulladder fulladd4(a[3],b[3],w3,s[3],co);
endmodule
