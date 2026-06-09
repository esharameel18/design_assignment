module ripple_carry_tb();
reg [3:0]a_tb;
reg [3:0]b_tb;
reg cin_tb;
wire [3:0]sum_tb;
wire co;

ripple_carry dut(a_tb,b_tb,cin_tb,sum_tb,co_tb);

initial begin
cin_tb = 0;
a_tb = 4'b0110;
b_tb = 4'b1100;
#10
a_tb = 4'b1110;
b_tb = 4'b1000;
#10
a_tb = 4'b0111;
b_tb = 4'b1110;
#10
a_tb = 4'b0010;
b_tb = 4'b1001;
#10
$finish();
end              
endmodule
