library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder_operator is
	port(binInput	: in  std_logic_vector(3 downto 0);
		  decOut_n	: out std_logic_vector(6 downto 0));
end Bin7SegDecoder_operator;

architecture Behavioral of Bin7SegDecoder_operator is	
begin
	with binInput select
	
	-- 9 + 10 -
	-- 11 * 12 /
	
		decOut_n <= "0001111" when "1001", --+
						"0111111" when "1010", ---
						"0001001" when "1011", --*
						"0101101" when "1100", --/
						"1111111" when others;
end Behavioral;