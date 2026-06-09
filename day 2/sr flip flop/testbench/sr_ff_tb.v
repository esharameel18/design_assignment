module sr_ff_tb();
reg s_tb, r_tb, rst_tb, en_tb, clk_tb;
wire q_tb, qbar_tb;

sr_ff dut(.s(s_tb),.r(r_tb),.rst(rst_tb),.en(en_tb),.clk(clk_tb),.q(q_tb),.qbar(qbar_tb));

always #5 clk_tb = ~clk_tb;
initial 
begin
    clk_tb = 0;
    s_tb = 0; r_tb = 0; rst_tb = 0; en_tb = 0;
    
    #10 en_tb = 1; rst_tb = 1;
    #10 rst_tb = 0;
    
    #10 s_tb = 0; r_tb = 0;
    #10 s_tb = 0; r_tb = 1;
    #10 s_tb = 1; r_tb = 0;
    #10 s_tb = 1; r_tb = 1;
    
    #10 en_tb = 0;
    #10 s_tb = 1; r_tb = 0;
    #10 s_tb = 0; r_tb = 1;
    
    #10 en_tb = 1; rst_tb = 1;
    #10 rst_tb = 0;
    #10 s_tb = 1; r_tb = 0;
    #10 s_tb = 0; r_tb = 1;
    #10 s_tb = 0; r_tb = 0;
    #10 s_tb = 1; r_tb = 1;

end

initial 
begin
$monitor($time," clk=%b en=%b rst=%b s=%b r=%b | q=%b qbar=%b",clk_tb, en_tb, rst_tb, s_tb, r_tb, q_tb, qbar_tb);
end
endmodule
