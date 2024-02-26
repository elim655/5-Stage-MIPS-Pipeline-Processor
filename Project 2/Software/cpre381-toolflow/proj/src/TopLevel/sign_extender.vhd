library IEEE;
use IEEE.std_logic_1164.all;

entity sign_extender is

  port(i_IM              : in std_logic_vector(15 downto 0);
       o_O               : out std_logic_vector(31 downto 0));

end sign_extender;

architecture behavior of sign_extender is


begin

G_NBit_STORE: for i in 0 to 15 generate
    o_O(i) <= i_IM(i);
end generate G_NBit_STORE;

G_Nbit_PAD: for i in 16 to 31 generate
  o_O(i) <= i_IM(15);
end generate G_NBit_PAD;

  


end behavior;