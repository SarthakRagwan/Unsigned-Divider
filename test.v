// ================================================================
// Testbench for Unsigned Divider Module
// Description: Tests a parameterized divider by iterating through
//              multiple input combinations of dividend (A) and divisor (B).
//              Displays both quotient (Q) and remainder (R).
// ================================================================

`timescale 10ns/1ns
`include "main.v"

module tb;
  // Parameters matching the divider module
  parameter M = 3;    // Width of dividend
  parameter N = 2;    // Width of divisor

  // Testbench signals
  reg [M-1:0] A;           // Dividend
  reg [N-1:0] B;           // Divisor
  wire [M-N:0] Q;          // Quotient

  // Instantiate the divider module
  divider dut(A, B, Q);

  // Simulation logic
  integer i,j;
  initial begin
    // Create waveform dump for visualization (e.g., GTKWave)
    $dumpfile("file.vcd");
    $dumpvars(0, tb);

    // Monitor output on console
    $monitor($time, "  |  A = %d  |  B = %d  |  Q = %d  |  R = %d", A, B, Q, dut.R);

    // Test a range of valid input combinations
    // Avoid divide-by-zero by starting B from non-zero values
    for (i = 1; i < (1 << M); i = i + 1) begin
      for (j = (1 << (N-1)); j < (1 << N); j = j + 1) begin
        #5;
        A = i;   // Apply dividend
        B = j;   // Apply divisor
      end
    end

    #5 $finish;   // End simulation
  end
endmodule
