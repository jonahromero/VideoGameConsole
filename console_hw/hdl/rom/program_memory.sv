
interface program_memory_bus;
    logic[31:0] addr, instr;
    logic read_request, data_valid;

    logic[31:0] addr_b, instr_b;
    logic read_request_b, data_valid_b;

    modport PROGRAM_MEMORY_BUS (
        input addr, read_request,
        output instr, data_valid,
        
        input addr_b, read_request_b,
        output instr_b, data_valid_b
    );
    modport CONSUMER_A (
        output addr, read_request,
        input instr, data_valid
    );
    modport CONSUMER_B (
        output addr_b, read_request_b,
        input instr_b, data_valid_b
    );
endinterface

module program_memory(
    input wire logic clk_in,
    wire logic rst_in,
    output logic sys_rst_out, // program memory will reset system when its ready

    output logic[31:0] display,

    rom_io_bus.READER rom_io,
    program_memory_bus.PROGRAM_MEMORY_BUS bus
);
    //assign display = {7'h0, rom_data_is_valid, rom_io.data, rom_addr};
    // external rom stuff
    logic rom_data_is_valid;
    logic[7:0] rom_data;
    logic[15:0] rom_addr;
    logic finished_reading;
    rom_reader #(.TOTAL_ADDRESSES(8*1024)) reader(
        .clk_in, .rst_in, .rom_io(rom_io),
        .data_valid_out(rom_data_is_valid),
        .data_out(rom_data), .finished(finished_reading),
        .addr_out(rom_addr)
    );
    
    enum { INITIALIZING, WAITING } state;
    logic[31:0] rom_instr;
    logic rom_instr_we;
    logic[3:0] counter;
    
    assign sys_rst_out = rst_in;

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            counter <= 0;
            rom_instr_we <= 0;
            state <= WAITING;
//            state <= INITIALIZING;
        end
        else begin
            if (rom_instr_we) begin
                rom_instr_we <= 0;
            end
            if (sys_rst_out) begin
                //sys_rst_out <= 0;
            end
            case (state)
            INITIALIZING: begin
                if (rom_data_is_valid) begin
                    rom_instr <= {rom_data, rom_instr[31:8]};
                    counter <= counter + 1;
                    if (counter + 1 == 4) begin
//                        rom_instr_we <= 1;
                        counter <= 0;
                    end
                end
                if (finished_reading) begin
                    //sys_rst_out <= 1;
                    state <= WAITING;
                end
            end
            WAITING: begin
            end
            endcase
        end
    end

    // reading/writing to memory
    logic[15:0] actual_addr;
    
    assign actual_addr = (state == INITIALIZING ? rom_addr : bus.addr) >> 2;
    logic[31:0] rom_instr_big_endian;
    always_comb begin
        rom_instr_big_endian[7:0]   = rom_instr[31:24];
        rom_instr_big_endian[15:8]  = rom_instr[23:16];
        rom_instr_big_endian[23:16] = rom_instr[15:8];
        rom_instr_big_endian[31:24] = rom_instr[7:0];
    end

    pipeline #(.STAGES(2), .WIDTH(1)) valid_pipe(
        .clk_in, .rst_in, .in(bus.read_request), .out(bus.data_valid)
    );
    pipeline #(.STAGES(2), .WIDTH(1)) valid_pipe2(
        .clk_in, .rst_in, .in(bus.read_request_b), .out(bus.data_valid_b)
    );


    // 2 cycle read
    xilinx_true_dual_port_read_first_2_clock_ram #(
        .RAM_WIDTH(32),                       // Specify RAM data width
        .RAM_DEPTH((8*1024) / 4),           // Specify RAM depth (number of entries)
        .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        .INIT_FILE("program.mem")
    ) icache (
        .addra(actual_addr),
        //.dina(rom_instr_big_endian),
        .dina(rom_instr),
        .wea(rom_instr_we),
        .douta(bus.instr),

        .clka(clk_in),
        .ena(1),
        .rsta(rst_in),
        .regcea(1),

        // second read port
        .addrb(bus.addr_b >> 2),
        .dinb(0),
        .web(0),
        .doutb(bus.instr_b),

        .clkb(clk_in),
        .enb(1),
        .rstb(rst_in),
        .regceb(1)
    );
endmodule
