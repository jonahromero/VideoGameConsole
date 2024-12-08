
module cpu(
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
                
            end
            MEM: begin
            end
            WRITEBACK: begin
            end
            endcase 
        end
    end


endmodule