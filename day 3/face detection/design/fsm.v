module FSM_module(
    input  wire       clk,
    input  wire       rst,
    input  wire       fifo_empty,
    input  wire [7:0] fifo_data,
    output reg        fifo_rdenb,
    output reg  [7:0] dout,
    output reg        dout_valid
);
 
    localparam S_CLK1 = 2'd0;
    localparam S_CLK2 = 2'd1;
    localparam S_CLK3 = 2'd2;
 
    reg [1:0] state;
    reg [1:0] next_state;
 
    always @(posedge clk) begin
        if (rst)
            state <= S_CLK1;
        else
            state <= next_state;
    end
 
    always @(*) begin
        case (state)
            S_CLK1: next_state = fifo_empty ? S_CLK1 : S_CLK2;
            S_CLK2: next_state = S_CLK3;
            S_CLK3: next_state = S_CLK1;
            default: next_state = S_CLK1;
        endcase
    end
 
    always @(posedge clk) begin
        if (rst) begin
            fifo_rdenb <= 1'b0;
            dout       <= 8'b0;
            dout_valid <= 1'b0;
        end
        else begin
            fifo_rdenb <= 1'b0;
            dout_valid <= 1'b0;
 
            case (state)
                S_CLK1: begin
                    if (!fifo_empty)
                        fifo_rdenb <= 1'b1;
                end
                S_CLK2: begin
                    fifo_rdenb <= 1'b0;
                end
                S_CLK3: begin
                    dout       <= fifo_data;
                    dout_valid <= 1'b1;
                end
            endcase
        end
    end
 
endmodule
