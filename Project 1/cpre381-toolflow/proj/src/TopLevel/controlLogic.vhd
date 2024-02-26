library IEEE;
use IEEE.std_logic_1164.all;

entity CntLogic is
   port(i_Opco	: in std_logic_vector(5 downto 0);
	i_Funco	: in std_logic_vector(5 downto 0);
	o_ALUSrc: out std_logic;
	o_Alucon: out std_logic_vector(3 downto 0);
	o_MemtoReg: out std_logic;
	o_DMemWr: out std_logic;
	o_RegWr	: out std_logic;
	o_RegDst: out std_logic;
	o_nxtad	: out std_logic_vector(1 downto 0);
	o_branch: out std_logic;
	o_jr	: out std_logic;
	o_jal	: out std_logic;
	o_shf	: out std_logic;
	o_ext	: out std_logic);
end CntLogic;


architecture mixed of CntLogic is
 begin
  o_ALUSrc<=	'1' when i_Opco = "001000" else
		'0' when i_Opco = "000000" and i_Funco = "100000" else
		'1' when i_Opco = "001001" else
		'0' when i_Opco = "000000" and i_Funco = "100001" else
		'0' when i_Opco = "000000" and i_Funco = "100100" else
		'1' when i_Opco = "001100" else
		'1' when i_Opco = "001111" else
		'1' when i_Opco = "100011" else
		'0' when i_Opco = "000000" and i_Funco = "100111" else
		'0' when i_Opco = "000000" and i_Funco = "100110" else
		'1' when i_Opco = "001110" else
		'0' when i_Opco = "000000" and i_Funco = "100101" else
		'1' when i_Opco = "001101" else
		'0' when i_Opco = "000000" and i_Funco = "101010" else
		'1' when i_Opco = "001010" else
		'0' when i_Opco = "000000" and i_Funco = "000000" else
		'0' when i_Opco = "000000" and i_Funco = "000010" else
		'0' when i_Opco = "000000" and i_Funco = "000011" else
		'1' when i_Opco = "101011" else
		'0' when i_Opco = "000000" and i_Funco = "100010" else
		'0' when i_Opco = "000000" and i_Funco = "100011" else
		'0' when i_Opco = "000100" else
		'0' when i_Opco = "000101" else
		'0' when i_Opco = "000010" else
		'0' when i_Opco = "000011" else
		'0' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_MemtoReg<=	'0' when i_Opco = "001000" else
		'0' when i_Opco = "000000" and i_Funco = "100000" else
		'0' when i_Opco = "001001" else
		'0' when i_Opco = "000000" and i_Funco = "100001" else
		'0' when i_Opco = "000000" and i_Funco = "100100" else
		'0' when i_Opco = "001100" else
		'0' when i_Opco = "001111" else
		'1' when i_Opco = "100011" else
		'0' when i_Opco = "000000" and i_Funco = "100111" else
		'0' when i_Opco = "000000" and i_Funco = "100110" else
		'0' when i_Opco = "001110" else
		'0' when i_Opco = "000000" and i_Funco = "100101" else
		'0' when i_Opco = "001101" else
		'0' when i_Opco = "000000" and i_Funco = "101010" else
		'0' when i_Opco = "001010" else
		'0' when i_Opco = "000000" and i_Funco = "000000" else
		'0' when i_Opco = "000000" and i_Funco = "000010" else
		'0' when i_Opco = "000000" and i_Funco = "000011" else
		'1' when i_Opco = "101011" else
		'0' when i_Opco = "000000" and i_Funco = "100010" else
		'0' when i_Opco = "000000" and i_Funco = "100011" else
		'0' when i_Opco = "000100" else
		'0' when i_Opco = "000101" else
		'0' when i_Opco = "000010" else
		'0' when i_Opco = "000011" else
		'0' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_DMemWr<=	'0' when i_Opco = "001000" else
		'0' when i_Opco = "000000" and i_Funco = "100000" else
		'0' when i_Opco = "001001" else
		'0' when i_Opco = "000000" and i_Funco = "100001" else
		'0' when i_Opco = "000000" and i_Funco = "100100" else
		'0' when i_Opco = "001100" else
		'0' when i_Opco = "001111" else
		'0' when i_Opco = "100011" else
		'0' when i_Opco = "000000" and i_Funco = "100111" else
		'0' when i_Opco = "000000" and i_Funco = "100110" else
		'0' when i_Opco = "001110" else
		'0' when i_Opco = "000000" and i_Funco = "100101" else
		'0' when i_Opco = "001101" else
		'0' when i_Opco = "000000" and i_Funco = "101010" else
		'0' when i_Opco = "001010" else
		'0' when i_Opco = "000000" and i_Funco = "000000" else
		'0' when i_Opco = "000000" and i_Funco = "000010" else
		'0' when i_Opco = "000000" and i_Funco = "000011" else
		'1' when i_Opco = "101011" else
		'0' when i_Opco = "000000" and i_Funco = "100010" else
		'0' when i_Opco = "000000" and i_Funco = "100011" else
		'0' when i_Opco = "000100" else
		'0' when i_Opco = "000101" else
		'0' when i_Opco = "000010" else
		'0' when i_Opco = "000011" else
		'0' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_RegWr<=	'1' when i_Opco = "001000" else
		'1' when i_Opco = "000000" and i_Funco = "100000" else
		'1' when i_Opco = "001001" else
		'1' when i_Opco = "000000" and i_Funco = "100001" else
		'1' when i_Opco = "000000" and i_Funco = "100100" else
		'1' when i_Opco = "001100" else
		'1' when i_Opco = "001111" else
		'1' when i_Opco = "100011" else
		'1' when i_Opco = "000000" and i_Funco = "100111" else
		'1' when i_Opco = "000000" and i_Funco = "100110" else
		'1' when i_Opco = "001110" else
		'1' when i_Opco = "000000" and i_Funco = "100101" else
		'1' when i_Opco = "001101" else
		'1' when i_Opco = "000000" and i_Funco = "101010" else
		'1' when i_Opco = "001010" else
		'1' when i_Opco = "000000" and i_Funco = "000000" else
		'1' when i_Opco = "000000" and i_Funco = "000010" else
		'1' when i_Opco = "000000" and i_Funco = "000011" else
		'0' when i_Opco = "101011" else
		'1' when i_Opco = "000000" and i_Funco = "100010" else
		'1' when i_Opco = "000000" and i_Funco = "100011" else
		'0' when i_Opco = "000100" else
		'0' when i_Opco = "000101" else
		'0' when i_Opco = "000010" else
		'1' when i_Opco = "000011" else
		'0' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_RegDst<=	'0' when i_Opco = "001000" else
		'1' when i_Opco = "000000" and i_Funco = "100000" else
		'0' when i_Opco = "001001" else
		'1' when i_Opco = "000000" and i_Funco = "100001" else
		'1' when i_Opco = "000000" and i_Funco = "100100" else
		'0' when i_Opco = "001100" else
		'0' when i_Opco = "001111" else
		'0' when i_Opco = "100011" else
		'1' when i_Opco = "000000" and i_Funco = "100111" else
		'1' when i_Opco = "000000" and i_Funco = "100110" else
		'0' when i_Opco = "001110" else
		'1' when i_Opco = "000000" and i_Funco = "100101" else
		'0' when i_Opco = "001101" else
		'1' when i_Opco = "000000" and i_Funco = "101010" else
		'0' when i_Opco = "001010" else
		'1' when i_Opco = "000000" and i_Funco = "000000" else
		'1' when i_Opco = "000000" and i_Funco = "000010" else
		'1' when i_Opco = "000000" and i_Funco = "000011" else
		'0' when i_Opco = "101011" else
		'1' when i_Opco = "000000" and i_Funco = "100010" else
		'1' when i_Opco = "000000" and i_Funco = "100011" else
		'1' when i_Opco = "000100" else
		'1' when i_Opco = "000101" else
		'1' when i_Opco = "000010" else
		'1' when i_Opco = "000011" else
		'1' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_Alucon<=	"0000" when i_Opco = "001000" else
		"0000" when i_Opco = "000000" and i_Funco = "100000" else
		"0001" when i_Opco = "001001" else
		"0001" when i_Opco = "000000" and i_Funco = "100001" else
		"0010" when i_Opco = "000000" and i_Funco = "100100" else
		"0010" when i_Opco = "001100" else
		"1100" when i_Opco = "001111" else
		"0000" when i_Opco = "100011" else
		"0011" when i_Opco = "000000" and i_Funco = "100111" else
		"0100" when i_Opco = "000000" and i_Funco = "100110" else
		"0100" when i_Opco = "001110" else
		"0101" when i_Opco = "000000" and i_Funco = "100101" else
		"0101" when i_Opco = "001101" else
		"0110" when i_Opco = "000000" and i_Funco = "101010" else
		"0110" when i_Opco = "001010" else
		"0111" when i_Opco = "000000" and i_Funco = "000000" else
		"1000" when i_Opco = "000000" and i_Funco = "000010" else
		"1001" when i_Opco = "000000" and i_Funco = "000011" else
		"0000" when i_Opco = "101011" else
		"1010" when i_Opco = "000000" and i_Funco = "100010" else
		"1011" when i_Opco = "000000" and i_Funco = "100011" else
		"1101" when i_Opco = "000100" else
		"1101" when i_Opco = "000101" else
		"1111";

  o_nxtad<=	"00" when i_Opco = "001000" else
		"00" when i_Opco = "000000" and i_Funco = "100000" else
		"00" when i_Opco = "001001" else
		"00" when i_Opco = "000000" and i_Funco = "100001" else
		"00" when i_Opco = "000000" and i_Funco = "100100" else
		"00" when i_Opco = "001100" else
		"00" when i_Opco = "001111" else
		"00" when i_Opco = "100011" else
		"00" when i_Opco = "000000" and i_Funco = "100111" else
		"00" when i_Opco = "000000" and i_Funco = "100110" else
		"00" when i_Opco = "001110" else
		"00" when i_Opco = "000000" and i_Funco = "100101" else
		"00" when i_Opco = "001101" else
		"00" when i_Opco = "000000" and i_Funco = "101010" else
		"00" when i_Opco = "001010" else
		"00" when i_Opco = "000000" and i_Funco = "000000" else
		"00" when i_Opco = "000000" and i_Funco = "000010" else
		"00" when i_Opco = "000000" and i_Funco = "000011" else
		"00" when i_Opco = "101011" else
		"00" when i_Opco = "000000" and i_Funco = "100010" else
		"00" when i_Opco = "000000" and i_Funco = "100011" else
		"10" when i_Opco = "000100" else
		"10" when i_Opco = "000101" else
		"01" when i_Opco = "000010" else
		"01" when i_Opco = "000011" else
		"11" when i_Opco = "000000" and i_Funco = "001000" else
		"00";

  o_branch<=	'0' when i_Opco = "001000" else
		'0' when i_Opco = "000000" and i_Funco = "100000" else
		'0' when i_Opco = "001001" else
		'0' when i_Opco = "000000" and i_Funco = "100001" else
		'0' when i_Opco = "000000" and i_Funco = "100100" else
		'0' when i_Opco = "001100" else
		'0' when i_Opco = "001111" else
		'0' when i_Opco = "100011" else
		'0' when i_Opco = "000000" and i_Funco = "100111" else
		'0' when i_Opco = "000000" and i_Funco = "100110" else
		'0' when i_Opco = "001110" else
		'0' when i_Opco = "000000" and i_Funco = "100101" else
		'0' when i_Opco = "001101" else
		'0' when i_Opco = "000000" and i_Funco = "101010" else
		'0' when i_Opco = "001010" else
		'0' when i_Opco = "000000" and i_Funco = "000000" else
		'0' when i_Opco = "000000" and i_Funco = "000010" else
		'0' when i_Opco = "000000" and i_Funco = "000011" else
		'0' when i_Opco = "101011" else
		'0' when i_Opco = "000000" and i_Funco = "100010" else
		'0' when i_Opco = "000000" and i_Funco = "100011" else
		'0' when i_Opco = "000100" else
		'1' when i_Opco = "000101" else
		'0' when i_Opco = "000010" else
		'0' when i_Opco = "000011" else
		'0' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_jal<=	'1' when i_Opco = "000011" else
		'0';

  o_jr<=	'1' when i_Opco = "000000" and i_Funco = "001000" else
		'0';

  o_shf<=	'1' when i_Opco = "000000" and i_Funco = "000000" else
		'1' when i_Opco = "000000" and i_Funco = "000010" else
		'1' when i_Opco = "000000" and i_Funco = "000011" else
		'0';

  o_ext<=	'1' when i_Opco = "001100" else
		'1' when i_Opco = "001110" else
		'1' when i_Opco = "001101" else
		'0';
end mixed;
