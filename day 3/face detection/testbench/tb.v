
module system_tb();
 
    reg        clk;
    reg        rst;
    reg        wrenb;
    reg  [7:0] sin;
 
    wire [7:0] dout;
    wire       dout_valid;
    wire       fifo_full;
    wire       fifo_empty;
 
    top_module dut (
        .clk        (clk),
        .rst        (rst),
        .wrenb      (wrenb),
        .sin        (sin),
        .dout       (dout),
        .dout_valid (dout_valid),
        .fifo_full  (fifo_full),
        .fifo_empty (fifo_empty)
    );
 
    initial clk = 0;
    always #5 clk = ~clk;
 
    integer k;
 
    task send_byte;
        input [7:0] data;
        begin
            @(posedge clk); #1;
            sin   = data;
            wrenb = 1;
            @(posedge clk); #1;
            wrenb = 0;
        end
    endtask
 
    initial begin
        rst   = 1;
        wrenb = 0;
        sin   = 8'h00;
 
        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0;
        $display("--------------------------------------");
        $display("         SYSTEM SIMULATION START      ");
        $display("--------------------------------------");
        $display("Time=%0t | Reset released", $time);
 
        $display("\n--- Phase 1: Writing 8 bytes into FIFO via face_sensor ---");
        for (k = 1; k <= 8; k = k + 1) begin
            if (!fifo_full) begin
                send_byte(k * 8'h11);
                $display("Time=%0t | sin=0x%02h written | fifo_full=%b fifo_empty=%b",
                         $time, k * 8'h11, fifo_full, fifo_empty);
            end else begin
                $display("Time=%0t | FIFO full, skipping write k=%0d", $time, k);
            end
        end
 
        $display("\n--- Phase 2: FSM reading FIFO, output every 3rd clock ---");
        repeat (60) begin
            @(posedge clk); #1;
            if (dout_valid)
                $display("Time=%0t | *** dout = 0x%02h | dout_valid=%b | fifo_empty=%b ***",
                         $time, dout, dout_valid, fifo_empty);
        end
 
        $display("\n--- Phase 3: Reset test ---");
        rst = 1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0;
        $display("Time=%0t | Reset applied and released | fifo_empty=%b dout_valid=%b",
                 $time, fifo_empty, dout_valid);
 
        $display("\n--- Phase 4: Write 3 bytes after reset, verify output ---");
        send_byte(8'hAA);
        send_byte(8'hBB);
        send_byte(8'hCC);
 
        repeat (20) begin
            @(posedge clk); #1;
            if (dout_valid)
                $display("Time=%0t | *** dout = 0x%02h | dout_valid=%b ***",
                         $time, dout, dout_valid);
        end
 
        #20;
        $finish;
    end
 
endmodule
