
module seq_detect(input clk,din,rst,output reg det);
    parameter idle=2'b00;
    parameter s1=2'b01;
    parameter s2=2'b10;
    parameter s3=2'b11;
    reg [1:0]ps,ns;
    //present state logic
    always@(posedge clk)
    begin
    if(rst)begin
    ps<=idle;
    end
    else
    ps<=ns;
    end
    //next state logic
    always@(*)
    //overlapping seq detector
    begin
    case(ps)
    idle: begin
          det=0;
          if(din==0)
            ns=idle;
          else 
            ns=s1;
      end
      s1: begin
          det=0;
          if(din==0)
           ns=idle;
          else
           ns=s2;
          end
       s2: begin
           det=0;
           if(din==0)
             ns=idle;
           else
             ns=s3;
           end
       s3: begin
           if(din==0)begin
             det=1;
             ns=idle;
             end
           else
             ns=s3;
           end
      default: begin
            det=0;
            ns=idle;
            end
      endcase       
    end
    
endmodule
