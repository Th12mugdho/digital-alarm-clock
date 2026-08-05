// Counter 60 module for Seconds and Minutes
module counter_60 (
    input clk, reset, en,
    input [5:0] load_val,
    output reg [5:0] count,
    output rollover
);
    assign rollover = (count == 6'd59 && en);

    always @(posedge clk) begin
        if (reset) 
            count <= load_val;
        else if (en) begin
            if (count == 6'd59) 
                count <= 6'd0;
            else 
                count <= count + 1'b1;
        end
    end
endmodule

// Counter 24 module for Hours
module counter_24 (
    input clk, reset, en,
    input [4:0] load_val,
    output reg [4:0] count,
    output rollover
);
    assign rollover = (count == 5'd23 && en);

    always @(posedge clk) begin
        if (reset) 
            count <= load_val;
        else if (en) begin
            if (count == 5'd23) 
                count <= 5'd0;
            else 
                count <= count + 1'b1;
        end
    end
endmodule
