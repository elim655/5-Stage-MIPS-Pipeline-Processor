library IEEE;
use IEEE.std_logic_1164.all;

entity dec5t32 is
   port(i_S    : in std_logic_Vector(4 downto 0);
	i_regwrite	: in std_logic;
    o_O    : out std_logic_vector(31 downto 0));

end dec5t32;

architecture o_O of dec5t32 is
 begin
  o_O<=    x"00000001" when i_S = "00000" and i_regwrite = '1' else
    x"00000002" when i_S = "00001" and i_regwrite = '1' else
    x"00000004" when i_S = "00010" and i_regwrite = '1' else
    x"00000008" when i_S = "00011" and i_regwrite = '1' else
    x"00000010" when i_S = "00100" and i_regwrite = '1' else
    x"00000020" when i_S = "00101" and i_regwrite = '1' else
    x"00000040" when i_S = "00110" and i_regwrite = '1' else
    x"00000080" when i_S = "00111" and i_regwrite = '1' else
    x"00000100" when i_S = "01000" and i_regwrite = '1' else
    x"00000200" when i_S = "01001" and i_regwrite = '1' else
    x"00000400" when i_S = "01010" and i_regwrite = '1' else
    x"00000800" when i_S = "01011" and i_regwrite = '1' else
    x"00001000" when i_S = "01100" and i_regwrite = '1' else
    x"00002000" when i_S = "01101" and i_regwrite = '1' else
    x"00004000" when i_S = "01110" and i_regwrite = '1' else
    x"00008000" when i_S = "01111" and i_regwrite = '1' else
    x"00010000" when i_S = "10000" and i_regwrite = '1' else
    x"00020000" when i_S = "10001" and i_regwrite = '1' else
    x"00040000" when i_S = "10010" and i_regwrite = '1' else
    x"00080000" when i_S = "10011" and i_regwrite = '1' else
    x"00100000" when i_S = "10100" and i_regwrite = '1' else
    x"00200000" when i_S = "10101" and i_regwrite = '1' else
    x"00400000" when i_S = "10110" and i_regwrite = '1' else
    x"00800000" when i_S = "10111" and i_regwrite = '1' else
    x"01000000" when i_S = "11000" and i_regwrite = '1' else
    x"02000000" when i_S = "11001" and i_regwrite = '1' else
    x"04000000" when i_S = "11010" and i_regwrite = '1' else
    x"08000000" when i_S = "11011" and i_regwrite = '1' else
    x"10000000" when i_S = "11100" and i_regwrite = '1' else
    x"20000000" when i_S = "11101" and i_regwrite = '1' else
    x"40000000" when i_S = "11110" and i_regwrite = '1' else
    x"80000000" when i_S = "11111" and i_regwrite = '1' else
    x"00000000";
end o_O;

