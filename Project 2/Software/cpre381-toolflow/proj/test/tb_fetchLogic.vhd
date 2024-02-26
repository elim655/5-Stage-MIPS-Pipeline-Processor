library IEEE;
use IEEE.std_logic_1164.all;

entity tb_fetchLogic is
  generic(gCLK_HPER   : time := 25 ns);
end tb_fetchLogic;

architecture behavior of tb_fetchLogic is
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component fetchLogic
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
  end component;

  signal s_CLK, s_RST, s_zero, s_branch	: std_logic;
  signal s_jalAdd, s_jr, s_Bimmed, s_pc 	: std_logic_vector(31 downto 0);
  signal s_AddrMux	: std_logic_vector(1 downto 0);
  signal s_Jimmed	: std_logic_vector(25 downto 0);

 begin

  DUT: fetchLogic 
  port map(i_Jimmed 	=> s_Jimmed, 
           i_Bimmed 	=> s_Bimmed,
           i_jr		=> s_jr,
           i_branch	=> s_branch,
	   i_zero	=> s_zero,
	   i_CLK 	=> s_CLK, 
           i_RST 	=> s_RST,
           i_AddrMux	=> s_AddrMux,
	   o_pc		=> s_pc,
           o_jalAdd	=> s_jalAdd);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

  P_TB: process
  begin
    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '0';
    s_zero	<= '0';
    s_AddrMux	<= "00";
    s_RST 	<= '1';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '0';
    s_zero	<= '0';
    s_AddrMux	<= "00";
    s_RST 	<= '0';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '0';
    s_zero	<= '0';
    s_AddrMux	<= "01";
    s_RST 	<= '0';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '0';
    s_zero	<= '1';
    s_AddrMux	<= "10";
    s_RST 	<= '0';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '1';
    s_zero	<= '0';
    s_AddrMux	<= "10";
    s_RST 	<= '0';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '1';
    s_zero	<= '1';
    s_AddrMux	<= "10";
    s_RST 	<= '0';
    wait for cCLK_PER;

    s_Jimmed	<= "00000000000000000000000010";
    s_Bimmed	<= x"00000001";
    s_jr	<= x"00000000";
    s_branch	<= '1';
    s_zero	<= '1';
    s_AddrMux	<= "11";
    s_RST 	<= '0';
    wait for cCLK_PER;
 end process;
end behavior;