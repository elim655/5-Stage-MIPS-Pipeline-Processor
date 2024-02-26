library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrelshifter is
  generic(gCLK_HPER   : time := 50 ns);
end tb_barrelshifter;

architecture behavior of tb_barrelshifter is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component barrelshifter
    port(i_DATA : in std_logic_vector(31 downto 0);
	 i_shamt : in std_logic_vector(4 downto 0);
	 i_DIR : in std_logic; -- 0: right 1: left
	 i_MODE : in std_logic; -- 0: logical 1: arithmetic 
	 o_F : out std_logic_vector(31 downto 0));
  end component;

  -- Create signals for all of the inputs and outputs of the file that you are testing
  -- := '0' or := (others => '0') just make all the signals start at an initial value of zero
  signal s_CLK  : std_logic := '0';

  -- Temporary signals to connect to the dff component.
  signal s_DATA  : std_logic_vector(31 downto 0);
  signal s_shamt : std_logic_vector(4 downto 0);
  signal s_DIR   : std_logic;
  signal s_MODE  : std_logic;
  signal s_F     : std_logic_vector(31 downto 0);

begin

  DUT: barrelshifter 
  port map(i_DATA   => s_DATA, 
	   i_shamt  => s_shamt,
           i_DIR    => s_DIR,
	   i_MODE   => s_MODE,
	   o_F	    => s_F);

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

    -- Case 1, sll 1. Ouput 18
    s_DATA  <= X"00000009";
    s_shamt <= "00001";
    s_DIR   <= '1';
    s_MODE  <= '0';
    wait for cCLK_PER;

    -- Case 2, sll 2. Output 36
    s_DATA  <= X"00000009";
    s_shamt <= "00010";
    s_DIR   <= '1';
    s_MODE  <= '0';
    wait for cCLK_PER;

    -- Case 3, sla 3. Output -24
    s_DATA  <= X"FFFFFFFD";
    s_shamt <= "00011";
    s_DIR   <= '1';
    s_MODE  <= '1';
    wait for cCLK_PER;

    -- Case 4, srl 2. Output 4
    s_DATA  <= X"00000010";
    s_shamt <= "00010";
    s_DIR   <= '0';
    s_MODE  <= '0';
    wait for cCLK_PER;

    -- Case 5, srl 4. Output 1
    s_DATA  <= X"00000011";
    s_shamt <= "00100";
    s_DIR   <= '0';
    s_MODE  <= '0';
    wait for cCLK_PER;

     -- Case 6, sra 2. Output -4
    s_DATA  <= X"FFFFFFF0";
    s_shamt <= "00010";
    s_DIR   <= '0';
    s_MODE  <= '1';
    wait for cCLK_PER;


    wait;
  end process;
  
end behavior;