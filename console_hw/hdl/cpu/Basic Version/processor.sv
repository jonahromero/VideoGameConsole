`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

// Types associated with the Fetch Stage
typedef enum {
    Dequeue, // Consume instruction at the f2d output, if any
    Stall, // Do not consume instruction at f2d
    Redirect  // Redirect fetch to another PC, annulling any fetched instructions
} FetchAction;

typedef struct packed{
    FetchAction fetchAction;
    logic [31:0] redirectPC;  // PC to fetch from, used only if fetchAction is Redirect
} FetchInput;

typedef struct packed{
    logic [16:0] pc;
    logic [31:0] inst;
    logic isValid;
} F2D;

typedef struct packed{
    logic [31:0] pc;
    DecodedInst dInst;
    logic [31:0] rVal1;
    logic [31:0] rVal2;
    logic isValid;
    // Add anything you need
} D2E;

typedef struct packed{
    logic[31:0] pc;
    IType iType;
    logic[4:0] dst;
    MemFunc memFunc;
    logic[31:0] data;
    logic isValid;
    // Add anything you need
} E2W;

typedef struct packed{
    logic [31:0] data;
    logic isValid;
} Maybe;

module fetch (
    input wire clk_in,
    input wire rst_in,
    input FetchInput f_in,
    program_memory_bus  program_mem_bus,

    output F2D f2d                    // Contains PC and requested instruction
);

    logic [31:0] fetch_pc,f2d_tp, f2d_tp1;

    always_comb begin
        fetch_action = f_in.fetchAction;
        program_mem_bus.addr = fetch_pc;
        case (fetch_action)
            REDIRECT: begin
                // f2d = '{pc: 'x, inst: 'x, isValid:1'b0}; // Invalid Instruction
                f2d.pc = 'x;
                f2d.inst = 'x;
                f2d.isValid = 1'b0;
            end
            default: begin
            // f2d = '{pc: f2d_tp1, inst:program_mem_bus.write_data, isValid:1'b1};
                f2d.pc = f2d_tp1;
                f2d.inst = program_mem_bus.write_data;
                f2d.isValid = 1'b1;
            end
        endcase
    end

    always_ff @(posedge clk_in ) begin
        if (rst_in) begin
            f2d_tp <= 'x;
            f2d_tp1 <= 'x;
            fetch_pc <= 32'b0;
        end
        else begin
            case (fetch_action)
                REDIRECT: begin                    
                    fetch_pc <= f_in.redirectPC << 3;
                    f2d_tp <= 32'hFFFF_FFFF;
                    f2d_tp1 <= 32'hFFFF_FFFF;
                end
                STALL: begin                    
                    f2d_tp1 <= f2d_tp;
                    f2d_tp <= fetch_pc;
                end
                DEQUEUE: begin                 
                    f2d_tp <= fetch_pc + 6'd32;
                    f2d_tp1 <= f2d_tp;
                    fetch_pc <= fetch_pc + 6'd32;
                end
                default: begin
                    f2d_tp <= fetch_pc;
                    f2d_tp1 <= f2d_tp;
                end
            endcase
        end
    end

endmodule 

module cpu(
    input wire  rst_in,
    input wire clk_in,
    memory_bus mem_bus,
    program_memory_bus program_mem_bus
);

    // Peformance counters
    logic [31:0] cycle;
    logic [31:0] instrs;

    // Pipeline Registers
    F2D f2d;
    D2E d2e;
    D2E d2e_tp;
    E2W e2w;
    E2W e2w_tp;

    // Variables associated with the Writeback Stage
    // Signals used by decode to handle data hazards
    logic [4:0] dstW;
    logic [31:0] dataW;

    // Signal for dCache-induced stalls
    logic dDataStall;

    // Variables associated with the Execute Stage
    // Signals used to handle mispredictions
    logic annul;
    logic [31:0] redirectPC;

    // Signals used by decode to handle data hazards
    logic [4:0] dstE;
    Maybe dataE;

    // Signal for dCache-induced stalls
    logic dReqStall;

    ExecInst eInst;

    // Variables associated with the Decode Stage
    // Signal for decode stalls
    logic hazardStall;
    logic [31:0] r_val1;
    logic [31:0] r_val2;

    // Variables associated with the Fetch Stage
    FetchInput f_in;

    // Register File
    logic [5:0][31:0] rf;

    fetch read_only(.clk_in(clk_in), .rst_in(rst_in), .f_in(f_in), .program_mem_bus(program_mem_bus), .f2d(f2d));

    always_comb begin
        cycle = cycle + 1'd1;

        /////////////////////
        // Writeback Stage //
        /////////////////////
        dstW = 5'b0;
        dataW = 'x;
        dDataStall = 1'b0;

        if (e2w.isValid) begin
            if(e2w.dst != 5'b0) begin
                if (e2w.iType == LOAD) begin
                    if(mem_bus.busy) dDataStall = 1'b1;
                    else begin
                        if (e2w.memFunc == Lw) rf[e2w.dst] = mem_bus.write_data;
                        if (e2w.memFunc == Lh) rf[e2w.dst] = (mem_bus.write_data[15])? {16'hFFFF, mem_bus.write_data}: {16'h0, mem_bus.write_data}; 
                        if (e2w.memFunc == Lhu) rf[e2w.dst] = {16'h0, mem_bus.write_data};
                        if (e2w.memFunc == Lb) rf[e2w.dst] = (mem_bus.write_data[7])? {24'hFF_FFFF, mem_bus.write_data} : {24'h0, mem_bus.write_data};
                        if (e2w.memFunc == Lbu) rf[e2w.dst] = {24'h0, mem_bus.write_data}; 
                        end
                    end
                end
                // else if ((e2w_v.iType == PMUL)) begin
                // end
                else begin
                    rf[e2w.dst] = e2w.data;
                    dataW = e2w.data;
                end
                dstW = e2w.dst;

                instrs = instrs + 1;

                // if (e2w.iType == Unsupported) begin //Handles unsupportd instructions
                // end
            end
                    

        ///////////////////
        // Execute Stage //
        ///////////////////
        annul = 1'b0;
        redirectPC = 'x;

        dstE = 5'b0;
        dataE.isValid = 1'b0;

        dReqStall = 1'b0;

        if ((d2e.isValid) & (!dDataStall)) begin
            eInst = execute(d2e.dInst, d2e.r_val1, d2e.r_val2, d2e.pc);

            if (eInst.iType == LOAD || eInst.iType == STORE) begin
                if(eInst.iType == LOAD) begin
                    // e2w_tp = '{pc: d2e.pc, iType: eInst.iType, dst: eInst.dst, eInst: eInst, data: 'x, isValid:1'b1}; 
                    e2w_tp.pc = d2e.pc;
                    e2w_tp.iType = eInst.iType;
                    e2w_tp.dst = eInst.dst;
                    e2w_tp.memFunc = eInst.memFunc;
                    e2w_tp.data = 'x;
                    e2w_tp.isValid = 1'b1;
                end
                else if (eInst.iType == STORE) begin
                    // e2w_tp = '{pc: d2e.pc, iType: eInst.iType, dst: 5'b0,eInst: eInst, data:'x, isValid:1'b1};
                    e2w_tp.pc = d2e.pc;
                    e2w_tp.iType = eInst.iType;
                    e2w_tp.dst = 5'd0;
                    e2w_tp.memFunc = eInst.memFunc;
                    e2w_tp.data = 'x;
                    e2w_tp.isValid = 1'b1;
                end
                if (mem_bus.busy) dReqStall = 1'b1;
                else begin
                    mem_bus.addr = eInst.addr;
                    if ((eInst.memFunc == Lb) || (eInst.memFunc == Lbu) || (eInst.memFunc == Sb)) mem_bus.mem_width = mem::BYTE;
                    else if ((eInst.memFunc == Lh) || (eInst.memFunc == Lhu) || (eInst.memFunc == Sh)) mem_bus.mem_width = mem::WORD;
                    else if ((eInst.memFunc == Lw) || (eInst.memFunc == Sw)) mem_bus.mem_width = mem::DWORD;

                    if (eInst.iType == LOAD) mem_bus.dispatch_read = 1'b1;
                    else if (eInst.iType == STORE) begin
                        mem_bus.dispatch_write = 1'b1;
                        mem_bus.write_data = eInst.data;
                    end
                end
            end else begin
                // e2w_tp = '{pc: d2e_v.pc, iType: eInst.iType, dst: eInst.dst,eInst: eInst, data: eInst.data, isValid:1'b1};
                e2w_tp.pc = d2e.pc;
                e2w_tp.iType = eInst.iType;
                e2w_tp.dst = eInst.dst;
                e2w_tp.memFunc = eInst.memFunc;
                e2w_tp.data = eInst.data;
                e2w_tp.isValid = 1'b1;
            end

            // Optional PMUL Code here

            
            if (!dReqStall) begin
                dstE = eInst.dst;
                if ((eInst.iType != LOAD)) begin
                     dataE.data = eInst.data;
                     dataE.isValid = 1'b1;
                end
                if(eInst.nextPc != (d2e_v.pc + 32'd4)) begin
                    annul = 1'b1;
                    redirectPC = eInst.nextPc;
                end
            end
        end

        //////////////////
        // Decode Stage //
        //////////////////
        hazardStall = 1'b0;

        if((f2d.isValid) && (!dDataStall) && (!dReqStall)) begin
            dInst = decode(f2d.inst);

            r_val1 = rf[dInst.src1];
            r_val2 = rf[dInst.src2];

            if ((dstE != 0) && dataE.isValid) begin
                if (dstE == dInst.src1) r_val1 = dataE.data; //Bypassing dataE into rd1
                if (dst == dInst.src2) r_val2 = dataE.data; //Bypassing dataE into rd2
            end else if ((dst != 0) && (!dataE.isValid)) hazardStall = 1'b1;

            if ((dstW != 0) && (dstW != dstE)) begin
                if (dstW == dInst.src1) r_val1 = dataW;
                if (dstW == dInst.src2) r_val2 = dataW;
            end

            if ((!annul) && (!hazardStall)) begin
                //  d2e_tp = '{pc: f2d.pc, dInst: dInst, rVal1: r_val1, rVal2: r_val2, isValid: 1'b1};
                d2e_tp.pc = f2d.pc;
                d2e_tp.dInst = dInst;
                d2e_tp.rVal1 = r_val1;
                d2e_tp.rVal2 = r_val2;
                d2e_tp.isValid = 1'b1;
            end
        end


        ///////////////////////
        // Drive fetch stage //
        ///////////////////////

        if (annul) begin 
            // f_in = '{fetchAction: Redirect, redirectPC: redirectPC};
            f_in.fetchAction = Redirect;
            f_in.redirectPC = redirectPC;
        end
        else if ((!f2d.isValid) || hazardStall || dDataStall || dReqStall) begin
            f_in.fetchAction = Stall;
            f_in.redirectPC = 'x;
        //  f_in = '{fetchAction: Stall, redirectPC: 'x};
        end
        else begin
            // f_in = '{fetchAction: Dequeue, redirectPC: 'x};
            f_in.fetchAction = Dequeue;
            f_in.redirectPC = 'x;
        end
    end

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            cycle <= 0;
            instrs <= 0;
        end
        else begin
            ///////////////////
            // Execute Stage //
            ///////////////////

            if (dReqStall) e2w.isValid <= 1'b0;
            else e2w <= e2w_tp;

            if(!dDataStall) e2w.isValid <= 1'b0;

            //////////////////
            // Decode Stage //
            //////////////////

            if (annul) d2e.isValid <= 1'b0;
            else if(hazardStall) d2e.isValid <= 1'b0;
            else begin
                d2e <= d2e_tp;
            end

            if ((!dDataStall) && (!dReqStall)) d2e.isValid <= 1'b0;

            ///////////////////////
            // Drive fetch stage //
            ///////////////////////

        end
    end
endmodule // processor

`default_nettype wire