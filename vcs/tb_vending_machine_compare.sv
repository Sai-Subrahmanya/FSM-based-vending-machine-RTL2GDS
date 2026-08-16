`timescale 1ns/1ps

module tb_vending_machine_compare;


    // DUT ports
    logic       Clock;
    logic       rst;
    logic [1:0] in;
    wire        out;
    wire  [1:0] change;


    // DUT instance
    vending_machine dut (
        .Clock  (Clock),
        .rst    (rst),
        .in     (in),
        .out    (out),
        .change (change)
    );


    // Clock generation
    initial begin
        Clock = 1'b0;
        forever #5 Clock = ~Clock;
    end


    // Constants
    localparam [1:0] NO_COIN   = 2'b00;
    localparam [1:0] COIN_5    = 2'b01;
    localparam [1:0] COIN_10   = 2'b10;
    localparam [1:0] INVALID   = 2'b11;

    localparam [1:0] CHANGE_0  = 2'b00;
    localparam [1:0] CHANGE_5  = 2'b01;
    localparam [1:0] CHANGE_10 = 2'b10;


    // Helper tasks
    task automatic wait_clks(input int n);
        int i;
        begin
            for (i = 0; i < n; i++) begin
                @(posedge Clock);
            end
            #1;
        end
    endtask

    task automatic check_outputs(
        input       exp_out,
        input [1:0] exp_change,
        input string test_name
    );
        begin
            if ((out !== exp_out) || (change !== exp_change)) begin
                $display("ERROR: %s", test_name);
                $display("       actual   out=%b change=%b", out, change);
                $display("       expected out=%b change=%b", exp_out, exp_change);
                $display("       time=%0t", $time);
                $fatal;
            end else begin
                $display("PASS : %-45s out=%b change=%b time=%0t",
                         test_name, out, change, $time);
            end
        end
    endtask

    task automatic apply_reset;
        begin
            @(negedge Clock);
            rst = 1'b1;
            in  = NO_COIN;

            wait_clks(3);

            @(negedge Clock);
            rst = 1'b0;
            in  = NO_COIN;

            wait_clks(1);

            check_outputs(1'b0, CHANGE_0, "reset output check");
        end
    endtask


    // Drive one input for exactly one clock transaction.
    // IMPORTANT: This task does NOT automatically insert a trailing NO_COIN cycle. The next call controls the next cycle input.
    task automatic drive_cycle(
        input [1:0] coin,
        input       exp_out,
        input [1:0] exp_change,
        input string test_name
    );
        begin
            @(negedge Clock);
            in = coin;

            wait_clks(1);

            check_outputs(exp_out, exp_change, test_name);
        end
    endtask


    // Main test sequence
    initial begin
        $vcdplusfile("vending_machine_compare.vpd");
        $vcdpluson(0, tb_vending_machine_compare);

        $display("============================================================");
        $display("Vending Machine self-checking testbench started");
        $display("============================================================");

        rst = 1'b0;
        in  = NO_COIN;


        // TEST 1: Reset
        apply_reset();


        // TEST 2: S0 behavior
        apply_reset();
        drive_cycle(NO_COIN, 1'b0, CHANGE_0, "S0 + no coin");

        apply_reset();
        drive_cycle(COIN_5,  1'b0, CHANGE_0, "S0 + 5 Rs -> S1");
        drive_cycle(NO_COIN, 1'b0, CHANGE_5, "S1 + no coin -> refund 5");

        apply_reset();
        drive_cycle(COIN_10, 1'b0, CHANGE_0,  "S0 + 10 Rs -> S2");
        drive_cycle(NO_COIN, 1'b0, CHANGE_10, "S2 + no coin -> refund 10");

        apply_reset();
        drive_cycle(INVALID, 1'b0, CHANGE_0, "S0 + invalid coin");


        // TEST 3: S1 behavior
        apply_reset();
        drive_cycle(COIN_5, 1'b0, CHANGE_0,  "Reach S1 with 5 Rs");
        drive_cycle(COIN_5, 1'b0, CHANGE_0,  "S1 + 5 Rs -> S2");
        drive_cycle(NO_COIN, 1'b0, CHANGE_10, "S2 + no coin refund 10 after S1+5");

        apply_reset();
        drive_cycle(COIN_5,  1'b0, CHANGE_0, "Reach S1 again");
        drive_cycle(COIN_10, 1'b1, CHANGE_0, "S1 + 10 Rs -> vend, no change");
        drive_cycle(NO_COIN, 1'b0, CHANGE_0, "After vend return S0 idle");

        apply_reset();
        drive_cycle(COIN_5,  1'b0, CHANGE_0, "Reach S1 for invalid test");
        drive_cycle(INVALID, 1'b0, CHANGE_5, "S1 + invalid -> refund 5");


        // TEST 4: S2 behavior
        apply_reset();
        drive_cycle(COIN_10, 1'b0, CHANGE_0, "Reach S2 with 10 Rs");
        drive_cycle(COIN_5,  1'b1, CHANGE_0, "S2 + 5 Rs -> vend, no change");
        drive_cycle(NO_COIN, 1'b0, CHANGE_0, "After vend return S0 idle");

        apply_reset();
        drive_cycle(COIN_10, 1'b0, CHANGE_0, "Reach S2 again");
        drive_cycle(COIN_10, 1'b1, CHANGE_5, "S2 + 10 Rs -> vend, return 5");
        drive_cycle(NO_COIN, 1'b0, CHANGE_0, "After vend+change return S0 idle");

        apply_reset();
        drive_cycle(COIN_10, 1'b0, CHANGE_0,  "Reach S2 for invalid test");
        drive_cycle(INVALID, 1'b0, CHANGE_10, "S2 + invalid -> refund 10");


        // TEST 5: Back-to-back purchase sequences
        apply_reset();

        drive_cycle(COIN_5,  1'b0, CHANGE_0, "Sequence 5 then 10, step 1");
        drive_cycle(COIN_10, 1'b1, CHANGE_0, "Sequence 5 then 10, vend");

        drive_cycle(COIN_10, 1'b0, CHANGE_0, "Sequence 10 then 5, step 1");
        drive_cycle(COIN_5,  1'b1, CHANGE_0, "Sequence 10 then 5, vend");

        drive_cycle(COIN_10, 1'b0, CHANGE_0, "Sequence 10 then 10, step 1");
        drive_cycle(COIN_10, 1'b1, CHANGE_5, "Sequence 10 then 10, vend plus 5 change");


        // TEST 6: Reset in middle of transaction
        apply_reset();

        drive_cycle(COIN_5, 1'b0, CHANGE_0, "Reach S1 before mid-transaction reset");

        @(negedge Clock);
        rst = 1'b1;
        in  = COIN_10;

        wait_clks(2);

        check_outputs(1'b0, CHANGE_0, "reset during transaction clears output/change");

        @(negedge Clock);
        rst = 1'b0;
        in  = NO_COIN;

        wait_clks(1);

        check_outputs(1'b0, CHANGE_0, "after reset machine is idle S0");


        // End
        $display("============================================================");
        $display("ALL VENDING MACHINE TESTS PASSED");
        $display("============================================================");

        $finish;
    end

endmodule
