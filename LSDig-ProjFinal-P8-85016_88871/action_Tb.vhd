library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity action_Tb is
end action_Tb;

architecture Test of action_Tb is

signal s_action_in : std_logic_vector(2 downto 0);
signal s_delete : std_logic;
signal s_swap : std_logic;
signal s_clear : std_logic;
signal s_action_out : std_logic_vector(2 downto 0);

begin

uut : entity work.action(Behavioral)
			port map(action_in => s_action_in,
						delete => s_delete,
						swap => s_swap,
						clear => s_clear,
						action_out => s_action_out);
						
stim_proc : process

begin

s_action_in <= "000";
wait for 50 ns;

s_delete <= '1';
wait for 25 ns;
s_delete <= '0';
wait for 25 ns;
s_swap <= '1';
wait for 25 ns;
s_swap <= '0';
wait for 25 ns;
s_clear <= '1';
wait for 25 ns;
s_clear <= '0';
wait for 25 ns;
s_action_in <= "100";
wait for 25 ns;

end process;

end Test;




