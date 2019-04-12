module ram_test(write_en,bus,data_in,data_out,output_enable,data_enable,chip_enable,UB,LB);
	input [1:0] write_en;
	/*output reg output_enable;
	output reg data_enable;
	output reg chip_en;
	output reg UB;
	output reg LB;*/
	inout [15:0] bus;
	//inout [15:0] bus;
	input [15:0] data_in;
	output [15:0]data_out;
	
	
	output output_enable;
	output data_enable;
	output chip_enable;
	output UB;
	output LB;
	//output [15:0]data_out;
	
	/*always@(posedge clk)
		begin
			if(write_en==2'b11)
				begin
					data_enable=1'b0;
					chip_en=1'b0;
					output_enable=1'b1;
					LB= 1'b0;
					UB= 1'b0;
					
				end
			else if(write_en==2'b00)
				begin
					data_enable=1'b1;
					chip_en=1'b0;
					output_enable=1'b0;
					LB= 1'b0;
					UB= 1'b0;
				end
			else 
				begin
					data_enable=1'b1;
					chip_en=1'b1;
					output_enable=1'b1;
					LB= 1'bz;
					UB= 1'bz;
					//bus=16'bzzzzzzzzzzzzzzzz;
				end
		end*/
		assign data_enable=(write_en==2'b11) ? 1'b0 :1'b1 ;
		assign chip_enable=(write_en==2'b11 || write_en==2'b00) ? 1'b0 :1'b1 ;
		assign output_enable=(write_en==2'b00) ? 1'b0 :1'b1 ;
		assign LB= (write_en==2'b11 || write_en==2'b00) ? 1'b0 :1'b1 ;
		assign UB= (write_en==2'b11 || write_en==2'b00) ? 1'b0 :1'b1 ;
	
		assign data_out=(write_en ==2'b00) ? bus : 16'dz;
		assign bus= (write_en ==2'b11) ? data_in: 16'dz;
	
	
endmodule
