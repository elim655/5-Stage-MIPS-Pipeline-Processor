library IEEE;
use IEEE.std_logic_1164.all;

entity nor32to1 is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);
end nor32to1;

architecture behavior of nor32to1 is

begin
	with i_A select
		o_F <= '1' when X"00000000",
		'0' when others;

end behavior;	