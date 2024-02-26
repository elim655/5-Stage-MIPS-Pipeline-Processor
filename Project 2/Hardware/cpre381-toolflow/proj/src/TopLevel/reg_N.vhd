library IEEE;
use IEEE.std_logic_1164.all;

entity reg_N is
generic (N : integer := 32);
   port(i_CLK    : in std_logic;
    i_WE    : in std_logic;
    i_RST    : in std_logic;
    i_D    : in std_logic_vector(N-1 downto 0);
    o_Q    : out std_logic_vector(N-1 downto 0));    
end reg_N;

architecture structure of reg_N is
 component dffg is
   port(i_CLK    	: in std_logic;	 
    i_RST    	: in std_logic;	 
    i_WE     	: in std_logic;	 
    i_D      	: in std_logic;	 
    o_Q      	: out std_logic);  
 end component;
begin
  G_NBit_REG: for i in 0 to N-1 generate
	Reg: dffg port map(
    	i_CLK    => i_CLK,
    	i_RST    => i_RST,
    	i_WE    => i_WE,
    	i_D    => i_D(i),
    	o_Q    => o_Q(i));
  end generate G_NBit_REG;

end structure;
