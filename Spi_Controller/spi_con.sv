module spi_con
     #(parameter DATA_WIDTH = 8,
       parameter DATA_CLK_PERIOD = 100
      )
      (input wire   clk_in, //system clock (100 MHz)
       input wire   rst_in, //reset in signal
       input wire   [DATA_WIDTH-1:0] data_in, //data to send
       input wire   trigger_in, //start a transaction
       output logic [DATA_WIDTH-1:0] data_out, //data received!
       output logic data_valid_out, //high when output data is present.
 
       output logic chip_data_out, //(COPI)
       input wire   chip_data_in, //(CIPO)
       output logic chip_clk_out, //(DCLK)
       output logic chip_sel_out // (CS)
      );
  //your code here
    localparam HALF_CYCLE = DATA_CLK_PERIOD >> 1;
    localparam DATA_SIZE = $clog2(DATA_WIDTH);
    localparam DATA_CLK_SIZE = $clog2(DATA_CLK_PERIOD);
    logic [DATA_SIZE:0] re_counter;
    logic [DATA_CLK_PERIOD-1:0] cycle_counter;
    logic [DATA_WIDTH-1:0] save_data;
    logic old_chip_clk_out;
    logic end_flag;

    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            chip_clk_out <= 1'b0;
            chip_data_out <= 1'b0;
            data_valid_out <= 1'b0;
            data_out <= 0;
            chip_sel_out <= 1'b1;
        end else begin
            if(end_flag) begin
                end_flag <= 1'b0;
                data_valid_out <= 1'b0;
                chip_clk_out <= 0;
            end
            if (trigger_in) begin
                save_data <= {data_in[DATA_WIDTH-3:0], data_in[DATA_WIDTH-1:DATA_WIDTH-2]};
                chip_sel_out <= 1'b0;
                data_valid_out <= 1'b0;
                chip_data_out <= data_in[DATA_WIDTH-1];
                re_counter <= 0;
                cycle_counter <= 1;
                data_out <= 0;
            end else if (chip_sel_out == 1'b0) begin
                data_valid_out <= 1'b0;
                old_chip_clk_out <= chip_clk_out;
                cycle_counter <= cycle_counter + 1;
                if (cycle_counter == HALF_CYCLE) begin
                    chip_clk_out <= 1'b1;
                    data_out <= {data_out[DATA_WIDTH-2:0], chip_data_in};
                    re_counter <= re_counter + 1;
                end else if (cycle_counter == DATA_CLK_PERIOD) begin
                    chip_clk_out <= 1'b0;
                    cycle_counter <= 1;
                    save_data <= {save_data[DATA_WIDTH-2:0], save_data[DATA_WIDTH-1]};
                    chip_data_out <= save_data[0];
                    if(re_counter == (DATA_WIDTH)) begin
                        chip_sel_out <= 1'b1;
                        data_valid_out <= 1'b1;
                        re_counter <= 0;
                        end_flag <= 1'b1;
                    end
                end
            end
            
        end
    end
endmodule
