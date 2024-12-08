`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;


function automatic logic aluBr(input logic [31:0] a, input logic [31:0] b, input BrFunc brfunc);
    logic ret;
    case(brfunc)
        Eq: ret = ((a == b));
        Neq: ret =((a != b));
        Lt: ret = ($signed(a) < $signed(b));
        Ltu: ret = ((a < b));
        Ge: ret = ($signed(a) >= $signed(b));
        GeU: ret = ((a >= b));
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
        OP, OPIMM: data = (alu(r_val1, alu_val2, dInst.aluFunc));
        JAL, JALR: data = (pc + 4);
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

    // ret.iType = dInst.iType;
    // ret.memFunc = dInst.memFunc;
    // ret.dst = dInst.dst;
    // ret.data = data;
    // ret.addr = addr;
    // ret.nextPC = nextPc;

    // return ret;
endfunction

`default_nettype wire