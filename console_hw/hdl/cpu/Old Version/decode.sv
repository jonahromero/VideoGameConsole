`timescale 1ns / 1ps
`default_nettype none

// import ProcTypes::*;

// Alu function enumeration
    typedef enum {Add, Sub, And, Or, Xor, Slt, Sltu, Sll, Srl, Sra} AluFunc;

    // Branch function enumeration
    typedef enum { Eq,Neq,Lt,Ltu,Ge,GeU} BrFunc;

    // Mem function enumeration
    typedef enum { Lw, Lh, Lhu, Lb, Lbu, Sw, Sh, Sb } MemFunc;

    // AUIPC added for this lab - Add Upper Immediate to PC
    typedef enum {OP, OPIMM, BRANCH, LUI, JAL, JALR, LOAD, STORE, AUIPC, PMUL, Unsupported} IType;

    // Return type for Decode function
    typedef struct packed{
        IType iType;
        AluFunc aluFunc;
        BrFunc brFunc;
        MemFunc memFunc;
        logic [4:0] dst;
        logic [4:0] src1;
        logic [4:0] src2;
        logic [31:0] imm;
    } DecodedInst;

    // Opcode
    logic [6:0] opOpImm  = 7'b0010011;
    logic [6:0] opOp     = 7'b0110011;
    logic [6:0] opLui    = 7'b0110111;
    logic [6:0] opJal    = 7'b1101111;
    logic [6:0] opJalr   = 7'b1100111;
    logic [6:0] opBranch = 7'b1100011;
    logic [6:0] opLoad   = 7'b0000011;
    logic [6:0] opStore  = 7'b0100011;
    logic [6:0] opAuipc  = 7'b0010111;

    // funct3 - ALU
    logic [2:0] fnADD   = 3'b000;
    logic [2:0] fnSLL   = 3'b001;
    logic [2:0] fnSLT   = 3'b010;
    logic [2:0] fnSLTU  = 3'b011;
    logic [2:0] fnXOR   = 3'b100;
    logic [2:0] fnSR    = 3'b101;
    logic [2:0] fnOR    = 3'b110;
    logic [2:0] fnAND   = 3'b111;
    // funct3 - Branch
    logic [2:0] fnBEQ   = 3'b000;
    logic [2:0] fnBNE   = 3'b001;
    logic [2:0] fnBLT   = 3'b100;
    logic [2:0] fnBGE   = 3'b101;
    logic [2:0] fnBLTU  = 3'b110;
    logic [2:0] fnBGEU  = 3'b111;
    // funct3 - Load
    logic [2:0] fnLW    = 3'b010;
    logic [2:0] fnLB    = 3'b000;
    logic [2:0] fnLH    = 3'b001;
    logic [2:0] fnLBU   = 3'b100;
    logic [2:0] fnLHU   = 3'b101;
    // funct3 - Store
    logic [2:0] fnSW    = 3'b010;
    logic [2:0] fnSB    = 3'b000;
    logic [2:0] fnSH    = 3'b001;
    // funct3 - JALR
    logic [2:0] fnJALR  = 3'b000;

    // Return type for Execute function
    typedef struct packed{
        IType iType;
        MemFunc memFunc;
        logic [4:0] dst;
        logic[31:0]  data;
        logic[31:0] addr;
        logic[31:0] nextPc;
    } ExecInst;

module decode(
    input wire [31:0] inst,

    // output logic [4:0] dst,
    // output logic [4:0] src1,
    // output logic [4:0] src2,
    // output logic [31:0] imm,
    // output logic [3:0] itype,
    // output logic [2:0] br_func,
    // output logic [3:0] mem_func,
    // output logic [3:0] alu_func
    output DecodedInst dInst
);
  
