library IEEE;
use IEEE.std_logic_1164.all;

entity reg_IF_ID is
   port(i_CLK        : in std_logic;  
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_flush      : in std_logic;    
        i_PC	     : in std_logic_vector(31 downto 0);
	i_Inst	     : in std_logic_vector(31 downto 0);   
        o_PC         : out std_logic_vector(31 downto 0);
	o_Inst	     : out std_logic_vector(31 downto 0));   

end reg_IF_ID;

architecture mixed of reg_IF_ID is

component reg_N
generic (N : integer := 32);
   port(i_CLK    : in std_logic;
        i_WE    : in std_logic;
        i_RST    : in std_logic;
        i_D    : in std_logic_vector(N-1 downto 0);
        o_Q    : out std_logic_vector(N-1 downto 0));   
end component;

 signal s_PC : std_logic_vector(31 downto 0);
 signal s_Inst : std_logic_vector(31 downto 0);

begin
s_PC <= X"00000000" when i_flush = '1' else
        i_PC;

s_Inst <= x"00000000" when i_flush = '1' else
        i_Inst;

PC_count : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	         i_RST => i_RST,
	         i_WE => i_WE,
	         i_D => s_PC,
	         o_Q => o_PC);

Instruction : reg_N
    generic map(N => 32)
    port map(i_CLK => i_CLK,
	         i_RST => i_RST,
	         i_WE => i_WE,
	         i_D => s_Inst,
	         o_Q => o_Inst);
	     
end mixed;
