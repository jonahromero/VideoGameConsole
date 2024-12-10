`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

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
    
    if ((alufunc == ADD) || (alufunc == SUB)) begin
        if (alufunc == SUB) isSub = 1;
        else isSub = 0;
        data_out = addSub(val1,val2,isSub);
    end
    else if(alufunc == AND) data_out = val1 & val2; 
    else if(alufunc == OR) data_out = val1 | val2; 
    else if(alufunc == XOR) data_out = val1 ^ val2; 
    else if((alufunc == SLT) || (alufunc==SLTU)) begin //Slt or Sltu
        if (alufunc == SLT) isSigned = 1;
        else isSigned = 0;
        lt32Val = lt32(val1,val2,isSigned);
        data_out = {31'b0, lt32Val};
    end
    else if((alufunc == SLL) || (alufunc == SRL) || (alufunc == SRA)) begin 
        sftSz = val2[4:0];
        if (alufunc == SRL) shiftType = LogicalRightShift;
        else if (alufunc == SRA) shiftType = ArithemticRightShift;
        else shiftType = LeftShift;
        data_out = sft32(val1,sftSz,shiftType);
    end


    return data_out;

endfunction

`default_nettype wire