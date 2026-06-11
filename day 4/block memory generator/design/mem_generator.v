module mem_generator(input clk,arstn,wr_en,input [2:0]wr_add,rd_add,input [7:0]datain, output reg[7:0]dataout );
reg [7:0] mem[7:0];
integer i;
always@(posedge clk or negedge arstn)
begin
if(!arstn)begin
for(i=0;i<8;i=i+1)
  mem[i]<=0;
dataout<=0;
end
else if(wr_en==1)begin
  mem[wr_add]<=datain;
end
else begin
  dataout<=mem[rd_add];
end
end
endmodule
