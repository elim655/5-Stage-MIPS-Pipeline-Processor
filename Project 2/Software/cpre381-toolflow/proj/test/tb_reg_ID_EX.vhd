library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_ID_EX is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_ID_EX;

architecture behavior of tb_reg_ID_EX is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component reg_ID_EX
    port(i_CLK       			                            : in std_logic;  
         i_RST        			                            : in std_logic;
         i_WE         			                            : in std_logic;
         i_ALUSrc, i_MemtoReg, i_DMemWr, i_RegWr, i_RegDst,
         i_branch, i_jal, i_Shf, i_fetch                              : in std_logic;
         i_nxtad                                             : in std_logic_vector(1 downto 0);
	 i_Alucon				                            : in std_logic_vector(3 downto 0); 
         i_WrAdd						                        : in std_logic_vector(4 downto 0);
         i_read1, i_read2			                        : in std_logic_vector(31 downto 0);
         i_signExt, i_PC, i_Inst			                    : in std_logic_vector(31 downto 0);
         o_ALUSrc, o_MemtoReg, o_DMemWr, o_RegWr, o_RegDst,
         o_branch, o_jal, o_Shf, o_fetch                              : out std_logic; 
         o_nxtad                                             : out std_logic_vector(1 downto 0);
         o_Alucon				                            : out std_logic_vector(3 downto 0); 
         o_WrAdd						                        : out std_logic_vector(4 downto 0);
         o_read1, o_read2			                        : out std_logic_vector(31 downto 0);
         o_signExt, o_PC, o_Inst			                    : out std_logic_vector(31 downto 0));
  end component;

  -- Temporary signals
  signal s_CLK, s_RST, s_WE, s_MemtoReg, s_RegWr, s_DMemWr, s_ALUSrc, s_OALUSrc, s_RegDst, s_branch, s_Obranch, s_jal, s_Ojal, s_Shf, s_OShf, s_ODMemWr, s_OMemtoReg, s_ORegWr, s_fetch, s_Ofetch  : std_logic;
  signal s_nxtad, s_Onxtad : std_logic_vector(1 downto 0);
  signal s_ALUCon, s_OALUCon : std_logic_vector(3 downto 0);
  signal s_WrAdd, s_OWrAdd : std_logic_vector(4 downto 0);
  signal s_Read2, s_ORead2, s_Read1, s_ORead1, s_signExt, s_OsignExt, s_Inst, s_OInst, s_PC, s_OPC : std_logic_vector(31 downto 0);

begin

  DUT: reg_ID_EX 
  port map(i_CLK     => s_CLK, 
           i_RST      => s_RST,
           i_WE     => s_WE,
	   i_ALUSrc => s_ALUSrc,
           i_jal     => s_jal,
	   i_MemtoReg      => s_MemtoReg,
	   i_branch	=> s_branch,
	   i_RegDst	=> s_RegDst,
	   i_RegWr   => s_RegWr,
	   i_DMemWr     => s_DMemWr,
	   i_fetch  => s_fetch,
	   i_Shf    => s_Shf,
	   i_nxtad  => s_nxtad,
	   i_ALUCon	=> s_ALUCon,
	   i_WrAdd     => s_WrAdd,
	   i_signExt	=> s_signExt,
	   i_PC     => s_PC,
	   i_Inst	=> s_Inst,
	   i_Read1	=> s_Read1,
	   i_Read2  => s_Read2,

	   o_jal     => s_Ojal,
	   o_MemtoReg      => s_OMemtoReg,
	   o_RegWr   => s_ORegWr,
	   o_DMemWr     => s_ODMemWr,
	   o_branch	=> s_Obranch,
	   o_Shf	=> s_OShf,
	   o_fetch  => s_Ofetch,
	   o_nxtad  => s_Onxtad,
	   o_ALUCon	=> s_OALUCon,
	   o_ALUSrc	=> s_OALUSrc,
	   o_WrAdd     => s_OWrAdd,
	   o_PC     => s_OPC,
	   o_signExt	=> s_OsignExt,
	   o_Inst	=> s_OInst,
	   o_Read1	=> s_ORead1,
	   o_Read2      => s_ORead2);

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

    s_ALUSrc	<= '0';
    s_MemtoReg  <= '0';
    s_DMemWr    <= '0';
    s_RegWr     <= '0';
    s_RegDst    <= '0';
    s_branch    <= '0';
    s_jal       <= '0';
    s_Shf	<= '0';
    s_fetch     <= '0';

    s_nxtad	<= "00";

    s_Alucon    <= "0000";

    s_WrAdd	<= "00000";

    s_read1	<= X"00000000";
    s_read2	<= X"00000000";
    s_signExt	<= X"00000000";
    s_PC	<= X"00000000";
    s_Inst	<= X"00000000";
    wait for cCLK_PER;

    --Second case, all 1's
    s_RST           <= '0';
    s_WE            <= '1';

    s_ALUSrc	<= '1';
    s_MemtoReg  <= '1';
    s_DMemWr    <= '1';
    s_RegWr     <= '1';
    s_RegDst    <= '1';
    s_branch    <= '1';
    s_jal       <= '1';
    s_Shf	<= '1';
    s_fetch     <= '1';

    s_nxtad	<= "11";

    s_Alucon    <= "1111";

    s_WrAdd	<= "11111";

    s_read1	<= X"11111111";
    s_read2	<= X"11111111";
    s_signExt	<= X"11111111";
    s_PC	<= X"11111111";
    s_Inst	<= X"11111111";
    wait for cCLK_PER;

    --Third case, test RST
    s_RST           <= '1';
    s_WE            <= '0';

    s_ALUSrc	<= '1';
    s_MemtoReg  <= '1';
    s_DMemWr    <= '1';
    s_RegWr     <= '1';
    s_RegDst    <= '1';
    s_branch    <= '1';
    s_jal       <= '1';
    s_Shf	<= '1';
    s_fetch     <= '1';

    s_nxtad	<= "11";

    s_Alucon    <= "1111";

    s_WrAdd	<= "11111";

    s_read1	<= X"11111111";
    s_read2	<= X"11111111";
    s_signExt	<= X"11111111";
    s_PC	<= X"11111111";
    s_Inst	<= X"11111111";
    wait for cCLK_PER;

    --Fourth case, test WE
    s_RST           <= '0';
    s_WE            <= '0';

    s_ALUSrc	<= '1';
    s_MemtoReg  <= '0';
    s_DMemWr    <= '1';
    s_RegWr     <= '0';
    s_RegDst    <= '1';
    s_branch    <= '0';
    s_jal       <= '1';
    s_Shf	<= '0';
    s_fetch     <= '1';

    s_nxtad	<= "00";

    s_Alucon    <= "1010";

    s_WrAdd	<= "10001";

    s_read1	<= X"01111111";
    s_read2	<= X"01111111";
    s_signExt	<= X"01111001";
    s_PC	<= X"01111111";
    s_Inst	<= X"01111111";
    wait for cCLK_PER;


    wait;
  end process;
  
end behavior;