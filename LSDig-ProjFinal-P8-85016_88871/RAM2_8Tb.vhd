library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM2_8Tb is
end RAM2_8Tb;

architecture Stimulus of Ram2_8Tb is

signal s_clock : std_logic;
signal s_action : std_logic_vector(2 downto 0); -- 000 push ; 001 delete ; 010 swap ; 011 clear ; 100 result
signal s_writeData : std_logic_vector(7 downto 0);
signal s_resultado_in : std_logic_vector(7 downto 0);
signal s_readAdress : std_logic_vector(1 downto 0);
signal s_number1_out : std_logic_vector(7 downto 0);
signal s_number2_out : std_logic_vector(7 downto 0);
signal s_readData : std_logic_vector(7 downto 0);

signal s_pointer : std_logic_vector(2 downto 0);

begin
	uut : entity work.RAM2_8(Behavioral)
			port map(clock => s_clock,
						action => s_action,
						writeData => s_writeData,
						resultado_in => s_resultado_in,
						readAdress => s_readAdress,
						number1_out => s_number1_out,
						number2_out => s_number2_out,
						readData => s_readData,
						pointer => s_pointer);

clock : process
begin
	s_clock <= '0';
	wait for 25 ns;
	s_clock <= '1';
	wait for 25 ns;
end process;

						
stim_proc: process
begin
	wait for 25 ns;
	s_action <= "000";
	s_writeData <= "00000001";

	wait for 50 ns;
	s_writeData <= "00000011";
	s_readAdress <= "00";

	wait for 50 ns;
	s_action <= "111";
	s_readAdress <= "01";
	wait for 50 ns;
	s_action <= "100";
	s_resultado_in <= "00000100";
	s_readAdress <= "00";
	wait for 50 ns;
	s_action <= "000";
	s_writeData <= "00000001";
	s_readAdress <= "01";

	wait for 50 ns; -- 250 ns
	s_action <= "001";
	s_readAdress <= "00";
	
	wait for 50 ns;
	s_action <= "111";
	wait for 50 ns;
	s_action <= "000";
	s_writeData <= "00001100";
	
	wait for 50 ns; 
	s_action <= "010";
	s_readAdress <= "01";
	wait for 50 ns;
	s_action <= "111";
	wait for 50 ns; -- 500 ns
	s_action <= "011";
	s_readAdress <= "00";
	wait for 50 ns;
	s_action <= "111";
	wait for 50 ns;
end process;
end Stimulus;
	