module d_ff(d,rst,clk,q,qbar); 
input d, clk, rst; 
output reg q, qbar; 
always@(posedge clk) 
begin
if(rst== 1)begin
q <= 1'b0;
qbar <= 1'b1;
end
else if (d==0)begin
q <= 1'b0; 
qbar = 1'b1; 
end
else if (d==1)begin
q <= 1'b1; 
qbar = 1'b0; 
end
end 
endmodule
