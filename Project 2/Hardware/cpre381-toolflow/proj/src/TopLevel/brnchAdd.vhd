library IEEE;
use IEEE.std_logic_1164.all;

entity brnchAdd is
   port(i_immed	: in std_logic_vector(31 downto 0);
	i_pc4	: in std_logic_vector(31 downto 0);
	o_badd	: out std_logic_vector(31 downto 0));
end brnchAdd;

architecture mixed of brnchAdd is
  component adder_N
  generic(N : integer := 32); 
   port(i_A         : in std_logic_vector(N-1 downto 0);
	i_B         : in std_logic_vector(N-1 downto 0);
	i_Cin       : in std_logic;
        o_S         : out std_logic_vector(N-1 downto 0);
	o_Cout	    : out std_logic);
 end component;

 signal s_badd	: std_logic_vector(31 downto 0);

 begin
  s_badd <= i_immed(29 downto 0) & "00";

    Add: Adder_N port map(
  	i_A	=> 	i_pc4,
	i_B 	=> 	s_badd,
	i_Cin	=> 	'0',
	o_S	=> 	o_badd,
	o_Cout	=> 	open);
end mixed;