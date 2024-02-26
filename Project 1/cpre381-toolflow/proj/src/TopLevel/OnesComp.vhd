library IEEE;
use IEEE.std_logic_1164.all;

entity OnesComp is
 generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
 port( i_A		            : in std_logic_vector(N-1 downto 0);
       o_O 		            : out std_logic_vector(N-1 downto 0));

end OnesComp;

architecture structural of OnesComp is
  --List Components

  component invg is
    port(i_A          : in std_logic;
         o_F          : out std_logic);

  end component;

begin

  G_NBit_INV: for i in 0 to 31 generate
      g_Not: invg port MAP(
  	    i_A               => i_A(i),
            o_F               => o_O(i));

  end generate G_NBit_INV;

end structural;