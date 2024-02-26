library IEEE;
use IEEE.std_logic_1164.all;

entity Adder is
   port(i_A         : in std_logic;
	i_B         : in std_logic;
	i_Cin       : in std_logic;
        o_S         : out std_logic;
	o_Cout      : out std_logic);

end Adder;

architecture structure of Adder is


 
 Begin
	
	o_S <= i_A xor i_b xor i_Cin;
	o_Cout <= (i_A and i_B) or (i_A and i_Cin) or (i_B and i_Cin);
end structure;