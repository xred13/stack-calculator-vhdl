library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Display_7seg_operator is
	port(dataIn : in std_logic_Vector(1 downto 0);
		  display1 : out std_logic_vector(6 downto 0));
end Display_7seg_operator;

architecture Behavioral of Display_7seg_operator is

signal s_display1 : std_logic_vector(3 downto 0) := "1111";

begin

process(dataIn)
begin

	-- 9 + 10 -
	-- 11 * 12 /
if(dataIN = "00") then
	s_display1 <= "1001";

elsif(dataIn = "01") then
	s_display1 <= "1010";

elsif(dataIn = "10") then
	s_display1 <= "1011";

elsif(dataIn = "11") then
	s_display1 <= "1100";

else
	s_display1 <= "1111";
end if;
end process;

seg7bin1 : entity work.Bin7SegDecoder_operator(Behavioral)
			port map(binInput => s_display1,
				decOut_n => display1);

end Behavioral;