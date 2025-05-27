module ALU_1bit_v2 (
    input A,
    input B,
    input Cin,
    input [1:0] sel,
    output reg Result,
    output reg Cout
);
    always @(*) begin
        case (sel)
            2'b00: begin // AND
                Result = A & B;
                Cout = 0;
            end
            2'b01: begin // OR
                Result = A | B;
                Cout = 0;
            end
            2'b10: begin // ADD
                {Cout, Result} = A + B + Cin;
            end
            2'b11: begin // SUB (A - B - Cin)
                {Cout, Result} = A - B - Cin;
            end
            default: begin
                Result = 1'bx;
                Cout = 1'bx;
            end
        endcase
    end
endmodule

module ALU_1bit_v2_tb;
    reg A, B, Cin;
    reg [1:0] sel;
    wire Result, Cout;

    ALU_1bit_v2 dut (.A(A), .B(B), .Cin(Cin), .sel(sel), .Result(Result), .Cout(Cout));

    integer i;

    initial begin
        $dumpfile("ALU_1bit_v2.vcd");
        $dumpvars(0, ALU_1bit_v2_tb);

        $display("sel | A B Cin | Result Cout | Operation");

        for (i = 0; i < 32; i = i + 1) begin
            {sel, A, B, Cin} = i;
            #1;
            $display("%b   | %b %b  %b   |   %b      %b    | %s", sel, A, B, Cin, Result, Cout,
                     (sel == 2'b00) ? "AND" :
                     (sel == 2'b01) ? "OR " :
                     (sel == 2'b10) ? "ADD" : "SUB");
        end

        $finish;
    end
endmodule
