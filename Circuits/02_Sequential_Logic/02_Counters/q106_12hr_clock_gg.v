module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    // step minutes when seconds hits 59
    wire step_m = ena && (ss == 8'h59);
    
    // step hours when minutes hits 59
    wire step_h= step_m && (mm == 8'h59);
    
    // Sequential Clock Logic
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h0;
            mm <= 8'h0;
            hh <= 8'h12; // resets to 12:00:00
            pm <= 1'b0; // 0 matlab AM hota hai
        end
        
        // seconds 
        if (ena) begin
                if (ss == 8'h59) begin
                    ss <= 8'h00;
                end 
            	else if (ss[3:0] == 4'h9) begin
                    ss[3:0] <= 4'h0;
                    ss[7:4] <= ss[7:4] + 1'b1;
                end 
            	else begin
                    ss[3:0] <= ss[3:0] + 1'b1;
                end
         end
        
        // minutes
        if (step_m) begin
            if (mm == 8'h59) begin
				mm <= 8'h00;
			end 
            else if (mm[3:0] == 4'h9) begin
				mm[3:0] <= 4'h0;
                mm[7:4] <= mm[7:4] + 1'b1;
            end 
            else begin
                mm[3:0] <= mm[3:0] + 1'b1;
			end
        end
        
        // hours
        if (step_h) begin
            if (hh == 8'h59) begin
                hh <= 8'h00;
            end 
            else if (hh[3:0] == 4'h9) begin
                hh[3:0] <= 4'h0;
                hh[7:4] <= hh[7:4] + 1'b1;
            end 
            else begin
                hh[3:0] <= hh[3:0] + 1'b1;
            end
		end
        
        // am/pm logic
    
    end
endmodule
