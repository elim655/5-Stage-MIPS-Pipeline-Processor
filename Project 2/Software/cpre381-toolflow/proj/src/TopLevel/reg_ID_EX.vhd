library IEEE;
use IEEE.std_logic_1164.all;

entity reg_ID_EX is
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
end reg_ID_EX;

architecture structure of reg_ID_EX is

component reg_N
generic (N : integer := 32);
   port(i_CLK    : in std_logic;
    i_WE    : in std_logic;
    i_RST    : in std_logic;
    i_D    : in std_logic_vector(N-1 downto 0);
    o_Q    : out std_logic_vector(N-1 downto 0));   
end component;

component dffg
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
end component;

begin

Inst_reg : reg_N
  generic map(N => 32)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_Inst,
	   o_Q => o_Inst);


read1 : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_read1,
	     o_Q => o_read1);

read2 : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_read2,
	     o_Q => o_read2);

imm_ext : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_signExt,
	     o_Q => o_signExt);

nxtad :  reg_N
generic map(N => 2)
port map(i_CLK => i_CLK,
     i_RST => i_RST,
     i_WE => i_WE,
     i_D => i_nxtad,
     o_Q => o_nxtad);

Alucon : reg_N
    generic map(N => 4)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_Alucon,
	     o_Q => o_Alucon);    
         
WrAdd_reg : reg_N
    generic map(N => 5)
    port map(i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE => i_WE,
        i_D => i_WrAdd,
        o_Q => o_WrAdd);
       

jal : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_jal,
	    o_Q => o_jal);

fetch : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_fetch,
	    o_Q => o_fetch);

MemtoReg : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_MemtoReg,
	    o_Q => o_MemtoReg);

RegWrite : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_RegWr,
	    o_Q => o_RegWr);

MemWrite : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_DMemWr,
	    o_Q => o_DMemWr);

ALUSrc : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_ALUSrc,
	    o_Q => o_ALUSrc);

ShiftVariable : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_Shf,
	    o_Q => o_Shf);

RegDst : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_RegDst,
	    o_Q => o_RegDst);

Branch : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_branch,
	    o_Q => o_branch);

PC : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_PC,
	     o_Q => o_PC);

end structure;
