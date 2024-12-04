`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

function logic aluBr(logic[31:0] a, logic[31:0] b, BrFunc brfunc);
    logic ret = case(brFunc)
        Eq: ((a == b));
        Neq: ((a != b));
        Lt: ($signed(r_val1) < $signed(r_val2));
        Ltu: ((a < b));
        Ge: ($signed(r_val1) >= $signed(r_val2));
        Geu: ((a >= b));
        default: 1'b0;
    endcase
    return res
endfunction

function ExecInst execute(DecodedInst dInst, logic[31:0] r_val1,logic [31:0] r_val2, logic [31:0] pc);
    logic [31:0] imm, alu_val2,data, nextPc, addr;

    imm = dInst.imm;
    alu_val2 = (dInst.iType == OPIMM)? imm : r_val2;

    data = case (dInst.iType)
        AUIPC: (pc + imm);
        LUI: (imm);
        OP, OPIMM: (alu(rVal1, aluVal2, aluFunc));
        JAL, JALR: (pc + 4);
        STORE: (r_val2);
        default: 32'b0;
    endcase

    nextPc = case (dInst.iType)
        BRANCH: (aluBr(r_val1, r_val2, dInst.brFunc)? pc + imm: pc + 4);
        JAL: (pc + imm);
        JALR: ((r_val1 + imm) & 32'hFFFF_FFFE);
        default: (pc + 4);
    endcase

    addr = r_val1 + imm;

    return '{iType: dInst.iType, dst: dInst.dst, data: data, addr: addr, nextPc: nextPc, memFunc : dInst.memFunc}

endfunction

// module execute (
//     input DecodedInst dInst,
//     input wire [31:0] r_val1,
//     input wire [31:0] r_val2,
//     input wire [31:0] pc,

//     output ExecInst eInst
// );

// logic [31:0] imm, alu_val2, data; 
// logic alu_bool, alu_br_bool;

// alu a1(.val1(r_val1), .val2(alu_val2), .alufunc(alu_func),.alu_bool(alu_bool), .data_out(alu_out));

// always_comb begin
//     alu_bool = 1'b1;
//     alu_val2 = (d_itype == 4'd1)? d_imm : r_val2;

//     // Compute the correct value for data and nextPC
//     case (d_itype)
//         4'd8: begin                     // AUIPC
//             data = pc + d_imm; 
//             next_pc = pc + 4;
//             end       
//         4'd3: begin                     // LUI
//             data = d_imm; 
//             next_pc = pc + 4;
//         end            
//         4'd0: begin                     // OP
//             alu_bool = 1'b1; 
//             next_pc = pc + 4;  
//             data_out = alu_out;
//         end      
//         4'd1: begin                     // OPIMM
//             alu_bool = 1'b1;   
//             next_pc = pc + 4;
//             data_out = alu_out;
//         end       
//         4'd4: begin                     // JAL
//             data = pc + 4; 
//             next_pc = pc + d_imm;
//         end           
//         4'd5: begin                     // JALR
//             data = pc + 4; 
//             next_pc = (r_val1 + d_imm) & 32'hFFFF_FFFE;             
//         end            
//         4'd7: begin                     // STORE
//             data = r_val2; 
//             next_pc = pc + 4;
//         end   
//         4'd2: begin                     // BRANCH
//             case (br_func)
//                 3'd0: alu_br_bool = (r_val1 == r_val2);                 //Eq
//                 3'd1: alu_br_bool = (r_val1 != r_val2);                 //Neq
//                 3'd2: alu_br_bool = $signed(r_val1) < $signed(r_val2);  //Lt
//                 3'd3: alu_br_bool = r_val1 < r_val2;                    //Ltu
//                 3'd4: alu_br_bool = $signed(r_val1) >= $signed(r_val2); //Ge
//                 3'd5: alu_br_bool = r_val1 >= r_val2;                   //Geu
//                 default: alu_br_bool = 1'b0;
//             endcase

//             next_pc = alu_br_bool? pc + d_imm : pc + 4;
//         end        
//         default: begin 
//             data = 32'b0;
//             next_pc = pc + 4;
//         end 
//     endcase

//     addr = r_val1 + d_imm;
//     e_itype = d_itype;
//     e_dst = d_dst;
//     e_mem_func = mem_func;

// end

// endmodule

`default_nettype wire