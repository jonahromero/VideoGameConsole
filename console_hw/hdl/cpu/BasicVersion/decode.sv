`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

function automatic DecodedInst decode(
    input logic [31:0] inst
);
    logic [6:0] opcode, funct7;
    logic [2:0] funct3;
    logic [4:0] dst, src1, src2;
    logic [31:0] immD32, immB32, immU32, immI32, immJ32, immS32;
    DecodedInst dInst;

    opcode = inst[6:0];
    funct3 = inst[14:12];
    funct7 = inst[31:25];
    dst = inst[11:7];
    src1 = inst[19:15];
    src2 = inst[24:20];

    immD32 = 32'b0;
    if (inst[31]) immB32 = {19'h7_FFFF, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
    else immB32 = {19'h0, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
    immU32 = {inst[31:12], 12'b0};
    immI32 = inst[31]? {20'hF_FFFF, inst[31:20]} : {20'h0, inst[31:20]};     
    if (inst[31]) immJ32 = {11'h7FF, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
    else immJ32 = {11'h0, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
    immS32 = inst[31]? {20'hF_FFFF, inst[31:25], inst[11:7]} : {20'h0,inst[31:25], inst[11:7]};


    dInst = '{Unsupported,NopA,NopB,NopM,5'd0,5'd0,5'd0,immD32};

    case (opcode)
        7'b0010111: begin                   // AUIPC
            dInst.iType = AUIPC;
            dInst.dst = dst;
            dInst.imm = immU32;
        end
        7'b0110111: begin                   //opLui
            dInst.iType = LUI;
            dInst.dst = dst;
            dInst.imm = immU32;
        end
        7'b0010011: begin                   //opOpImm
            dInst.iType = OPIMM;
            dInst.src1 = src1;
            dInst.imm = immI32;
            dInst.dst = dst;
            case (funct3)
                fnAND : dInst.aluFunc = And; 
                fnOR  : dInst.aluFunc = Or; 
                fnXOR : dInst.aluFunc = Xor; 
                fnADD : dInst.aluFunc = Add; 
                fnSLT : dInst.aluFunc = Slt; 
                fnSLTU: dInst.aluFunc = Sltu; 
                fnSLL : case (funct7)
                    7'b0000000: dInst.aluFunc = Sll;
                    default:    dInst.iType = Unsupported;
                endcase
                fnSR  :
                    case(funct7)
                        7'b0000000: dInst.aluFunc = Srl;
                        7'b0100000: dInst.aluFunc = Sra;
                        default: dInst.iType = Unsupported;
                    endcase
            endcase
        end
        7'b0110011: begin                   //opOp
            dInst.iType = OP;
            dInst.dst = dst;
            dInst.src1 = src1;
            dInst.src2 = src2;

            case(funct7)
                7'b0000000: case(funct3)
                    fnADD: dInst.aluFunc = Add;
                    fnSLL: dInst.aluFunc = Sll;
                    fnSLT: dInst.aluFunc = Slt;
                    fnSLTU: dInst.aluFunc = Sltu;
                    fnXOR: dInst.aluFunc = Xor;
                    fnSR: dInst.aluFunc = Srl;
                    fnOR: dInst.aluFunc = Or;
                    fnAND: dInst.aluFunc = And;
                    default: dInst.iType = Unsupported;
                endcase
                7'b0100000: case(funct3)
                    fnADD: dInst.aluFunc = Sub;
                    fnSR: dInst.aluFunc = Sra;
                    default: dInst.iType = Unsupported;
                endcase
                7'b0000001: case(funct3)
                        fnSLL: dInst.iType = PMUL;
                        default: dInst.iType = Unsupported;
                    endcase
                default: dInst.iType = Unsupported;
            endcase
        end
        7'b1100011: begin                   //opBranch
            dInst.iType = BRANCH;
            //dInst.dst = dst;
            dInst.src1 = src1;
            dInst.src2 = src2;
            dInst.imm = immB32;

            case(funct3)
                fnBEQ: dInst.brFunc = Eq;
                fnBNE: dInst.brFunc = Neq;
                fnBLT: dInst.brFunc = Lt;
                fnBGE: dInst.brFunc = Ge;
                fnBLTU: dInst.brFunc = Ltu;
                fnBGEU: dInst.brFunc = GeU; 
                default: dInst.iType = Unsupported;
            endcase

        end
        7'b1101111: begin                   //opJal
            dInst.iType = JAL;
            dInst.dst = dst;
            dInst.imm = immJ32;
        end
        7'b0000011: begin                   //opLoad
            dInst.iType = LOAD;
            dInst.dst = dst;
            dInst.src1 = src1;
            dInst.imm = immI32;

            case(funct3)
                fnLW: dInst.memFunc = Lw;
                fnLB: dInst.memFunc = Lb;
                fnLH: dInst.memFunc = Lh;
                fnLBU: dInst.memFunc = Lbu;
                fnLHU: dInst.memFunc = Lhu;
                default: dInst.iType = Unsupported;
            endcase

        end
        7'b0100011: begin                   //opStore

            dInst.iType = STORE;
            dInst.dst = 5'd0;
            dInst.src1 = src1;
            dInst.src2 =  src2;
            dInst.imm = immS32;

            case(funct3)
                fnSW: dInst.memFunc = Sw;
                fnSH: dInst.memFunc = Sh;
                fnSB: dInst.memFunc = Sb;
                default: dInst.iType = Unsupported;
            endcase

        end
        7'b1100111: begin                   //opJalr

            dInst.dst = dst;
            dInst.src1 = src1;
            dInst.imm = immI32;

            case(funct3)
                fnJALR: dInst.iType = JALR;
                default: dInst.iType = Unsupported;
            endcase

        end
        default: dInst.iType = Unsupported;
    endcase


    return dInst;
endfunction
`default_nettype wire