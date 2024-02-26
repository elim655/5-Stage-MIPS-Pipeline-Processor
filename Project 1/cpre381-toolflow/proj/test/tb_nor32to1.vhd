library IEEE;
use IEEE.std_logic_1164.all;

entity tb_nor32to1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_nor32to1;

architecture behavior of tb_nor32to1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component nor32to1
    port(i_A       : in std_logic_vector(31 downto 0);
	 o_F	    : out std_logic);
  end component;

  -- Create signals for all of the inputs and outputs of the file that you are testing
  -- := '0' or := (others => '0') just make all the signals start at an initial value of zero
  signal s_CLK  : std_logic := '0';

  -- Temporary signals to connect to the dff component.
  signal s_A : std_logic_vector(31 downto 0);
  signal s_F : std_logic;

begin

  DUT: nor32to1 
  port map(i_A  => s_A, 
	   o_F  => s_F);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin

    -- Case 1
    s_A <= X"FFFFFFFF";
    wait for cCLK_PER;

    -- Case 2
    s_A <= X"00000001";
    wait for cCLK_PER;

    -- Case 3
    s_A <= X"ABDC0000";
    wait for cCLK_PER;

    -- Case 1
    s_A <= X"00000000";
    wait for cCLK_PER;




    wait;
  end process;
  
end behavior;