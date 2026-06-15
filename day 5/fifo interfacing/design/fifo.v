
module fifo(input clk,rst,wrenb,rdenb,input[7:0]datain,output reg[7:0]dataout,output reg full,empty);
reg [7:0]mem[7:0];
reg [2:0] wr_ptr=0;
reg [2:0] rd_ptr=0;
integer i;
always@(posedge clk)
begin
if(rst)begin
   for(i=0;i<8;i=i+1)
     mem[i]<=0;
end
else if(wrenb==1&&full==0)begin
mem[wr_ptr]<=datain;
wr_ptr<=wr_ptr+1;
end
else if(rdenb==1&&empty==0)begin
dataout<=mem[rd_ptr];
rd_ptr<=rd_ptr+1;
end
assign full=((wr_ptr+3'b001)==rd_ptr)?1'b1:1'b0;
assign empty=(wr_ptr==rd_ptr)?1'b1:1'b0;
 
end
endmodule
