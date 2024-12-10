`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;


function automatic logic aluBr(input logic [31:0] a, input logic [31:0] b, input BrFunc brfunc);
    logic ret;
    case(brfunc)
        EQ: ret = ((a == b));
        NEQ: ret =((a != b));
        LT: ret = ($signed(a) < $signed(b));
        LTU: ret = ((a < b));
        GE: ret = ($signed(a) >= $signed(b));
        GEU: ret = ((a >= b));
        default: ret =1'b0;
    endcase
    return ret;
endfunction

function automatic ExecInst execute(input DecodedInst dInst, input logic[31:0] r_val1,input logic [31:0] r_val2, input logic [31:0] pc);
    logic [31:0] imm, alu_val2,data, nextPc, addr;
    // ExecInst ret;

    imm = dInst.imm;
    alu_val2 = (dInst.iType == OPIMM)? imm : r_val2;

    case (dInst.iType)
        AUIPC: data = (pc + imm);
        LUI: data = (imm);
        OP: data = (alu(r_val1, alu_val2, dInst.aluFunc));
        OPIMM: data = (alu(r_val1, alu_val2, dInst.aluFunc));
        JAL: data = (pc + 4);
        JALR: data = (pc + 4);
        STORE: data = (r_val2);
        default: data = 32'b0;
    endcase

    case (dInst.iType)
        BRANCH: nextPc = (aluBr(r_val1, r_val2, dInst.brFunc)? pc + imm: pc + 4);
        JAL: nextPc = (pc + imm);
        JALR: nextPc = ((r_val1 + imm) & 32'hFFFF_FFFE);
        default: nextPc = (pc + 4);
    endcase

    addr = r_val1 + imm;

    return '{dInst.iType, dInst.memFunc,dInst.dst, data, addr, nextPc};
endfunction

`default_nettype wire