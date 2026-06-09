
module universal_shift_reg (input clk,rst,sin,load,input [1:0]mod,input [3:0]pin,output sout,output reg[3:0]pout);

    reg [3:0] sreg;
    assign sout = sreg[3];
    always @(posedge clk)
     begin
        if (rst) begin
            sreg <= 4'b0000;
            pout <= 4'b0000;
        end 
        else begin
            case (mod)
                2'b00 : begin
                    sreg <= {sreg[2:0], sin};
                    pout <= 4'b0000;
                end

                2'b01 : begin
                    sreg <= {sreg[2:0], sin};
                    pout <= {sreg[2:0], sin};
                end

                2'b10 : begin
                    if (load)
                        sreg <= pin;
                    else
                        sreg <= {sreg[2:0], 1'b0};
                    pout <= 4'b0000;
                end

                2'b11 : begin
                    if (load)
                        sreg <= pin;
                    pout <= sreg;
                end

                default : begin
                    sreg <= sreg;
                    pout <= pout;
                end
            endcase
        end
    end

endmodule
