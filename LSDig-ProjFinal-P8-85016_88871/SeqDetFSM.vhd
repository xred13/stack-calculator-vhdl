library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetFSM is
	port(clock, reset : in std_logic;
		  enter : in std_logic;
		  numero_operador : in std_logic; -- numero ou operador
		  operador_in : in std_logic_vector(1 downto 0);
		  xIn : in std_logic_vector(7 downto 0);
		  action : out std_logic_vector(2 downto 0);
		  operador_out : out std_logic_vector(1 downto 0);
		  xOut : out std_logic_vector(7 downto 0));
end SeqDetFSM;

architecture MealyArch of SeqDetFSM is
	
	type state is (A, B, C);
	signal PS, NS: state := C;


begin
	process(clock)
	begin
		if(rising_edge(clock)) then
			if (reset = '1') then
				PS <= C;
			else
				PS <= NS;
			end if;
		end if;
	end process;


	
	comb_proc : process(PS, enter)
	begin
		
		case PS is
		when A => 

			action <= "000";
			NS <= C;

		when B =>

			action <= "100";
			NS <= C;

		when C =>
			action <= "111";
			
			if(enter = '1') then
				if(numero_operador = '0') then
					NS <= A;
				else
					NS <= B;
				end if;
			end if;
			
			
		when others =>
			action <= "000";

		end case;
		
	end process;
	
	operador_out <= operador_in;
	xOut <= xIn;
	
end MealyArch;
		
				