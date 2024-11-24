

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
    program_memory_bus bus
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

    
    logic[31:0] icache_addr;
    logic[31:0] icache_data_out;
    enum { INITIALIZING, WAITING } state;

    assign bus.instr = icache_data_out;
    pipeline #(.STAGES(2), .WIDTH(1)) valid_pipe(
        .clk_in, .rst_in, .in(bus.read_request), .out(bus.data_valid)
    );

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            state <= INITIALIZING;
            icache_addr <= 0;
        end
        else begin
            case (state)
            INITIALIZING: begin
                if (data_valid_in) begin
                    // do something with data_in
                    icache_addr <= icache_addr + 1;
                end
                if (finished_reading) begin
                    sys_rst_out <= 1;
                    state <= WAITING;
                end
            end
            WAITING: begin
            end
            endcase
            if (sys_rst_out) begin
                sys_rst_out <= 0;
            end
        end
    end

    // 2 cycle read
    xilinx_single_port_ram_read_first #(
        .RAM_WIDTH(32),                       // Specify RAM data width
        .RAM_DEPTH((64*1024) / 32),           // Specify RAM depth (number of entries)
        .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    ) icache (
        .addra(state == INITIALIZING ? icache_addr : bus.addr),        // Address bus, width determined from RAM_DEPTH
        .dina(data_in),                                                // RAM input data, width determined from RAM_WIDTH
        .wea(data_valid_in),                                           // Write enable
        .douta(icache_data_out)                                        // RAM output data, width determined from RAM_WIDTH

        .clka(clk_in),       // Clock
        .ena(1),         // RAM Enable, for additional power savings, disable port when not in use
        .rsta(rst_in),       // Output reset (does not affect memory contents)
        .regcea(1),   // Output register enable
    );
endmodule