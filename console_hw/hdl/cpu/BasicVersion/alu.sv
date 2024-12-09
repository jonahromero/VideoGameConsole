`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

function automatic logic [31:0] barrel_rshift(
    input [31:0] data_in,
    input  [4:0] sftSz,
    input  sft_in
);

    logic [31:0] sft4, sft3, sft2, sft1;
    logic [31:0] data_out;

    
    sft4 = (sftSz[4])? (sft_in)? {15'h7FFF, sft_in, data_in[31:16]}: {15'h0, sft_in, data_in[31:16]} : data_in;
    sft3 = (sftSz[3])? (sft_in)? {7'h7F, sft_in, sft4[31:8]}: {7'h0, sft_in, sft4[31:8]} : sft4;
    sft2 = (sftSz[2])? (sft_in)? {3'h7, sft_in, sft3[31:4]}: {3'h0, sft_in, sft3[31:4]} : sft3;
    sft1 = (sftSz[1])? (sft_in)? {1'h1, sft_in, sft2[31:2]}: {1'h0, sft_in, sft2[31:2]} : sft2;
    data_out = (sftSz[0])? (sft_in)?  {sft_in, sft1[31:1]}: {sft_in, sft1[31:1]} : sft1;

    return data_out;

endfunction

function automatic logic [31:0] sr32 (
    input [31:0] data_in,
    input [4:0] sftSz,
    input arith
);
    logic sft_in;
    logic [31:0] data_out;

    sft_in = (arith)? data_in[31]: 1'b0;
    data_out = barrel_rshift(data_in,sftSz,sft_in);
    return data_out;
endfunction

function automatic sll32 (
    input [31:0] data_in,
    input [4:0] sftSz
);

    logic [31:0] reversed_in, shift_out, data_out;

    for (int i = 0; i < 32; i=i+1) begin
        reversed_in[i] = data_in[31 - i];
    end

    shift_out = barrel_rshift(reversed_in, sftSz,1'b0);

    for (int i = 0; i < 32; i=i+1) begin
        data_out[i] = shift_out[31 - i];
    end

    return data_out;
endfunction

typedef enum { ArithemticRightShift, LogicalRightShift,LeftShift} ShiftType;

function automatic logic [31:0] sft32 (
    input [31:0] data_in,
    input [4:0] sftSz,
    input ShiftType shiftType
);
    if (shiftType == ArithemticRightShift) begin
        return data_in >>> sftSz;
    end
    else if (shiftType == LogicalRightShift) begin
        return data_in >> sftSz;
    end
    else begin // LeftShift
        return data_in << sftSz;
    end
    
//    logic reverse, sft_in;
//    logic [31:0] m_in, reversed_in, shift_out, data_out;

    
//    m_in = data_in;
//    reverse = 1'b0;
//    sft_in = 1'b0;
//    if (shiftType == ArithemticRightShift) sft_in = data_in[31];
//    else if (shiftType == LeftShift) begin
//        reverse = 1'b1;
//            for (int i = 0; i < 32; i=i+1) begin
//                reversed_in[i] = data_in[31-i];
//            end
//    end

//    shift_out = barrel_rshift(m_in,sftSz,sft_in);

//    if(reverse) begin
//        for (int i = 0; i < 32; i=i+1) begin
//            data_out[i] = shift_out[31-i];
//        end
//    end else data_out = shift_out;

//    return data_out;
endfunction

function automatic logic [31:0] cmp32(
    input [31:0] val1,
    input [31:0] val2
);

    logic eq, lt;
    logic [1:0] lower, upper, data_out;

    lower = cmp16(val1[15:0],val2[15:0]);
    upper = cmp16(val1[31:16],val2[31:16]);
    eq = lower[1] & upper[1];
    lt =  upper[0] | (upper[1] & lower[0]);
    data_out = {eq, lt};

    return data_out;
endfunction

function automatic logic [15:0] cmp16(
    input  [15:0] val1,
    input  [15:0] val2
);

    logic eq, lt;
    logic [1:0] lower, upper, data_out;

    lower = cmp8(val1[7:0],val2[7:0]);
    upper = cmp8(val1[15:8],val2[15:8]);
    eq = lower[1] & upper[1];
    lt =  upper[0] | (upper[1] & lower[0]);
    data_out = {eq, lt};

    return data_out;
endfunction

function automatic logic [7:0] cmp8(
    input  [7:0] val1,
    input  [7:0] val2
);

    logic eq, lt;
    logic [1:0] lower, upper,data_out;

    lower = cmp4(val1[3:0],val2[3:0]);
    upper = cmp4(val1[7:4],val2[7:4]);
    eq = lower[1] & upper[1];
    lt =  upper[0] | (upper[1] & lower[0]);
    data_out = {eq, lt};

    return data_out;
endfunction

function automatic logic [3:0] cmp4(
    input [3:0] val1,
    input [3:0] val2
);

    logic eq, lt;
    logic [1:0] lower, upper,data_out;

    lower = cmp2(val1[1:0],val2[1:0]);
    upper = cmp2(val1[3:2],val2[3:2]);
    eq = lower[1] & upper[1];
    lt =  upper[0] | (upper[1] & lower[0]);
    data_out = {eq, lt};

    return data_out;
endfunction

function automatic logic [1:0] cmp2(input [1:0] val1,input [1:0] val2);

    logic eq, lt;
    logic [1:0] lower, upper, data_out;

    lower = cmp(val1[0],val2[0]);
    upper = cmp(val1[1],val2[1]);
    eq = lower[1] & upper[1];
    lt =  upper[0] | (upper[1] & lower[0]);
    data_out = {eq, lt};

    return data_out;
endfunction

function automatic logic cmp(input val1,input val2);
    return {~(val1 ^ val2), ~val1 & val2};
endfunction

function automatic logic[31:0] ltu32(
    input [31:0] val1,
    input [31:0] val2
);
    logic [1:0] tp;

    tp = cmp32(val1,val2);
    return tp[0];

endfunction

function automatic logic [31:0] lt32(
    input [31:0] val1,
    input [31:0] val2,
    input isSigned
);
    if (isSigned) begin
        return $signed(val1) < $signed(val2);
    end
    else begin
        return val1 < val2;
    end
//    logic [31:0] a, b, data_out;

//    a = val1;
//    b = val2;

//    if(isSigned) begin
//        a[31] = ~a[31];
//        b[31] = ~b[31];
//    end

//    data_out = ltu32(a,b);

//    return data_out;
endfunction

function automatic logic [31:0][1:0] composer32(
    input [31:0][1:0] func
);

    logic g,p;
    logic [1:0] current, prev;
    logic [31:0][1:0] now, past;

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

    return now;
endfunction

function automatic logic [31:0] fastAdd(
    input [31:0] val1,
    input [31:0] val2,
    input carryIn
);

    logic g, p;
    logic [31:0][1:0] vecF, carry_data;
    logic [31:0] carry,data_out;
    logic [1:0] temp;

    carry_data = composer32(vecF);

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

    return data_out;

endfunction

function automatic logic [31:0] addSub(
    input [31:0] val1,
    input [31:0] val2,
    input isSub
);
    if (isSub) begin
        return val1 - val2;
    end
    else begin
        return val1 + val2;
    end

//    logic carryIn;
//    logic [31:0] b,data_out;

//    carryIn = 0;
//    b = val2;
//    if (isSub) begin
//        b = ~b;
//        carryIn = 1'b1;
//    end

//    data_out = fastAdd(val1,b,carryIn);
//    return data_out;
endfunction

function automatic logic [31:0] alu(
    input logic [31:0] val1,
    input logic [31:0] val2,
    input AluFunc alufunc
);
    logic isSub, isSigned, lt32Val;
    ShiftType shiftType;
    logic [4:0] sftSz;
    logic [31:0] data_out;
    
    if ((alufunc == Add) || (alufunc == Sub)) begin
        if (alufunc == Sub) isSub = 1;
        else isSub = 0;
        data_out = addSub(val1,val2,isSub);
    end
    else if(alufunc == And) data_out = val1 & val2; 
    else if(alufunc == Or) data_out = val1 | val2; 
    else if(alufunc == Xor) data_out = val1 ^ val2; 
    else if((alufunc == Slt) || (alufunc==Sltu)) begin //Slt or Sltu
        if (alufunc == Slt) isSigned = 1;
        else isSigned = 0;
        lt32Val = lt32(val1,val2,isSigned);
        data_out = {31'b0, lt32Val};
    end
    else if((alufunc == Sll) || (alufunc == Srl) || (alufunc == Sra)) begin 
        sftSz = val2[4:0];
        if (alufunc == Srl) shiftType = LogicalRightShift;
        else if (alufunc == Sra) shiftType = ArithemticRightShift;
        else shiftType = LeftShift;
        data_out = sft32(val1,sftSz,shiftType);
    end


    return data_out;

endfunction

`default_nettype wire