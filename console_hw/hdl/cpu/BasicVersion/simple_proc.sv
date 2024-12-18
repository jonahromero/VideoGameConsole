
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
    input wire [15:0] sw,
    memory_bus mem_bus,
    program_memory_bus program_mem_bus,
    
    output logic [31:0] reg_file [31:0],
    output logic [31:0] pc_out 
);
    // helper for counting cycles
    logic[5:0] counter;

    // which state our processor is in
    typedef enum { FETCH_DECODE, EXECUTE, MEM, WRITEBACK } stage_t;
    stage_t stage;

    // processor stage states
    DecodedInst dInstr;
    ExecInst eInstr;

    logic[31:0] pc, pc_out;
    logic[31:0] regfile[31:0];
    logic old_sw2;

    always_comb begin
        program_mem_bus.addr = pc;
        reg_file = regfile;
    end
    
    // DEBUGGING
//    logic[31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
//    logic[31:0] t0, t1, t2, t3, t4, t5, t6;
//    logic[31:0] a0, a1, a2, a3, a4, a5, a6, a7;
//    logic[31:0] tp, gp, sp, ra, zero;
//    always_comb begin
//        zero = regfile[0];
//        ra = regfile[1];
//        sp = regfile[2];
//        gp = regfile[3];
//        tp = regfile[4];
//        t0 = regfile[5];
//        t1 = regfile[6];
//        t2 = regfile[7];
//        s0 = regfile[8];
//        s1 = regfile[9];
//        a0 = regfile[10];
//        a1 = regfile[11];
//        a2 = regfile[12];
//        a3 = regfile[13];
//        a4 = regfile[14];
//        a5 = regfile[15];
//        a6 = regfile[16];
//        a7 = regfile[17];
//        s2 = regfile[18];
//        s3 = regfile[19];
//        s4 = regfile[20];
//        s5 = regfile[21];
//        s6 = regfile[22];
//        s7 = regfile[23];
//        s8 = regfile[24];
//        s9 = regfile[25];
//        s10 = regfile[26];
//        s11 = regfile[27];
//        t3 = regfile[28];
//        t4 = regfile[29];
//        t5 = regfile[30];
//        t6 = regfile[31];
//    end

    

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
                    old_sw2 <= sw[2];
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
                            LW: mem_bus.mem_width <= mem::DWORD;
                            LH: mem_bus.mem_width <= mem::WORD;
                            LHU: mem_bus.mem_width <= mem::WORD;
                            LB: mem_bus.mem_width <= mem::BYTE;
                            LBU: mem_bus.mem_width <= mem::BYTE;
                            // TODO - sign extension
                            SW: mem_bus.mem_width <= mem::DWORD;
                            SH: mem_bus.mem_width <= mem::WORD;
                            SB: mem_bus.mem_width <= mem::BYTE;
                            NOPM:;
                        endcase
                    end
                    if (eInstr.iType == STORE) begin
                        mem_bus.dispatch_write <= 1;
                        mem_bus.write_data <= eInstr.data;
                    end
                    else if (eInstr.iType == LOAD) begin
                        mem_bus.dispatch_read <= 1;
                    end
                end
            end
            WRITEBACK: begin
                if ((eInstr.iType == STORE || eInstr.iType == LOAD) && mem_bus.busy) begin
                    // if its a memory operation and the bus is busy, do nothing and wait
                end
                else begin
                    if (eInstr.iType == LOAD) begin
                        case (eInstr.memFunc)
                            LW:  regfile[eInstr.dst] <= mem_bus.read_data;
                            
                            LH:  regfile[eInstr.dst] <= (mem_bus.read_data[15])? {16'hFF_FF, mem_bus.read_data[15:0] }: {16'h00_00, mem_bus.read_data[15:0] }; 
                            LHU: regfile[eInstr.dst] <= { 16'h00_00, mem_bus.read_data[15:0] };
                            
                            LB:  regfile[eInstr.dst] <= (mem_bus.read_data[7])? {24'hFF_FF_FF, mem_bus.read_data[7:0] }: {24'h00_00_00, mem_bus.read_data[7:0] }; 
                            LBU: regfile[eInstr.dst] <= {24'h00_00_00, mem_bus.read_data[7:0]};
                            default: regfile[eInstr.dst] <= 32'h45_45_45_45; // shouldnt happen
                        endcase
                    end
                    // if instr isnt the zero register
                    else if (eInstr.dst != 0) begin
                        regfile[eInstr.dst] <= eInstr.data;
                    end
                    // update pc
                    pc <= eInstr.nextPc;
                    counter <= 0;
                    
                    if(sw[0]) begin
                        if (old_sw2 != sw[2]) begin 
                            stage <= FETCH_DECODE;
                            old_sw2 <= sw[2];
                        end
                    end else stage <= FETCH_DECODE;
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

