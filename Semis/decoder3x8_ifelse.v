`timescale 1ns / 1ps

module decoder3x8_ifelse (
    input wire A, B, C,         
    output reg [7:0] D          
);

    always @ (A, B, C) begin
        
        if (A == 0 && B == 0 && C == 0) D = 8'b00000001;
        else if (A == 0 && B == 0 && C == 1) D = 8'b00000010;
        else if (A == 0 && B == 1 && C == 0) D = 8'b00000100;
        else if (A == 0 && B == 1 && C == 1) D = 8'b00001000;
        else if (A == 1 && B == 0 && C == 0) D = 8'b00010000;
        else if (A == 1 && B == 0 && C == 1) D = 8'b00100000;
        else if (A == 1 && B == 1 && C == 0) D = 8'b01000000;
        else if (A == 1 && B == 1 && C == 1) D = 8'b10000000;
        else D = 8'b00000000; 
    end

endmodule


module tb_decoder3x8_ifelse;
    reg A, B, C;         // 3-bit inputs A, B, C
    wire [7:0] D;        // 8-bit output D

    // Instantiate the decoder3x8_ifelse module
    decoder3x8_ifelse uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D)
    );

    initial begin
        // Setup for GTKWave
        $dumpfile("decoder3x8_ifelse.vcd");
        $dumpvars(0, tb_decoder3x8_ifelse);
        
        // Display input/output for testing
        $display(" A B C |    D");
        $display("---------------");

        // Apply all combinations for inputs A, B, and C
        for (A = 0; A <= 1; A = A + 1) begin
            for (B = 0; B <= 1; B = B + 1) begin
                for (C = 0; C <= 1; C = C + 1) begin
                    #10; // Wait for 10 ns
                    $display("%b %b %b | %b", A, B, C, D);
                end
            end
        end

        $finish;
    end

endmodule
