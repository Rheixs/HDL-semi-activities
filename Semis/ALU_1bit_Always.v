module ALU_1bit (
    input wire X, Y,        // 1-bit input operands
    input wire S0, S1,      // 2-bit select inputs to choose the operation
    output wire R           // 1-bit result output
);

   
    wire add_op;  // Result of addition
    wire sub_op;  // Result of subtraction
    wire and_op;  // Result of AND operation
    wire or_op;   // Result of OR operation

  
    assign add_op = X ^ Y;      // XOR used to simulate 1-bit addition
    assign sub_op = X ^ Y;      // XOR used to simulate 1-bit subtraction
    assign and_op = X & Y;      // AND operation
    assign or_op  = X | Y;      // OR operation

   
    assign R = (S1 == 0 && S0 == 0) ? add_op :  // S1S0 = 00 → Add
               (S1 == 0 && S0 == 1) ? sub_op :  // S1S0 = 01 → Subtract
               (S1 == 1 && S0 == 0) ? and_op :  // S1S0 = 10 → AND
                                     or_op;     // S1S0 = 11 → OR

endmodule
