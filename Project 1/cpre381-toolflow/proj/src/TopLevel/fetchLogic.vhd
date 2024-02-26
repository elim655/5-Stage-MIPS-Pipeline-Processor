library IEEE;
use IEEE.std_logic_1164.all;

entity fetchLogic is
   port(i_Jimmed	: in std_logic_vector(25 downto 0);
	i_Bimmed	: in std_logic_vector(31 downto 0);
	i_jr		: in std_logic_vector(31 downto 0);
	i_branch	: in std_logic;
	i_zero		: in std_logic;
	i_CLK		: in std_logic;
	i_RST		: in std_logic;
	i_AddrMux	: in std_logic_vector(1 downto 0);
	o_pc		: out std_logic_vector(31 downto 0); 
	o_jalAdd	: out std_logic_vector(31 downto 0));
end fetchLogic;

architecture mixed of fetchLogic is
 component PCandAdd is
   port(i_CLK	: in std_logic;
	i_RST	: in std_logic;
	i_addr	: in std_logic_vector(31 downto 0);
	o_pc4	: out std_logic_vector(31 downto 0);
	o_pc	: out std_logic_vector(31 downto 0));
 end component;

 component brnchAdd
   port(i_immed	: in std_logic_vector(31 downto 0);
	i_pc4	: in std_logic_vector(31 downto 0);
	o_badd	: out std_logic_vector(31 downto 0));
 end component;

 component jumpAdd
   port(i_immed	: in std_logic_vector(25 downto 0);
	i_pc4	: in std_logic_vector(3 downto 0);
	o_jadd	: out std_logic_vector(31 downto 0));
 end component;

 signal bmuxc	: std_logic;
 signal bmux	: std_logic_vector(31 downto 0);
 signal pc4	: std_logic_vector(31 downto 0);
 signal badd	: std_logic_vector(31 downto 0);
 signal jadd	: std_logic_vector(31 downto 0);
 signal addr	: std_logic_vector(31 downto 0);

 begin
  pc: PCandAdd port map(
	i_CLK	=>	i_CLK,
	i_RST	=>	i_RST,
	i_addr	=>	addr,
	o_pc4	=>	pc4,
	o_pc	=>	o_pc);

  brch: brnchAdd port map(
  	i_immed	=> 	i_Bimmed,
	i_pc4 	=> 	pc4,
	o_badd	=> 	badd);

  jump: jumpAdd port map(
  	i_immed	=> 	i_Jimmed,
	i_pc4 	=> 	pc4(31 downto 28),
	o_jadd	=> 	jadd);

  bmuxc	<= i_zero xor i_branch;
  
  bmux	<= badd when bmuxc = '1' else
	   pc4;

  addr	<= jadd when i_AddrMux = "01" else
	   bmux when i_AddrMux = "10" else
	   i_jr when i_AddrMux = "11" else
	   pc4;

  o_jaladd <= pc4;
end mixed;