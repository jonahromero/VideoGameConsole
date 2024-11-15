

`timescale 1ns / 1ps
`default_nettype none // prevents system from inferring an undeclared logic (good practice)
 
module bit_counter
#(parameter SIZE)
(
    input wire[SIZE-1:0] data_in,
    output logic[$clog2(SIZE+1)-1:0] ones_out,
    output logic[$clog2(SIZE+1)-1:0] zeros_out
);
    always_comb begin
        ones_out = 0;
        for (integer i = 0; i < SIZE; i++) begin
            ones_out += data_in[i];
        end
        zeros_out = SIZE - ones_out;
    end
endmodule

module tm_choice (
  input wire [7:0] data_in,
  output logic [8:0] qm_out
);

    logic[$clog2(9)-1:0] one_count;
    always_comb begin
        one_count = 0;
        for (integer i = 0; i < 8; i++) begin
            one_count += data_in[i];
        end
        qm_out[0] = data_in[0];
        if (one_count > 4 || (one_count == 4 && !data_in[0])) begin
            for (integer i = 1; i < 8; i++) begin
                qm_out[i] = !(qm_out[i-1] ^ data_in[i]);
            end
            qm_out[8] = 0;
        end
        else begin
            for (integer i = 1; i < 8; i++) begin
                qm_out[i] = qm_out[i-1] ^ data_in[i];
            end
            qm_out[8] = 1;
        end
    end
endmodule

module tmds_encoder(
  input wire clk_in,
  input wire rst_in,
  input wire [7:0] data_in,  // video data (red, green or blue)
  input wire [1:0] control_in, //for blue set to {vs,hs}, else will be 0
  input wire ve_in,  // video data enable, to choose between control or video signal
  output logic [9:0] tmds_out
);
 
    logic [8:0] q_m;
    logic [4:0] tally;
    // helper variables
    logic is_count_neg, is_count_pos;
    logic[3:0] qm_ones, qm_zeros;
    assign is_count_neg = tally[4] == 1 && tally != 0;
    assign is_count_pos = tally[4] == 0 && tally != 0;
    bit_counter #(.SIZE(8)) mbc(.data_in(q_m[7:0]), .ones_out(qm_ones), .zeros_out(qm_zeros));

    tm_choice mtm(
    .data_in(data_in),
    .qm_out(q_m));
 
  //your code here.
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            tmds_out <= 0;
            tally <= 0;
        end
        else if(!ve_in) begin
            tally <= 0;
            case (control_in)
            2'b00: tmds_out <= 10'b1101010100;
            2'b01: tmds_out <= 10'b0010101011;
            2'b10: tmds_out <= 10'b0101010100;
            2'b11: tmds_out <= 10'b1010101011;
            endcase
        end
        else begin
            if (tally == 0 || (qm_ones == qm_zeros)) begin
                tmds_out[9] <= ~q_m[8];
                tmds_out[8] <= q_m[8];
                tmds_out[7:0] <= q_m[8] ? q_m[7:0] : ~q_m[7:0];
                if (q_m[8] == 0) begin
                    tally <= tally + (qm_zeros - qm_ones);
                end
                else begin
                    tally <= tally + (qm_ones - qm_zeros);
                end
            end
            else begin
                if ((is_count_pos && qm_ones > qm_zeros) || (is_count_neg && qm_zeros > qm_ones)) begin
                    tmds_out[9] <= 1;
                    tmds_out[8] <= q_m[8];
                    tmds_out[7:0] <= ~q_m[7:0];
                    tally <= tally + 2 * q_m[8] + (qm_zeros - qm_ones);
                end
                else begin
                    tmds_out[9] <= 0;
                    tmds_out[8] <= q_m[8];
                    tmds_out[7:0] <= q_m[7:0];

                    tally <= tally - (2 * (!q_m[8])) + (qm_ones - qm_zeros);
                end
            end
        end
    end

endmodule
 
`default_nettype wire
