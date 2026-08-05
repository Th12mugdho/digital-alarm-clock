`timescale 1ms / 100us

module alarm_mod (
    input clk, reset,
    input [4:0] h_in, ah_in,
    input [5:0] m_in, am_in,
    input [5:0] s_in,
    output reg alarm_pwm
);

    reg [9:0] duration_cnt; // Needed to count 60 seconds
    reg alarm_active;
    reg [3:0] pwm_divider;  // Used to generate the PWM signal

    always @(posedge clk) begin
        if (reset) begin
            alarm_active <= 1'b0;
            duration_cnt <= 10'd0;
            pwm_divider  <= 4'd0;
            alarm_pwm    <= 1'b0;
        end else begin
            // Trigger match at 0 seconds
            if (!alarm_active && (h_in == ah_in) && (m_in == am_in) && (s_in == 6'd0)) begin
                alarm_active <= 1'b1;
                duration_cnt <= 10'd0;
            end

            if (alarm_active) begin
                pwm_divider <= pwm_divider + 1'b1;
                alarm_pwm   <= pwm_divider[3];

                // Counter for 1 minute (60 seconds)
                if (duration_cnt == 10'd59) begin
                    alarm_active <= 1'b0;
                    duration_cnt <= 10'd0;
                    alarm_pwm    <= 1'b0;
                end else begin
                    duration_cnt <= duration_cnt + 1'b1;
                end
            end else begin
                alarm_pwm <= 1'b0;
            end
        end
    end

endmodule
