`timescale 1ns/1ps
`default_nettype none

module vending_machine (
    input  wire       Clock,
    input  wire       rst,
    input  wire [1:0] in,
    output reg        out,
    output reg  [1:0] change
);

    localparam [1:0] S0 = 2'b00;  // 0 Rs inserted
    localparam [1:0] S1 = 2'b01;  // 5 Rs inserted
    localparam [1:0] S2 = 2'b10;  // 10 Rs inserted

    reg [1:0] c_state;
    reg [1:0] n_state;

    reg       out_next;
    reg [1:0] change_next;

    ////////////////////////////////////////////////////////////////////////////
    // State/output registers
    ////////////////////////////////////////////////////////////////////////////

    always @(posedge Clock) begin
        if (rst) begin
            c_state <= S0;
            out     <= 1'b0;
            change  <= 2'b00;
        end else begin
            c_state <= n_state;
            out     <= out_next;
            change  <= change_next;
        end
    end

    ////////////////////////////////////////////////////////////////////////////
    // Next-state and output combinational logic
    ////////////////////////////////////////////////////////////////////////////

    always @* begin
        n_state     = c_state;
        out_next    = 1'b0;
        change_next = 2'b00;

        case (c_state)

            ////////////////////////////////////////////////////////////////////
            // S0: 0 Rs inserted
            ////////////////////////////////////////////////////////////////////
            S0: begin
                if (in == 2'b00) begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b00;
                end else if (in == 2'b01) begin
                    n_state     = S1;
                    out_next    = 1'b0;
                    change_next = 2'b00;
                end else if (in == 2'b10) begin
                    n_state     = S2;
                    out_next    = 1'b0;
                    change_next = 2'b00;
                end else begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b00;
                end
            end

            ////////////////////////////////////////////////////////////////////
            // S1: 5 Rs inserted
            ////////////////////////////////////////////////////////////////////
            S1: begin
                if (in == 2'b00) begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b01;
                end else if (in == 2'b01) begin
                    n_state     = S2;
                    out_next    = 1'b0;
                    change_next = 2'b00;
                end else if (in == 2'b10) begin
                    n_state     = S0;
                    out_next    = 1'b1;
                    change_next = 2'b00;
                end else begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b01;
                end
            end

            ////////////////////////////////////////////////////////////////////
            // S2: 10 Rs inserted
            ////////////////////////////////////////////////////////////////////
            S2: begin
                if (in == 2'b00) begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b10;
                end else if (in == 2'b01) begin
                    n_state     = S0;
                    out_next    = 1'b1;
                    change_next = 2'b00;
                end else if (in == 2'b10) begin
                    n_state     = S0;
                    out_next    = 1'b1;
                    change_next = 2'b01;
                end else begin
                    n_state     = S0;
                    out_next    = 1'b0;
                    change_next = 2'b10;
                end
            end

            ////////////////////////////////////////////////////////////////////
            // Default
            ////////////////////////////////////////////////////////////////////
            default: begin
                n_state     = S0;
                out_next    = 1'b0;
                change_next = 2'b00;
            end

        endcase
    end

endmodule

`default_nettype wire
