library  ieee;                    										--程序所调用的库是IEEE库
use  ieee.std_logic_1164.all;       									--定义了std_logic，std_logic_vector类型 
use  ieee.std_logic_unsigned.all;   									--用到基于std_logic，std_logic_vector类型的 --无符号的算术运算 
entity fujie is 
port (clockin: in std_logic;      										--输入时钟 2.048Mb/s 
		Audio_input1:   in std_logic_vector(7 downto 0):="00000001"; 
		Audio_input2:   in std_logic_vector(7 downto 0):="00000010"; 
		Audio_input3:   in std_logic_vector(7 downto 0):="00000011"; 
		Audio_input4:   in std_logic_vector(7 downto 0):="00000100";
		Audio_input5:   in std_logic_vector(7 downto 0):="00000101"; 
		Audio_input6:   in std_logic_vector(7 downto 0):="00000110";
		Audio_input7:   in std_logic_vector(7 downto 0):="00000111"; 
		Audio_input8:   in std_logic_vector(7 downto 0):="00001000"; 
		Audio_input9:   in std_logic_vector(7 downto 0):="00001001"; 
		Audio_input10:  in std_logic_vector(7 downto 0):="00001010"; 
		Audio_input11:  in std_logic_vector(7 downto 0):="00001011"; 
		Audio_input12:  in std_logic_vector(7 downto 0):="00001100"; 
		Audio_input13:  in std_logic_vector(7 downto 0):="00001101"; 
		Audio_input14:  in std_logic_vector(7 downto 0):="00001110"; 
		Audio_input15:  in std_logic_vector(7 downto 0):="00001111";
		Audio_input16:  in std_logic_vector(7 downto 0):="00010000"; 
		Audio_input17:  in std_logic_vector(7 downto 0):="00010001"; 
		Audio_input18:  in std_logic_vector(7 downto 0):="00010010"; 
		Audio_input19:  in std_logic_vector(7 downto 0):="00010011";
		Audio_input20:  in std_logic_vector(7 downto 0):="00010100"; 
		Audio_input21:  in std_logic_vector(7 downto 0):="00010101"; 
		Audio_input22:  in std_logic_vector(7 downto 0):="00010110"; 
		Audio_input23:  in std_logic_vector(7 downto 0):="00010111";  
		Audio_input24:  in std_logic_vector(7 downto 0):="00011000";
		Audio_input25:  in std_logic_vector(7 downto 0):="00011001"; 
		Audio_input26:  in std_logic_vector(7 downto 0):="00011010";
		Audio_input27:  in std_logic_vector(7 downto 0):="00011011"; 
		Audio_input28:  in std_logic_vector(7 downto 0):="00011100"; 
		Audio_input29:  in std_logic_vector(7 downto 0):="00011101";
		Audio_input30:  in std_logic_vector(7 downto 0):="00011110";        --30路语音信号输入     
		dataout		 :  out std_logic;                       				--输出串行数据流  
		address_bus	 :  out std_logic_vector(4 downto 0);					--五位时隙总线信号  
		clockout:out std_logic);                   							
end  fujie; 
architecture  behav  of fujie  is 
			shared variable total_counter :std_logic_vector(11 downto 0):="000000000000";
			signal temp  :std_logic_vector(7 downto 0) ;
begin 
p1:process(clockin)         
begin
	 clockout<=clockin;                       								
if   clockin'event and clockin='1' then
	 total_counter:=total_counter+'1'; 
case total_counter(7 downto 3)  is
	when "00000"=>if   total_counter(8)='0' 										--在偶数帧传输同步信号“10011011”；在基数帧传输“全1信号”
					then temp<="10011011";	
					else temp<="11111111";
					end if;
					address_bus<="00000";
	when "00001"=> temp<=Audio_input1;	address_bus<="00001";	--1
	when "00010"=> temp<=Audio_input2;	address_bus<="00010";	--2
	when "00011"=> temp<=Audio_input3;	address_bus<="00011"; 	--3
	when "00100"=> temp<=Audio_input4;	address_bus<="00100"; 	--4
	when "00101"=> temp<=Audio_input5;	address_bus<="00101";	--5
	when "00110"=> temp<=Audio_input6;  address_bus<="00110";	--6
	when "00111"=> temp<=Audio_input7;	address_bus<="00111";
	when "01000"=> temp<=Audio_input8;	address_bus<="01000";
	when "01001"=> temp<=Audio_input9;	address_bus<="01001";
	when "01010"=> temp<=Audio_input10;	address_bus<="01010";
	when "01011"=> temp<=Audio_input11;	address_bus<="01011";
	when "01100"=> temp<=Audio_input12;	address_bus<="01100";
	when "01101"=> temp<=Audio_input13;	address_bus<="01101";
	when "01110"=> temp<=Audio_input14;	address_bus<="01110";
	when "01111"=> temp<=Audio_input15;	address_bus<="01111";
		
	when "10000"=> if total_counter(11 downto 8)="0000"								--只有在第零帧的第十六时隙传输勤务信号，否则传输全1
											 then temp<="00001111";   
											 else temp<="11111111";
											 end if;
	when "10001"=> temp<=Audio_input17; address_bus<="10000";
	when "10010"=> temp<=Audio_input18;	address_bus<="10001";
	when "10011"=> temp<=Audio_input19;	address_bus<="10010";
	when "10100"=> temp<=Audio_input20;	address_bus<="10011";
	when "10101"=> temp<=Audio_input21;	address_bus<="10100";
	when "10110"=> temp<=Audio_input22;	address_bus<="10101";
	when "10111"=> temp<=Audio_input23;	address_bus<="10110";
	when "11000"=> temp<=Audio_input24;	address_bus<="10111";
	when "11001"=> temp<=Audio_input25;	address_bus<="11000";
	when "11010"=> temp<=Audio_input26;	address_bus<="11001";
	when "11011"=> temp<=Audio_input27;	address_bus<="11010";
	when "11100"=> temp<=Audio_input28;	address_bus<="11011";
	when "11101"=> temp<=Audio_input29;	address_bus<="11100";
	when "11110"=> temp<=Audio_input30;	address_bus<="11101";
	when "11111"=> temp<="00000000";												--第三十一路信号不传输信号，传输保护间隔
	when others => null;
end case;
end if;
end process p1;
p2:process (clockin)
begin
	if clockin'event and clockin='1' then
case total_counter(2 downto 0)is
	when "000"=>dataout<=temp(7);
	when "001"=>dataout<=temp(6);
	when "010"=>dataout<=temp(5);
	when "011"=>dataout<=temp(4);
	when "100"=>dataout<=temp(3);
	when "101"=>dataout<=temp(2);
	when "110"=>dataout<=temp(1);
	when "111"=>dataout<=temp(0);
end case;
end if;
end process p2;	
end behav;  