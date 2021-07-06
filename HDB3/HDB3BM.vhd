library ieee;
use ieee.std_logic_1164.all;
entity HBD3BM is
port(
	codein: in std_logic;
	codeout: out std_logic_vector(1 downto 0);
	clk: in std_logic);
end HBD3BM;
architecture rtl of HBD3BM is
	shared variable  temp:std_logic_vector(3 downto 0);
	signal counta:std_logic;
	signal countc:std_logic;
begin
process(clk)
begin
if(rising_edge(clk))then
	temp(3 downto 0):=temp(2 downto 0)&codein;
	case temp(3) is
		when'1'=>counta<=not counta;
				 countc<=not countc;
			case counta is
				when'0'=>codeout<="10";
				when'1'=>codeout<="01";
			end case;
		when'0'=>
			case temp(3 downto 0) is
			when"0000"=>temp(0):='1';
				if(countc='0')then
					countc<='1';
					if(counta='0')then
					codeout<="10";
					else if(counta='1')then
					codeout<="01";
					end if;
					end if;
				else if(countc='1')then
					codeout<="00";
					counta<=not counta;
				end if;
				end if;
			when others =>codeout<="00";
			end case;					
	end case;
	end if;
end process;
end rtl;
			
			
				