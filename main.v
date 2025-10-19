// ================================================================
// Module Name   : Divider
// Description   : Parameterized Unsigned Divider in Verilog
//                 Performs integer division of M-bit dividend 'A'
//                 by N-bit divisor 'B' using a restoring division
//                 approach. Outputs quotient 'Q' and remainder 'R'.
// Parameters    : 
//     M : Width of dividend (default = 3)
//     N : Width of divisor (default = 2)
// Inputs        : 
//     A : M-bit unsigned dividend
//     B : N-bit unsigned divisor
// Outputs       : 
//     Q : (M-N+1)-bit unsigned quotient
//     R : N-bit unsigned remainder (declared inside module)
// ================================================================

module divider (A, B, Q);
  // Parameter declarations
  parameter M = 3;
  parameter N = 2;

  // Inputs
  input [M-1:0] A;     // Dividend
  input [N-1:0] B;     // Divisor

  // Outputs
  output reg [M-N:0] Q; // Quotient

  // Internal registers
  reg [N:0] sub, R;    // 'sub' is partial remainder, 'R' holds final remainder

  // ================================================================
  // Division Logic (Restoring Division Algorithm)
  // ================================================================
  // 1. Initialize 'sub' with the most significant N bits of 'A'.
  // 2. For each bit position:
  //    - Subtract divisor 'B' from partial remainder 'sub'.
  //    - If result >= 0, set corresponding bit in quotient to 1.
  //      Otherwise, restore 'sub' and set quotient bit to 0.
  // 3. After final iteration, 'sub' holds the remainder 'R'.
  // ================================================================

    integer k;
  always @(*) begin
    Q = 0;                          // Initialize quotient
    sub = A[M-1:M-N];               // Initialize partial remainder with MSBs of A

    for ( k = 0; k < M-N+1; k = k + 1) begin
      if (sub >= B) begin
        Q[M-N-k] = 1'b1;            // Set quotient bit to 1
        if (k < (M-N))              // Shift and append next bit of A
          sub = {sub - B, A[M-1-N-k]};
      end
      else begin
        Q[M-N-k] = 1'b0;            // Set quotient bit to 0
        if (k < (M-N))              // Shift and append next bit of A
          sub = {sub, A[M-1-N-k]};
      end
    end

    // Compute remainder after final subtraction
    R = (Q[0] == 1) ? sub - B : sub;
  end
endmodule
