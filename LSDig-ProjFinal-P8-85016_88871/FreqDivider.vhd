library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FreqDivider is
	generic(divide : positive := 50000000);
	port(start : in std_logic;
		  clock : in std_logic;
		  out_clock : out std_logic);
end FreqDivider;

architecture Behavioral of FreqDivider is
	subtype maxCont is natural range 0 to divide-1;
	signal s_cont : maxCont := 0;
begin
	process(clock)
	begin
		if(start = '1') then
			if(rising_edge(clock)) then 
				if(s_cont = ((divide/2)-1)) then
					out_clock <= '1';
				elsif(s_cont = divide-1) then
					out_clock <= '0';
				end if;
				s_cont <= s_cont +1;
			end if;
		end if;
	end process;
end Behavioral;
				
				
	