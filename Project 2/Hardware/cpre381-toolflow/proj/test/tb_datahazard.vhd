library IEEE;
use IEEE.std_logic_1164.all;

entity tb_datahazard is
end tb_datahazard;

architecture mixed of tb_datahazard is
 component datahazard
   port(i_EXop		: in std_logic_Vector(5 downto 0);
	i_MEMop		: in std_logic_Vector(5 downto 0);
	i_WBop		: in std_logic_Vector(5 downto 0);
	i_EXRD		: in std_logic_Vector(4 downto 0);
	i_MEMRD       	: in std_logic_Vector(4 downto 0);
        i_WBRD         	: in std_logic_Vector(4 downto 0);
	i_IDRT      	: in std_logic_Vector(4 downto 0);
	i_IDRS		: in std_logic_Vector(4 downto 0);
	i_EXRT		: in std_logic_Vector(4 downto 0);
	i_EXRS		: in std_logic_Vector(4 downto 0);
	i_EXdata	: in std_logic_Vector(31 downto 0);
	i_EXjal		: in std_logic_Vector(31 downto 0);
	i_MEMdata	: in std_logic_Vector(31 downto 0);
	i_MEMmemd	: in std_logic_Vector(31 downto 0);
	i_MEMjal	: in std_logic_Vector(31 downto 0);
	i_WBdata	: in std_logic_Vector(31 downto 0);
	i_WBmemd	: in std_logic_Vector(31 downto 0);
	i_WBjal		: in std_logic_Vector(31 downto 0);
	o_ID		: out std_logic_Vector(31 downto 0);
	o_EX		: out std_logic_Vector(31 downto 0));
end component;

   signal s_EXop, s_MEMop, s_WBop : std_logic_vector(5 downto 0);
   signal s_EXRD, s_MEMRD, s_WBRD, s_IDRT, s_IDRS, s_EXRT, s_EXRS: std_logic_vector(4 downto 0);
   signal s_EXdata, s_EXjal, s_MEMdata, s_MEMmemd, s_MEMjal, s_WBdata, s_WBmemd, s_WBjal, s_ID, s_EX: std_logic_vector(31 downto 0);

begin

 DUT0: datahazard
  port map(i_EXop => s_EXop,
	  i_MEMop => s_MEMop,
	  i_WBop => s_WBop,
	  i_EXRD => s_EXRD,
	  i_MEMRD => s_MEMRD,
          i_WBRD => s_WBRD,
	  i_IDRT => s_IDRT,
	  i_IDRS => s_IDRS,
	  i_EXRT => s_EXRT,
	  i_EXRS => s_EXRS,
	  i_EXdata => s_EXdata,
	  i_EXjal => s_EXjal,
	  i_MEMdata => s_MEMdata,
	  i_MEMmemd => s_MEMmemd,
	  i_MEMjal => s_MEMjal,
	  i_WBdata => s_WBdata,
	  i_WBmemd => s_WBmemd,
	  i_WBjal => s_WBjal,
	  o_ID => s_ID,
	  o_EX => s_EX);
  

 P_TEST_CASES: process
  begin
   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "000000";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00001";
   s_IDRS <= "00110";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000000";
   s_MEMop <= "000101";
   s_WBop <= "000000";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00010";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "000100";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00011";
   s_IDRS <= "00110";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "100011";
   s_WBop <= "000000";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00010";
   s_IDRS <= "00110";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "100011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00011";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000011";
   s_MEMop <= "000000";
   s_WBop <= "100011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00001";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "000011";
   s_WBop <= "100011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00010";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;
   
   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "000011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00011";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "000011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00111";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "000000";
   s_WBop <= "001111";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00111";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;

   s_EXop <= "000100";
   s_MEMop <= "001010";
   s_WBop <= "000011";
   s_EXRD <= "00001";
   s_MEMRD <= "00010";
   s_WBRD <= "00011";
   s_IDRT <= "00110";
   s_IDRS <= "00111";
   s_EXRT <= "00100";
   s_EXRS <= "00101";
   s_EXdata <= x"00000008";
   s_EXjal <= x"00000001";
   s_MEMdata <= x"00000002";
   s_MEMmemd <= x"00000003";
   s_MEMjal <= x"00000004";
   s_WBdata <= x"00000005";
   s_WBmemd <= x"00000006";
   s_WBjal <= x"00000007";
   wait for 50 ns;
 end process;
end mixed;