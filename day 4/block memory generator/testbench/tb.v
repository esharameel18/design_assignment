module mem_generator_tb();
reg clk_tb,arstn_tb,wr_en_tb;
reg [2:0]wr_add_tb,rd_add_tb;
reg [7:0]datain_tb;
wire [7:0] dataout_tb;
mem_generator dut(clk_tb,arstn_tb,wr_en_tb,wr_add_tb,rd_add_tb,datain_tb,dataout_tb);
initial
begin
{clk_tb,wr_en_tb,wr_add_tb,rd_add_tb,datain_tb}=0;
arstn_tb=1;
end
 always #5 clk_tb=~clk_tb;
initial
begin
arstn_tb=0;
#10;
arstn_tb=1;
#10;
wr_en_tb=1;
wr_add_tb=3'b001;
datain_tb=8'b00000001;
#10;
wr_add_tb=3'b011;
datain_tb=8'b00000101;
#10;
wr_add_tb=3'b101;
datain_tb=8'b00001111;
#10;
wr_en_tb=0;
rd_add_tb=3'b001;
#10;
rd_add_tb=3'b011;
#10;
rd_add_tb=3'b101;
end
endmodule
