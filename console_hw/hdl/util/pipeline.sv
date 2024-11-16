
`default_nettype none

module pipeline#(
  parameter STAGES,
  parameter WIDTH = 1
) (
  input wire clk_in,
  input wire[WIDTH-1:0] sig_in,
  output logic[WIDTH-1:0] sig_out
);
  logic [WIDTH-1:0] pipe [STAGES-1:0];
  assign sig_out = pipe[STAGES-1];

  always_ff @(posedge clk_in)begin
    pipe[0] <= sig_in;
    for (int i=1; i<STAGES; i = i+1)begin
      pipe[i] <= pipe[i-1];
    end
  end
endmodule

`default_nettype wire
