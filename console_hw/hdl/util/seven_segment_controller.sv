

module seven_segment_controller #(parameter COUNT_PERIOD = 100000)
	(input wire           clk_in,
	 input wire           rst_in,
	 input wire [31:0]    val_in,
	 output logic[6:0]    cat_out,
	 output logic[7:0]    an_out
	);

	logic [7:0]	  segment_state;
	logic [31:0]	segment_counter;
	logic [3:0]	  sel_values;
	logic [6:0]	  led_out;
	
    bto7s mbto7s (.x_in(sel_values), .s_out(led_out));
    assign cat_out = ~led_out; //<--note this inversion is needed
    assign an_out = ~segment_state; //note this inversion is needed

    // every count_period switch to the next led display
    logic [2:0] counter;
    assign sel_values = val_in[counter*4 +:4];

	always_ff @(posedge clk_in)begin
		if (rst_in)begin
			segment_state <= 8'b0000_0001;
			segment_counter <= 32'b0;
            counter <= 3'b0;
		end else begin
			if (segment_counter == COUNT_PERIOD) begin
				segment_counter <= 32'd0;
				segment_state <= {segment_state[6:0],segment_state[7]};
                counter <= counter + 1;
			end else begin
				segment_counter <= segment_counter +1;
			end
		end
	end
endmodule // seven_segment_controller

