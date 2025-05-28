`timescale 1ns/1ps

module priority_encoder_4to2 (
    input [3:0] in,       // 4-bit input
    output reg [1:0] out, // 2-bit encoded output
    output reg valid      // Indicates if any input is high
);
    always @(*) begin
        valid = 1'b1;
        casex (in)
            4'b1xxx: out = 2'b11; // Highest priority
            4'b01xx: out = 2'b10;
            4'b001x: out = 2'b01;
            4'b0001: out = 2'b00;
            default: begin
                out = 2'b00;
                valid = 1'b0;
            end
        endcase
    end
endmodule

// Testbench for Priority Encoder
module tb_priority_encoder;
    reg [3:0] in;
    wire [1:0] out;
    wire valid;

    // Instantiate the DUT (Device Under Test)
    priority_encoder_4to2 uut (
        .in(in),
        .out(out),
        .valid(valid)
    );

    initial begin
        
        $dumpfile("priority_encoder_4to2.vcd"); // VCD file for GTKWave
        $dumpvars(0, tb_priority_encoder); // Dump all vars in the testbench

        // Apply test inputs
        in = 4'b0000; #10;
        in = 4'b0001; #10;
        in = 4'b0010; #10;
        in = 4'b0011; #10;
        in = 4'b0100; #10;
        in = 4'b0101; #10;
        in = 4'b0110; #10;
        in = 4'b0111; #10;
        in = 4'b1000; #10;
        in = 4'b1001; #10;
        in = 4'b1111; #10;

        // End simulation
        $finish;
    end
endmodule
