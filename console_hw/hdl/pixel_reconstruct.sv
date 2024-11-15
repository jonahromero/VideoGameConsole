`timescale 1ns / 1ps
`default_nettype none

module pixel_reconstruct
	#(
	 parameter HCOUNT_WIDTH = 11,
	 parameter VCOUNT_WIDTH = 10
	 )
	(
	 input wire clk_in,
	 input wire rst_in,

	 input wire camera_pclk_in,
	 input wire camera_hs_in,
	 input wire camera_vs_in,
	 input wire [7:0] camera_data_in,

	 output logic pixel_valid_out,
	 output logic [HCOUNT_WIDTH-1:0] pixel_hcount_out,
	 output logic [VCOUNT_WIDTH-1:0] pixel_vcount_out,
	 output logic [15:0] pixel_data_out
	 );

	// your code here! and here's a handful of logics that you may find helpful to utilize.

	// previous value of PCLK
	logic pclk_prev;
	logic camera_sample_valid;
	assign camera_sample_valid = !pclk_prev && camera_pclk_in;

	// previous value of camera data, from last valid sample!
	// should NOT update on every cycle of clk_in, only
	// when samples are valid.
	logic last_sampled_hs;
	logic [7:0] last_sampled_data;
	logic [HCOUNT_WIDTH-1:0] hcount_counter;

	typedef enum { PIXEL_HI, PIXEL_LO } pixel_receiving_state_t;
	pixel_receiving_state_t pixel_receive_state;

	always_ff@(posedge clk_in) begin
		if (rst_in) begin
			pixel_receive_state <= PIXEL_HI;
			hcount_counter <= 0;
			pixel_hcount_out <= 0;
			pixel_vcount_out <= 0;
			pixel_data_out <= 0;
			pixel_valid_out <= 0;
		end else begin
			pclk_prev <= camera_pclk_in;
			if(camera_sample_valid) begin
				// reading valid data in
				if (camera_hs_in && camera_vs_in) begin
					if (pixel_receive_state == PIXEL_HI) begin
						last_sampled_data <= camera_data_in;
						pixel_receive_state <= PIXEL_LO;
					end
					else begin
						pixel_valid_out <= 1;
						pixel_data_out <= {last_sampled_data, camera_data_in};
						pixel_receive_state <= PIXEL_HI;
						hcount_counter <= hcount_counter + 1;
					end
				end
				// reset screen
				else if (!camera_vs_in) begin
					hcount_counter <= 0;
					pixel_vcount_out <= 0;
					pixel_receive_state <= PIXEL_HI;
				end
				// hsync negedge => next line
				else if (last_sampled_hs && !camera_hs_in) begin
					hcount_counter <= 0;
					pixel_vcount_out <= pixel_vcount_out + 1;
					pixel_receive_state <= PIXEL_HI;
				end
				pixel_hcount_out <= hcount_counter;
				last_sampled_hs <= camera_hs_in;
			end
			if (pixel_valid_out) begin
				pixel_valid_out <= 0;
			end
		end
	end

endmodule

`default_nettype wire
