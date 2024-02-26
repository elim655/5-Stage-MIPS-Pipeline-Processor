library IEEE;
use IEEE.std_logic_1164.all;

entity comp is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end comp;

architecture dataflow of comp is
begin

o_F(0) <= i_A(31);

G_NBit_LOADZEROS: for i in 1 to 31 generate
  o_F(i) <= '0';
end generate G_NBit_LOADZEROS;
  
end dataflow;	