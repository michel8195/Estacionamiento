library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
	port(
		clk, reset : in std_logic;
		up, en  : in std_logic;
		seg1, seg2, seg3, seg4 : out std_logic_vector(3 downto 0)
	);
end contador;

architecture Behavioral of contador is
	signal r_reg, r_next : unsigned(15 downto 0);
begin

 -- registro
	process(clk, reset)
	begin
		if (reset='1') then
			r_reg <= (others=>'0');			
		elsif (clk'event and clk='1') then
			r_reg <= r_next;
		end if;
	end process;
	
-- logica de proximo estado

   r_next <= r_reg + 1 when en='1' and up='1' else
             r_reg - 1 when en='1' and up='0' else
             r_reg;
	

-- logica de salida
	
	seg1 <= std_logic_vector(r_reg(3 downto 0));
	seg2 <= std_logic_vector(r_reg(7 downto 4));
	seg3 <= std_logic_vector(r_reg(11 downto 8));
	seg4 <= std_logic_vector(r_reg(15 downto 12));
	
end Behavioral;

