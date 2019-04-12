module Ram(address,clk,bus,chip_enable,data_enable,output_enable,data_out,LB,UB,mem_address);
	input clk;
	output reg [19:0] address=20'd0;
	output chip_enable,data_enable,output_enable,LB,UB;
	inout [15:0] bus;
	reg [15:0] data[9:0];
	reg [19:0] add[9:0];
	reg [15:0] data_in;
	reg [15:0] count;
	//wire [15:0] data_out_1;
	output [15:0] data_out;
	output [7:0] mem_address;
	
	reg [1:0]write_en;
	reg [2:0] state;
	
	reg [39:0] counter=40'd0;
	reg sample_clock=1'd0;
	
	ram_test sram(.chip_enable(chip_enable),.data_enable(data_enable),.output_enable(output_enable),.bus(bus),.data_in(data_in),.data_out(data_out),.write_en(write_en),.LB(LB),.UB(UB));//ram_test(clk,write_en,bus,data_in,data_out,output_enable,data_enable,chip_en);
	
	parameter put_data=3'd0, write= 3'd1,set_address=3'd2,idle2=3'd3 , idle1= 3'd4,read=3'd6,idle3=3'd7;
	
	initial 
		begin
			count=10'd0;
			data[0]=16'd1024;
			data[1]=16'd50612;
			data[2]=16'd255;
			data[3]=16'd12;
			data[4]=16'd6427;
			data[5]=16'd322;
			data[6]=16'd16;
			data[7]=16'd82;
			data[8]=16'd43;
			data[9]=16'd23;
	
			
			add[0]=20'd233;
			add[1]=20'd252;
			add[2]=20'd255;
			add[3]=20'd128;
			add[4]=20'd64;
			add[5]=20'd32;
			add[6]=20'd16;
			add[7]=20'd8;
			add[8]=20'd4;
			add[9]=20'd2;
		end
		
	
	always @(posedge sample_clock)
		begin
			case(state)
				put_data:
					begin
						write_en=2'b10;
						address=count;
						data_in=3'd3*count;
						state=write;
					end
				write:
					begin
						write_en=2'b11;
						state=idle1;
					end
				idle1:
					begin
						write_en=2'b10;
						if(count==16'd50) 
							begin
								state=read;
								count=16'd0;
							end
						else
							begin
								count=count+10'd1;
								state=put_data;
							end
					end
				read:
					begin
						write_en=2'b00;
						address=count;
						state=idle2;
					end
				idle2:
					begin
						if(count==16'd50) 
							begin
								state=put_data;
								count=16'd0;
							end
						else
							begin
								count=count+10'd1;
								state=read;
							end
					end
				default:
					begin
						write_en=2'b10;
						count=10'd0;
					end
				
			endcase
		end
		
		always@(posedge clk)
		begin
			if (counter==40'd10000000)
				begin
					counter=40'd0;
					sample_clock=1'b1;
				end
			else
				begin
					counter=counter +40'd1;
					sample_clock=1'b0;
				end
		end 
		assign mem_address=address[7:0];
endmodule
