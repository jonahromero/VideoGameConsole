
`default_nettype none

module pipeline#(
  parameter STAGES,
  parameter WIDTH = 1
) (
  input wire clk_in,
  input wire rst_in,
  input wire[WIDTH-1:0] in,
  output logic[WIDTH-1:0] out
);
  logic [WIDTH-1:0] pipe [STAGES-1:0];
  assign out = pipe[STAGES-1];

  always_ff @(posedge clk_in)begin
    if (rst_in) begin
      for (int i = 0; i < STAGES; i++) begin
        pipe[i] <= 0;
      end
    end
    else begin
      pipe[0] <= in;
      for (int i=1; i<STAGES; i = i+1)begin
        pipe[i] <= pipe[i-1];
      end
    end
  end
endmodule

`default_nettype wire
