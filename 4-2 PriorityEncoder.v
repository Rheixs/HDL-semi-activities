module PriorityEncoder4to2 (
    input [3:0] D,
    output reg [1:0] Y
);
    always @(*) begin
        if (D[3])
            Y = 2'b11;
        else if (D[2])
            Y = 2'b10;
        else if (D[1])
            Y = 2'b01;
        else if (D[0])
            Y = 2'b00;
        else
            Y = 2'bxx; // undefined or no input is active
    end
endmodule

module PriorityEncoder4to2_tb;
    reg [3:0] D;
    wire [1:0] Y;

    PriorityEncoder4to2 dut (.D(D), .Y(Y));

    initial begin
        $dumpfile("PriorityEncoder4to2.vcd");
        $dumpvars(0, PriorityEncoder4to2_tb);

        D = 4'b0000; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b0001; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b0010; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b0011; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b0100; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b0111; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b1000; #10;
        $display("D = %b => Y = %b", D, Y);

        D = 4'b1111; #10;
        $display("D = %b => Y = %b", D, Y);

        $finish;
    end
endmodule
