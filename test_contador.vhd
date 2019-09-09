LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_contador IS
END test_contador;
 
ARCHITECTURE behavior OF test_contador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         up : IN  std_logic;
         en : IN  std_logic;
         seg1 : OUT  std_logic_vector(3 downto 0);
         seg2 : OUT  std_logic_vector(3 downto 0);
         seg3 : OUT  std_logic_vector(3 downto 0);
         seg4 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal up : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal seg1 : std_logic_vector(3 downto 0);
   signal seg2 : std_logic_vector(3 downto 0);
   signal seg3 : std_logic_vector(3 downto 0);
   signal seg4 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador PORT MAP (
          clk => clk,
          reset => reset,
          up => up,
          en => en,
          seg1 => seg1,
          seg2 => seg2,
          seg3 => seg3,
          seg4 => seg4
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
      wait for 15 ns;
		
		wait until falling_edge(clk);
		-- saco el reset
		reset <= '0';
		
		en <= '1';
		up <= '1';
		wait for clk_period*10;
		
		en <= '0';
		up <= '1';
		wait for clk_period*10;
		
		en <= '1';
		up <= '0';
		wait for clk_period*10;
		
		assert false report "termine" severity failure;
		
      wait;
   end process;

END;
