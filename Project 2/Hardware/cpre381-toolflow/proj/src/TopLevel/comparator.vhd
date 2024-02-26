library IEEE;
use IEEE.std_logic_1164.all;

entity comparator is

  port(i_OpCode          : in std_logic_vector(5 downto 0);
       i_RS		 : in std_logic_vector(31 downto 0);
       i_RT		 : in std_logic_vector(31 downto 0);
       o_O               : out std_logic);

end comparator;

architecture behavior of comparator is

  signal s_equal : std_logic; -- 0 if RS and RT are not equal, 1 if they are equal
  signal s_comp : std_logic_vector(31 downto 0);

begin
s_comp <= i_RS xor i_RT;

    with s_comp select 
    	s_equal <= '1' when X"00000000",
        '0' when others;

    with i_OpCode select 
	o_O <= s_equal when "000100",
	not s_equal when "000101",
	'0' when others;

  
end behavior;