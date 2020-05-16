library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Operator is
	port(dataIn : in std_logic_vector(1 downto 0);
		  dataOut : out std_logic_vector(1 downto 0));
end Operator;

architecture Behavioral of Operator is

	signal operador : integer range 0 to 3 := 0;


begin

operador <= to_integer(unsigned(dataIn));

dataOut <= "00" when operador = 0 else -- +
			  "01" when operador = 1 else -- -
			  "10" when operador = 2 else -- *
			  "11";                       -- /
			  
			  
end Behavioral;



		
			
		 