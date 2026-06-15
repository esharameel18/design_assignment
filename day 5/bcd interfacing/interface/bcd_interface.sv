interface bcd_if;
logic [3:0]A;
logic [3:0]B;
logic C;
logic [3:0]sum;
logic cout;
endinterface

module bcd_interface();
bcd_if bcdif();
BCD dut(bcdif.A,bcdif.B,bcdif.C,bcdif.sum,bcdif.cout);
initial
begin
$monitor("Time: %0t | value of A is %b | value of B is %b | value of C is %b | value of sum is %b | value of cout is %b",$time,bcdif.A,bcdif.B,bcdif.C,bcdif.sum,bcdif.cout);
bcdif.A=3; bcdif.B=6; bcdif.C=1;#10;
bcdif.A=6; bcdif.B=8; bcdif.C=0;#10;
bcdif.A=9; bcdif.B=4; bcdif.C=0;#10;
bcdif.A=1; bcdif.B=2; bcdif.C=1;#10;
#20
$finish();
end
endmodule
