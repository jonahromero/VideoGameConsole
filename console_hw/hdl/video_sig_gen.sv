module video_sig_gen
#(
  parameter ACTIVE_H_PIXELS = 1280,
  parameter H_FRONT_PORCH = 110,
  parameter H_SYNC_WIDTH = 40,
  parameter H_BACK_PORCH = 220,

  parameter ACTIVE_LINES = 720,
  parameter V_FRONT_PORCH = 5,
  parameter V_SYNC_WIDTH = 5,
  parameter V_BACK_PORCH = 20,
  parameter FPS = 60)
(
  input wire pixel_clk_in,
  input wire rst_in,
  output logic [$clog2(TOTAL_WIDTH)-1:0] hcount_out,
  output logic [$clog2(TOTAL_LINES)-1:0] vcount_out,
  output logic vs_out, //vertical sync out
  output logic hs_out, //horizontal sync out
  output logic ad_out,
  output logic nf_out, //single cycle enable signal
  output logic [5:0] fc_out  //frame
);

    localparam TOTAL_LINES = ACTIVE_LINES +  V_FRONT_PORCH + V_SYNC_WIDTH + V_BACK_PORCH; //figure this out
    localparam TOTAL_WIDTH = (ACTIVE_H_PIXELS + H_FRONT_PORCH + H_SYNC_WIDTH + H_BACK_PORCH);
    logic old_rst_in;

    always_ff @(posedge pixel_clk_in) begin
        old_rst_in <= rst_in;
        if (rst_in) begin
            hcount_out <= 0;
            vcount_out <= 0;

            vs_out <= 0;
            hs_out <= 0;
            ad_out <= 0;
            nf_out <= 0;
            fc_out <= 0;
        end
        else begin
            if (old_rst_in) begin
                ad_out <= 1;
            end
            hcount_out <= hcount_out + 1;
            case(hcount_out)
                ACTIVE_H_PIXELS - 1: begin
                    ad_out <= 0;
                end
                ACTIVE_H_PIXELS + H_FRONT_PORCH - 1: begin
                    hs_out <= 1;
                end
                ACTIVE_H_PIXELS + H_FRONT_PORCH + H_SYNC_WIDTH - 1: begin
                    hs_out <= 0;
                end
                TOTAL_WIDTH - 1: begin
                    hcount_out <= 0;
                    hs_out <= 0;
                    ad_out <= vcount_out < ACTIVE_LINES - 1 ? 1 : 0;
                    vcount_out <= vcount_out + 1;
                    case (vcount_out)
                    ACTIVE_LINES - 1: begin
                        ad_out <= 0;
                    end
                    ACTIVE_LINES + V_FRONT_PORCH - 1: begin
                        vs_out <= 1;
                    end
                    ACTIVE_LINES + V_FRONT_PORCH + V_SYNC_WIDTH - 1: begin
                        vs_out <= 0;
                    end
                    TOTAL_LINES - 1: begin
                        vcount_out <= 0;
                        ad_out <= 1;
                    end
                    endcase
                end
            endcase

            if (vcount_out == ACTIVE_LINES && hcount_out == ACTIVE_H_PIXELS - 1) begin
                nf_out <= 1;
                fc_out <= fc_out + 1;
            end
            if (nf_out) begin
                nf_out <= 0;
            end
        end
    end

endmodule