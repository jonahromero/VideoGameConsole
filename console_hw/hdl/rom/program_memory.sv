

interface program_memory_bus;
    logic[31:0] addr, instr;
    logic read_request, data_valid;

    modport PROGRAM_MEMORY_BUS (
        input addr, read_request,
        output instr, data_valid
    );
    modport CONSUMER (
        output addr, read_request,
        input instr, data_valid
    );
endinterface

module program_memory(
    input logic clk_in,
    input logic rst_in,
    output logic sys_rst_out, // program memory will reset system when its ready

    rom_io_bus rom_io,
    program_memory_bus mem_bus
);
    
    // external rom stuff
    logic data_valid_in;
    logic[7:0] data_in;
    logic finished_reading;
    rom_reader reader(
        .clk_in, .rst_in, .rom_io,
        .data_valid_out(data_valid_in),
        .data_out(data_in), .finished(finished_reading)
    );

    logic[31:0] rom_addr, latched_addr;
    enum { INITIALIZING, WAITING } state;

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            state <= INITIALIZING;
            rom_addr <= 0;
        end
        else begin
            case (state)
            INITIALIZING: begin
                if (data_valid_in) begin
                    // do something with data_in
                    rom_addr <= rom_addr + 1;
                end
                if (finished_reading) begin
                    sys_rst_out <= 1;
                    state <= WAITING;
                end
            end
            WAITING: begin
                if (mem_bus.read_request) begin
                    latched_addr <= addr;
                    // write to instr, and data_valid
                end
            end
            endcase
            if (sys_rst_out) begin
                sys_rst_out <= 0;
            end
        end
    end
endmodule