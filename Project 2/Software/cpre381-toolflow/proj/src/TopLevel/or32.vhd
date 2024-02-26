library IEEE;
use IEEE.std_logic_1164.all;

entity or32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end or32;

architecture dataflow of or32 is
begin

G_NBit_OR: for i in 0 to 31 generate
  o_F(i) <= i_A(i) or i_B(i);
end generate G_NBit_OR;
  
end dataflow;