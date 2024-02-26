library IEEE;
use IEEE.std_logic_1164.all;

entity tb_brnchAdd is
end tb_brnchAdd;

architecture behavior of tb_brnchAdd is
  component brnchAdd
   port(i_immed	: in std_logic_vector(31 downto 0);
	i_pc4	: in std_logic_vector(31 downto 0);
	o_badd	: out std_logic_vector(31 downto 0));
  end component;

  signal s_immed, s_pc4, s_badd 	: std_logic_vector(31 downto 0);

 begin
  DUT: brnchAdd 
  port map(i_immed 	=> s_immed, 
           i_pc4 	=> s_pc4,
           o_badd	=> s_badd);

  P_TB: process
  begin
	s_immed <= x"000eea1f";
	s_pc4	<= x"11111003";
	wait for 50 ns;
 end process;
end behavior;