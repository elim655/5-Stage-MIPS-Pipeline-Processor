library IEEE;
use IEEE.std_logic_1164.all;

entity reg_ID_EX is
   port(i_CLK       			                            : in std_logic;  
        i_RST        			                            : in std_logic;
        i_WE         			                            : in std_logic;
		i_flush												: in std_logic;
        i_ALUSrc, i_MemtoReg, i_DMemWr, i_RegWr, i_RegDst,
        i_jal, i_Shf, i_jr                              : in std_logic;
        i_nxtad                                             : in std_logic_vector(1 downto 0);
	    i_Alucon				                            : in std_logic_vector(3 downto 0); 
        i_WrAdd						                        : in std_logic_vector(4 downto 0);
        i_read1, i_read2			                        : in std_logic_vector(31 downto 0);
        i_signExt, i_PC, i_Inst			                    : in std_logic_vector(31 downto 0);
        o_ALUSrc, o_MemtoReg, o_DMemWr, o_RegWr, o_RegDst,
        o_jal, o_Shf, o_jr                              : out std_logic; 
        o_nxtad                                             : out std_logic_vector(1 downto 0);
        o_Alucon				                            : out std_logic_vector(3 downto 0); 
        o_WrAdd						                        : out std_logic_vector(4 downto 0);
        o_read1, o_read2			                        : out std_logic_vector(31 downto 0);
        o_signExt, o_PC, o_Inst			                    : out std_logic_vector(31 downto 0));   
end reg_ID_EX;

architecture mixed of reg_ID_EX is

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

signal s_ALUSrc, s_MemtoReg, s_DMemWr, s_RegWr, s_RegDst,
        s_jal, s_Shf, s_jr                              : std_logic;
signal s_nxtad                                          : std_logic_vector(1 downto 0);
signal s_Alucon				                            : std_logic_vector(3 downto 0); 
signal s_WrAdd						                    : std_logic_vector(4 downto 0);
signal s_read1, s_read2			                        : std_logic_vector(31 downto 0);
signal s_signExt, s_PC, s_Inst							: std_logic_vector(31 downto 0);

begin
s_PC <= X"00000000" when i_flush = '1' else
        i_PC;

s_Inst <= x"00000000" when i_flush = '1' else
        i_Inst;

s_signExt <= X"00000000" when i_flush = '1' else
        i_signExt;

s_read1 <= x"00000000" when i_flush = '1' else
        i_read1;

s_read2 <= X"00000000" when i_flush = '1' else
        i_read2;

s_WrAdd <= "00000" when i_flush = '1' else
        i_WrAdd;

s_Alucon <= "0000" when i_flush = '1' else
        i_Alucon;

s_nxtad <= "00" when i_flush = '1' else
        i_nxtad;

s_ALUSrc <= '0' when i_flush = '1' else
        i_ALUSrc;

s_MemtoReg <= '0' when i_flush = '1' else
        i_MemtoReg;

s_DMemWr <= '0' when i_flush = '1' else
        i_DMemWr;

s_RegWr <= '0' when i_flush = '1' else
        i_RegWr;

s_RegDst <= '0' when i_flush = '1' else
        i_RegDst;

s_jal <= '0' when i_flush = '1' else
        i_jal;

s_Shf <= '0' when i_flush = '1' else
        i_Shf;

s_jr <= '0' when i_flush = '1' else
        i_jr;


Inst_reg : reg_N
  generic map(N => 32)
  port map(i_CLK => i_CLK,
	   i_RST => i_RST,
	   i_WE => i_WE,
	   i_D => s_Inst,
	   o_Q => o_Inst);


read1 : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => s_read1,
	     o_Q => o_read1);

read2 : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => s_read2,
	     o_Q => o_read2);

imm_ext : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => s_signExt,
	     o_Q => o_signExt);

nxtad :  reg_N
generic map(N => 2)
port map(i_CLK => i_CLK,
     i_RST => i_RST,
     i_WE => i_WE,
     i_D => s_nxtad,
     o_Q => o_nxtad);

Alucon : reg_N
    generic map(N => 4)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => s_Alucon,
	     o_Q => o_Alucon);    
         
WrAdd_reg : reg_N
    generic map(N => 5)
    port map(i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE => i_WE,
        i_D => s_WrAdd,
        o_Q => o_WrAdd);
       

jal : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_jal,
	    o_Q => o_jal);

jr : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_jr,
	    o_Q => o_jr);

MemtoReg : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_MemtoReg,
	    o_Q => o_MemtoReg);

RegWrite : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_RegWr,
	    o_Q => o_RegWr);

MemWrite : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_DMemWr,
	    o_Q => o_DMemWr);

ALUSrc : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_ALUSrc,
	    o_Q => o_ALUSrc);

ShiftVariable : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_Shf,
	    o_Q => o_Shf);

RegDst : dffg
   port MAP(i_CLK => i_CLK,
	    i_RST => i_RST,
 	    i_WE => i_WE,
	    i_D => s_RegDst,
	    o_Q => o_RegDst);

PC : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	     i_RST => i_RST,
	     i_WE => i_WE,
	     i_D => s_PC,
	     o_Q => o_PC);

end mixed;
