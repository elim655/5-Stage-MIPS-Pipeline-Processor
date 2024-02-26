library IEEE;
use IEEE.std_logic_1164.all;

entity datahazard is
   port(i_IDop		: in std_logic_Vector(5 downto 0);
	i_IDfun		: in std_logic_Vector(5 downto 0);
	i_EXop		: in std_logic_Vector(5 downto 0);
	i_EXfun		: in std_logic_Vector(5 downto 0);
	i_MEMop		: in std_logic_Vector(5 downto 0);
	i_WBop		: in std_logic_Vector(5 downto 0);
	i_EXRD		: in std_logic_Vector(4 downto 0);
	i_MEMRD       	: in std_logic_Vector(4 downto 0);
    i_WBRD         	: in std_logic_Vector(4 downto 0);
	i_IDRT      	: in std_logic_Vector(4 downto 0);
	i_IDRS		: in std_logic_Vector(4 downto 0);
	i_EXRT		: in std_logic_Vector(4 downto 0);
	i_EXRS		: in std_logic_Vector(4 downto 0);
	i_MEMRT		: in std_logic_Vector(4 downto 0);
	i_WBRT		: in std_logic_Vector(4 downto 0); 
	i_EXdata	: in std_logic_Vector(31 downto 0);
	i_EXjal		: in std_logic_Vector(31 downto 0);
	i_MEMdata	: in std_logic_Vector(31 downto 0);
	i_MEMmemd	: in std_logic_Vector(31 downto 0);
	i_MEMjal	: in std_logic_Vector(31 downto 0);
	i_WBdata	: in std_logic_Vector(31 downto 0);
	i_WBmemd	: in std_logic_Vector(31 downto 0);
	i_WBjal		: in std_logic_Vector(31 downto 0);
	o_IDRS		: out std_logic_Vector(31 downto 0);
	o_IDRT		: out std_logic_Vector(31 downto 0);
	o_jr		: out std_logic_Vector(31 downto 0);
	o_EXRS		: out std_logic_Vector(31 downto 0);
	o_EXRT		: out std_logic_Vector(31 downto 0);
	o_IDRSmux	: out std_logic;
	o_IDRTmux	: out std_logic;
	o_Jrmux		: out std_logic;
	o_EXRSmux	: out std_logic;
	o_EXRTmux	: out std_logic);
end datahazard;

