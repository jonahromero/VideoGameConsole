`timescale 1ns / 1ps
`default_nettype none

module ascii_tbl(
    input wire [7:0] ascii_idx,
    
    output logic [6:0][4:0] ascii_map
);

always_comb begin
    case (ascii_idx)
        8'h21: begin // Exclamation mark
            ascii_map[0] = 5'b00100;
            ascii_map[1] = 5'b00100;
            ascii_map[2] = 5'b00100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'd0;
            ascii_map[6] = 5'b00100;
        end
        8'h30: begin // 0
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10011;
            ascii_map[3] = 5'b10101;
            ascii_map[4] = 5'b11001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h31: begin // 1
            ascii_map[0] = 5'b00100;
            ascii_map[1] = 5'b01100;
            ascii_map[2] = 5'b10100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b11111;
        end
        8'h32: begin // 2
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b00001;
            ascii_map[3] = 5'b00110;
            ascii_map[4] = 5'b01000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b11111;
        end
        8'h33: begin // 3
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b00001;
            ascii_map[3] = 5'b00110;
            ascii_map[4] = 5'b00001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h34: begin // 4
            ascii_map[0] = 5'b00010;
            ascii_map[1] = 5'b00110;
            ascii_map[2] = 5'b01010;
            ascii_map[3] = 5'b10010;
            ascii_map[4] = 5'b11111;
            ascii_map[5] = 5'b00010;
            ascii_map[6] = 5'b00010;
        end
        8'h35: begin // 5
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b11110;
            ascii_map[3] = 5'b00001;
            ascii_map[4] = 5'b00001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h36: begin // 6
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h36: begin // 6
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h37: begin // 7
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b00001;
            ascii_map[2] = 5'b00010;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b00100;
        end
        8'h38: begin // 8
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b01110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h39: begin // 9
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b01111;
            ascii_map[4] = 5'b00001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h3A: begin // :
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b00100;
            ascii_map[3] = 5'b00000;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00000;
            ascii_map[6] = 5'b00000;
        end
        8'h41: begin // A
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b11111;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h42: begin // B
            ascii_map[0] = 5'b11110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b11110;
        end
        8'h43: begin // C
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b10000;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h44: begin // D
            ascii_map[0] = 5'b11110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b11110;
        end
        8'h45: begin // E
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b11111;
        end
        8'h46: begin // F
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b10000;
        end
        8'h47: begin // G
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b10111;
            ascii_map[4] = 5'b10101;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h48: begin // H
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b11111;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h49: begin // I
            ascii_map[0] = 5'b00100;
            ascii_map[1] = 5'b00100;
            ascii_map[2] = 5'b00100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b00100;
        end
        8'h4A: begin // J
            ascii_map[0] = 5'b00010;
            ascii_map[1] = 5'b00010;
            ascii_map[2] = 5'b00010;
            ascii_map[3] = 5'b00010;
            ascii_map[4] = 5'b00010;
            ascii_map[5] = 5'b10010;
            ascii_map[6] = 5'b01100;
        end
        8'h4B: begin // K
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10010;
            ascii_map[3] = 5'b11100;
            ascii_map[4] = 5'b10010;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h4C: begin // L
            ascii_map[0] = 5'b10000;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b10000;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b11111;
        end
        8'h4D: begin // M
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b11011;
            ascii_map[2] = 5'b10101;
            ascii_map[3] = 5'b10101;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h4E: begin // N
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b11001;
            ascii_map[3] = 5'b10101;
            ascii_map[4] = 5'b10011;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h4F: begin // O
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h50: begin // P
            ascii_map[0] = 5'b11110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b10000;
        end
        8'h51: begin // Q
            ascii_map[0] = 5'b01110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10101;
            ascii_map[5] = 5'b10011;
            ascii_map[6] = 5'b01111;
        end
        8'h52: begin // R
            ascii_map[0] = 5'b11110;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h53: begin // S
            ascii_map[0] = 5'b01111;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b01110;
            ascii_map[4] = 5'b00001;
            ascii_map[5] = 5'b00001;
            ascii_map[6] = 5'b11110;
        end
        8'h54: begin // T
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b00100;
            ascii_map[2] = 5'b00100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b00100;
        end
        8'h55: begin // U
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h56: begin // V
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b01010;
            ascii_map[6] = 5'b00100;
        end
        8'h57: begin // W
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10101;
            ascii_map[4] = 5'b10101;
            ascii_map[5] = 5'b11011;
            ascii_map[6] = 5'b10001;
        end
        8'h58: begin // X
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b01010;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b01010;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h59: begin // Y
            ascii_map[0] = 5'b10001;
            ascii_map[1] = 5'b10001;
            ascii_map[2] = 5'b01010;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b00100;
        end
        8'h5A: begin // Z
            ascii_map[0] = 5'b11111;
            ascii_map[1] = 5'b00001;
            ascii_map[2] = 5'b00010;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b01000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b11111;
        end
        8'h61: begin // a
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b00001;
            ascii_map[4] = 5'b01111;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01111;
        end
        8'h62: begin // b
            ascii_map[0] = 5'b10000;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b11110;
        end
        8'h63: begin // c
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h64: begin // d
            ascii_map[0] = 5'b00001;
            ascii_map[1] = 5'b00001;
            ascii_map[2] = 5'b00001;
            ascii_map[3] = 5'b01111;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01111;
        end
        8'h65: begin // e
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b11111;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b01111;
        end
        8'h66: begin // f
            ascii_map[0] = 5'b00110;
            ascii_map[1] = 5'b01001;
            ascii_map[2] = 5'b01000;
            ascii_map[3] = 5'b11100;
            ascii_map[4] = 5'b01000;
            ascii_map[5] = 5'b01000;
            ascii_map[6] = 5'b01000;
        end
        8'h67: begin // g
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b01111;
            ascii_map[5] = 5'b00001;
            ascii_map[6] = 5'b01110;
        end
        8'h68: begin // h
            ascii_map[0] = 5'b10000;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10000;
            ascii_map[3] = 5'b11110;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h69: begin // i
            ascii_map[0] = 5'b00100;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b01110;
        end
        8'h6A: begin // j
            ascii_map[0] = 5'b00010;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b00110;
            ascii_map[3] = 5'b00010;
            ascii_map[4] = 5'b00010;
            ascii_map[5] = 5'b10010;
            ascii_map[6] = 5'b01100;
        end
        8'h6B: begin // k
            ascii_map[0] = 5'b10000;
            ascii_map[1] = 5'b10000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10010;
            ascii_map[4] = 5'b11100;
            ascii_map[5] = 5'b10010;
            ascii_map[6] = 5'b10001;
        end
        8'h6C: begin // l
            ascii_map[0] = 5'b01100;
            ascii_map[1] = 5'b00100;
            ascii_map[2] = 5'b00100;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b01110;
        end
        8'h6D: begin // m
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b11110;
            ascii_map[3] = 5'b10101;
            ascii_map[4] = 5'b10101;
            ascii_map[5] = 5'b10101;
            ascii_map[6] = 5'b10101;
        end
        8'h6E: begin // n
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b11110;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b10001;
        end
        8'h6F: begin // o
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10001;
            ascii_map[6] = 5'b01110;
        end
        8'h70: begin // p
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b01001;
            ascii_map[4] = 5'b01110;
            ascii_map[5] = 5'b01000;
            ascii_map[6] = 5'b01000;
        end
        8'h71: begin // q
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b00111;
            ascii_map[3] = 5'b01001;
            ascii_map[4] = 5'b00111;
            ascii_map[5] = 5'b00001;
            ascii_map[6] = 5'b00001;
        end
        8'h72: begin // r
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10111;
            ascii_map[3] = 5'b11000;
            ascii_map[4] = 5'b10000;
            ascii_map[5] = 5'b10000;
            ascii_map[6] = 5'b10000;
        end
        8'h73: begin // s
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b01111;
            ascii_map[3] = 5'b10000;
            ascii_map[4] = 5'b01110;
            ascii_map[5] = 5'b00001;
            ascii_map[6] = 5'b11110;
        end
        8'h74: begin // t
            ascii_map[0] = 5'b00100;
            ascii_map[1] = 5'b00100;
            ascii_map[2] = 5'b01110;
            ascii_map[3] = 5'b00100;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b00100;
            ascii_map[6] = 5'b00011;
        end
        8'h75: begin // u
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b10011;
            ascii_map[6] = 5'b01101;
        end
        8'h76: begin // v
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10001;
            ascii_map[5] = 5'b01010;
            ascii_map[6] = 5'b00100;
        end
        8'h77: begin // w
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b10101;
            ascii_map[5] = 5'b11111;
            ascii_map[6] = 5'b10101;
        end
        8'h78: begin // x
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b01010;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b01010;
            ascii_map[6] = 5'b10001;
        end
        8'h79: begin // y
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b10001;
            ascii_map[3] = 5'b10001;
            ascii_map[4] = 5'b01111;
            ascii_map[5] = 5'b00001;
            ascii_map[6] = 5'b11110;
        end
        8'h7A: begin // z
            ascii_map[0] = 5'b00000;
            ascii_map[1] = 5'b00000;
            ascii_map[2] = 5'b11111;
            ascii_map[3] = 5'b00010;
            ascii_map[4] = 5'b00100;
            ascii_map[5] = 5'b01000;
            ascii_map[6] = 5'b11111;
        end
        default: begin // Blank or Space
            ascii_map[0] = 5'd0;
            ascii_map[1] = 5'd0;
            ascii_map[2] = 5'd0;
            ascii_map[3] = 5'd0;
            ascii_map[4] = 5'd0;
            ascii_map[5] = 5'd0;
            ascii_map[6] = 5'd0;
        end
    endcase
end

endmodule

`default_nettype wire