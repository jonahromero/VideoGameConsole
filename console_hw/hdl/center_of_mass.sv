`default_nettype none

module average_unit
    #(parameter DATA_WIDTH)
(
    input wire clk_in,
    input wire rst_in,

    input wire [DATA_WIDTH-1:0] data_in,
    input wire valid_in,

    input wire tabulate_in,
    output logic [DATA_WIDTH-1:0] average_out,
    output logic valid_out
);
    localparam DIVISION_WIDTH = 32;
    logic divison_valid_out, division_valid_in;
    logic[DIVISION_WIDTH-1:0] quotient_out, remainder_out;
	divider #(.WIDTH(DIVISION_WIDTH)) x_div(
        .clk_in(clk_in),
        .rst_in(rst_in),
        .dividend_in(value_sum),
        .divisor_in(total_datapoints),
        .data_valid_in(division_valid_in),
        .quotient_out(quotient_out),
        .remainder_out(remainder_out),
        .data_valid_out(divison_valid_out) // single pulse it's done
        // dont care: .error_out(),
        // .busy_out(division_busy_out)
    );

    typedef enum { ACCEPTING_POINTS, COMPUTING } state_t;
    state_t current_state;

    logic [DIVISION_WIDTH-1:0] total_datapoints, value_sum;
    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            total_datapoints <= 0;
            value_sum <= 0;
            valid_out <= 0;
            average_out <= 0;
            current_state <= ACCEPTING_POINTS;
        end
        else begin
            case (current_state)
            ACCEPTING_POINTS: begin
                if (valid_in) begin
                    total_datapoints <= total_datapoints + 1;
                    value_sum <= value_sum + data_in;
                end
                // compute the sum
                else if (tabulate_in && total_datapoints != 0) begin
                    division_valid_in <= 1;
                    current_state <= COMPUTING;
                end
            end
            COMPUTING: begin
                if (divison_valid_out) begin
                    average_out <= quotient_out;
                    valid_out <= 1;
                    current_state <= ACCEPTING_POINTS;
                    total_datapoints <= 0;
                    value_sum <= 0;
                end
            end
            endcase
            if (valid_out) begin
                valid_out <= 0;
            end
            if (division_valid_in) begin
                division_valid_in <= 0;
            end
        end
    end

endmodule

module center_of_mass (
    input wire clk_in,
    input wire rst_in,
    input wire [10:0] x_in,
    input wire [9:0]  y_in,
    input wire valid_in,
    input wire tabulate_in,
    output logic [10:0] x_out,
    output logic [9:0] y_out,
    output logic valid_out);

    logic x_valid, y_valid;
    average_unit #(.DATA_WIDTH(11)) xavg(
        .clk_in(clk_in),
        .rst_in(rst_in),
        .data_in(x_in),
        .valid_in(valid_in),
        .tabulate_in(tabulate_in),
        .average_out(x_out),
        .valid_out(x_valid)
    );
    average_unit #(.DATA_WIDTH(10)) yavg(
        .clk_in(clk_in),
        .rst_in(rst_in),
        .data_in(y_in),
        .valid_in(valid_in),
        .tabulate_in(tabulate_in),
        .average_out(y_out),
        .valid_out(y_valid)
    );

    logic [1:0] total_valid;
    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            total_valid <= 0;
            valid_out <= 0;
        end
        else begin
            if (x_valid || y_valid) begin
                total_valid <= total_valid + x_valid + y_valid;
            end
            if (total_valid == 2) begin
                total_valid <= 0;
                valid_out <= 1;
            end
            if (valid_out) begin
                valid_out <= 0;
            end
        end
    end
endmodule

`default_nettype wire
