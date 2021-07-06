library ieee;  
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity fenjie is       
port( datain,clkin  :in std_logic;
      shixi_pulse  	:out std_logic_vector(31 downto 0 );
      dataout, clkout  :out std_logic       );
end fenjie;
    
architecture fj of fenjie is 
    
  signal temp 			:std_logic_vector(7 downto 0):="00000000";     
  signal total_conter   :std_logic_vector(8 downto 0):="000000000";     --总计数器—-第三位表示该时隙的第几位，中间五位数表示第几时隙--最高位表示当前帧是否位奇数偶数帧0为偶数
  signal state         	:std_logic:='0';   								--状态表示 0为非同步态  1为同步态
  signal tong_bu,shi_bu :std_logic_vector(1 downto 0):="00";			--同步，失步计数器
       
  begin
p1:process(clkin)       
begin
		if clkin'event and clkin='1' then  
				temp<=temp(6 downto 0)&datain;																--装入数据
		end if;
end process p1;  
pan_duan_tong_bu:process(clkin)    														
begin
if clkin'event and clkin='0' then
        total_conter<= total_conter+'1';
        
case state is
    when '0'=>case tong_bu is
					when "00"=> if temp="10011011"then tong_bu<=tong_bu+'1'; total_conter<="000001000";end if;  --计数器加一，是输出变为第八位
					when "01"=> if total_conter="000000111" then 
									if temp="10011011"then 
									tong_bu<=tong_bu+'1';
									else tong_bu<="00";
									end if;
								else null;
								end if;
					when "10"=> if total_conter="000000111" then 
									if temp="10011011"then 
									state<='1';
									tong_bu<="00";
									else tong_bu<="00";
									end if;
								else null;
					end if;
					when others=>null;
					end case ;
    when '1'=>case shi_bu is                              
					when "00"=>if total_conter="000000000111" then if temp/="10011011" then shi_bu<=shi_bu+'1'; end if;end if;
					when "01"=>if total_conter="000000000111" then if temp/="10011011" then shi_bu<=shi_bu+'1'; else shi_bu<="00";end if; end if;
					when "10"=>if total_conter="000000000111" then if temp/="10011011" then state<='0';shi_bu<="00";else shi_bu<="00"; end if;end if;
					when others=>null;
					end case;
	when others=>null;

end case ;
end if;
end process pan_duan_tong_bu;

shu_ju_shu_chu:process(clkin,state)    
    
begin
    if clkin'event and clkin='1' then
       if state='1' then
		dataout<=temp(7);
case total_conter(7 downto 3) is
    when	"00000"=>shixi_pulse<="00000000000000000000000000000001";
    when	"00001"=>shixi_pulse<="00000000000000000000000000000010";
    when	"00010"=>shixi_pulse<="00000000000000000000000000000100";
    when	"00011"=>shixi_pulse<="00000000000000000000000000001000";
    when	"00100"=>shixi_pulse<="00000000000000000000000000010000";
    when	"00101"=>shixi_pulse<="00000000000000000000000000100000";
    when	"00110"=>shixi_pulse<="00000000000000000000000001000000";
    when	"00111"=>shixi_pulse<="00000000000000000000000010000000";
    when	"01000"=>shixi_pulse<="00000000000000000000000100000000";
    when	"01001"=>shixi_pulse<="00000000000000000000001000000000";
    when	"01010"=>shixi_pulse<="00000000000000000000010000000000";
    when	"01011"=>shixi_pulse<="00000000000000000000100000000000";
    when	"01100"=>shixi_pulse<="00000000000000000001000000000000";
    when	"01101"=>shixi_pulse<="00000000000000000010000000000000";
    when	"01110"=>shixi_pulse<="00000000000000000100000000000000";
    when	"01111"=>shixi_pulse<="00000000000000001000000000000000";
    when	"10000"=>shixi_pulse<="00000000000000010000000000000000";
    when	"10001"=>shixi_pulse<="00000000000000100000000000000000";
    when	"10010"=>shixi_pulse<="00000000000001000000000000000000";
    when	"10011"=>shixi_pulse<="00000000000010000000000000000000";
    when	"10100"=>shixi_pulse<="00000000000100000000000000000000";
    when	"10101"=>shixi_pulse<="00000000001000000000000000000000";
    when	"10110"=>shixi_pulse<="00000000010000000000000000000000";
    when	"10111"=>shixi_pulse<="00000000100000000000000000000000";
    when	"11000"=>shixi_pulse<="00000001000000000000000000000000";
    when	"11001"=>shixi_pulse<="00000010000000000000000000000000";
    when	"11010"=>shixi_pulse<="00000100000000000000000000000000";
    when	"11011"=>shixi_pulse<="00001000000000000000000000000000";
    when	"11100"=>shixi_pulse<="00010000000000000000000000000000";
    when	"11101"=>shixi_pulse<="00100000000000000000000000000000";
    when	"11110"=>shixi_pulse<="01000000000000000000000000000000";
    when	"11111"=>shixi_pulse<="10000000000000000000000000000000";
			
    end case;
    end if;
    end if;
    end process shu_ju_shu_chu;
    clkout<=clkin;
end fj;
