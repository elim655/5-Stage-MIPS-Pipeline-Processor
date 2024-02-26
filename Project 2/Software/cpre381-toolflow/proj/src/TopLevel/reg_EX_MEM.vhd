library IEEE;
use IEEE.std_logic_1164.all;

entity reg_EX_MEM is
   port(i_CLK       			                : in std_logic;  
        i_RST        			                : in std_logic;
        i_WE         			                : in std_logic;
	    i_jal, i_MemtoReg, i_RegWr, i_DMemWr, i_fetch, i_XOR    : in std_logic;
        i_nxtad                                 : in std_logic_vector(1 downto 0);    
        i_ALUout			                    : in std_logic_vector(31 downto 0);
        i_WrAdd						            : in std_logic_vector(4 downto 0);
	    i_Read2	     			                : in std_logic_vector(31 downto 0);
        i_JumpAdd, i_BranchAdd, i_JrAdd	     			: in std_logic_vector(31 downto 0);
	    i_PC 	                                : in std_logic_vector(31 downto 0);
	    o_jal, o_MemtoReg, o_RegWr, o_DMemWr, o_fetch, o_XOR    : out std_logic; 
        o_nxtad                                 : out std_logic_vector(1 downto 0);
        o_ALUout        		                : out std_logic_vector(31 downto 0);
        o_WrAdd						            : out std_logic_vector(4 downto 0);
	    o_Read2	     			                : out std_logic_vector(31 downto 0);
	    o_JumpAdd, o_BranchAdd, o_JrAdd	     			: out std_logic_vector(31 downto 0);
	    o_PC 	                                : out std_logic_vector(31 downto 0));   
end reg_EX_MEM;

architecture structure of reg_EX_MEM is

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

ALUout : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_ALUout,
	     o_Q => o_ALUout);

WrAdd_reg : reg_N
    generic map(N => 5)
    port map(i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE => i_WE,
        i_D => i_WrAdd,
        o_Q => o_WrAdd);

BranchAdd : reg_N
  generic map(N => 32)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_BranchAdd,
	   o_Q => o_BranchAdd);

Read2 : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_Read2,
	     o_Q => o_Read2);

JumpAdd : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_JumpAdd,
	     o_Q => o_JumpAdd);

JrAdd : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_JrAdd,
	     o_Q => o_JrAdd);

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

XOR_dffg : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_XOR,
	    o_Q => o_XOR);

MemtoReg : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_MemtoReg,
	    o_Q => o_MemtoReg);

RegWr : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_RegWr,
	    o_Q => o_RegWr);

DMemWr : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => i_DMemWr,
	    o_Q => o_DMemWr);

nxtad :  reg_N
    generic map(N => 2)
    port map(i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE => i_WE,
        i_D => i_nxtad,
        o_Q => o_nxtad);

PC : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_PC,
	     o_Q => o_PC);

end structure;
