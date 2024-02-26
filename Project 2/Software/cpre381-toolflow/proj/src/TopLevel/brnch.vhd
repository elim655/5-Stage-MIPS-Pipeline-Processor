library IEEE;
use IEEE.std_logic_1164.all;

entity brnch is
   port(i_brnch         : in std_logic;
        i_zero          : in std_logic;
        i_op	        : in std_logic_vector(5 downto 0);
	o_brnch		: out std_logic);
end brnch;

architecture behavioral of brnch is
 begin
  o_brnch<=	'1' when i_brnch = '1' and i_zero = '1' and i_op = "000100" else
		'1' when i_brnch = '1' and i_zero = '0' and i_op = "000101" else
		'0';
end behavioral;
