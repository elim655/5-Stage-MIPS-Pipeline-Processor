library IEEE;
use IEEE.std_logic_1164.all;

entity extender is
port( i_IM    : in std_logic_vector(15 downto 0);
  	i_S	: in std_logic;
  	o_O   	: out std_logic_vector(31 downto 0));
end extender;

architecture dataflow of extender is

signal s_ext : std_logic;

begin

with i_S select
   s_ext <= '0' when '1',
     	i_IM(15) when others;

Part1: for i in 0 to 15 generate
    o_O(i) <= i_IM(i);
end generate;

Part2: for i in 16 to 31 generate
    o_O(i) <= s_ext;
end generate;

end dataflow;
