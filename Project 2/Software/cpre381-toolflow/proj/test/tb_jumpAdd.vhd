library IEEE;
use IEEE.std_logic_1164.all;

entity tb_jumpAdd is
end tb_jumpAdd;

architecture behavior of tb_jumpAdd is
  component jumpAdd
   port(i_immed	: in std_logic_vector(25 downto 0);
	i_pc4	: in std_logic_vector(3 downto 0);
	o_jadd	: out std_logic_vector(31 downto 0));
  end component;

  signal s_immed  	: std_logic_vector(25 downto 0);
  signal s_pc4		: std_logic_vector(3 downto 0);
  signal s_jadd 	: std_logic_vector(31 downto 0);

 begin

  DUT: jumpAdd 
  port map(i_immed 	=> s_immed, 
           i_pc4 	=> s_pc4,
           o_jadd	=> s_jadd);

  P_TB: process
  begin
	s_immed <= "01101010000011010100001010";
	s_pc4	<= "0000";
	wait for 50 ns;

	s_immed <= "01000000000000000000000000";
	s_pc4	<= "0000";
	wait for 50 ns;
 end process;
end behavior;