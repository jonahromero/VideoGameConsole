`timescale 1ns / 1ps
`default_nettype none

module barrel_rshift(
    input wire [31:0] data_in,
    input wire [4:0] sftSz,
    input wire sft_in,

    output logic [31:0] data_out
);

logic [31:0] sft4, sft3, sft2, sft1;

always_comb begin
    sft4 = (sftSz[4])? (sft_in)? {15'h7FFF, sft_in, data_in[31:16]}: {15'h0, sft_in, data_in[31:16]} : data_in;
    sft3 = (sftSz[3])? (sft_in)? {7'h7F, sft_in, sft4[31:8]}: {7'h0, sft_in, sft4[31:8]} : sft4;
    sft2 = (sftSz[2])? (sft_in)? {3'h7, sft_in, sft3[31:4]}: {3'h0, sft_in, sft3[31:4]} : sft3;
    sft1 = (sftSz[1])? (sft_in)? {1'h1, sft_in, sft2[31:2]}: {1'h0, sft_in, sft2[31:2]} : sft2;
    data_out = (sftSz[0])? (sft_in)?  {sft_in, sft1[31:1]}: {sft_in, sft1[31:1]} : sft1;
end

endmodule

module sr32 (
    input wire [31:0] data_in,
    input wire [4:0] sftSz,
    input wire arith,

    output logic [31:0] data_out
);
logic sft_in;

assign sft_in = (arith)? data_in[31]: 1'b0;
barrel_rshift sr32_shifter(.data_in(data_in), .sftSz(sftSz), .sft_in(sft_in), .data_out(data_out));
endmodule

module sll32 (
    input wire [31:0] data_in,
    input wire [4:0] sftSz,

    output logic [31:0] data_out
);

logic [31:0] reversed_in, shift_out;

always_comb begin
    for (int i = 0; i < 32; i=i+1) begin
        reversed_in[i] = data_in[31 - i];
    end

    for (int i = 0; i < 32; i=i+1) begin
        data_out[i] = shift_out[31 - i];
    end
end

