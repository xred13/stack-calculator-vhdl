	library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity StackCalculator is
	port(enter, numero_operador, delete, swap, clear, reset, clock : in std_logic;
		  operator_in : in std_logic_vector(1 downto 0);
		  xIn : in std_logic_Vector(7 downto 0);
		  readAdress : in std_logic_vector(3 downto 0);
		  readData : out std_logic_vector(7 downto 0);
		  display_operador, sinal_display : out std_logic_vector(6 downto 0));
end StackCalculator;

architecture Structural of StackCalculator is
	
	signal s_operator : std_logic_vector(1 downto 0);
	signal s_action : std_logic_vector(2 downto 0);
	signal s_operador_out : std_logic_vector(1 downto 0);
	signal s_xOut : std_logic_vector(7 downto 0);
	signal s_action2 : std_logic_vector(2 downto 0);
	signal k_enter, k_delete, k_swap, k_clear : std_logic;
	
	
begin
	
maquina_estados : entity work.SeqDetFSM(MealyArch)
			port map(clock => clock,
						reset => reset,
						enter => k_enter,
						numero_operador => numero_operador,
						operador_in => s_operator,
						xIn => xIn,
						action => s_action,
						operador_out => s_operador_out,
						xOut => s_xOut);
						
operator : entity work.Operator(Behavioral)
			port map(dataIn => operator_in,
						dataOut => s_operator);
						

action : entity work.action(Behavioral)
			port map(clock => clock,
						action_in => s_action,
						delete => k_delete,
						swap => k_swap,
						clear => k_clear,
						action_out => s_action2);
						
ram : entity work.RAM2_8(Behavioral)
			port map(clock => clock,
						action => s_action2,
						writeData => s_xOut,
						readAdress => readAdress,
						readData => readData,
						operador => s_operador_out,
						op_display => sinal_display);

deb0 : entity work.Debouncer(Behavioral)
			generic map ( clkfreq     => 1000,
							  mSecMinInWidth => 100,
							  inPolarity     => '0',
							  outPolarity    => '1' )
			port map ( refClk    =>  clock,
						  dirtyIn   =>  enter,
				        pulsedOut =>   k_enter);
						  
deb1 : entity work.Debouncer(Behavioral)
			generic map ( clkfreq     => 1000,
							  mSecMinInWidth => 100,
							  inPolarity     => '0',
							  outPolarity    => '1' )
			port map ( refClk    =>  clock,
						  dirtyIn   =>  swap,
				        pulsedOut =>   k_swap);
						  
deb2 : entity work.Debouncer(Behavioral)
			generic map ( clkfreq     => 1000,
							  mSecMinInWidth => 100,
							  inPolarity     => '0',
							  outPolarity    => '1' )
			port map ( refClk    =>  clock,
						  dirtyIn   =>  clear,
				        pulsedOut =>  k_clear );
						  
deb3 : entity work.Debouncer(Behavioral)
			generic map ( clkfreq     => 1000,
							  mSecMinInWidth => 100,
							  inPolarity     => '0',
							  outPolarity    => '1' )
			port map ( refClk    =>  clock,
						  dirtyIn   =>  delete,
				        pulsedOut =>   k_delete);
						  
display_operator : entity work.Display_7seg_operator(Behavioral)
			port map(dataIn => s_operador_out,
						display1 => display_operador);


						  

						
end Structural;
						

			
			

			
			
			
			
			
			