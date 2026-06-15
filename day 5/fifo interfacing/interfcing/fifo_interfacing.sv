interface fifo_if;
logic clk;
logic rst;
logic wrenb;
logic rdenb;
logic [7:0]datain;
logic [7:0]dataout;
logic full;
logic empty;
endinterface

module fifo_interfacing();
fifo_if fin();
fifo dut(fin.clk,fin.rst,fin.wrenb,fin.rdenb,fin.datain,fin.dataout,fin.full,fin.empty);
initial begin
{fin.clk ,fin.rst ,fin.wrenb ,fin.rdenb ,fin.datain}=0;
end
always #5 fin.clk=~fin.clk;
initial begin
$monitor("time=%0t, rst=%b, wrenb=%b, rdenb=%b, datain=%b,dataout=%b",$time,fin.rst,fin.wrenb,fin.rdenb,fin.datain,fin.dataout);
end
initial begin
fin.rst=1;
#10
fin.rst=0;
#10
fin.wrenb=1;
fin.datain=4'b0010;
#10
fin.datain=4'b0100;
#10
fin.datain=4'b0110;
#10
fin.datain=4'b1000;
#10
fin.datain=4'b1010;
#10
fin.wrenb=0;
fin.rdenb=1;

end
endmodule
