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


    dInst = '{UNSUPPORTED,NOPA,NOPB,NOPM,5'd0,5'd0,5'd0,immD32};

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
                fnAND : dInst.aluFunc = AND; 
                fnOR  : dInst.aluFunc = OR; 
                fnXOR : dInst.aluFunc = XOR; 
                fnADD : dInst.aluFunc = ADD; 
                fnSLT : dInst.aluFunc = SLT; 
                fnSLTU: dInst.aluFunc = SLTU; 
                fnSLL : case (funct7)
                    7'b0000000: dInst.aluFunc = SLL;
                    default:    dInst.iType = UNSUPPORTED;
                endcase
                fnSR  :
                    case(funct7)
                        7'b0000000: dInst.aluFunc = SRL;
                        7'b0100000: dInst.aluFunc = SRA;
                        default: dInst.iType = UNSUPPORTED;
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
                    fnADD: dInst.aluFunc = ADD;
                    fnSLL: dInst.aluFunc = SLL;
                    fnSLT: dInst.aluFunc = SLT;
                    fnSLTU: dInst.aluFunc = SLTU;
                    fnXOR: dInst.aluFunc = XOR;
                    fnSR: dInst.aluFunc = SRL;
                    fnOR: dInst.aluFunc = OR;
                    fnAND: dInst.aluFunc = AND;
                    default: dInst.iType = UNSUPPORTED;
                endcase
                7'b0100000: case(funct3)
                    fnADD: dInst.aluFunc = SUB;
                    fnSR: dInst.aluFunc = SRA;
                    default: dInst.iType = UNSUPPORTED;
                endcase
                7'b0000001: case(funct3)
                        3'd0: dInst.aluFunc = MUL;
                        3'd1: dInst.aluFunc = MULH;
                        3'd2: dInst.aluFunc = MULHSU;
                        3'd3: dInst.aluFunc = MULHU;
                        3'd4: dInst.aluFunc = DIV;
                        3'd5: dInst.aluFunc = DIVU;
                        3'd6: dInst.aluFunc = REM;
                        3'd7: dInst.aluFunc = REMU;
                        default: dInst.iType = UNSUPPORTED;
                    endcase
                default: dInst.iType = UNSUPPORTED;
            endcase
        end
        7'b1100011: begin                   //opBranch
            dInst.iType = BRANCH;
            dInst.src1 = src1;
            dInst.src2 = src2;
            dInst.imm = immB32;

            case(funct3)
                fnBEQ: dInst.brFunc = EQ;
                fnBNE: dInst.brFunc = NEQ;
                fnBLT: dInst.brFunc = LT;
                fnBGE: dInst.brFunc = GE;
                fnBLTU: dInst.brFunc = LTU;
                fnBGEU: dInst.brFunc = GEU; 
                default: dInst.iType = UNSUPPORTED;
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
                fnLW: dInst.memFunc = LW;
                fnLB: dInst.memFunc = LB;
                fnLH: dInst.memFunc = LH;
                fnLBU: dInst.memFunc = LBU;
                fnLHU: dInst.memFunc = LHU;
                default: dInst.iType = UNSUPPORTED;
            endcase

        end
        7'b0100011: begin                   //opStore

            dInst.iType = STORE;
            dInst.src1 = src1;
            dInst.src2 =  src2;
            dInst.imm = immS32;

            case(funct3)
                fnSW: dInst.memFunc = SW;
                fnSH: dInst.memFunc = SH;
                fnSB: dInst.memFunc = SB;
                default: dInst.iType = UNSUPPORTED;
            endcase

        end
        7'b1100111: begin                   //opJalr

            dInst.dst = dst;
            dInst.src1 = src1;
            dInst.imm = immI32;

            case(funct3)
                fnJALR: dInst.iType = JALR;
                default: dInst.iType = UNSUPPORTED;
            endcase

        end
        default: dInst.iType = UNSUPPORTED;
    endcase


    return dInst;
endfunction
`default_nettype wire