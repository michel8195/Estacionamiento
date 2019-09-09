LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_cont_M IS
END test_cont_M;
 
ARCHITECTURE behavior OF test_cont_M IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador_M
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         en : IN  std_logic;
         M : IN  integer;
         max_tick : OUT  std_logic;
         q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal en : std_logic := '0';
   signal M : integer := 400000;

 	--Outputs
   signal max_tick : std_logic;
   signal q : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador_M PORT MAP (
          clk => clk,
          reset => reset,
          en => en,
          M => M,
          max_tick => max_tick,
          q => q
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
      wait for 15 ns;
		
		wait until falling_edge(clk);
		
		reset <= '0';

      wait for clk_period*2;
		
		en <= '1';
		
		wait for clk_period*400000;
		assert max_tick ='1' report "fallo tick" severity failure;
		 
		wait for clk_period*10000;
		
		assert false report "termine" severity failure;
      -- insert stimulus here 

      wait;
   end process;

END;
