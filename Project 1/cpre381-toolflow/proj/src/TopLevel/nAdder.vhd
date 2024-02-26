library IEEE;
use IEEE.std_logic_1164.all;

entity nAdder is
 generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
 port( i_Cin			    : in std_logic;
       i_A		            : in std_logic_vector(N-1 downto 0);
       i_B			    : in std_logic_vector(N-1 downto 0);
       o_O 		            : out std_logic_vector(N-1 downto 0);
       o_Cout			    : out std_logic;
       oC30			    : out std_logic);

end nAdder;

architecture structure of nAdder is
  --List Components

  component AdderStructural is
    port(iA                          : in std_logic;
         iB 		             : in std_logic;
         iC 		             : in std_logic;
         oS 		             : out std_logic;
         oC                          : out std_logic);

  end component;

     signal carry : std_logic_vector(32 downto 0);

begin

  carry(0)		     <= i_Cin;

  G_NBit_ADD: for i in 0 to 31 generate
      g_nAdder: AdderStructural port MAP(
  	    iA               => i_A(i),
	    iB		     => i_B(i),
	    iC		     => carry(i),
	    oC		     => carry(i+1),
            oS               => o_O(i));

  end generate G_NBit_ADD;

  o_Cout <= carry(32);
  oC30   <= carry(31);		

  

end structure;