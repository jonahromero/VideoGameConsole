
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
    logic[7:0] spi_recv;
    logic spi_recv_valid;

    spi_con #(.DATA_CLK_PERIOD(100)) spi(
        .clk_in, .rst_in, 
        .data_in(0), .trigger_in(0),
        .data_out(spi_recv), .data_valid_out(spi_recv_valid),

       wire  chip_data_in, //(CIPO)
       logic chip_clk_out, //(DCLK)
       
       logic chip_data_out, //(COPI)
        .chip_sel_out() // (CS)
    );

endmodule