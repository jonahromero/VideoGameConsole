
/* Helpful functions:
function automatic logic [31:0] alu(
    input logic [31:0] val1,
    input logic [31:0] val2,
    input AluFunc alufunc
);

function automatic DecodedInst decode(
    input logic [31:0] inst
);

function automatic ExecInst execute(
    input DecodedInst dInst, 
    input logic[31:0] r_val1,
    input logic [31:0] r_val2, 
    input logic [31:0] pc
);

function automatic logic aluBr(
    input logic [31:0] a, 
    input logic [31:0] b, 
    input BrFunc brfunc
);

Types
=====
DecodedInstr
ExecInstr
*/

import ProcTypes::*;

module simple_proc(
    input wire  rst_in,
    input wire clk_in,
    memory_bus mem_bus,
    program_memory_bus program_mem_bus
);
    // helper for counting cycles
    logic[5:0] counter;

    // which state our processor is in
    typedef enum { FETCH_DECODE, EXECUTE, MEM, WRITEBACK } stage_t;
    stage_t stage;

    // processor stage states
    DecodedInst dInstr;
    ExecInst eInstr;

    logic[31:0] pc;
    logic[31:0] regfile[31:0];

    always_comb begin
        program_mem_bus.addr = pc;
    end
    
    // DEBUGGING
    logic[31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
    logic[31:0] t0, t1, t2, t3, t4, t5, t6;
    logic[31:0] a0, a1, a2, a3, a4, a5, a6, a7;
    logic[31:0] tp, gp, sp, ra, zero;
    always_comb begin
        zero = regfile[0];
        ra = regfile[1];
        sp = regfile[2];
        gp = regfile[3];
        tp = regfile[4];
        t0 = regfile[5];
        t1 = regfile[6];
        t2 = regfile[7];
        s0 = regfile[8];
        s1 = regfile[9];
        a0 = regfile[10];
        a1 = regfile[11];
        a2 = regfile[12];
        a3 = regfile[13];
        a4 = regfile[14];
        a5 = regfile[15];
        a6 = regfile[16];
        a7 = regfile[17];
        s2 = regfile[18];
        s3 = regfile[19];
        s4 = regfile[20];
        s5 = regfile[21];
        s6 = regfile[22];
        s7 = regfile[23];
        s8 = regfile[24];
        s9 = regfile[25];
        s10 = regfile[26];
        s11 = regfile[27];
        t3 = regfile[28];
        t4 = regfile[29];
        t5 = regfile[30];
        t6 = regfile[31];
    end
    

    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            stage <= FETCH_DECODE;
            counter <= 0;
            mem_bus.dispatch_read <= 0;
            mem_bus.dispatch_write <= 0;
            for (int i = 0; i < 32; i++) begin
                regfile[i] <= 0;
            end
            pc <= 0;
        end
        else begin
            counter <= counter + 1;
            case (stage)
            FETCH_DECODE: begin
                if (counter + 1 == 3) begin
                    stage <= EXECUTE;
                    dInstr <= decode(program_mem_bus.instr);
                    counter <= 0;
                end
            end
            EXECUTE: begin
                eInstr <= execute(dInstr, regfile[dInstr.src1], regfile[dInstr.src2], pc);
                stage <= MEM;
            end
            MEM: begin
                if (!mem_bus.busy) begin
                    stage <= WRITEBACK;
                    if (eInstr.iType == STORE || eInstr.iType == LOAD) begin
                        mem_bus.addr <= eInstr.addr;
                        case (eInstr.memFunc)
                            Lw: mem_bus.mem_width <= mem::DWORD;
                            Lh: mem_bus.mem_width <= mem::WORD;
                            Lhu: mem_bus.mem_width <= mem::WORD;
                            Lb: mem_bus.mem_width <= mem::BYTE;
                            Lbu: mem_bus.mem_width <= mem::BYTE;
                            // TODO - sign extension
                            Sw: mem_bus.mem_width <= mem::DWORD;
                            Sh: mem_bus.mem_width <= mem::WORD;
                            Sb: mem_bus.mem_width <= mem::BYTE;
                            NopM:;
                        endcase
                    end
                    if (eInstr.iType == STORE) begin
                        if (!mem_bus.busy) begin
                            mem_bus.dispatch_write <= 1;
                            mem_bus.write_data <= eInstr.data;
                        end
                    end
                    else if (eInstr.iType == LOAD) begin
                        if (!mem_bus.busy) begin
                            mem_bus.dispatch_read <= 1;
                        end
                    end
                end
            end
            WRITEBACK: begin
                if ((eInstr.iType == STORE || eInstr.iType == LOAD) && mem_bus.busy) begin
                    // if its a memory operation and the bus is busy, do nothing and wait
                end
                else begin
                    if (eInstr.iType == LOAD) begin
                        regfile[eInstr.dst] <= mem_bus.read_data;
                    end
                    else begin
                        regfile[eInstr.dst] <= eInstr.data;
                    end
                    // update pc
                    pc <= eInstr.nextPc;
                    counter <= 0;
                    stage <= FETCH_DECODE;
                    // reset MISC
//                    dInstr <= 0;
//                    dInstr <= 0;
//                    dInstr <= 0;
//                    dInstr <= 0;
                    
//                    eInstr.iType <= Unsupported;
//                    eInstr.iType <= 0;
//                    eInstr.iType <= 0;
                end
            end
            endcase
            // single cycles for the mem_bus.
            if (mem_bus.dispatch_read) begin
                mem_bus.dispatch_read <= 0;
            end
            if (mem_bus.dispatch_write) begin
                mem_bus.dispatch_write <= 0;
            end
        end
    end
endmodule