library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_IF_ID is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_IF_ID;

architecture behavior of tb_reg_IF_ID is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component reg_IF_ID
     port(i_CLK        : in std_logic;  
        i_RST        : in std_logic;
        i_WE         : in std_logic;    
        i_PC	     : in std_logic_vector(31 downto 0);
	    i_Inst	     : in std_logic_vector(31 downto 0);   
        o_PC         : out std_logic_vector(31 downto 0);
	    o_Inst	     : out std_logic_vector(31 downto 0)); 
  end component;

  -- Temporary signals
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_PC, s_OPC, s_Inst, s_OInst : std_logic_vector(31 downto 0);

begin

  DUT: reg_IF_ID 
  port map(i_CLK     => s_CLK, 
           i_RST      => s_RST,
           i_WE     => s_WE,
           i_PC     => s_PC,
	   i_Inst      => s_Inst,

	   o_PC     => s_OPC,
	   o_Inst      => s_OInst);

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

    --First Case, Reset, all outputs should be 0
    s_RST           <= '1';
    s_WE            <= '1';
    s_PC	    <= X"FFF00000";
    s_Inst          <= X"00000000";
    wait for cCLK_PER;

    --Second Case, Set all 1's
    s_RST           <= '0';
    s_WE            <= '1';
    s_PC	    <= X"FFFFFFFF";
    s_Inst          <= X"FFFFFFFF";
    wait for cCLK_PER;

    --Third Case, Test WE
    s_RST           <= '0';
    s_WE            <= '0';
    s_PC	    <= X"0000FFFF";
    s_Inst          <= X"0000FFFF";
    wait for cCLK_PER;



    wait;
  end process;
  
end behavior;