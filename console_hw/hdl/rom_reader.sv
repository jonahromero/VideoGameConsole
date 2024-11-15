

`define MAX(a, b) ((a)>(b)?(a):(b)) 

module rom_reader#(parameter PERIOD_NS = 10)(
    input wire rst_in,
    input wire clk_in,
    input wire[7:0] data_in,

    output logic[7:0] addr_out,
    output logic latch_out,

    // get the data from rom
    output logic data_valid_out,
    output logic[7:0] data_out
);
    localparam SETUP_TIME              = 50; // ns
    localparam HOLD_TIME               = 5; // ns
    localparam ROM_OUTPUT_DELAY        = 250; // ns
    localparam SETUP_TIME_CYCLES       = ((SETUP_TIME + PERIOD_NS - 1) / PERIOD_NS);
    localparam HOLD_TIME_CYCLES        = ((HOLD_TIME + PERIOD_NS - 1) / PERIOD_NS);
    localparam ROM_OUTPUT_DELAY_CYCLES = ((ROM_OUTPUT_DELAY + PERIOD_NS - 1) / PERIOD_NS);
    localparam MAX_CYCLES_WAITING      = MAX(MAX(SETUP_TIME_CYCLES + HOLD_TIME_CYCLES), ROM_OUTPUT_DELAY_CYCLES);

    typedef enum { LATCH_LOW, SETUP_LATCH, HOLD_LATCH, LATCH_HIGH, WAIT_FOR_DATA } rom_reader_state;
    logic[15:0] addr;
    logic[$clog2(MAX_CYCLES_WAITING)-1:0] counter;
    rom_reader_state state;

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            addr <= 0;
            latch_out <= 0;
            data_out <= 0;
            data_valid_out <= 0;
            state <= LATCH_LOW;
        end
        else begin
            if (data_valid_out) begin
                data_valid_out <= 0;
            end
            case (state)
                LATCH_LOW: begin
                    addr_out <= addr[7:0];
                    state <= SETUP_LATCH;
                    counter <= 0;
                end
                SETUP_LATCH: begin
                    if (counter + 1 == SETUP_TIME_CYCLES) begin
                        latch_out <= 1;
                        state <= HOLD_LATCH;
                        counter <= 0;
                    end
                    counter <= counter + 1;
                end
                HOLD_LATCH: begin
                    latch_out <= 0;
                    if (counter + 1 == HOLD_TIME_CYCLES) begin
                        state <= LATCH_HIGH;
                        counter <= 0;
                    end
                    counter <= counter + 1;
                end
                LATCH_HIGH: begin
                    addr_out <= addr[15:8];
                    counter <= 0;
                    state <= WAIT_FOR_DATA;
                end
                WAIT_FOR_DATA: begin
                    if (counter + 1 == ROM_OUTPUT_DELAY_CYCLES) begin
                        data_out <= data_in;
                        data_valid_out <= 1;
                        state <= LATCH_LOW;
                    end
                    counter <= counter + 1;
                end
            endcase
        end
    end
endmodule