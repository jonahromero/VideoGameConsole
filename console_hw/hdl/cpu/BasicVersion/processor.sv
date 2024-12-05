`timescale 1ns / 1ps
`default_nettype none

import ProcTypes::*;

// Types associated with the Fetch Stage
typedef enum {
    DEQUEUE, // Consume instruction at the f2d output, if any
    STALL, // Do not consume instruction at f2d
    REDIRECT  // Redirect fetch to another PC, annulling any fetched instructions
} FetchAction;

typedef struct {
    FetchAction fetchAction;
    logic [31:0] redirectPC;  // PC to fetch from, used only if fetchAction is Redirect
} FetchInput;

typedef struct {
    logic [16:0] pc;
    logic [31:0] instr;
    logic isValid;
} F2D;

typedef struct {
    logic [31:0] pc;
    DecodedInst dInst;
    logic [31:0] rVal1;
    logic [31:0] rVal2;
    logic isValid;
    // Add anything you need
} D2E;

typedef struct {
    logic[31:0] pc;
    IType iType;
    logic[4:0] dst;
    MemFunc memFunc;
    logic[31:0] data;
    logic isValid;
    // Add anything you need
} E2W;

typedef struct {
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

    logic [31:0] fetch_pc;

    // always_comb begin
    //     fetch_action = f_in.fetchAction;
    //     program_mem_bus.addr = fetch_pc;
    //     program_mem_bus.read_request = 1'b1;
    //     // case (fetch_action)
    //     //     Redirect: begin
    //     //         f2d = '{pc: 'x, inst: 'x, isValid:1'b0}; // Invalid Instruction
    //     //     end
    //     //     default: begin
    //     //         if (program_mem_bus.data_valid) f2d = '{pc: f2d_tp1, inst:program_mem_bus.instr, isValid:1'b1};
    //     //         else f2d = '{pc: 'x, inst: 'x, isValid:1'b0};
    //     //     end
    //     // endcase
    // end

    always_ff @(posedge clk_in ) begin
        // if (rst_in) begin
        //     f2d_tp <= '{data:32'hFFFF_FFFF, isValid:1'b0};
        //     f2d_tp1 <= '{data:32'hFFFF_FFFF, isValid:1'b0};
        //     fetch_pc <= 32'b0;
        // end
        // else begin
            // case (fetch_action)
            //     Redirect: begin                    
            //         fetch_pc <= f_in.redirectPC;
            //         f2d_tp.isValid <= 1'b0;
            //         f2d_tp1.isValid <= 1'b0;
            //         f2d <= '{pc: 32'hFFFF_FFFF, inst: 32'h0000_0013, isValid: 1'b0}; 
            //     end
            //     Stall: begin                    
            //         f2d_tp1<= f2d_tp1;
            //         f2d_tp <= f2d_tp;
            //         fetch_pc <= fetch_pc;
            //     end
            //     Dequeue: begin
            //         if (program_mem_bus.data_valid) begin                 
            //             f2d_tp <= '{data:fetch_pc + 32'd32, isValid:1'b1};
            //             f2d_tp1 <= f2d_tp;
            //             fetch_pc <= fetch_pc + 32'd32;
            //             if (f2d_tp1.isValid) f2d <= '{pc: f2d_tp1.data, inst: program_mem_bus.instr, isValid:1'b1};
            //             else f2d <= '{pc: 32'hFFFF_FFFF, inst: 32'h0000_0013, isValid: 1'b0};
            //         end
            //         else f2d <= '{pc: 32'hFFFF_FFFF, inst: 32'h0000_0013, isValid: 1'b0};
            //     end
            //     default: begin
            //         if (program_mem_bus.data_valid) begin                 
            //             f2d_tp <= '{data:fetch_pc + 32'd32, isValid:1'b1};
            //             f2d_tp1 <= f2d_tp;
            //             fetch_pc <= fetch_pc + 32'd32;
            //             if (f2d_tp1.isValid) f2d <= '{pc: f2d_tp1.data, inst: program_mem_bus.instr, isValid:1'b1};
            //             else f2d <= '{pc: 32'hFFFF_FFFF, inst: 32'h0000_0013, isValid: 1'b0};
            //         end
            //         else f2d <= '{pc: 32'hFFFF_FFFF, inst: 32'h0000_0013, isValid: 1'b0};
            //     end
            // endcase
        if (rst_in) begin
            fetch_pc <= 32'b0;
        end
        else begin
            case (f_in.fetchAction)
                REDIRECT: begin
                    f2d <= '{pc: 32'hFFFF_FFFF, instr: 32'h0000_0013, isValid:1'b0};
                    fetch_pc <= f_in.redirectPC;
                    program_mem_bus.addr <= f_in.redirectPC;
                    program_mem_bus.read_request <= 1'b1;
                end
                // STALL: begin
                    
                // end
                DEQUEUE: begin
                    if(program_mem_bus.data_valid) begin 
                        f2d <= '{pc: fetch_pc, instr: program_mem_bus.instr, isValid:1'b1};
                        fetch_pc <= fetch_pc + 32'd4;
                        program_mem_bus.addr <= fetch_pc;
                        program_mem_bus.read_request <= 1'b1;
                    end else f2d <= '{pc: 32'hFFFF_FFFF, instr: 32'h0000_0013, isValid: 1'b0};
                end
                default: begin
                    if(program_mem_bus.data_valid) begin 
                        f2d <= '{pc: fetch_pc, instr: program_mem_bus.instr, isValid:1'b1};
                        fetch_pc <= fetch_pc + 32'd4;
                        program_mem_bus.addr <= fetch_pc;
                        program_mem_bus.read_request <= 1'b1;
                    end else f2d <= '{pc: 32'hFFFF_FFFF, instr: 32'h0000_0013, isValid: 1'b0};
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

    ila_0 your_instance_name (
        .clk(clk_in), // input wire clk

        .probe0(rf[0]), // input wire [31:0]  probe0  
        .probe1(rf[1]), // input wire [31:0]  probe1 
        .probe2(rf[2]), // input wire [31:0]  probe2 
        .probe3(rf[3]), // input wire [31:0]  probe3 
        .probe4(rf[4]), // input wire [31:0]  probe4 
        .probe5(rf[5]), // input wire [31:0]  probe5 
        .probe6(rf[6]), // input wire [31:0]  probe6 
        .probe7(rf[7]), // input wire [31:0]  probe7 
        .probe8(rf[8]), // input wire [31:0]  probe8 
        .probe9(rf[9]), // input wire [31:0]  probe9 
        .probe10(rf[10]), // input wire [31:0]  probe10 
        .probe11(rf[11]), // input wire [31:0]  probe11 
        .probe12(rf[12]), // input wire [31:0]  probe12 
        .probe13(rf[13]), // input wire [31:0]  probe13 
        .probe14(rf[14]), // input wire [31:0]  probe14 
        .probe15(rf[15]), // input wire [31:0]  probe15 
        .probe16(rf[16]), // input wire [31:0]  probe16 
        .probe17(rf[17]), // input wire [31:0]  probe17 
        .probe18(rf[18]), // input wire [31:0]  probe18 
        .probe19(rf[19]), // input wire [31:0]  probe19 
        .probe20(rf[20]), // input wire [31:0]  probe20 
        .probe21(rf[21]), // input wire [31:0]  probe21 
        .probe22(rf[22]), // input wire [31:0]  probe22 
        .probe23(rf[23]), // input wire [31:0]  probe23 
        .probe24(rf[24]), // input wire [31:0]  probe24 
        .probe25(rf[25]), // input wire [31:0]  probe25 
        .probe26(rf[26]), // input wire [31:0]  probe26 
        .probe27(rf[27]), // input wire [31:0]  probe27 
        .probe28(rf[28]), // input wire [31:0]  probe28 
        .probe29(rf[29]), // input wire [31:0]  probe29 
        .probe30(rf[30]), // input wire [31:0]  probe30 
        .probe31(rf[31]) // input wire [31:0]  probe31
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
    DecodedInst dInst;

    // Register File
    logic [31:0][31:0] rf;

    fetch read_only(.clk_in(clk_in), .rst_in(rst_in), .f_in(f_in), .program_mem_bus(program_mem_bus), .f2d(f2d));

    always_comb begin
        if (!mem_bus.busy) begin
            mem_bus.dispatch_read = 1'b0;
            mem_bus.dispatch_write = 1'b0;
        end

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
                    // else begin
                    //     if (e2w.memFunc == Lw) rf[e2w.dst] = mem_bus.write_data;
                    //     if (e2w.memFunc == Lh) rf[e2w.dst] = (mem_bus.write_data[15])? {16'hFFFF, mem_bus.write_data}: {16'h0, mem_bus.write_data}; 
                    //     if (e2w.memFunc == Lhu) rf[e2w.dst] = {16'h0, mem_bus.write_data};
                    //     if (e2w.memFunc == Lb) rf[e2w.dst] = (mem_bus.write_data[7])? {24'hFF_FFFF, mem_bus.write_data} : {24'h0, mem_bus.write_data};
                    //     if (e2w.memFunc == Lbu) rf[e2w.dst] = {24'h0, mem_bus.write_data}; 
                    //     end
                    end
                end
                // else if ((e2w_v.iType == PMUL)) begin
                // end
                else begin
                    // rf[e2w.dst] = e2w.data;
                    dataW = e2w.data;
                end
                // dstW = e2w.dst;

                // instrs = instrs + 1;

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
            eInst = execute(d2e.dInst, d2e.rVal1, d2e.rVal2, d2e.pc);

            if (eInst.iType == LOAD || eInst.iType == STORE) begin
                if(eInst.iType == LOAD) begin
                    e2w_tp = '{pc: d2e.pc, iType: eInst.iType, dst: eInst.dst, memFunc: eInst.memFunc, data: 'x, isValid:1'b1}; 
                end
                else if (eInst.iType == STORE) begin
                    e2w_tp = '{pc: d2e.pc, iType: eInst.iType, dst: 5'b0, memFunc: eInst.memFunc, data:'x, isValid:1'b1};
                end
                if (mem_bus.busy) dReqStall = 1'b1;
                else begin
                    mem_bus.addr = eInst.addr;
                    if ((eInst.memFunc == Lb) || (eInst.memFunc == Lbu) || (eInst.memFunc == Sb)) mem_bus.mem_width = mem::BYTE;
                    else if ((eInst.memFunc == Lh) || (eInst.memFunc == Lhu) || (eInst.memFunc == Sh)) mem_bus.mem_width = mem::WORD;
                    else if ((eInst.memFunc == Lw) || (eInst.memFunc == Sw)) mem_bus.mem_width = mem::DWORD;

                    if (eInst.iType == LOAD) begin 
                        mem_bus.dispatch_read = 1'b1;
                        mem_bus.dispatch_write = 1'b0;
                        mem_bus.write_data = 32'b0;
                    end
                    else if (eInst.iType == STORE) begin
                        mem_bus.dispatch_write = 1'b1;
                        mem_bus.dispatch_read = 1'b0;
                        mem_bus.write_data = eInst.data;
                    end
                end
            end else begin
                e2w_tp = '{pc: d2e.pc, iType: eInst.iType, dst: eInst.dst, memFunc: eInst.memFunc, data: eInst.data, isValid:1'b1};
            end

            // Optional PMUL Code here

            
            if (!dReqStall) begin
                dstE = eInst.dst;
                if ((eInst.iType != LOAD)) begin
                     dataE.data = eInst.data;
                     dataE.isValid = 1'b1;
                end
                if(eInst.nextPc != (d2e.pc + 32'd4)) begin
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
            dInst = decode(f2d.instr);

            r_val1 = rf[dInst.src1];
            r_val2 = rf[dInst.src2];

            if ((dstE != 0) && dataE.isValid) begin
                if (dstE == dInst.src1) r_val1 = dataE.data; //Bypassing dataE into rd1
                if (dstE == dInst.src2) r_val2 = dataE.data; //Bypassing dataE into rd2
            end else if ((dstE != 0) && (!dataE.isValid)) hazardStall = 1'b1;

            if ((dstW != 0) && (dstW != dstE)) begin
                if (dstW == dInst.src1) r_val1 = dataW;
                if (dstW == dInst.src2) r_val2 = dataW;
            end

            if ((!annul) && (!hazardStall)) begin
                 d2e_tp = '{pc: f2d.pc, dInst: dInst, rVal1: r_val1, rVal2: r_val2, isValid: 1'b1};
            end
        end


        ///////////////////////
        // Drive fetch stage //
        ///////////////////////

        if (annul) begin 
            // f_in = '{fetchAction: Redirect, redirectPC: redirectPC};
            f_in.fetchAction = REDIRECT;
            f_in.redirectPC = redirectPC;
        end
        else if ((!f2d.isValid) || hazardStall || dDataStall || dReqStall) begin
            f_in.fetchAction = STALL;
            f_in.redirectPC = 'x;
        //  f_in = '{fetchAction: Stall, redirectPC: 'x};
        end
        else begin
            // f_in = '{fetchAction: Dequeue, redirectPC: 'x};
            f_in.fetchAction = DEQUEUE;
            f_in.redirectPC = 'x;
        end
    end

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            cycle <= 0;
            instrs <= 0;
        end
        else begin

            /////////////////////
            // Writeback Stage //
            /////////////////////

            if (e2w.isValid) begin
                if(e2w.dst != 5'b0) begin
                    if (e2w.iType == LOAD) begin
                        if(!mem_bus.busy) begin
                            if (e2w.memFunc == Lw) rf[e2w.dst] <= mem_bus.write_data;
                            if (e2w.memFunc == Lh) rf[e2w.dst] <= (mem_bus.write_data[15])? {16'hFFFF, mem_bus.write_data}: {16'h0, mem_bus.write_data}; 
                            if (e2w.memFunc == Lhu) rf[e2w.dst] <= {16'h0, mem_bus.write_data};
                            if (e2w.memFunc == Lb) rf[e2w.dst] <= (mem_bus.write_data[7])? {24'hFF_FFFF, mem_bus.write_data} : {24'h0, mem_bus.write_data};
                            if (e2w.memFunc == Lbu) rf[e2w.dst] <= {24'h0, mem_bus.write_data}; 
                            end
                        end
                    end
                    // else if ((e2w_v.iType == PMUL)) begin
                    // end
                    else begin
                        rf[e2w.dst] <= e2w.data;
                    end

                    instrs <= instrs + 1;

                    // if (e2w.iType == Unsupported) begin //Handles unsupportd instructions
                    // end
            end

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
            else if ((!dDataStall) && (!dReqStall)) d2e.isValid <= 1'b0;
            else d2e <= d2e_tp;



            ///////////////////////
            // Drive fetch stage //
            ///////////////////////

        end
    end
endmodule // processor

`default_nettype wire