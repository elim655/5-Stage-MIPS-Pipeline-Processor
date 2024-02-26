library IEEE;
use IEEE.std_logic_1164.all;

entity PCandAdd is
   port(i_CLK	: in std_logic;
	i_RST	: in std_logic;
	i_addr	: in std_logic_vector(31 downto 0);
	i_fetch : in std_logic;
	i_xor	: in std_logic;
	o_pc4	: out std_logic_vector(31 downto 0);
	o_pc	: out std_logic_vector(31 downto 0));
end PCandAdd;

architecture mixed of PCandAdd is
 component newdff is
   port(i_CLK        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;
       i_D          : in std_logic_vector(31 downto 0);
       o_Q          : out std_logic_vector(31 downto 0));
 end component;

 component adder_N
  generic(N : integer := 32); 
   port(i_A         : in std_logic_vector(N-1 downto 0);
	i_B         : in std_logic_vector(N-1 downto 0);
	i_Cin       : in std_logic;
        o_S         : out std_logic_vector(N-1 downto 0);
	o_Cout	    : out std_logic);
 end component;

 signal Sout	: std_logic_vector(31 downto 0);
 signal Qout	: std_logic_vector(31 downto 0);
 signal mux_o	: std_logic_vector(31 downto 0);


 begin
  Reg: newdff port map(
	i_CLK	=>	i_CLK,
	i_WE	=>	'1',
	i_RST	=>	i_RST,
	i_D	=>	mux_o,
	o_Q	=>	Qout);

  Add: Adder_N port map(
  	i_A	=> 	Qout,
	i_B 	=> 	x"00000004",
	i_Cin	=> 	'0',
	o_S	=> 	Sout,
	o_Cout	=> 	open);
	
	o_pc4 <= Sout;
	
	mux_o <= i_addr when i_fetch = '1' or i_xor = '1' else
		 Sout;

	o_pc <= Qout;
end mixed;
