module BCD_tb();
reg [3:0]a_tb,b_tb;
reg c_tb;
wire [3:0]sum_tb;
wire co_tb;
BCD dut(a_tb,b_tb,c_tb,sum_tb,co_tb);
initial
begin
$monitor("value of A is %b  value of B is %b  value of C is %b  value of sum is %b  value of cout is %b",a_tb,b_tb,c_tb,sum_tb,co_tb);
a_tb=3; b_tb=6; c_tb=1;#10;
a_tb=6; b_tb=8; c_tb=0;#10;
a_tb=9; b_tb=4; c_tb=0;#10;
a_tb=1; b_tb=2; c_tb=1;#10;
end
endmodule
