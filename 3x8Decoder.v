`timescale 1ns/1ps

module Decoder3x8 (
    input [2:0] in,
    output reg [7:0] out
);
    always @(*) begin
        // Default: everything off
        out = 8'b00000000;

        // Decoder logic using if-else
        if (in == 3'b000) out = 8'b00000001;
        else if (in == 3'b001) out = 8'b00000010;
        else if (in == 3'b010) out = 8'b00000100;
        else if (in == 3'b011) out = 8'b00001000;
        else if (in == 3'b100) out = 8'b00010000;
        else if (in == 3'b101) out = 8'b00100000;
        else if (in == 3'b110) out = 8'b01000000;
        else if (in == 3'b111) out = 8'b10000000;
    end
endmodule

module Decoder3x8_tb;
    reg [2:0] in;
    wire [7:0] out;

    Decoder3x8 dut (.in(in), .out(out));

    integer i;

    initial begin
        $dumpfile("Decoder3x8.vcd");
        $dumpvars(0, Decoder3x8_tb);

        for (i = 0; i < 8; i = i + 1) begin
            in = i[2:0];
            #10;
            $display("Input = %b => Output = %b", in, out);
        end

        $finish;
    end
endmodule
