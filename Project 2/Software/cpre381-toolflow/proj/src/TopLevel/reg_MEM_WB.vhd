library IEEE;
use IEEE.std_logic_1164.all;

entity reg_MEM_WB is
    port(i_CLK       			                : in std_logic;  
        i_RST        			                : in std_logic;
        i_WE         			                : in std_logic;
	    i_jal, i_MemtoReg, i_RegWrite	        : in std_logic;
	    i_DMEMout, i_ALUout, i_PC			    : in std_logic_vector(31 downto 0);
	    i_WrAdd						            : in std_logic_vector(4 downto 0);
	    o_jal, o_MemtoReg, o_RegWrite	        : out std_logic;
	    o_DMEMout, o_ALUout, o_PC			    : out std_logic_vector(31 downto 0);
	    o_WrAdd						            : out std_logic_vector(4 downto 0));
end reg_MEM_WB;

architecture structure of reg_MEM_WB is

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

dmemout_reg : reg_N
  generic map(N => 32)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_DMEMout,
	   o_Q => o_DMEMout);

ALUout_reg : reg_N
  generic map(N => 32)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_ALUout,
	   o_Q => o_ALUout);

wradd_reg : reg_N
  generic map(N => 5)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_WrAdd,
	   o_Q => o_WrAdd);

jal_reg : dffg
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_jal,
	   o_Q => o_jal);

MemtoReg_reg : dffg
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_MemtoReg,
	   o_Q => o_MemtoReg);

RegWrite_reg : dffg
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => i_RegWrite,
	   o_Q => o_RegWrite);

PC : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => i_PC,
	     o_Q => o_PC);

end structure;
