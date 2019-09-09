LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_disp_mux IS
END test_disp_mux;
 
ARCHITECTURE behavior OF test_disp_mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT disp_mux
    PORT(
         in_0 : IN  std_logic_vector(3 downto 0);
         in_1 : IN  std_logic_vector(3 downto 0);
         in_2 : IN  std_logic_vector(3 downto 0);
         in_3 : IN  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_0 : std_logic_vector(3 downto 0) := (others => '0');
   signal in_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal in_2 : std_logic_vector(3 downto 0) := (others => '0');
   signal in_3 : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal sseg : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: disp_mux PORT MAP (
          in_0 => in_0,
          in_1 => in_1,
          in_2 => in_2,
          in_3 => in_3,
          sseg => sseg,
          clk => clk,
          reset => reset,
          an => an
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
		
		in_0 <= "0001";
		in_1 <= "0010";
		in_2 <= "0011";
		in_3 <= "0100";
		
      wait for clk_period*4000000;
	
      -- insert stimulus here 
		
		assert false report "termine" severity failure;
      wait;
   end process;

END;