logic [6:0] opcode, funct7;
logic [2:0] funct3;
logic [4:0] dst, src1, src2;
logic [31:0] immD32, immB32, immU32, immI32, immJ32, immS32;


    always_comb  begin
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


        // //default:
        // itype = 4'd9;
        // dst = 5'd0;
        // src1 = 5'd0;
        // src2 = 5'd0;
        // imm = immD32;
        // br_func = 'x;
        // alu_func = 'x;
        // mem_func = 'x;

        // dInst = '{Unsupported, 5'd0, 5'd0, 5'd0, immD32, 'x, 'x, 'x};
        dInst.iType = Unsupported;
        dInst.dst = 5'd0;
        dInst.src1 = 5'd0;
        dInst.src2 = 5'd0;
        dInst.imm = immD32;
        dInst.aluFunc = 'x;
        dInst.brFunc = 'x;
        dInst.memFunc = 'x;

        case (opcode)
            7'b0010111: begin                   // AUIPC
                dInst.iType = AUIPC;
                dInst.dst = dst;
                dInst.imm = immU32;
                // itype = 4'd8;
                // dst = inst_dst;
                // imm = immU32;
            end
            7'b0110111: begin                   //opLui
                dInst.iType = LUI;
                dInst.dst = dst;
                dInst.imm = immU32;
                // itype = 4'd3;
                // dst = inst_dst;
                // imm = immU32;
            end
            7'b0010011: begin                   //opOpImm
                dInst.iType = OPIMM;
                dInst.src1 = src1;
                dInst.imm = immI32;
                dInst.dst = dst;
                // itype = 4'd1;
                // src1 = inst_src1;
                // imm = immI32;
                // dst = inst_dst;

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

                // case (funct3)
                //     3'b001: begin                   //fnSLL
                //         if (funct7 == 7'b0) alu_func = funct3;
                //         else itype = 4'd9;
                //     end
                //     3'b101: begin                   //fnSR
                //         if (funct7 == 7'b0) alu_func = 4'b1000;               //fnSRL
                //         else if (funct7 == 7'b0100000) alu_func = 4'b1001;    //fnSRA
                //         else itype = 4'd9;
                //     end
                //     default: alu_func = funct3; //fnAND, fnOR, fnXOR, fnADD, fnSLT, fnSLTU
                // endcase
            end
            7'b0110011: begin                   //opOp
                dInst.iType = OP;
                dInst.dst = dst;
                dInst.src1 = src1;
                dInst.src2 = src2;
                // itype = 4'd0;
                // dst = inst_dst;
                // src1 = inst_src1;
                // src2 = inst_src2;

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

                // case (funct7)
                //     7'b0000000: begin
                //         alu_func = (funct3 == 3'b101)? 4'b1000: funct3;
                //     end
                //     7'b0100000: begin
                //         case (funct3)
                //             3'b000: alu_func = 4'b1010;    //Sub
                //             3'b101: alu_func = 4'b1001;    //Sra
                //             default: itype = 4'd9;
                //         endcase
                //     end
                //     7'b0000001: begin
                //         if (funct3 == 3'b1) alu_func = 4'b1011; //PMUL
                //         else itype = 4'd9;
                //     end
                //     default: itype = 4'd9; 
                // endcase
            end
            7'b1100011: begin                   //opBranch
                dInst.iType = BRANCH;
                dInst.dst = dst;
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

                // itype = 4'd2;
                // dst = inst_dst;
                // src1 = inst_src1;
                // src2 = inst_src2;
                // imm = immB32;
                
                // if ((funct3 == 3'b010) || (funct3 == 3'b011)) itype = 4'd9;
                // else br_func = funct3;
            end
            7'b1101111: begin                   //opJal
                // itype = 4'd4;
                // dst = inst_dst;
                // imm = immJ32;

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

                // itype = 4'd6;
                // dst = inst_dst;
                // src1 = inst_src1;
                // imm = immI32;

                // if ((funct3 == 3'b011) || (funct3 == 3'b110) || (funct3 == 3'b111)) itype = 4'd9; 
                // else mem_func = funct3;
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

                // itype = 4'd7;
                // src1 = inst_src1;
                // src2 = inst_src2;
                // imm = immS32;

                // case (funct3)
                //     3'b010: mem_func = 3'b011;      //SW
                //     3'b000: mem_func = 3'b110;      //SB
                //     3'b001: mem_func = 3'b111;      //SH
                //     default: itype = 4'd9;
                // endcase
            end
            7'b1100111: begin                   //opJalr

                dInst.dst = dst;
                dInst.src1 = src1;
                dInst.imm = immI32;

                case(funct3)
                    fnJALR: dInst.iType = JALR;
                    default: dInst.iType = Unsupported;
                endcase

                // dst = inst_dst;
                // src1 = inst_src1;
                // imm = immI32;

                // case(funct3)
                //     3'b000: itype = 4'd5;
                //     default: itype = 4'd9;
                // endcase
            end
            // default: itype = 4'd9;
            default: dInst.iType = Unsupported;
        endcase
    end

endmodule
`default_nettype wire