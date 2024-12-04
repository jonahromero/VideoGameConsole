
package ProcTypes;
    // Alu function enumeration
    typedef enum {Add, Sub, And, Or, Xor, Slt, Sltu, Sll, Srl, Sra, NopA} AluFunc;

    // Branch function enumeration
    typedef enum { Eq,Neq,Lt,Ltu,Ge,GeU,NopB} BrFunc;

    // Mem function enumeration
    typedef enum { Lw, Lh, Lhu, Lb, Lbu, Sw, Sh, Sb, NopM} MemFunc;

    // AUIPC added for this lab - Add Upper Immediate to PC
    typedef enum {OP, OPIMM, BRANCH, LUI, JAL, JALR, LOAD, STORE, AUIPC, PMUL, Unsupported} IType;

    // Return type for Decode function
    typedef struct {
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
    typedef struct {
        IType iType;
        MemFunc memFunc;
        logic [4:0] dst;
        logic[31:0]  data;
        logic[31:0] addr;
        logic[31:0] nextPc;
    } ExecInst;

endpackage