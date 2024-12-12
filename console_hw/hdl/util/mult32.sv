`timescale 1ns / 1ps
`default_nettype none

module mult32(
    input wire clk_in,
    input wire rst_in,
    input wire [31:0] a,
    input wire [31:0] b,
    input  AluFunc alufunc,
    
    output logic [31:0] data_out
    );

    
    always_ff @(posedge clk_in) begin
        if(rst_in) data_out <= 32'b0;
        else begin
            case (alufunc)
                MUL: data_out <= $signed(a) * $signed(b);
                MULH: data_out <= ($signed(a) * $signed(b)) >>> 32;
                MULHU: data_out <= (a * b) >>> 32;
                MULHSU: data_out <= ($signed(a) << 1 * $signed({1'b0, b})) >>> 34;
                default: data_out <= 32'b0;
            endcase
        end
    end

endmodule

`default_nettype wire