architecture behavioral of datahazard is
 begin
  o_IDRS<=	i_WBdata when (((i_IDRS = i_WBRD) and ((i_WBop = "000000"))) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((((i_IDop = "000000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011"))) and (i_IDRS /= "00000") else
		i_WBmemd when ((i_IDRS = i_WBRT) and (i_WBop = "100011")) and (((i_IDop = "000000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011") and (i_IDfun /= "001000"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011")) and (i_IDRS /= "00000") else
		i_EXdata when ((i_IDRS = i_EXRD) or ((i_IDRS = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		i_MEMdata when ((i_IDRS = i_MEMRD) or ((i_IDRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000")else
		i_WBdata when ((i_IDRS = i_WBRD) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000")else 
		i_MEMmemd when (i_IDRS = i_MEMRT) and (i_MEMop = "100011") and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		i_WBmemd when (i_IDRS = i_WBRT) and (i_WBop = "100011") and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		i_WBjal when ((i_IDRS = "11111") and (((i_IDop = "000000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011"))) and (i_WBop = "000011") else
		x"00000000";

  o_IDRT<=	i_WBdata when (((i_IDRT = i_WBRD) and ((i_WBop = "000000"))) or ((i_IDRT = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011")) and (i_IDRT /= "00000") else
		i_WBmemd when (i_IDRT = i_WBRT) and (i_WBop = "100011") and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011")) and (i_IDRT /= "00000") else
		i_EXdata when ((i_IDRT = i_EXRD) or ((i_IDRT = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		i_MEMdata when ((i_IDRT = i_MEMRD) or ((i_IDRT = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		i_WBdata when ((i_IDRT = i_WBRD) or ((i_IDRT = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		i_MEMmemd when (i_IDRT = i_MEMRT) and (i_MEMop = "100011") and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		i_WBmemd when (i_IDRT = i_WBRT) and (i_WBop = "100011") and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		i_WBjal when ((i_IDRT = "11111") and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011"))) and (i_WBop = "000011") else
		x"00000000";

  o_jr<=	i_EXjal when (i_IDRS = "11111") and ((i_EXop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else
		i_MEMjal when (i_IDRS = "11111") and ((i_MEMop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else
		i_WBjal when (i_IDRS = "11111") and ((i_WBop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else 
		i_EXdata when ((i_IDRS = i_EXRD) or ((i_IDRS = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		i_MEMdata when ((i_IDRS = i_MEMRD) or ((i_IDRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		i_WBdata when ((i_IDRS = i_WBRD) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		i_MEMmemd when (i_IDRS = i_MEMRT) and (i_MEMop = "100011") and(i_IDfun = "001000") and (i_IDRS /= "00000") else
		i_WBmemd when (i_IDRS = i_WBRT) and (i_WBop = "100011") and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		x"00000000";

  o_EXRS<= 	i_MEMdata when (((i_EXRS = i_MEMRD) and ((i_MEMop = "000000"))) or ((i_EXRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else
		i_WBdata when (((i_EXRS = i_WBRD) and ((i_WBop = "000000"))) or ((i_EXRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else 
		i_WBmemd when ((i_EXRS = i_WBRT) and (i_WBop = "100011")) and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else
		i_MEMjal when ((i_EXRS = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_MEMop = "000011") else
		i_WBjal when ((i_EXRS = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_WBop = "000011") else		
		x"00000001" when (i_EXop = "001111") or (i_EXfun = "001000") else
		x"00000000";

  o_EXRT<=	i_MEMdata when (((i_EXRT = i_MEMRD) and ((i_MEMop = "000000"))) or ((i_EXRT = i_MEMRT) and ((i_MEMop = "001000")or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		i_WBdata when (((i_EXRT = i_WBRD) and ((i_WBop = "000000"))) or ((i_EXRT = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		i_WBmemd when (i_EXRT = i_WBRT) and (i_WBop = "100011") and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		i_MEMjal when ((i_EXRT = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_MEMop = "000011") else
		i_WBjal when ((i_EXRT = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_WBop = "000011") else
		x"00000001" when (i_EXop = "001111") or (i_EXfun = "001000") else
		x"00000000";

  o_IDRSmux<=	'1' when (((i_IDRS = i_WBRD) and ((i_WBop = "000000"))) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and (((i_IDop = "000000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011")) and (i_IDRS /= "00000") else
		'1'when ((i_IDRS = i_WBRT) and (i_WBop = "100011")) and ((((i_IDop = "000000") and (i_IDfun /= "001000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011"))) and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = i_EXRD) or ((i_IDRS = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = i_MEMRD) or ((i_IDRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = i_WBRD) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else 
		'1' when (i_IDRS = i_MEMRT) and (i_MEMop = "100011") and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		'1' when (i_IDRS = i_WBRT) and (i_WBop = "100011") and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = "11111") and (((i_IDop = "000000") and ((i_IDfun /= "000000") and (i_IDfun /= "000010") and (i_IDfun /= "000011"))) or (i_IDop = "101011") or (i_IDop = "001000") or (i_IDop = "001001") or (i_IDop = "001100") or (i_IDop = "001110") or (i_IDop = "001101") or (i_IDop = "001010") or (i_IDop = "100011"))) and (i_WBop = "000011") else
		'0';

  o_IDRTmux<=	'1' when (((i_IDRT = i_WBRD) and ((i_WBop = "000000"))) or ((i_IDRT = i_WBRT) and ((i_WBop = "001000")or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011")) and (i_IDRT /= "00000") else
		'1' when (i_IDRT = i_WBRT) and (i_WBop = "100011") and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011")) and (i_IDRT /= "00000") else
		'1' when ((i_IDRT = i_EXRD) or ((i_IDRT = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		'1' when ((i_IDRT = i_MEMRD) or ((i_IDRT = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		'1' when ((i_IDRT = i_WBRD) or ((i_IDRT = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		'1' when (i_IDRT = i_MEMRT) and (i_MEMop = "100011") and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		'1' when (i_IDRT = i_WBRT) and (i_WBop = "100011") and((i_IDop = "000100") or (i_IDop = "000101")) and (i_IDRT /= "00000") else
		'1' when ((i_IDRT = "11111") and ((i_IDop = "000000") or (i_IDop = "101011") or (i_IDop = "100011"))) and (i_WBop = "000011") else
		'0';

  o_Jrmux<=	'1' when (i_IDRS = "11111") and ((i_EXop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else
		'1' when (i_IDRS = "11111") and ((i_MEMop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else
		'1' when (i_IDRS = "11111") and ((i_WBop = "000011") and (i_IDfun = "001000")) and (i_IDRS /= "00000") else 
		'1' when ((i_IDRS = i_EXRD) or ((i_IDRS = i_EXRT) and ((i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001111") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = i_MEMRD) or ((i_IDRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		'1' when ((i_IDRS = i_WBRD) or ((i_IDRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		'1' when (i_IDRS = i_MEMRT) and (i_MEMop = "100011") and(i_IDfun = "001000") and (i_IDRS /= "00000") else
		'1' when (i_IDRS = i_WBRT) and (i_WBop = "100011") and (i_IDfun = "001000") and (i_IDRS /= "00000") else
		'0';

  o_EXRSmux<= 	'1' when (((i_EXRS = i_MEMRD) and ((i_MEMop = "000000"))) or ((i_EXRS = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else
		'1' when (((i_EXRS = i_WBRD) and ((i_WBop = "000000"))) or ((i_EXRS = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else  
		'1' when (i_EXRS = i_WBRT) and (i_WBop = "100011") and ((((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_EXRS /= "00000") else
		'1' when ((i_EXRS = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_MEMop = "000011") else
		'1' when ((i_EXRS = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_WBop = "000011") else
		'0' when (i_EXop = "001111") or (i_EXfun = "001000") else
		'0';

  o_EXRTmux<=	'1' when (((i_EXRT = i_MEMRD) and ((i_MEMop = "000000"))) or ((i_EXRT = i_MEMRT) and ((i_MEMop = "001000") or (i_MEMop = "001001") or (i_MEMop = "001100") or (i_MEMop = "001111") or (i_MEMop = "001110") or (i_MEMop = "001101") or (i_MEMop = "001010")))) and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		'1' when (((i_EXRT = i_WBRD) and ((i_WBop = "000000"))) or ((i_EXRT = i_WBRT) and ((i_WBop = "001000") or (i_WBop = "001001") or (i_WBop = "001100") or (i_WBop = "001111") or (i_WBop = "001110") or (i_WBop = "001101") or (i_WBop = "001010")))) and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		'1' when (i_EXRT = i_WBRT) and (i_WBop = "100011") and ((i_EXop = "000000") or (i_EXop = "101011") or (i_EXop = "100011")) and (i_EXRT /= "00000") else
		'1' when ((i_EXRT = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_MEMop = "000011") else
		'1' when ((i_EXRT = "11111") and (((i_EXop = "000000") and ((i_EXfun /= "000000") and (i_EXfun /= "000010") and (i_EXfun /= "000011"))) or (i_EXop = "101011") or (i_EXop = "001000") or (i_EXop = "001001") or (i_EXop = "001100") or (i_EXop = "001110") or (i_EXop = "001101") or (i_EXop = "001010") or (i_EXop = "100011"))) and (i_WBop = "000011") else
		'0' when (i_EXop = "001111") or (i_EXfun = "001000") else
		'0';
end behavioral;