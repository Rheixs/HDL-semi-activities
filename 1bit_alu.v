`timescale 1ns/1ps

module ALU_1bit (
    input A, B, Cin,
    input [1:0] Op,
    output reg Result,
    output reg Cout
);
    always @(*) begin
        Cout = 0; // Default carry-out
        case (Op)
            2'b00: Result = A & B;                  // AND
            2'b01: Result = A | B;                  // OR
            2'b10: Result = A ^ B;                  // XOR
            2'b11: {Cout, Result} = A + B + Cin;    // ADD with carry
            default: Result = 1'bx;
        endcase
    end
endmodule

module ALU_1bit_tb;
    reg A, B, Cin;
    reg [1:0] Op;
    wire Result, Cout;

    ALU_1bit dut (
        .A(A), .B(B), .Cin(Cin), .Op(Op),
        .Result(Result), .Cout(Cout)
    );

    integer i;

    initial begin
        $dumpfile("ALU_1bit.vcd");
        $dumpvars(0, ALU_1bit_tb);

        // === AND Test ===
        Op = 2'b00;
        for (i = 0; i < 4; i = i + 1) begin
            {A, B} = i[1:0];
            #10;
            $display("AND: A=%b, B=%b => Result=%b", A, B, Result);
        end

        // === OR Test ===
        Op = 2'b01;
        for (i = 0; i < 4; i = i + 1) begin
            {A, B} = i[1:0];
            #10;
            $display("OR : A=%b, B=%b => Result=%b", A, B, Result);
        end

        // === XOR Test ===
        Op = 2'b10;
        for (i = 0; i < 4; i = i + 1) begin
            {A, B} = i[1:0];
            #10;
            $display("XOR: A=%b, B=%b => Result=%b", A, B, Result);
        end

        // === ADD Test ===
        Op = 2'b11;
        for (i = 0; i < 8; i = i + 1) begin
            {A, B, Cin} = i[2:0];
            #10;
            $display("ADD: A=%b, B=%b, Cin=%b => Result=%b, Cout=%b", A, B, Cin, Result, Cout);
        end

        $finish;
    end
endmodule
