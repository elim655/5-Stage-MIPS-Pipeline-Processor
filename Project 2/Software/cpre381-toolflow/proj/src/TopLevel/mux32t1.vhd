library IEEE;
use IEEE.std_logic_1164.all;

entity mux32t1 is
   port(i_Data0   	 : in std_logic_Vector(31 downto 0);
    i_Data1   	 : in std_logic_Vector(31 downto 0);
    i_Data2   	 : in std_logic_Vector(31 downto 0);
    i_Data3   	 : in std_logic_Vector(31 downto 0);
    i_Data4   	 : in std_logic_Vector(31 downto 0);
    i_Data5   	 : in std_logic_Vector(31 downto 0);
    i_Data6   	 : in std_logic_Vector(31 downto 0);
    i_Data7   	 : in std_logic_Vector(31 downto 0);
    i_Data8   	 : in std_logic_Vector(31 downto 0);
    i_Data9   	 : in std_logic_Vector(31 downto 0);
    i_Data10    : in std_logic_Vector(31 downto 0);
    i_Data11    : in std_logic_Vector(31 downto 0);
    i_Data12    : in std_logic_Vector(31 downto 0);
    i_Data13    : in std_logic_Vector(31 downto 0);
    i_Data14    : in std_logic_Vector(31 downto 0);
    i_Data15    : in std_logic_Vector(31 downto 0);
    i_Data16    : in std_logic_Vector(31 downto 0);
    i_Data17    : in std_logic_Vector(31 downto 0);
    i_Data18    : in std_logic_Vector(31 downto 0);
    i_Data19    : in std_logic_Vector(31 downto 0);
    i_Data20    : in std_logic_Vector(31 downto 0);
    i_Data21    : in std_logic_Vector(31 downto 0);
    i_Data22    : in std_logic_Vector(31 downto 0);
    i_Data23    : in std_logic_Vector(31 downto 0);
    i_Data24    : in std_logic_Vector(31 downto 0);
    i_Data25    : in std_logic_Vector(31 downto 0);
    i_Data26    : in std_logic_Vector(31 downto 0);
    i_Data27    : in std_logic_Vector(31 downto 0);
    i_Data28    : in std_logic_Vector(31 downto 0);
    i_Data29    : in std_logic_Vector(31 downto 0);
    i_Data30    : in std_logic_Vector(31 downto 0);
    i_Data31    : in std_logic_Vector(31 downto 0);
    i_Select: in std_logic_Vector(4 downto 0);
    o_Out    : out std_logic_vector(31 downto 0));
end mux32t1;

architecture o_Out of mux32t1 is
 begin
  o_Out<= i_Data0 when i_Select = "00000" else
      i_Data1 when i_Select = "00001" else
      i_Data2 when i_Select = "00010" else
      i_Data3 when i_Select = "00011" else
      i_Data4 when i_Select = "00100" else
      i_Data5 when i_Select = "00101" else
      i_Data6 when i_Select = "00110" else
      i_Data7 when i_Select = "00111" else
      i_Data8 when i_Select = "01000" else
      i_Data9 when i_Select = "01001" else
      i_Data10 when i_Select = "01010" else
      i_Data11 when i_Select = "01011" else
      i_Data12 when i_Select = "01100" else
      i_Data13 when i_Select = "01101" else
      i_Data14 when i_Select = "01110" else
      i_Data15 when i_Select = "01111" else
      i_Data16 when i_Select = "10000" else
      i_Data17 when i_Select = "10001" else
      i_Data18 when i_Select = "10010" else
      i_Data19 when i_Select = "10011" else

      i_Data20 when i_Select = "10100" else
      i_Data21 when i_Select = "10101" else
      i_Data22 when i_Select = "10110" else
      i_Data23 when i_Select = "10111" else
      i_Data24 when i_Select = "11000" else
      i_Data25 when i_Select = "11001" else
      i_Data26 when i_Select = "11010" else
      i_Data27 when i_Select = "11011" else
      i_Data28 when i_Select = "11100" else
      i_Data29 when i_Select = "11101" else
      i_Data30 when i_Select = "11110" else
      i_Data31 when i_Select = "11111" else
      (others => '0');
    
end architecture o_Out;

