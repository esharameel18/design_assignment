module fifo_face(
    input  wire       clk,
    input  wire       rst,
    input  wire       wrenb,
    input  wire       rdenb,
    input  wire [7:0] datain,
    output reg  [7:0] dataout,
    output wire       full,
    output wire       empty
);
 
    reg [7:0] mem [0:7];
    reg [2:0] wr_ptr;
    reg [2:0] rd_ptr;
    reg [3:0] count;
    integer i;
 
    assign full  = (count == 4'd8);
    assign empty = (count == 4'd0);
 
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 8'b0;
            wr_ptr  <= 3'd0;
            rd_ptr  <= 3'd0;
            count   <= 4'd0;
            dataout <= 8'b0;
        end
        else begin
            if (wrenb && !full && rdenb && !empty) begin
                mem[wr_ptr] <= datain;
                wr_ptr      <= wr_ptr + 3'd1;
                dataout     <= mem[rd_ptr];
                rd_ptr      <= rd_ptr + 3'd1;
            end
            else if (wrenb && !full) begin
                mem[wr_ptr] <= datain;
                wr_ptr      <= wr_ptr + 3'd1;
                count       <= count + 4'd1;
            end
            else if (rdenb && !empty) begin
                dataout <= mem[rd_ptr];
                rd_ptr  <= rd_ptr + 3'd1;
                count   <= count - 4'd1;
            end
        end
    end
endmodule
