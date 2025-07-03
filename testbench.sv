// testbench for simulation
module testbench;
  reg clk; reg signed [15:0] in_data; reg RST; reg EN;
  wire signed[31:0]out_data; wire signed[15:0] sampleT;
  digital_fir uut(clk,in_data,RST,EN,out_data,sampleT);
  reg [15:0] memory[0:15];
  integer k=0;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,testbench);
    $dumpvars(1, uut);
    $display("Simulation started");
    memory[0] = 16'd0;
    memory[1] = 16'd1;
    memory[2] = 16'd2;
    memory[3] = 16'd3;
    memory[4] = 16'd4;
    memory[5] = 16'd5;
    memory[6] = 16'd6;
    memory[7] = 16'd7;


  end
  
  initial begin
    clk=1'b0;
    forever #10 clk=~clk;
  end
  initial begin
    RST = 1'b1;
    EN  = 1'b0;
    in_data = 0;
    #30;

    RST = 1'b0;
    EN  = 1'b1;

    for (k = 0; k < 8; k = k + 1) begin
      @(posedge clk);
      in_data = memory[k];
      #1;  // Wait for out_data update
      $display("Time: %0t | Input: %0d | Output: %0d", $time, in_data, out_data);
    end

    #50;
    $finish;
  end
endmodule
  
