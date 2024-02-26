library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_MEM_WB is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_MEM_WB;

architecture behavior of tb_reg_MEM_WB is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component reg_MEM_WB
      port(i_CLK       			                : in std_logic;  
        i_RST        			                : in std_logic;
        i_WE         			                : in std_logic;
	    i_jal, i_MemtoReg, i_RegWrite	        : in std_logic;
	    i_DMEMout, i_ALUout, i_PC			    : in std_logic_vector(31 downto 0);
	    i_WrAdd						            : in std_logic_vector(4 downto 0);
	    o_jal, o_MemtoReg, o_RegWrite	        : out std_logic;
	    o_DMEMout, o_ALUout, o_PC			    : out std_logic_vector(31 downto 0);
	    o_WrAdd						            : out std_logic_vector(4 downto 0));
  end component;

  -- Temporary signals
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_jal, s_Ojal, s_MemtoReg, s_OMemtoReg, s_RegWrite, s_ORegWrite : std_logic;
  signal s_WrAdd, s_OWrAdd : std_logic_vector(4 downto 0);
  signal s_PC, s_OPC, s_DMEMout, s_ODMEMout, s_ALUOut, s_OALUout : std_logic_vector(31 downto 0);

begin

  DUT: reg_MEM_WB 
  port map(i_CLK     => s_CLK, 
           i_RST      => s_RST,
           i_WE     => s_WE,
           i_jal     => s_jal,
	   i_MemtoReg      => s_MemtoReg,
	   i_RegWrite      => s_RegWrite,
	   i_DMEMout      => s_DMEMout,
	   i_ALUout      => s_ALUout,
	   i_PC      => s_PC,
	   i_WrAdd      => s_WrAdd,
	   
	   o_jal       => s_Ojal,
	   o_MemtoReg      => s_OMemtoReg,
	   o_RegWrite      => s_ORegWrite,
	   o_DMEMout      => s_ODMEMout,
	   o_ALUout      => s_OALUout,
	   o_PC      => s_OPC,
	   o_WrAdd      => s_OWrAdd);

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

    s_jal           <= '1';
    s_MemtoReg      <= '1';
    s_RegWrite      <= '1';
    s_DMEMout       <= X"FFFFFFFF";
    s_ALUout        <= X"FFFFFFFF";
    s_PC            <= X"FFFFFFFF";
    s_WrAdd         <= "11111";
    wait for cCLK_PER;

    --Second Case, Write, all outputs should be 1
    s_RST           <= '0';
    s_WE            <= '1';

    s_jal           <= '1';
    s_MemtoReg      <= '1';
    s_RegWrite      <= '1';
    s_DMEMout       <= X"FFFFFFFF";
    s_ALUout        <= X"FFFFFFFF";
    s_PC            <= X"FFFFFFFF";
    s_WrAdd         <= "11111";
    wait for cCLK_PER;

    --Third Case, Test Write Enable, all outputs should stay 1
    s_RST           <= '0';
    s_WE            <= '0';

    s_jal           <= '0';
    s_MemtoReg      <= '1';
    s_RegWrite      <= '0';
    s_DMEMout       <= X"0000FFFF";
    s_ALUout        <= X"0000FFFF";
    s_PC            <= X"0000FFFF";
    s_WrAdd         <= "00001";
    wait for cCLK_PER;

  

    wait;
  end process;
  
end behavior;