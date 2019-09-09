library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parking is
	port(
		clk, reset : in std_logic;
		a, b : in std_logic;
		en, up : out std_logic
	);
end parking;

architecture moore of parking is
	type state_type is (s0, e1, e2, e3, s1, s2, s3, plus, minus);
	signal state_req, state_next : state_type;
begin

-- Registo de estado
	process(clk, reset)
	begin
		if ( reset = '1') then
			state_req <= s0;
		elsif (clk'event and clk='1') then
			state_req <= state_next;
		end if;
	end process;

-- Next state logic

	process(state_req, a, b)
	begin
		state_next <= state_req; -- default
		case state_req is
			when s0 =>
				if (a = '1' and b = '0') then
				state_next <= e1;
				elsif (a = '0' and b = '1') then
				state_next <= s1;
				else
					state_next <= s0;
				end if;
					
			when e1 =>
				if (a = '1' and b = '0') then
				state_next <= e1;
				elsif (a = '1' and b = '1') then
				state_next <= e2;
				else
					state_next <= s0;
				end if;
			
			when e2 =>
				if (a = '1' and b = '1') then
				state_next <= e2;
				elsif (a = '0' and b = '1') then
				state_next <= e3;
				else
					state_next <= s0;
				end if;
				
			 when e3 =>
				if (a = '0' and b = '1') then
				state_next <= e3;
				elsif (a = '0' and b = '0') then
				state_next <= plus;
				else
					state_next <= s0;
			 end if;
			 
			 when plus =>
				state_next <= s0;
			
			 when s1 =>
				if (a = '0' and b = '1') then
				state_next <= s1;
				elsif (a = '1' and b = '1') then
				state_next <= s2;
				else
					state_next <= s0;
				end if;
				
			 when s2 =>
				if (a = '1' and b = '1') then
				state_next <= s2;
				elsif (a = '1' and b = '0') then
				state_next <= s3;
				else
					state_next <= s0;
				end if;
				
			 when s3 =>
				if (a = '1' and b = '0') then
				state_next <= s3;
				elsif (a = '0' and b = '0') then
				state_next <= minus;
				else
					state_next <= s0;
				end if;
				
			 when minus =>
				state_next <= s0;	 
		end case;	
	end process;

	-- logica de salida
	
	process(state_req)
	begin
		case state_req is
			when plus =>
				en <= '1';
				up <= '1';
			when minus =>
				en <= '1';
				up <= '0';
			when others =>
				en <= '0';
				up <= '0';
		end case;
	end process;
				
end moore;

