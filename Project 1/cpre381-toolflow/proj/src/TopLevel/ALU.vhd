library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is

  -- With this design, there are no defined ouptut signals
  -- If needed, the two register output buses can be added as outputs in order to read the register file
  port(i_A 		            : in std_logic_vector(31 downto 0);
       i_B 		            : in std_logic_vector(31 downto 0);
       i_AluOp                      : in std_logic_vector(3 downto 0);
       o_OF 		            : out std_logic;
       o_ZERO                       : out std_logic;
       o_O			    : out std_logic_vector(31 downto 0));

end ALU;

architecture structure of ALU is
  
  --Describe Components
  component aluctrl
    port(i_AluOp           : in std_logic_vector(3 downto 0);
         o_AddSub          : out std_logic;
         o_Ofen            : out std_logic;
         o_Dir             : out std_logic;
         o_Mode            : out std_logic;
         o_C0              : out std_logic;
         o_C1              : out std_logic;
         o_C2              : out std_logic);
  end component;

  component and32
     port(i_A          : in std_logic_vector(31 downto 0);
          i_B          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

  component or32
     port(i_A          : in std_logic_vector(31 downto 0);
          i_B          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

  component nor32
     port(i_A          : in std_logic_vector(31 downto 0);
          i_B          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

  component xor32
     port(i_A          : in std_logic_vector(31 downto 0);
          i_B          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

  component lui
     port(i_A          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

  component mux2t1_N
    port(i_S		            : in std_logic;
	 i_D0 			    : in std_logic_vector(31 downto 0);
         i_D1 			    : in std_logic_vector(31 downto 0);
         o_O		            : out std_logic_vector(31 downto 0));
  end component;

  component AddSub
     port(i_C			    : in std_logic;
          i_iA		            : in std_logic_vector(31 downto 0);
          i_iB			    : in std_logic_vector(31 downto 0);
          o_Oout 		    : out std_logic_vector(31 downto 0);
          o_Cout		    : out std_logic;
	  o_Cout30		    : out std_logic);
  end component;

  component barrelshifter
    port (
    i_DATA : in std_logic_vector(31 downto 0);
    i_shamt : in std_logic_vector(4 downto 0);
    i_DIR : in std_logic; -- 0: right 1: left
    i_MODE : in std_logic; -- 0: logical 1: arithmetic
    o_F : out std_logic_vector(31 downto 0)
  );
  end component;

  component comp
     port(i_A          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic_vector(31 downto 0));
  end component;

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

  component nor32to1
     port(i_A          : in std_logic_vector(31 downto 0);
          o_F          : out std_logic);
  end component;

  

  --Signals
  
  --Component Signals
  signal s_AND, s_OR, s_NOR, s_XOR, s_LU, s_ADD, s_SHIFT, s_COMP : std_logic_vector(31 downto 0);
  
  --Mux Signals
  signal s_M0, s_M1, s_M2, s_M3, s_M4, s_M5 : std_logic_vector(31 downto 0);

  --Control Signals
  signal s_AddSub, s_OFEN, s_DIR, s_MODE, s_C0, s_C1, s_C2 : std_logic;

  --Misc
  signal s_COUT, s_COUT30, s_XOR1 : std_logic;
  

begin
 
--Bitwise Operators
  --Step 1: 
  g_and32: and32
    port MAP(i_A             => i_A,
      	     i_B	     => i_B,
             o_F 	     => s_AND);

  --Step 2:
  g_or32: or32
    port MAP(i_A             => i_A,
      	     i_B	     => i_B,
             o_F 	     => s_OR);

  --Step 3:
  g_nor32: nor32
    port MAP(i_A             => i_A,
      	     i_B	     => i_B,
             o_F 	     => s_NOR);

  --Step 4:
  g_xor32: xor32
    port MAP(i_A             => i_A,
      	     i_B	     => i_B,
             o_F 	     => s_XOR);

  --Step 5:
  g_lui: lui
    port MAP(i_A             => i_B,
             o_F 	     => s_LU);

--ALUCTRL
  --Step 6:
  g_aluctrl: aluctrl
    port MAP(i_AluOp         => i_AluOp,
	     o_AddSub        => s_AddSub,
             o_Ofen          => s_OFEN,
      	     o_Dir           => s_DIR,
             o_Mode          => s_MODE,
             o_C0            => s_C0,
             o_C1            => s_C1,
             o_C2            => s_C2);

--Add/Shift
  --Step 7:
  g_adder: AddSub
    port MAP(i_iA            => i_A,
	     i_iB            => i_B,
	     i_C             => s_AddSub,
             o_Oout          => s_ADD,
      	     o_Cout          => s_COUT,
	     o_Cout30	     => s_COUT30);

  --Step 8:
  g_shifter: barrelshifter
   port MAP(i_DATA          => i_B,
	    i_shamt         => i_A(10 downto 6),
	    i_DIR           => s_DIR,
            i_MODE          => s_MODE,
      	    o_F             => s_SHIFT); 

--Compare
  --Step 9:
  g_comp: comp
    port MAP(i_A             => s_ADD,
      	     o_F             => s_COMP); 

--MUX for output
  --Step 10:
  g_mux0: mux2t1_N
    port MAP(i_S            => s_C0,
	     i_D0           => s_AND,
	     i_D1           => s_OR,
             o_O            => s_M0);

  --Step 11:
  g_mux1: mux2t1_N
    port MAP(i_S            => s_C0,
	     i_D0           => s_NOR,
	     i_D1           => s_XOR,
             o_O            => s_M1);

  --Step 12:
  g_mux2: mux2t1_N
    port MAP(i_S            => s_C0,
	     i_D0           => s_ADD,
	     i_D1           => s_SHIFT,
             o_O            => s_M2);

  --Step 13:
  g_mux3: mux2t1_N
    port MAP(i_S            => s_C0,
	     i_D0           => s_LU,
	     i_D1           => s_COMP,
             o_O            => s_M3);

  --Step 14:
  g_mux4: mux2t1_N
    port MAP(i_S            => s_C1,
	     i_D0           => s_M0,
	     i_D1           => s_M1,
             o_O            => s_M4);

  --Step 15:
  g_mux5: mux2t1_N
    port MAP(i_S            => s_C1,
	     i_D0           => s_M2,
	     i_D1           => s_M3,
             o_O            => s_M5);

  --Step 16:
  g_mux6: mux2t1_N
    port MAP(i_S            => s_C2,
	     i_D0           => s_M4,
	     i_D1           => s_M5,
             o_O            => o_O);

--Overflow flag
  --Step 17:
  g_xor1: xorg2
    port MAP(i_A            => s_COUT30,
	     i_B            => s_COUT,
	     o_F            => s_XOR1);

  --Step 18:
  g_and1: andg2
    port MAP(i_A            => s_XOR1,
	     i_B            => s_OFEN,
	     o_F            => o_OF);

--Zero flag
  --Step 19:
  g_nor32to1: nor32to1
    port MAP(i_A            => s_ADD,
	     o_F            => o_ZERO);



  end structure;
