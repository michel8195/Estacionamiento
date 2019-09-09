library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top is
	port(
		clk, reset : in std_logic;
		sw0, sw1 : in std_logic;
		sseg : out std_logic_vector(7 downto 0);
		an : out std_logic_vector(3 downto 0)
	);
end top;

architecture Behavioral of top is
	signal a, b, en, up : std_logic;
	signal seg1, seg2, seg3, seg4 : std_logic_vector(3 downto 0);
begin
	-- Instanciamos los debouncing
	
	debounce_a: entity work.db_fsm(arch)
		port map(
			clk => clk,
			reset => reset,
			sw => sw0,
			db => a		
		);
		
	debounce_b: entity work.db_fsm(arch)
		port map(
			clk => clk,
			reset => reset,
			sw => sw1,
			db => b	
		);
	-- Instanciamos el parking
	
	parking: entity work.parking(moore)
		port map(
			clk  => clk,
			reset => reset,
			a => a,
			b => b,
			en => en,
			up => up
		);
		
	-- Instnciamos el contador
	contador: entity work.contador(Behavioral)
		port map(
			clk => clk,
			reset => reset,
			en => en,
			up => up,
			seg1 => seg1,
			seg2 => seg2,
			seg3 => seg3,
			seg4 => seg4
		);
	
	-- Instanciamos el display
	
	display: entity work.disp_mux(Behavioral)
		port map(
			clk => clk,
			reset => reset,
			in_0 => seg1,
			in_1 => seg2,
			in_2 => seg3,
			in_3 => seg4,
			sseg => sseg,
			an => an
		);
	
	

end Behavioral;

