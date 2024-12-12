`timescale 1ns / 1ps
`default_nettype none

module video_renderer(
    input wire clk_in,
    input wire rst_in,
    input wire [10:0] hcount_hdmi,
    input wire [9:0]  vcount_hdmi,
    input wire [31:0] pc_in,
    input wire [31:0] reg_file [31:0],
    input wire debug_mode,

    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue,

    frame_buffer_bus.READ bus
);

    typedef struct {
    logic [3:0] data;
    logic isValid;
    } Maybe;
    typedef enum  { GAME, ASCII } drw_state;

    logic [6:0][4:0] bit_map;
    logic [3:0] bit_map_col, bit_map_row;
    logic [7:0] chr_idx;
    Maybe half_byte;

    logic [2:0] symbolic_idx;
    logic [4:0] val_idx;
    
    drw_state draw;
    logic [5:0] v_idx;
    logic [6:0] h_idx;
    logic busy;
    
    


    ascii_tbl regTbl (.ascii_idx(chr_idx), .ascii_map_out(bit_map));
    
    always_comb begin
        v_idx = vcount_hdmi >> 4;
        h_idx = hcount_hdmi >> 4;
        bit_map_col = hcount_hdmi[3:0];
        bit_map_row = vcount_hdmi[3:0];
        
        if (h_idx < 5) symbolic_idx = h_idx;
        else symbolic_idx = 3'd5;
        
        if (h_idx >= 5 && h_idx < 16) val_idx = h_idx;
        else val_idx =  5'd16;
        half_byte = '{data: 'x, isValid:1'b0};
        if (debug_mode && (v_idx < 32) && (h_idx < 16)) draw = ASCII; 
        else draw = GAME;
        if ((draw == ASCII)) begin   
            if(busy) begin
                if ((bit_map_row < 4'd14) && (bit_map_col < 4'd10)) begin
                    if (bit_map[bit_map_row >> 1][bit_map_col >> 1]) begin
                        red = 8'hFF;
                        green = 8'hFF;
                        blue = 8'hFF;
                    end else begin
                        red = 8'h00;
                        green = 8'h00;
                        blue = 8'h00;
                    end
                end else begin
                    red = 8'h00;
                    green = 8'h00;
                    blue = 8'h00;
                end
            end else if (symbolic_idx < 5) begin
                case (v_idx)
                5'd0: begin
                    case (symbolic_idx)
                        3'd0: chr_idx = 8'h7A;
                        3'd1: chr_idx = 8'h65;
                        3'd2: chr_idx = 8'h72;
                        3'd3: chr_idx = 8'h6F;
                        3'd4: chr_idx = 8'h3A;
                        default: ;
                    endcase
                end
                5'd1:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h72;
                        3'd3: chr_idx = 8'h61;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd2:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h70;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd3:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h67;
                        3'd3: chr_idx = 8'h70;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd4:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h70;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd5:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h30;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd6:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h31;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd7:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h32;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd8:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h30;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd9:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h31;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd10:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h30;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd11:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h31;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd12:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h32;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd13:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h33;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd14:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h34;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd15:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h35;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd16:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h36;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd17:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h61;
                        3'd3: chr_idx = 8'h37;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd18:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h32;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd19:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h33;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd20:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h34;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd21:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h35;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd22:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h36;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd23:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h37;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd24:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h38;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd25:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h73;
                        3'd3: chr_idx = 8'h39;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd26:
                    case (symbolic_idx)
                        3'd1: chr_idx = 8'h73;
                        3'd2: chr_idx = 8'h31;
                        3'd3: chr_idx = 8'h30;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd27:
                    case (symbolic_idx)
                        3'd1: chr_idx = 8'h73;
                        3'd2: chr_idx = 8'h31;
                        3'd3: chr_idx = 8'h31;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd28:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h33;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd29:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h34;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd30:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h35;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                5'd31:
                    case (symbolic_idx)
                        3'd2: chr_idx = 8'h74;
                        3'd3: chr_idx = 8'h36;
                        3'd4: chr_idx = 8'h3A;
                        default: chr_idx = 8'h20;
                    endcase
                // 5'd32:
                //     case (symbolic_idx)
                //         3'd2: chr_idx = 8'h70;
                //         3'd3: chr_idx = 8'h63;
                //         3'd4: chr_idx = 8'h3A;
                //         default: chr_idx = 8'h20;
                //     endcase
                default: ;
                endcase
            end else if (val_idx < 16) begin
                
                case (val_idx)
                    4'd5: chr_idx = 8'h30;
                    4'd6: chr_idx = 8'h78;
                    4'd7: half_byte = '{data:reg_file[v_idx][31:28], isValid:1'b1};
                    4'd8: half_byte = '{data:reg_file[v_idx][27:24], isValid:1'b1};
                    4'd9: half_byte = '{data:reg_file[v_idx][23:20], isValid:1'b1};
                    4'd10: half_byte = '{data:reg_file[v_idx][19:16], isValid:1'b1};
                    4'd11: chr_idx = 8'h5F;
                    4'd12: half_byte = '{data:reg_file[v_idx][15:12], isValid:1'b1};
                    4'd13: half_byte = '{data:reg_file[v_idx][11:8], isValid:1'b1};
                    4'd14: half_byte = '{data:reg_file[v_idx][7:4], isValid:1'b1};
                    4'd15: half_byte = '{data:reg_file[v_idx][3:0], isValid:1'b1};
                    default: ;
                endcase
                
                if (half_byte.isValid) begin
                    case (half_byte.data)
                        4'h0: chr_idx = 8'h30;
                        4'h1: chr_idx = 8'h31;
                        4'h2: chr_idx = 8'h32;
                        4'h3: chr_idx = 8'h33;
                        4'h4: chr_idx = 8'h34;
                        4'h5: chr_idx = 8'h35;
                        4'h6: chr_idx = 8'h36;
                        4'h7: chr_idx = 8'h37;
                        4'h8: chr_idx = 8'h38;
                        4'h9: chr_idx = 8'h39;
                        4'hA: chr_idx = 8'h41;
                        4'hB: chr_idx = 8'h42;
                        4'hC: chr_idx = 8'h43;
                        4'hD: chr_idx = 8'h44;
                        4'hE: chr_idx = 8'h45;
                        4'hF: chr_idx = 8'h46;
                        default: ;
                    endcase
                end
            end
        end else begin
            red = bus.red;
            green = bus.green;
            blue =  bus.blue;
//             red = 8'hAA; 
//             green = 8'hAA; 
//             blue =  8'hAA; 
        end
       bus.vcount = vcount_hdmi;
       bus.hcount = hcount_hdmi;
       bus.read_clk = clk_in;
    end

    always_ff @(posedge clk_in) begin
        if(rst_in) begin
//            bit_map_col <= 4'd0;
//            bit_map_row <= 4'd0;
//            symbolic_idx <= 3'd0;
//            val_idx <= 4'd0;
            busy <= 1'b0;
        end else begin
            if (draw == ASCII) begin
                if(!busy) begin
                    busy <= 1'b1;
                end
//                if ((bit_map_row == 4'd15) && (bit_map_col == 4'd15)) begin
//                    bit_map_row <= 4'd0;
//                    bit_map_col <= 4'd0;
//                    busy <= 1'b0;
//                    if (symbolic_idx < 3'd5) symbolic_idx <= symbolic_idx + 1;
//                    else if (val_idx < 4'd11 && symbolic_idx == 3'd5) val_idx <= val_idx + 1;
//                    else begin 
//                        symbolic_idx <= 3'd0;
//                        val_idx <= 4'd0;
//                    end      
//                end else if (bit_map_col == 4'd15) begin
//                    bit_map_row <= bit_map_row + 1;
//                    bit_map_col <= 3'd0;
//                end else begin
//                    bit_map_col <= bit_map_col + 3'd1; 
//                end
                  if (bit_map_col == 4'd15) begin
                      busy <= 1'b0;
                  end
                  
                  
            end 
        end
    end
    
endmodule

`default_nettype wire
