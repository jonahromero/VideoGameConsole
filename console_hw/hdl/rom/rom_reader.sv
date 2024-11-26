

`define MAX(a, b) ((a)>(b)?(a):(b)) 

interface rom_io_bus(
    logic[7:0] data,
    logic debug_button
);
    logic [7:0] addr;
    logic latcher;
    modport READER ( 
        input data,debug_button,
        output latcher, addr
    );
endinterface


module rom_reader#(parameter PERIOD_NS = 10, parameter TOTAL_ADDRESSES)(
    input wire rst_in,
    input wire clk_in,
    
    rom_io_bus rom_io,
    // get the data from rom
    output logic data_valid_out, // single pulse
    output logic[7:0] data_out,  // output data
    output logic[15:0] addr_out,
    output logic finished
);
    localparam SETUP_TIME              = 250; //50; // ns
    localparam HOLD_TIME               = 250; //5;//5; // ns
    localparam ROM_OUTPUT_DELAY        = 250; //500_000_000; //250; // ns
    localparam SETUP_TIME_CYCLES       = ((SETUP_TIME + PERIOD_NS - 1) / PERIOD_NS);
    localparam HOLD_TIME_CYCLES        = ((HOLD_TIME + PERIOD_NS - 1) / PERIOD_NS);
    localparam ROM_OUTPUT_DELAY_CYCLES = ((ROM_OUTPUT_DELAY + PERIOD_NS - 1) / PERIOD_NS);
    localparam MAX_CYCLES_WAITING      = `MAX(SETUP_TIME_CYCLES + HOLD_TIME_CYCLES, ROM_OUTPUT_DELAY_CYCLES);

    typedef enum { LATCH_HIGH, SETUP_LATCH, HOLD_LATCH, LATCH_LOW, WAIT_FOR_DATA, NEXT_ADDR, FINISHED } rom_reader_state;
    logic[$clog2(MAX_CYCLES_WAITING)-1:0] counter;
    logic[15:0] addr;
    rom_reader_state state;

    assign finished = (state == FINISHED);
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            addr <= 0;
            rom_io.latcher <= 0;
            data_out <= 0;
            data_valid_out <= 0;
            state <= LATCH_HIGH;
        end
        else begin
            if (data_valid_out) begin
                data_valid_out <= 0;
            end
            case (state)
                LATCH_HIGH: begin
                    rom_io.addr <= addr[15:8];
                    state <= SETUP_LATCH;
                    counter <= 0;
                end
                SETUP_LATCH: begin
                    counter <= counter + 1;
                    if (counter + 1 == SETUP_TIME_CYCLES) begin
                        rom_io.latcher <= 1;
                        state <= HOLD_LATCH;
                        counter <= 0;
                    end
                end
                HOLD_LATCH: begin
                    //rom_io.latcher <= 0;
                    counter <= counter + 1;
                    if (counter + 1 == HOLD_TIME_CYCLES) begin
                        rom_io.latcher <= 0;
                        state <= LATCH_LOW;
                        counter <= 0;
                    end
                end
                LATCH_LOW: begin
                    rom_io.addr <= addr[7:0];
                    counter <= 0;
                    state <= WAIT_FOR_DATA;
                end
                WAIT_FOR_DATA: begin
                    counter <= counter + 1;
                    if (counter + 1 == ROM_OUTPUT_DELAY_CYCLES) begin
                        data_out <= rom_io.data;
                        addr_out <= addr;
                        data_valid_out <= 1;
                        state <= NEXT_ADDR;
                    end
                end
                NEXT_ADDR: begin
                    //if (rom_io.debug_button) begin
                    addr <= addr + 1;
                    if (addr + 1 == TOTAL_ADDRESSES) begin
                        state <= FINISHED;
                    end 
                    else begin
                        state <= LATCH_HIGH;
                    end
                    //end
                end
                FINISHED: begin
                end
            endcase
        end
    end
endmodule