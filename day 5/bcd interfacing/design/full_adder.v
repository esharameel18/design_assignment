module fulladder(input a,b,c, output s,co);
reg s;
reg co;
always@(*)
begin
 s=a^b^c;
 co=(a&b)|(b&c)|(c&a);
end
endmodule
