library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_EX_MEM is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_EX_MEM;

architecture behavior of tb_reg_EX_MEM is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component reg_EX_MEM
    port(i_CLK       			                : in std_logic;  
         i_RST        			                : in std_logic;
         i_WE         			                : in std_logic;
	 i_jal, i_MemtoReg, i_RegWr, i_DMemWr, i_fetch, i_XOR           : in std_logic;
         i_nxtad                                        : in std_logic_vector(1 downto 0);    
         i_ALUout			                : in std_logic_vector(31 downto 0);
         i_WrAdd					: in std_logic_vector(4 downto 0);
	 i_Read2	     			        : in std_logic_vector(31 downto 0);
         i_JumpAdd, i_BranchAdd	     			: in std_logic_vector(31 downto 0);
	 i_PC, i_JrAdd 	                                : in std_logic_vector(31 downto 0);
	 o_jal, o_MemtoReg, o_RegWr, o_DMemWr, o_fetch, o_XOR           : out std_logic; 
         o_nxtad                                	: out std_logic_vector(1 downto 0);
         o_ALUout        		                : out std_logic_vector(31 downto 0);
         o_WrAdd					: out std_logic_vector(4 downto 0);
	 o_Read2	     			        : out std_logic_vector(31 downto 0);
	 o_JumpAdd, o_BranchAdd	     			: out std_logic_vector(31 downto 0);
	 o_PC, o_JrAdd 	                                : out std_logic_vector(31 downto 0)); 
  end component;

  -- Temporary signals
  signal s_CLK, s_RST, s_WE, s_jal, s_MemtoReg, s_RegWr, s_DMemWr, s_ODMemWr, s_Ojal, s_OMemtoReg, s_ORegWr, s_fetch, s_Ofetch, s_XOR, s_OXOR  : std_logic;
  signal s_nxtad, s_Onxtad : std_logic_vector(1 downto 0);
  signal s_WrAdd, s_OWrAdd : std_logic_vector(4 downto 0);
  signal s_ALUout, s_OALUout, s_Read2, s_ORead2, s_JumpAdd, s_OJumpAdd, s_BranchAdd, s_OBranchAdd, s_PC, s_OPC, s_JrAdd, s_OJrAdd : std_logic_vector(31 downto 0);

begin

  DUT: reg_EX_MEM 
  port map(i_CLK     => s_CLK, 
           i_RST      => s_RST,
           i_WE     => s_WE,
           i_jal     => s_jal,
	   i_MemtoReg      => s_MemtoReg,
	   i_RegWr   => s_RegWr,
	   i_DMemWr     => s_DMemWr,
	   i_fetch  => s_fetch,
           i_XOR       => s_XOR,
	   i_nxtad  => s_nxtad,
	   i_ALUout => s_ALUout,
	   i_WrAdd     => s_WrAdd,
	   i_JumpAdd  => s_JumpAdd,
	   i_BranchAdd => s_BranchAdd,
	   i_PC     => s_PC,
	   i_JrAdd  => s_JrAdd,
	   i_Read2  => s_Read2,

	   o_jal     => s_Ojal,
	   o_MemtoReg      => s_OMemtoReg,
	   o_RegWr   => s_ORegWr,
	   o_DMemWr     => s_ODMemWr,
	   o_fetch  => s_Ofetch,
           o_XOR       => s_OXOR,
	   o_nxtad  => s_Onxtad,
	   o_ALUout => s_OALUout,
	   o_WrAdd     => s_OWrAdd,
	   o_JumpAdd  => s_OJumpAdd,
	   o_BranchAdd => s_OBranchAdd,
	   o_PC     => s_OPC,
	   o_JrAdd  => s_OJrAdd,
	   o_Read2  => s_ORead2);

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

    s_jal           <= '0';
    s_MemtoReg      <= '0';
    s_RegWr	    <= '0';
    s_DMemWr	    <= '0';
    s_fetch	    <= '0';
    s_XOR	    <= '0';

    s_nxtad	    <= "00";

    s_WrAdd	    <= "00000";

    s_ALUout	    <= X"00000000";
    s_Read2	    <= X"00000000";
    s_JumpAdd 	    <= X"00000000";
    s_BranchAdd     <= X"00000000";
    s_PC	    <= X"00000000";
    s_JrAdd         <= X"00000000";
    wait for cCLK_PER;

    --Case 2, all outputs should be 1
    s_RST           <= '0';
    s_WE            <= '1';

    s_jal           <= '1';
    s_MemtoReg      <= '1';
    s_RegWr	    <= '1';
    s_DMemWr	    <= '1';
    s_fetch	    <= '1';
    s_XOR	    <= '1';

    s_nxtad	    <= "11";

    s_WrAdd	    <= "11111";

    s_ALUout	    <= X"FFFFFFFF";
    s_Read2	    <= X"FFFFFFFF";
    s_JumpAdd 	    <= X"FFFFFFFF";
    s_BranchAdd     <= X"FFFFFFFF";
    s_PC	    <= X"FFFFFFFF";
    s_JrAdd         <= X"FFFFFFFF";
    wait for cCLK_PER;

    --Case 3, test WE, all outputs should stay 1
    s_RST           <= '0';
    s_WE            <= '0';

    s_jal           <= '0';
    s_MemtoReg      <= '0';
    s_RegWr	    <= '0';
    s_DMemWr	    <= '0';
    s_fetch	    <= '0';
    s_XOR	    <= '0';

    s_nxtad	    <= "00";

    s_WrAdd	    <= "00000";

    s_ALUout	    <= X"00000000";
    s_Read2	    <= X"00000000";
    s_JumpAdd 	    <= X"00000000";
    s_BranchAdd     <= X"00000000";
    s_PC	    <= X"00000000";
    s_JrAdd         <= X"00000000";
    wait for cCLK_PER;

    --Case 4, test RST, all outputs should get set to 0
    s_RST           <= '1';
    s_WE            <= '0';

    s_jal           <= '1';
    s_MemtoReg      <= '0';
    s_RegWr	    <= '1';
    s_DMemWr	    <= '0';
    s_fetch	    <= '1';
    s_XOR	    <= '0';

    s_nxtad	    <= "00";

    s_WrAdd	    <= "01100";

    s_ALUout	    <= X"FF000000";
    s_Read2	    <= X"00000000";
    s_JumpAdd 	    <= X"FF000000";
    s_BranchAdd     <= X"F0000000";
    s_PC	    <= X"00000000";
    s_JrAdd         <= X"F0000000";
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;