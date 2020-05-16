library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StackCalculator_Tb is
end StackCalculator_Tb;

architecture TestBench of StackCalculator_Tb is
	signal enter, numero_operador, delete, swap, clear, reset : std_logic;
	signal operator_in : std_logic;
	signal xIn : std_logic_Vector(7 downto 0);
	signal readAdress : std_logic_vector(1 downto 0);
	signal readData : std_logic_vector(7 downto 0);
	signal s_clock : std_logic;
	signal pointer : std_logic_vector(2 downto 0);
	signal action_out1, action_out2 : std_logic_vector(2 downto 0);
	
begin 

	uut : entity work.fase1_vhdl(Structural)
			port map(clock => s_clock,
						reset => reset,
						enter => enter,
						numero_operador => numero_operador,
						delete => delete,
						swap => swap,
						clear => clear,
						operator_in => operator_in,
						xIn => xIn,
						readAdress => readAdress,
						readData => readData,
						pointer => pointer,
						action_out1 => action_out1,
						action_out2 => action_out2);

						
	clock_proc : process
	begin
	s_clock <= '0';
	wait for 5 ns;
	s_clock <= '1';
	wait for 5 ns;
	end process;
	
	stim_proc : process
	begin
	
	wait for 5 ns;
	reset <= '1';
	enter <= '0';
	numero_operador <= '0';
	delete <= '0';
	swap <= '0';
	clear <= '0';
	operator_in <= '0';
	xIn <= "00000000";
	readAdress <= "00";
	
	wait for 50 ns;
	reset <= '0';
	
	wait for 50 ns;
	
	xIn <= "00000001";
	xIn <= "00000011";
	enter <= '1';
	wait for 5 ns;
	enter <= '0';
	
	wait for 45 ns;
	
	xIn <= "00000001";
	enter <= '1';
	wait for 5 ns;
	enter <= '0';
	
	wait for 45 ns;
	
	readAdress <= "01";
	wait for 50 ns; -- 255 ns
	
	readAdress <= "00";
	wait for 50 ns;
	
	
	delete <= '1';
	wait for 5 ns;
	delete <= '0';
	
	wait for 45 ns;
	
	xIn <= "00000011";
	enter <= '1';
	wait for 5 ns;
	enter <= '0';
	readAdress <= "01";
	
	wait for 45 ns;
	
	numero_operador <= '1';
	enter <= '1';
	wait for 5 ns;
	enter <= '0';
	
	wait for 45 ns; -- 455 ns
	
	wait for 50 ns;
	
	readAdress <= "00";
	wait for 50 ns; -- 545 ns
	
	end process;
	
end TestBench;
