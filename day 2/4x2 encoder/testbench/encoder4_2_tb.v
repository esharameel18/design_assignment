module encoder4_2_tb( );
reg [3:0]i_tb;
wire [1:0]y_tb;
integer m;
encoder4_2 dut(i_tb,y_tb );
initial
begin
i_tb=4'b0000;
end
initial
begin
for(m=0;m<4;m=m+1)
begin
#10;
i_tb=4'b0000;
i_tb[m]=1'b1;
$monitor("the value of i is %b ,the value of y is %b",i_tb,y_tb);
end 
end
endmodule
