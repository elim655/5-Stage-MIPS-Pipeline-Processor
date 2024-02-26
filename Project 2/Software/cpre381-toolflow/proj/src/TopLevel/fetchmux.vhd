library IEEE;
use IEEE.std_logic_1164.all;

entity fetchmux is
   port(i_jr	: in std_logic_vector(31 downto 0);
	i_jadd	: in std_logic_vector(31 downto 0);
	i_badd	: in std_logic_vector(31 downto 0);
	i_xor	: in std_logic;
	i_nxtad	: in std_logic_vector(1 downto 0);
	o_addr	: out std_logic_vector(31 downto 0));
end fetchmux;

architecture behavioral of fetchmux is
 begin
  o_addr <=	i_jr when i_nxtad = "11" else
		i_jadd when i_nxtad = "01" else
		i_badd when i_nxtad = "10" and i_xor = '1' else
		x"00000000";
end behavioral;