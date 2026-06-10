
module seq_detect_tb();
 reg clk_tb,rst_tb,din_tb;
 wire det_tb;
 seq_detect dut(clk_tb,din_tb,rst_tb,det_tb);
 initial
 begin
 {clk_tb,din_tb,rst_tb}=0;
 end
 always #5 clk_tb=~clk_tb;
 //sequence=111010011110
 initial
 begin
 rst_tb=1;
 #10
 rst_tb=0;
 #10
 din_tb=1;
 #10
 din_tb=1;
 #10
 din_tb=1;
 #10
 din_tb=0;
 #10
 din_tb=1;
 #10
 din_tb=0;
 #10
 din_tb=0;
 #10
 din_tb=1;
 #10
 din_tb=1;
 #10
 din_tb=1;
 #10
 din_tb=1;
 #10
 din_tb=0;
 #10
 din_tb=0;
end 
endmodule
