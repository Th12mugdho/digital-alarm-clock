`timescale 1ms / 100us

module digital_alarm_clock (
    input clk, reset,
    input [4:0] reset_hour, alarm_hour,
    input [5:0] reset_min, alarm_min,
    output [4:0] hour_out,
    output [5:0] min_out, sec_out,
    output alarm_signal // PWM output
);

    wire roll_s, roll_m;

    counter_60 sec_seg (
        .clk(clk), 
        .reset(reset), 
        .en(1'b1), 
        .load_val(6'd0),
        .count(sec_out),
        .rollover(roll_s)
    );

    counter_60 min_seg (
        .clk(clk), 
        .reset(reset), 
        .en(roll_s), 
        .load_val(reset_min),
        .count(min_out), 
        .rollover(roll_m)
    );

    counter_24 hr_seg (
        .clk(clk), 
        .reset(reset), 
        .en(roll_m), 
        .load_val(reset_hour),
        .count(hour_out), 
        .rollover()
    );

    alarm_mod alarm_seg (
        .clk(clk), 
        .reset(reset),
        .h_in(hour_out), 
        .ah_in(alarm_hour),
        .m_in(min_out),
        .s_in(sec_out),
        .am_in(alarm_min),
        .alarm_pwm(alarm_signal)
    );

endmodule
