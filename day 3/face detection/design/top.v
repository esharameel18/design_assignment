

module top_module(
    input  wire       clk,
    input  wire       rst,
    input  wire       wrenb,
    input  wire [7:0] sin,
    output wire [7:0] dout,
    output wire       dout_valid,
    output wire       fifo_full,
    output wire       fifo_empty
);
 
    wire [7:0] sout;
    wire [7:0] fifo_dataout;
    wire       fsm_rdenb;
 
    face_sensor sensor_inst (
        .clk  (clk),
        .sin  (sin),
        .sout (sout)
    );
 
    fifo_face fifo_inst (
        .clk     (clk),
        .rst     (rst),
        .wrenb   (wrenb),
        .rdenb   (fsm_rdenb),
        .datain  (sout),
        .dataout (fifo_dataout),
        .full    (fifo_full),
        .empty   (fifo_empty)
    );
 
    FSM_module fsm_inst (
        .clk        (clk),
        .rst        (rst),
        .fifo_empty (fifo_empty),
        .fifo_data  (fifo_dataout),
        .fifo_rdenb (fsm_rdenb),
        .dout       (dout),
        .dout_valid (dout_valid)
    );
 
endmodule
