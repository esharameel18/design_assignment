module BCD(input [3:0]A,[3:0]B,input C,output [3:0]sum,output cout);
wire w1,w2,w3,w4;
wire [3:0]sum1;
wire [3:0]corr;
ripple_carry R1(A,B,C,sum1,w1);
and(w2,sum1[1],sum1[3]);
and(w3,sum1[2],sum1[3]);
or(w4,w2,w3,w1);
assign corr={1'b0,w4,w4,1'b0};
ripple_carry R2(sum1,corr,1'b0,sum,cout);
endmodule
