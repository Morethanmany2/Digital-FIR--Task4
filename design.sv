// Design for digital FIR (Finite Impulse Response) Filter

`timescale 1ns/1ps

module digital_fir(clk,in_data,RST,EN,out_data,sampleT);
  
//   Coefficients width for the filter
  parameter N1=8;
//   input data width
  parameter N2=16;
//   output data width
  parameter N3=32;
  
//   array to store the coefficients
  wire signed [N1 -1:0] b[0:7];
  
//   assign filter coefficients
  assign b[0]=8'b00010000;
  assign b[1]=8'b00010000;
  assign b[2]=8'b00010000;
  assign b[3]=8'b00010000;
  assign b[4]=8'b00010000;
  assign b[5]=8'b00010000;
  assign b[6]=8'b00010000;
  assign b[7]=8'b00010000;
  
//   array to store input data
  input signed [N2-1:0] in_data;
  
//  array to store output data samples
  output signed [N2-1:0] sampleT;
  input clk;
  input RST;
  input EN;
//   filtered data samples
  output signed[N3-1:0] out_data;
  
//   register to store output data
  reg signed[N3-1:0] out_data_reg;
  
//   array to store samples and shift them
  reg signed[N2-1:0] samples[0:6];
  
  always @(posedge clk)
    begin
      if (RST==1'b1)
        begin
          samples[0]<=0;
          samples[1]<=0;
          samples[2]<=0;
          samples[3]<=0;
          samples[4]<=0;
          samples[5]<=0;
          samples[6]<=0;
          out_data_reg<=0;
        end
      if ((EN==1'b1)&&(RST==1'b0))
        begin
          out_data_reg<= b[0]*in_data+b[1]*samples[0]+b[2]*samples[1]+b[3]*samples[2]+b[4]*samples[3]+b[5]*samples[4]+b[6]*samples[5]+b[7]*samples[6];
          
          samples[0]<=in_data;
          samples[1]<=samples[0];
          samples[2]<=samples[1];
          samples[3]<=samples[2];
          samples[4]<=samples[3];
          samples[5]<=samples[4];
          samples[6]<=samples[5];
        end
    end
  assign out_data=out_data_reg;
  assign sampleT=samples[0];
endmodule          