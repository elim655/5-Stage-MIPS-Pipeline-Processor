library IEEE;
use IEEE.std_logic_1164.all;

entity jumpAdd is
   port(i_immed	: in std_logic_vector(25 downto 0);
	i_pc4	: in std_logic_vector(3 downto 0);
	o_jadd	: out std_logic_vector(31 downto 0));
end jumpAdd;

architecture dataflow of jumpAdd is
 begin
  o_jadd <= i_pc4 & i_immed & "00";
end dataflow;