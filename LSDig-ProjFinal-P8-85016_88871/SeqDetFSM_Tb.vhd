library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SeqDetFSM_Tb is
end SeqDetFSM_Tb;

architecture Test of SeqDetFSM_Tb is

signal clock, reset : std_logic;
signal enter : std_logic;
signal numero_operador : std_logic; -- numero ou operador
signal operador_in : std_logic_vector(1 downto 0);
signal xIn : std_logic_vector(7 downto 0);
signal action : std_logic_vector(2 downto 0);
signal operador_out : std_logic_vector(1 downto 0);
signal xOut : std_logic_vector(7 downto 0);

begin
uut : entity work.SeqDetFSM(MealyArch)
			port map(clock => clock,
						reset => reset,
						numero_operador => numero_operador,
						xIn => xIn,
						action => action,
						operador_out => operador_out,
						xOut => xOut,
						enter => enter,
						operador_in => operador_in);
						
clock_proc : process
begin

clock <= '0';
wait for 25 ns;
clock <= '1';
wait for 25 ns;

end process;

stim_proc : process
begin
wait for 25 ns;

operador_in <= "00";
xIn <= "00000000";
enter <= '0';
reset <= '0';
numero_operador <= '0';

wait for 100 ns;

xIn <= "00000010";

wait for 50 ns;

enter <= '1';
wait for 5 ns;
enter <= '0';
wait for 5 ns;

wait for 40 ns;

xIn <= "00000001";

wait for 50 ns; -- 275 ns

enter <= '1';
wait for 5 ns;
enter <= '0';
wait for 5 ns;

wait for 40 ns;

numero_operador <= '1';

wait for 50 ns;

enter <= '1';
wait for 5 ns;
enter <= '0';
wait for 5 ns;

wait for 90 ns;



reset <= '1';

wait for 50 ns;

reset <= '0';

wait for 50 ns; -- 575 ns

end process;

end Test;


