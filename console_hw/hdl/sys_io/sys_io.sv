
typedef struct packed {
    logic[7:0] joystick_x, joystick_y;
    logic[7:0] buttons;
} controller_t;

interface sys_io_bus(
    wire chip_data_raw,
    wire chip_clk_raw
);
    controller_t controller;
    logic[7:0] last_raw_byte; // debug spi

    modport SYS_IO (
        output controller, last_raw_byte,
      	input chip_data_raw, chip_clk_raw
    );
    modport CONSUMER (
        input controller 
    );
endinterface

module sys_io(
    input logic clk_in,
    input logic rst_in,
    sys_io_bus.SYS_IO io_bus
);
    logic[7:0] spi_recv;
    logic spi_recv_valid;

    spi_con spi(
        .clk_in, .rst_in, 
        .data_out(spi_recv), .data_valid_out(spi_recv_valid),
        .chip_data_raw(io_bus.chip_data_raw), 
        .chip_clk_raw(io_bus.chip_clk_raw)
    );

    localparam START_CHAR = 8'hFF;
    logic[3:0] counter;
    // we need to store the buttons, but want to atomically update bus, so we 
    // create a temporary storage until were ready to commit.
    logic[7:0] buttons_temp; 
    typedef enum {WAITING, RECEIVING_BUTTONS, RECEIVING_JOYSTICK } sys_io_state;
    sys_io_state state;

    always_ff@(posedge clk_in) begin
        if (rst_in) begin
            state <= WAITING;
        end
        else if (spi_recv_valid) begin
            io_bus.last_raw_byte <= spi_recv;
            case (state)
            WAITING: begin
                if (START_CHAR == spi_recv) begin
                    counter <= 0;
                    state <= RECEIVING_BUTTONS;
                end
            end
            RECEIVING_BUTTONS: begin
                buttons_temp <= {buttons_temp[6:0], spi_recv[0]};
                if (counter + 1 == 8) begin
                    state <= RECEIVING_JOYSTICK;
                    io_bus.controller.buttons <= buttons_temp;
                    counter <= 0;
                end
                else begin
                    counter <= counter + 1; 
                end
            end
            RECEIVING_JOYSTICK: begin
                case (counter)
                0: io_bus.controller.joystick_y <= spi_recv;
                1: io_bus.controller.joystick_x <= spi_recv;
                default: state <= WAITING;
                endcase
                counter <= counter + 1;
            end
            endcase
        end
    end
endmodule