`timescale 1ns / 1ps

module eight_bb (
    input wire clk,
    input wire rst,
    input wire shift_left,  // Shift direction control
    input wire shift_right, // Shift direction control
    input wire serial_in,   // Serial input bit
    output reg [7:0] q      // 8-bit output register
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 8'b00000000;  // Reset to 0
    end else begin
        if (shift_left) begin
            q <= {q[6:0], serial_in}; // Shift left and input new bit on LSB
        end else if (shift_right) begin
            q <= {serial_in, q[7:1]}; // Shift right and input new bit on MSB
        end
    end
end

endmodule

//========================//
// Testbench for eight_bb      //
//========================//
module tb_eight_bb;

    reg clk;
    reg rst;
    reg shift_left;
    reg shift_right;
    reg serial_in;
    wire [7:0] q;

    // Instantiate the 8-bit shift register (8_bb)
    eight_bb uut (
        .clk(clk),
        .rst(rst),
        .shift_left(shift_left),
        .shift_right(shift_right),
        .serial_in(serial_in),
        .q(q)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Optional: dump waveform if using GTKWave
        $dumpfile("8-bitShiftRegister.vcd");
        $dumpvars(0, tb_eight_bb);

        // Monitor changes
        $monitor("Time=%0t | rst=%b shift_left=%b shift_right=%b serial_in=%b => q=%b", 
                 $time, rst, shift_left, shift_right, serial_in, q);

        // Initialize inputs
        clk = 0;
        rst = 1;
        shift_left = 0;
        shift_right = 0;
        serial_in = 0;

        #10 rst = 0; // Clear reset

        // Test sequence
        #10 shift_left = 1; serial_in = 1;  // Shift left → q=00000001
        #10 shift_left = 1; serial_in = 0;  // Shift left → q=00000010
        #10 shift_left = 1; serial_in = 1;  // Shift left → q=00000101
        #10 shift_right = 1; serial_in = 0; // Shift right → q=10000101
        #10 shift_right = 1; serial_in = 1; // Shift right → q=11000101
        #10 shift_left = 1; serial_in = 0;  // Shift left → q=10000100
        #10 shift_left = 1; serial_in = 1;  // Shift left → q=00001001
        #10 shift_right = 1; serial_in = 1; // Shift right → q=10001001
        #10 shift_left = 0; shift_right = 0; // Hold

        #20 $finish;  // End simulation
    end

endmodule
