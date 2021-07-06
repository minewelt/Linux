LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pcm is
	port(
		clk : in std_logic after 10 us;
		input : in std_logic_vector(12 downto 0);
		output : out std_logic_vector(7 downto 0)
	);
end pcm;

architecture code of pcm is
	signal thirteen : std_logic_vector(12 downto 0);
	signal eight  : std_logic_vector(7 downto 0);
	
begin
	thirteen <= input;
	process(clk,input)
	begin
	eight(7) <= thirteen(12);
	if clk'event and clk='1' then
		if thirteen(11) = '1' then
			eight(6 downto 0) <= "000" & thirteen(10 downto 7);
			elsif thirteen(10) = '1' then
				eight(6 downto 0) <= "110" & thirteen(9 downto 6);
				elsif thirteen(9) = '1' then
					eight(6 downto 0) <= "101" & thirteen(8 downto 5);
					elsif thirteen(8) = '1' then
						eight(6 downto 0) <= "100" & thirteen(7 downto 4);
						elsif thirteen(7) = '1' then
							eight(6 downto 0) <= "011" & thirteen(6 downto 3);
							elsif thirteen(6) = '1' then
								eight(6 downto 0) <= "010" & thirteen(5 downto 2);
								elsif thirteen(5) = '1' then
									eight(6 downto 0) <= "001" & thirteen(4 downto 1);
									else
										eight(6 downto 0) <= "000" & thirteen(4 downto 1);
		
		
		end if;
		end if;
		output <= eight;
	end process;
end architecture;
		