barrel_rshift sll32_shifter(.data_in(reversed_in), .sftSz(sftSz), .sft_in(1'b0), .data_out(shift_out));


endmodule

module sft32 (
    input wire [31:0] data_in,
    input wire [4:0] sftSz,
    input wire [1:0] shiftType,

    output logic [31:0] data_out
);

logic reverse, sft_in;
logic [31:0] m_in, reversed_in, shift_out;

always_comb begin
    m_in = data_in;
    case (shiftType)
        2'b01: begin                    //ArithmeticRightShift
            reverse = 1'b0;
            sft_in = data_in[31];
        end 
        2'b10: begin                    //LeftShift
            reverse = 1'b1;
            for (int i = 0; i < 32; i=i+1) begin
                reversed_in[i] = data_in[31-i];
            end
        end
        default: begin
            reverse = 1'b0;
            sft_in = 1'b0;
        end
    endcase

    if(reverse) begin
        for (int i = 0; i < 32; i=i+1) begin
            data_out[i] = shift_out[31-i];
        end
    end else data_out = shift_out;
end

barrel_rshift sft32_shifter (.data_in(m_in), .sftSz(sftSz), .sft_in(sft_in), .data_out(shift_out));

endmodule

module cmp32(
    input wire [31:0] val1,
    input wire [31:0] val2,

    output logic [1:0] data_out
);

    logic eq, lt;
    logic [1:0] lower, upper;

    assign eq = lower[1] & upper[1];
    assign lt =  upper[0] | (upper[1] & lower[0]);
    assign data_out = {eq, lt};

    cmp16 c1(.val1(val1[15:0]), .val2(val2[15:0]), .data_out(lower));
    cmp16 c2(.val1(val1[31:16]), .val2(val2[31:16]), .data_out(upper));
endmodule

module cmp16(
    input wire [15:0] val1,
    input wire [15:0] val2,

    output logic [1:0] data_out
);

    logic eq, lt;
    logic [1:0] lower, upper;

    assign eq = lower[1] & upper[1];
    assign lt =  upper[0] | (upper[1] & lower[0]);
    assign data_out = {eq, lt};

    cmp8 c1(.val1(val1[7:0]), .val2(val2[7:0]), .data_out(lower));
    cmp8 c2(.val1(val1[15:8]), .val2(val2[15:8]), .data_out(upper));
endmodule

module cmp8(
    input wire [7:0] val1,
    input wire [7:0] val2,

    output logic [1:0] data_out
);

    logic eq, lt;
    logic [1:0] lower, upper;

    assign eq = lower[1] & upper[1];
    assign lt =  upper[0] | (upper[1] & lower[0]);
    assign data_out = {eq, lt};
    cmp4 c1(.val1(val1[3:0]), .val2(val2[3:0]), .data_out(lower));
    cmp4 c2(.val1(val1[7:4]), .val2(val2[7:4]), .data_out(upper));
endmodule

module cmp4(
    input wire [3:0] val1,
    input wire [3:0] val2,

    output logic [1:0] data_out
);

    logic eq, lt;
    logic [1:0] lower, upper;

    assign eq = lower[1] & upper[1];
    assign lt =  upper[0] | (upper[1] & lower[0]);
    assign data_out = {eq, lt};

    cmp2 c1(.val1(val1[1:0]), .val2(val2[1:0]), .data_out(lower));
    cmp2 c2(.val1(val1[3:2]), .val2(val2[3:2]), .data_out(upper));
endmodule

module cmp2(
    input wire [1:0] val1,
    input wire [1:0] val2,

    output logic [1:0] data_out
);

    logic eq, lt;
    logic [1:0] lower, upper;

    assign eq = lower[1] & upper[1];
    assign lt =  upper[0] | (upper[1] & lower[0]);
    assign data_out = {eq, lt};

    cmp c1(.val1(val1[0]), .val2(val2[0]), .data_out(lower));
    cmp c2(.val1(val1[1]), .val2(val2[1]), .data_out(upper));
endmodule

module cmp(
    input wire val1,
    input wire val2,

    output logic [1:0] data_out
);

    assign data_out = {~(val1 ^ val2), ~val1 & val2};

endmodule

module ltu32(
    input wire [31:0] val1,
    input wire [31:0] val2,

    output logic data_out
);
    logic [1:0] tp;

    cmp32 c1(.val1(val1), .val2(val2), .data_out(tp));
    assign data_out = tp[0];

endmodule

module lt32(
    input wire [31:0] val1,
    input wire [31:0] val2,
    input wire isSigned,

    output logic data_out
);

    logic [31:0] a, b;

    always_comb begin
        a = val1;
        b = val2;

        if(isSigned) begin
            a[31] = ~a[31];
            b[31] = ~b[31];
        end
    end

    ltu32 l1(.val1(a), .val2(b), .data_out(data_out));

endmodule

module composer32(
    input wire [31:0][1:0] func,

    output logic [31:0][1:0] data_out
);

    logic g,p;
    logic [1:0] current, prev;
    logic [31:0][1:0] now, past;

    always_comb begin
        past = func;
        // for(int m = 1; m < 32; m=m<<1) begin
        // m = 1
        for (int j = 0; j < 1; j=j+1) now[j] = past[j];
        for (int i = 1; i < 32; i=i+1) begin
            current = past[i];
            prev = past[i - 1];
            g = current[1] | (current[0] & prev[1]);
            p = current[0] & prev[0];
            now[i] = {g,p};
        end
        past = now;

        // m = 2
        for (int j = 0; j < 2; j=j+1) now[j] = past[j];
        for (int i = 2; i < 32; i=i+1) begin
            current = past[i];
            prev = past[i - 2];
            g = current[1] | (current[0] & prev[1]);
            p = current[0] & prev[0];
            now[i] = {g,p};
        end
        past = now;

        // m = 4
        for (int j = 0; j < 4; j=j+1) now[j] = past[j];
        for (int i = 4; i < 32; i=i+1) begin
            current = past[i];
            prev = past[i - 4];
            g = current[1] | (current[0] & prev[1]);
            p = current[0] & prev[0];
            now[i] = {g,p};
        end
        past = now;

        // m = 8
        for (int j = 0; j < 8; j=j+1) now[j] = past[j];
        for (int i = 8; i < 32; i=i+1) begin
            current = past[i];
            prev = past[i - 8];
            g = current[1] | (current[0] & prev[1]);
            p = current[0] & prev[0];
            now[i] = {g,p};
        end
        past = now;


        // m = 16
        for (int j = 0; j < 16; j=j+1) now[j] = past[j];
        for (int i = 16; i < 32; i=i+1) begin
            current = past[i];
            prev = past[i - 16];
            g = current[1] | (current[0] & prev[1]);
            p = current[0] & prev[0];
            now[i] = {g,p};
        end
        past = now;
        // end

        data_out = now;
    end

endmodule

module fastAdd(
    input wire [31:0] val1,
    input wire [31:0] val2,
    input wire carryIn,

    output logic [31:0] data_out
);

    logic g, p;
    logic [31:0][1:0] vecF, carry_data;
    logic [31:0] carry;
    logic [1:0] temp;

    composer32 c32(.func(vecF), .data_out(carry_data));

    always_comb begin
        for (int i = 0; i < 32; i=i+1) begin
            g = val1[i] & val2[i];
            p = val1[i] | val2[i];
            vecF[i] = {g,p};
        end
        
        carry = 0;
        temp = 0;

        for(int i = 0; i < 32; i=i+1) begin
            if (i == 0) carry[i] = carryIn;
            else begin
                temp = vecF[i-1];
                carry[i] = temp[1] | (temp[0] & carryIn);
            end
        end

        for(int i = 0; i < 32; i=i+1) begin
            data_out[i] = val1[i] ^ val2[i] ^ carry[i];
        end
    end

endmodule

module addSub(
    input wire [31:0] val1,
    input wire [31:0] val2,
    input wire isSub,

    output logic [31:0] data_out
);

    logic carryIn;
    logic [31:0] b;

    always_comb begin
        carryIn = 0;
        b = val2;
        if (isSub) begin
            b = ~b;
            carryIn = 1'b1;
        end
    end

    fastAdd f1(.val1(val1), .val2(b),.carryIn(carryIn), .data_out(data_out));

endmodule

module alu(
    input wire [31:0] val1,
    input wire [31:0] val2,
    input wire [3:0] alufunc,
    input wire alu_bool,

    output logic [31:0] data_out
);
    logic isSub, isSigned, lt32Val;
    logic [1:0] shiftType;
    logic [4:0] sftSz;
    logic [31:0] aSVal, sft32Val;

    addSub as1(.val1(val1),.val2(val2),.isSub(isSub), .data_out(aSVal));
    lt32 l1(.val1(val1), .val2(val2), .isSigned(isSigned), .data_out(lt32Val));
    sft32 s1(.data_in(val1), .shiftType(shiftType),.sftSz(sftSz), .data_out(sft32Val));

    always_comb begin
        if(alu_bool) begin
            if ((alufunc == 4'b0000) || (alufunc == 4'b1010)) begin //Add or Sub
                if (alufunc == 4'b1010) isSub = 1;
                else isSub = 0;
                data_out = aSVal;
            end
            else if(alufunc == 4'b0111) data_out = val1 & val2; // And
            else if(alufunc == 4'b0110) data_out = val1 | val2; // Or
            else if(alufunc == 4'b0100) data_out = val1 ^ val2; // Xor
            else if((alufunc == 4'b0010) || (alufunc==4'b0011)) begin //Slt or Sltu
                if (alufunc == 4'b0010) isSigned = 1;
                else isSigned = 0;
                data_out = {31'b0, lt32Val};
            end
            else if((alufunc == 4'b0001) || (alufunc == 4'b1000) || (alufunc == 4'b1001)) begin // SLL or SRL or SRA
                sftSz = val2[4:0];
                if (alufunc == 4'b0001) shiftType = 2'b10;
                else if (alufunc == 4'b1000) shiftType = 2'b00;
                else shiftType = 2'b01;
                data_out = sft32Val;
            end
        end
    end

endmodule

`default_nettype wire