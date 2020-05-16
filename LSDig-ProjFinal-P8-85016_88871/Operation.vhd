library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Operation is
	port(action : in std_logic_vector(2 downto 0);
		  clock : in std_logic;
		  number1 : in std_logic_vector(7 downto 0);
		  number2 : in std_logic_vector(7 downto 0);
		  operador : in std_logic_vector(1 downto 0);
		  result : out std_logic_vector(7 downto 0));
end Operation;

architecture Behavioral of Operation is
	
	signal s_number1 : integer;
	signal s_number2 : integer;
	signal s_result : integer;

begin

	process(clock)
	begin
		if(rising_edge(clock)) then
			if(action = "100") then
				s_number1 <= to_integer(signed(number1));
				s_number2 <= to_integer(signed(number2));
				
				case operador is
				when "00" =>
					s_result <= s_number1 + s_number2;
				when "01" =>
					s_result <= s_number1 - s_number2;
				when "10" =>
					s_result <= s_number1 * s_number2;
				when "11" =>
					if(s_number2 /= 0) then
						s_result <= s_number1 / s_number2;
						end if;
				when others =>
					s_result <= 0;
				end case;
			else
				null;
			end if;
		end if;	
	end process;
	
	result <= std_logic_vector(to_signed(s_result, 8));

end Behavioral;
		