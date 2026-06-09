
module USR_tb();

    reg clk;
    reg rst;
    reg sin;
    reg load;
    reg [1:0] mod;
    reg [3:0] pin;
    wire sout;
    wire [3:0] pout;

    universal_shift_reg dut (.clk  (clk),
        .rst  (rst),
        .sin  (sin),
        .load (load),
        .mod  (mod),
        .pin  (pin),
        .sout (sout),
        .pout (pout)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    integer i;
    initial begin
        rst = 1; sin = 0; load = 0; mod = 2'b00; pin = 4'b0000;
        @(posedge clk);
        rst = 0;

        mod = 2'b00; load = 0;
        sin = 1; @(posedge clk);
        sin = 0; @(posedge clk);
        sin = 1; @(posedge clk);
        sin = 1; @(posedge clk);
        sin = 0; @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        rst = 1; @(posedge clk); rst = 0;
        mod = 2'b01; load = 0;
        sin = 1; @(posedge clk);
        sin = 0; @(posedge clk);
        sin = 1; @(posedge clk);
        sin = 0; @(posedge clk);

        rst = 1; @(posedge clk); rst = 0;
        mod = 2'b10; pin = 4'b1101;
        load = 1; @(posedge clk);
        load = 0; sin = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        rst = 1; @(posedge clk); rst = 0;
        mod = 2'b11; pin = 4'b1010;
        load = 1; @(posedge clk);
        pin = 4'b0101; @(posedge clk);
        load = 0; @(posedge clk);

        mod = 2'b01; sin = 1;
        @(posedge clk);
        @(posedge clk);
        rst = 1; @(posedge clk);
        rst = 0;
        $finish;
    end
endmodule
