library IEEE;
use IEEE.std_logic_1164.all;


entity AdderStructural is

  port(iA                           : in std_logic;
       iB 		            : in std_logic;
       iC 		            : in std_logic;
       oS 		            : out std_logic;
       oC                           : out std_logic);

end AdderStructural;

architecture structure of AdderStructural is
  
  -- Describe the component entities
  component xorg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  component andg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  component org2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;


  -- Signal to carry Xor output
  signal s_Xor         : std_logic;
  -- Signals to carry output of and gates
  signal s_And1, s_And2   : std_logic;
  
begin

  ---------------------------------------------------------------------------
  -- Level 0
  ---------------------------------------------------------------------------
 
  g_Xor1: xorg2
    port MAP(i_A               => iA,
             i_B               => iB,
             o_F               => s_Xor);

  g_And1: andg2
    port MAP(i_A               => iA,
             i_B               => iB,
             o_F               => s_And1);


  ---------------------------------------------------------------------------
  -- Level 1
  ---------------------------------------------------------------------------
  
  g_Xor2: xorg2
    port MAP(i_A               => s_Xor,
             i_B               => iC,
             o_F               => oS);

  g_And2: andg2
    port MAP(i_A               => s_Xor,
             i_B               => iC,
             o_F               => s_And2);

    
  ---------------------------------------------------------------------------
  -- Level 2
  ---------------------------------------------------------------------------
  g_Or1: org2
    port MAP(i_A               => s_And2,
             i_B               => s_And1,
             o_F               => oC);
    

  end structure;