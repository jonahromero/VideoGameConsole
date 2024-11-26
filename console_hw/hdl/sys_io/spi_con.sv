
//posedge dclk, we read
//negedge dclk, we write. negedge chip_select

module spi_con
     #(parameter DATA_WIDTH = 8
      )
      (input wire   clk_in, //system clock (100 MHz)
       input wire   rst_in, //reset in signal

       output logic [DATA_WIDTH-1:0] data_out, //data received!
       output logic data_valid_out, //high when output data is present.
 
       input wire chip_data_raw, //(CIPO)
       input wire chip_clk_raw //(DCLK)
    );
    logic chip_data, chip_clk;
    pipeline #(.WIDTH(1), .STAGES(3)) cd_buf (
        .clk_in, .rst_in, .in(chip_data_raw), .out(chip_data)
    );
    pipeline #(.WIDTH(1), .STAGES(3)) cc_buf (
        .clk_in, .rst_in, .in(chip_clk_raw), .out(chip_clk)
    );

    logic clk_prev, rising_edge;
    logic[7:0] data_bits_read;
    parameter TIMEOUT = 5000;
    logic[$clog2(TIMEOUT+1)-1:0] timeout_counter;

    assign rising_edge = (!clk_prev && chip_clk);
    always_ff @( posedge clk_in) begin
        if (rst_in) begin
            data_out <= 0;
            data_bits_read <= 0;
            timeout_counter <= 1;
        end
        else begin
            clk_prev <= chip_clk;
            timeout_counter <= timeout_counter + 1;
            if (timeout_counter + 1 == TIMEOUT) begin
                data_bits_read <= 0;
                timeout_counter <= 0;
            end
            if (data_valid_out) begin
                data_valid_out <= 0;
            end
            if (rising_edge) begin
                timeout_counter <= 0;
                data_out <= {data_out[DATA_WIDTH-2:0], chip_data};
                if (data_bits_read + 1 == DATA_WIDTH) begin
                    data_bits_read <= 0;
                    data_valid_out <= 1;
                end
                else begin
                    data_bits_read <= data_bits_read + 1;
                end
            end
        end
    end
endmodule