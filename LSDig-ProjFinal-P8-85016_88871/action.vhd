library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity action is
	port(clock : in std_logic;
		  action_in : in std_logic_vector(2 downto 0);
		  delete : in std_logic;
		  swap : in std_logic;
		  clear : in std_logic;
		  action_out : out std_logic_vector(2 downto 0));
end action;

architecture Behavioral of action is
begin
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(clear = '1') then
				action_out <= "011";
			elsif(delete = '1') then
				action_out <= "001";
			elsif(swap = '1') then
				action_out <= "010";
			else
				action_out <= action_in;
			end if;
		end if;
	end process;
end Behavioral;