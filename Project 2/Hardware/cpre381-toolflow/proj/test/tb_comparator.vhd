library IEEE;
use IEEE.std_logic_1164.all;

entity tb_comparator is
  generic(gCLK_HPER   : time := 50 ns);
end tb_comparator;

architecture behavior of tb_comparator is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component comparator
    port(i_OpCode          : in std_logic_vector(5 downto 0);
         i_RS		   : in std_logic_vector(31 downto 0);
         i_RT		   : in std_logic_vector(31 downto 0);
         o_O               : out std_logic);
  end component;

  -- Create signals for all of the inputs and outputs of the file that you are testing
  -- := '0' or := (others => '0') just make all the signals start at an initial value of zero
  signal s_CLK  : std_logic := '0';

  -- Temporary signals to connect to the dff component.
  signal s_OpCode  : std_logic_vector(5 downto 0);
  signal s_RS : std_logic_vector(31 downto 0);
  signal s_RT : std_logic_vector(31 downto 0);
  signal s_O  : std_logic;


begin

  DUT: comparator 
  port map(i_OpCode => s_OpCode, 
	   i_RS => s_RS,
	   i_RT => s_RT,
           o_O => s_O);

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

    -- Case 1, beq = true
    s_OpCode <= "000100";
    s_RS <= X"12345678";
    s_RT <= X"12345678";
    wait for cCLK_PER;

     -- Case 1, beq = false
    s_OpCode <= "000100";
    s_RS <= X"28456385";
    s_RT <= X"97654321";
    wait for cCLK_PER;

    -- Case 1, bne = true
    s_OpCode <= "000101";
    s_RS <= X"28456385";
    s_RT <= X"97654321";
    wait for cCLK_PER;

    -- Case 1, bne = flase
    s_OpCode <= "000101";
    s_RS <= X"97654321";
    s_RT <= X"97654321";
    wait for cCLK_PER;
    

    wait;
  end process;
  
end behavior;