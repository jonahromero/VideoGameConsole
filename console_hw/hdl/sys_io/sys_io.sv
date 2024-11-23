
typedef struct packed {
    logic[7:0] joystick_x, joystick_y;
    logic[7:0] buttons;
} controller_t;

interface sys_io_bus;
    controller_t controller;

    modport SYS_IO (
        output controller
    );
    modport CONSUMER (
        input controller 
    );
endinterface

module sys_io(
    input logic clk_in,
    input logic rst_in,
    sys_io_bus io_bus,
);
    spi_con #(.DATA_CLK_PERIOD(100)) spi(
        .clk_in, .rst_in, 
    );

endmodule