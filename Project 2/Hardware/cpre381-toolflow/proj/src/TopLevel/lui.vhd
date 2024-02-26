library IEEE;
use IEEE.std_logic_1164.all;

entity lui is

  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end lui;

architecture dataflow of lui is
begin

G_NBit_LOADZERO: for i in 0 to 15 generate
  o_F(i) <= '0';
end generate G_NBit_LOADZERO;

G_NBit_LOADUPPER: for i in 16 to 31 generate
  o_F(i) <= i_A(i - 16);
end generate G_NBit_LOADUPPER;
  
end dataflow;	