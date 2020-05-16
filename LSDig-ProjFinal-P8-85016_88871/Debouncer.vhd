-- Código de um Debouncer, fornecido no Elearning 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Debouncer is

	generic ( clkfreq        : positive := 50000;
				 mSecMinInWidth : positive := 50;
				 inPolarity     : std_logic := '0';
				 outPolarity    : std_logic := '1' );
				 
	port ( refClk    : in std_logic;
			 dirtyIn   : in std_logic;
			 pulsedOut : out std_logic );
			 
end Debouncer;


architecture Behavioral of Debouncer is


	constant Min_In_With_Cycles : positive := mSecMinInWidth * Clkfreq; 
	subtype TCounter is natural range 0 to Min_In_With_Cycles;
	
	
	signal s_debCnt : TCounter := 0;
	signal s_dirtyIn, s_prevIn, s_pulsedOut : std_logic;
	
	
begin

	in_sync_proc : process(refClk)
	
	begin
		
		if ( rising_edge(refClk) ) then
			
			if ( inPolarity = '1' ) then
			
				s_dirtyIn <= dirtyIn;
			else
			
				s_dirtyIn <= not dirtyIn;
			end if;
			
			s_prevIn <= s_dirtyIn;
		end if;
		
	end process;
	
	
	count_proc : process(refClk)
	
	begin
	
		if ( rising_edge(refClk) ) then
		
			if ( (s_dirtyIn = '0') or (s_debCnt > Min_In_With_Cycles) ) then
			
				s_debCnt      <= 0;
				s_pulsedOut   <= '0';
				
			elsif (s_dirtyIn = '1') then
				
				if ( s_prevIn = '0' ) then
				
					s_debCnt <= Min_In_With_Cycles;
					s_pulsedOut   <= '0';
				else
				
					if ( s_debCnt >= 1 ) then
					
						s_debCnt <= s_debCnt -1;
					end if;
					
					if ( s_debCnt = 1 ) then
					
						s_pulsedOut <= '1';
					else
					
						s_pulsedOut <= '0';
					end if;
					
				end if;
				
			end if;
		
		end if;
		
	end process;
	
	
	pulsedOut <= s_pulsedOut when (outPolarity = '1') else not s_pulsedOut;
	
end Behavioral;				