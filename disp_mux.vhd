library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp_mux is
	generic(N : integer := 4);
	port(
		in_0 : in std_logic_vector(N-1 downto 0);
		in_1 : in std_logic_vector(N-1 downto 0);
		in_2 : in std_logic_vector(N-1 downto 0);
		in_3 : in std_logic_vector(N-1 downto 0);
		sseg : out std_logic_vector(7 downto 0);
		clk, reset : in std_logic;
		an : out std_logic_vector(3 downto 0)
		
		);
end disp_mux;

architecture Behavioral of disp_mux is
		signal r_tick : std_logic;
		signal cont_2 : std_logic_vector(1 downto 0);
		signal r_in : std_logic_vector(N-1 downto 0);
		signal r_reg : std_logic_vector(N-1 downto 0);
		signal r_next : std_logic_vector(N-1 downto 0);
begin


-- Instanciamos dos conversores de signo y magnitud a complemento a 2
-- Contador hasta numero M
	cont_M: entity work.contador_M(Behavioral)
	   generic map(N=>19)
		port map(M => 400000,
					clk => clk,
					reset => reset,
					max_tick => r_tick,
					en => '1',
					q =>  open   
		);
		
	cont_a2: entity work.contador_M(Behavioral)
		generic map(N=>2)
		port map(M => 4,
					clk => clk,
					reset => reset,
					max_tick => open,
					en => r_tick,
					q => cont_2
		);
		

 -- registro
	process(clk, reset)
	begin
		if (reset='1') then
			r_reg <= (others=>'0');			
		elsif (clk'event and clk='1') then
			r_reg <= r_next;
		end if;
	end process;

 -- logica de prox estado 
 	with cont_2 select
      r_in     <= in_0 when "00",
                  in_1 when "01",
                  in_2 when "10",
					   in_3 when "11",
					 (others=>'0') when others;
		r_next <= r_in;
	
	

 -- logica de salida
 	with cont_2 select
      an     <= "1110" when "00",
                "1101" when "01",
                "1011" when "10",
					 "0111" when "11",
					 "0000" when others;
	
	with r_reg select
		sseg <= not "11111100" when "0000",
             not "01100000" when "0001" ,
				 not "11011010" when "0010" ,
             not "11110010" when "0011" ,
				 not "01100110" when "0100" ,
             not "10110110" when "0101" ,
				 not "10111110" when "0110" ,
             not "11100000" when "0111" ,
				 not "11111110" when "1000" ,
             not "11100110" when "1001" ,
				 not "11111010" when "1010" ,
             not "00111110" when "1011" ,
				 not "00011010" when "1100" ,
             not "01111010" when "1101" ,
				 not "11011110" when "1110" ,
             not "10001110" when "1111" ,
             not "00000000" when others;


end Behavioral;

