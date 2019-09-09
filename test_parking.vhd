LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_parking IS
END test_parking;
 
ARCHITECTURE behavior OF test_parking IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT parking
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  std_logic;
         b : IN  std_logic;
         en : OUT  std_logic;
         up : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal en : std_logic;
   signal up : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: parking PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          b => b,
          en => en,
          up => up
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin 
		reset <= '1';
      -- hold reset state for 100 ns.
      wait for clk_period*2;	
		
		reset <= '0' ;
		wait for clk_period*2;
		
		-- entra auto
		a <= '1';
		b <= '0';
		wait for clk_period*2;
		
		a <= '1';
		b <= '1';
		wait for clk_period*2;
		
		a <= '0';
		b <= '1';		
		wait for clk_period*2;
		
		a <= '0';
		b <= '0';
      wait for clk_period*10;
		
		-- sale auto
		a <= '0';
		b <= '1';
		wait for clk_period*2;
		
		a <= '1';
		b <= '1';
		wait for clk_period*2;
		
		a <= '1';
		b <= '0';		
		wait for clk_period*2;
		
		a <= '0';
		b <= '0';
      wait for clk_period*10;
		
		-- combinacion erronea 1
		a <= '1';
		b <= '1';
		wait for clk_period*2;
		
		-- entra auto despues de combinacion erronea 1

		a <= '1';
		b <= '0';
		wait for clk_period*2;
		
		a <= '1';
		b <= '1';
		wait for clk_period*2;
		
		a <= '0';
		b <= '1';		
		wait for clk_period*2;
		
		a <= '0';
		b <= '0';
		wait for clk_period*2;
		
		-- combinacion erronea 2
		
		a <= '1';
		b <= '0';		
		wait for clk_period*2;
		
		a <= '0';
		b <= '0';
      wait for clk_period*2;

		-- sale auto despues de combinacion erronea 2
		a <= '0';
		b <= '1';
		wait for clk_period*2;
		
		a <= '1';
		b <= '1';
		wait for clk_period*2;
		
		a <= '1';
		b <= '0';		
		wait for clk_period*2;
		
		a <= '0';
		b <= '0';
      wait for clk_period*10;		
		
		
		assert false;
      -- insert stimulus here 

      wait;
   end process;

END;
