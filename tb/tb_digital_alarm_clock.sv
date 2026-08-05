`timescale 1ms / 100us // Simulation units in milliseconds

module tb_digital_alarm_clock;

    reg clk, reset;
    reg [4:0] rh, ah;
    reg [5:0] rm, am;
    wire [4:0] h;
    wire [5:0] m, s;
    wire alarm_out;

    digital_alarm_clock uut (
        .clk(clk), 
        .reset(reset),
        .reset_hour(rh),
        .alarm_hour(ah),
        .hour_out(h),
        .reset_min(rm),
        .alarm_min(am),
        .min_out(m), 
        .sec_out(s),
        .alarm_signal(alarm_out)
    );

    // Clock toggles every 500ms (1 second = 1000ms)
    always #500 clk = ~clk;

    initial begin
        clk = 0; 
        reset = 1;
        rh = 5'd0; rm = 6'd0; // Start at 00:00:00
        ah = 5'd0; am = 6'd1; // Alarm set for 00:01:00

        #1000 reset = 0; // Release reset after 1 simulated second
        $display("Clock started. Waiting for alarm at 00:01:00...");

        // Wait for alarm to activate
        wait (alarm_out == 1);
        $display("Alarm Triggered! Observing PWM output...");

        // Run for 12 simulated minutes (12 mins * 60 secs * 1000ms = 720,000 ms)
        #720000;

        $display("Simulation Finished.");
        $finish;
    end

endmodule
