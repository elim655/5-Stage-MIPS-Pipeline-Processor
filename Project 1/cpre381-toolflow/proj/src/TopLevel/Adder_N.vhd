library IEEE;
use IEEE.std_logic_1164.all;

entity Adder_N is
  generic(N : integer := 16); 
   port(i_A         : in std_logic_vector(N-1 downto 0);
	i_B         : in std_logic_vector(N-1 downto 0);
	i_Cin       : in std_logic;
        o_S         : out std_logic_vector(N-1 downto 0);
	o_Cout	    : out std_logic);

end Adder_N;

architecture structure of Adder_N is
 component Adder is
   port(i_A         : in std_logic;
	i_B         : in std_logic;
	i_Cin       : in std_logic;
        o_S         : out std_logic;
	o_Cout      : out std_logic);
 end component;
 	
	signal Car : std_logic_vector(N downto 0);

 Begin
  Car(0) <= i_Cin;

  G_NBit_Adder: for i in 0 to N-1 generate
    DUT: Adder port map(
              i_A      	=> i_A(i),      
              i_B     	=> i_B(i),  
              i_Cin     => Car(i),  
              o_S      	=> o_S(i),  
              o_Cout    => Car(i+1)); 
  end generate G_NBit_Adder;
	
  o_Cout <= Car(N);
end structure;