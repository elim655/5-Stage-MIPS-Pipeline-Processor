library IEEE;
use IEEE.std_logic_1164.all;


entity mux2t1 is
 port( i_D0		            : in std_logic;
       i_D1		            : in std_logic;
       i_S		            : in std_logic;
       o_O 		            : out std_logic);

end mux2t1;

architecture structure of mux2t1 is
  --List Components

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

  component invg
    port(i_A          : in std_logic;
       o_F          : out std_logic);

  end component;

  --List signals if needed

  -- Signal to carry negated select
  signal s_N         : std_logic;
  -- Signals to carry output of and gates
  signal s_A1, s_A2   : std_logic;

begin

  g_Not: invg
    port MAP(i_A               => i_S,
             o_F              => s_N);

  g_And1: andg2
    port MAP(i_A               => s_N,
             i_B              => i_D0,
	     o_F	      => s_A1);

  g_And2: andg2
    port MAP(i_A               => i_S,
             i_B              => i_D1,
	     o_F	      => s_A2);

  g_Or: org2
    port MAP(i_A               => s_A1,
             i_B              => s_A2,
	     o_F	      => o_O);

end structure;


    
