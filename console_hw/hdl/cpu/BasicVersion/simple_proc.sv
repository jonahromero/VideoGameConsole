
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
    DecodedInstr dInstr;
    ExecInst eInstr;

    logic[31:0] pc;
    logic[31:0] regfile[31:0];

    always_comb begin
        program_mem_bus.addr = pc;
    end

    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            stage <= FETCH;
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
            case (stage)
            FETCH_DECODE: begin
                if (counter + 1 == 2) begin
                    stage <= DECODE;
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
                            NopM:
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
                        regfile[eInstr.dst] <= regfile.data;
                    end
                    // update pc
                    pc <= eInstr.nextPc;
                    counter <= 0;
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