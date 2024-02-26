library IEEE;
use IEEE.std_logic_1164.all;

entity tb_PCadd4 is
  generic(gCLK_HPER   : time := 25 ns);
end tb_PCadd4;

architecture behavior of tb_PCadd4 is
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component PCandAdd
   port(i_CLK	: in std_logic;
	i_RST	: in std_logic;
	i_addr	: in std_logic_vector(31 downto 0);
	o_pc4	: out std_logic_vector(31 downto 0));
  end component;

  signal s_CLK, s_RST  	: std_logic;
  signal s_addr, s_pc4 	: std_logic_vector(31 downto 0);

 begin

  DUT: PCandAdd 
  port map(i_CLK 	=> s_CLK, 
           i_RST 	=> s_RST,
           i_addr	=> s_pc4,
           o_pc4	=> s_pc4);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

  P_TB: process
  begin
    s_RST <= '1';
    wait for cCLK_PER;

    s_RST <= '0';
    wait for cCLK_PER;

    s_RST <= '0';
    wait for cCLK_PER;
 end process;
end behavior;