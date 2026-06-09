module sr_ff(input s,r,rst,en,clk,output reg q,qbar);
always@(posedge clk)
begin
if(en)begin
  if(rst)begin
  q<=1'b0;
  qbar<=1'b1;
  end
  else if(s==0&&r==0)begin
  q<=q;
  qbar<=qbar;
  end
  else if(s==0&&r==1)begin
  q<=1'b0;
  qbar<=1'b1;
  end
  else if(s==1&&r==0)begin
  q<=1'b1;
  qbar<=1'b0;
  end
  else if(s==1&&r==1) begin
  q<=1'bx;
  qbar<=1'bx;
  end
end
end
endmodule
