library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_std.all;

entity Contador_num_op is
	port(up, down, numero_operador : in std_logic;
		  ram_out : out std_logic_vector(3 downto 0);
		  rom_out : out std_logic_vector(2 downto 0));
end Contador_num_op;

architecture Behavioral of Contador_num_op is

	signal ram : integer := 0; -- 0 to 15
	signal rom : integer := 0; -- 0 to 6
	
begin

process(up, down)
begin

	if(numero_operador = '0') then
		if(up = '1') then
			if(ram = 15) then
				ram <= 0;
			else
				ram <= ram +1;
			end if;
		elsif(down = '1') then
			if(ram = 0) then
				ram <= 15;
			else
				ram <= ram-1;
			end if;
		else
			null;
		end if;
	else
		if(up = '1') then
			if(rom = 6) then
				rom <= 0;
			else
				rom <= rom +1;
			end if;
		elsif(down = '1') then
			if(rom = 0) then
				rom <= 6;
			else
				rom <= rom -1;
			end if;
		else
			null;
		end if;
	end if;
end process;

ram_out <= std_logic_vector(to_unsigned(ram, 4));
rom_out <= std_logic_vector(to_unsigned(rom, 3));
end Behavioral;