library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM2_8 is
	port(operador : in std_logic_vector(1 downto 0);
		  clock : in std_logic;
		  action : in std_logic_vector(2 downto 0); -- 000 push ; 001 delete ; 010 swap ; 011 clear ; 100 result ; 111 hold
		  writeData : in std_logic_vector(7 downto 0);
		  readAdress : in std_logic_vector(3 downto 0);
		  readData : out std_logic_vector(7 downto 0);
		  op_display : out std_logic_vector(6 downto 0));
end RAM2_8;

architecture Behavioral of RAM2_8 is
	constant NUM_WORDS : integer := 16;
	subtype TDataWord is std_logic_vector(7 downto 0);
	type TMemory is array (0 to NUM_WORDS-1) of TDataWord;
	signal s_memory : TMemory;
	
	subtype natural_number is natural range 0 to 16;
	signal s_pointer : natural_number := 0;
	signal s_temporary : std_logic_vector(7 downto 0);
	
	signal s_number1, s_number2 : integer;
	
	signal number_logic : std_logic_vector(7 downto 0);
	signal number_int : signed(7 downto 0);

	
begin
		
	
	process(clock)
	begin
		if(rising_edge(clock)) then
			
			if(s_pointer > 1) then
				s_number1 <= to_integer(signed(s_memory(s_pointer-1)));
				s_number2 <= to_integer(signed(s_memory(s_pointer-2)));
			end if;
			case action is
			when "000" => -- push
	
				s_memory(s_pointer) <= writeData;
				s_pointer <= s_pointer +1;
	
				
			when "001" => -- delete
				if(s_pointer /= 0) then
					s_memory(s_pointer-1) <= "00000000";
					s_pointer <= s_pointer -1;
				end if;
			when "010" => -- swap
			
				s_memory(s_pointer-2) <= s_memory(s_pointer-1);
				s_memory(s_pointer-1) <= s_memory(s_pointer-2);
				
			when "011" => -- clear
				s_pointer <= 0;
				s_memory <= (others => "00000000");
			when "100" => -- result
				
				case operador is
				when "00" =>
					s_memory(s_pointer-2) <= std_logic_vector(to_signed(s_number1 + s_number2, 8));
				when "01" =>
					s_memory(s_pointer-2) <= std_logic_vector(to_signed(s_number1 - s_number2, 8));
				when "10" =>
					s_memory(s_pointer-2) <= std_logic_vector(to_signed(s_number1 * s_number2, 8));
				when "11" =>
					if(s_number2 /= 0) then
						s_memory(s_pointer-2) <= std_logic_vector(to_signed(s_number1 / s_number2, 8));
						end if;
				when others =>
					s_memory(s_pointer-2) <= "00000000";
				end case;
				
				s_pointer <= s_pointer-1;
				
			when "111" => --hold
				
				null;
				
			when others =>
				s_pointer <= s_pointer;
			end case;
		end if;
	end process;
	
	readData <= 
		s_memory(to_integer(unsigned(readAdress))) when number_int >= 0 else
		std_logic_Vector(to_signed(to_integer(signed(s_memory(to_integer(unsigned(readAdress))))-128), 8));
	
	
	number_logic <= s_memory(to_integer(unsigned(readAdress)));
	number_int <= signed(number_logic);
	
	
	op_display <= 
		"0111111" when number_int < 0 else
		"1111111";
end Behavioral;
		  