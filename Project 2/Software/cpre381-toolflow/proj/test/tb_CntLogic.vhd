library IEEE;
use IEEE.std_logic_1164.all;

entity tb_CntLogic is
  generic(gCLK_HPER   : time := 10 ns);
end tb_CntLogic;

architecture mixed of tb_CntLogic is

  constant cCLK_PER  : time := gCLK_HPER * 2;

component CntLogic
   port(i_Opco	: in std_logic_vector(5 downto 0);
	i_Funco	: in std_logic_vector(5 downto 0);
	o_ALUSrc: out std_logic;
	o_Alucon: out std_logic_vector(3 downto 0);
	o_MemtoReg: out std_logic;
	o_DMemWr: out std_logic;
	o_RegWr	: out std_logic;
	o_RegDst: out std_logic;
	o_nxtad	: out std_logic_vector(1 downto 0);
	o_branch: out std_logic;
	o_jr	: out std_logic;
	o_jal	: out std_logic;
	o_shf	: out std_logic;
	o_ext	: out std_logic);
end component;

   signal s_Opco, s_Funco : std_logic_vector(5 downto 0);
   signal s_ALUSrc, s_MemtoReg, s_DMemWr, s_RegWr, s_RegDst, s_branch, s_jr, s_jal, s_shf, s_ext : std_logic;
   signal s_Alucon : std_logic_vector(3 downto 0);
   signal s_nxtad : std_logic_vector(1 downto 0);
   

begin

  DUT0: CntLogic
  port map(i_Opco => s_Opco, 
           i_Funco => s_Funco,
           o_ALUSrc  => s_ALUSrc,
           o_Alucon   => s_Alucon,
           o_MemtoReg   => s_MemtoReg,
           o_DMemWr  =>  s_DMemWr,
           o_RegWr   => s_RegWr,
           o_RegDst   => s_RegDst,
           o_nxtad  =>  s_jump,
	   o_branch => s_branch,
	   o_jr => s_jr,
	   o_jal => s_jal,
	   o_shf => s_shf,
	   o_ext => s_ext);
  

  P_TEST_CASES: process
  begin

    -- add
    s_Opco <= "000000";
    s_Funco  <= "100000";
    wait for cCLK_PER;

    -- addu
    s_Opco <= "000000";
    s_Funco  <= "100001";
    wait for cCLK_PER;

    -- and
    s_Opco <= "000000";
    s_Funco  <= "100100";
    wait for cCLK_PER;

    -- nor
    s_Opco <= "000000";
    s_Funco  <= "100111";
    wait for cCLK_PER;

    -- xor
    s_Opco <= "000000";
    s_Funco  <= "100110";
    wait for cCLK_PER;

    -- or
    s_Opco <= "000000";
    s_Funco  <= "100101";
    wait for cCLK_PER;

    -- slt
    s_Opco <= "000000";
    s_Funco  <= "101010";
    wait for cCLK_PER;

    -- sll
    s_Opco <= "000000";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- srl
    s_Opco <= "000000";
    s_Funco  <= "000010";
    wait for cCLK_PER;

    -- sra
    s_Opco <= "000000";
    s_Funco  <= "000011";
    wait for cCLK_PER;

    -- sub
    s_Opco <= "000000";
    s_Funco  <= "100010";
    wait for cCLK_PER;

    -- subu
    s_Opco <= "000000";
    s_Funco  <= "100011";
    wait for cCLK_PER;

    -- addi
    s_Opco <= "001000";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- addiu
    s_Opco <= "001001";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- andi
    s_Opco <= "001100";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- lui
    s_Opco <= "001111";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- lw
    s_Opco <= "100011";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- xori
    s_Opco <= "001110";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- ori
    s_Opco <= "001101";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- slti
    s_Opco <= "001010";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- sw
    s_Opco <= "101011";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- beq
    s_Opco <= "000100";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- bne
    s_Opco <= "000101";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- j
    s_Opco <= "000010";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- jal
    s_Opco <= "000011";
    s_Funco  <= "000000";
    wait for cCLK_PER;

    -- jr
    s_Opco <= "000000";
    s_Funco  <= "001000";
    wait for cCLK_PER;



  end process;
  
end mixed;