library IEEE;
use IEEE.std_logic_1164.all;

entity AddSub is
 generic(N : integer := 32);
 port( i_C			    : in std_logic;
       i_iA		            : in std_logic_vector(N-1 downto 0);
       i_iB			    : in std_logic_vector(N-1 downto 0);
       o_Oout 		            : out std_logic_vector(N-1 downto 0);
       o_Cout			    : out std_logic;
       o_Cout30			    : out std_logic);

end AddSub;

architecture structure of AddSub is
  --List Components

  component nAdder is
    generic(N : integer := 32);
    port(i_Cin			    : in std_logic;
         i_A		            : in std_logic_vector(N-1 downto 0);
         i_B			    : in std_logic_vector(N-1 downto 0);
         o_O 		            : out std_logic_vector(N-1 downto 0);
         o_Cout			    : out std_logic;
         oC30			    : out std_logic);
  end component;

  component OnesComp is
    generic(N : integer := 32);
    port(i_A		            : in std_logic_vector(N-1 downto 0);
         o_O 		            : out std_logic_vector(N-1 downto 0));

  end component;

  component mux2t1_N is
    generic(N : integer := 32);
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;
    
  signal s_BInv : std_logic_vector(31 downto 0);
  signal s_Mux  : std_logic_vector(31 downto 0);

begin

  --Step 1
  	g_Negate: OnesComp port MAP(
		i_A               => i_iB,	
		o_O               => s_BInv);

  --Step 2
  	g_Mux: mux2t1_N port MAP(
  		i_S               => i_C,	
		i_D0              => i_iB,
  		i_D1              => s_BInv,
  		o_O               => s_Mux);

  --Step 3
  	g_Adder: nAdder port MAP(
  		i_Cin             => i_C,	
		i_A               => i_iA,
  		i_B               => s_Mux,
  		o_O               => o_Oout,
  		o_Cout            => o_Cout,
		oC30	          => o_Cout30);

 
end structure;