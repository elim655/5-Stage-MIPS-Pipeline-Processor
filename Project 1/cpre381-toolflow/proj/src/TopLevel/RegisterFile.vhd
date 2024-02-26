library IEEE;
use IEEE.std_logic_1164.all;

entity RegisterFile is

  port(i_CLK                    	: in std_logic;
   	i_D    	         	: in std_logic_vector(31 downto 0);
   	i_WS    	         	: in std_logic_vector(4 downto 0);
   	i_RST    	         	: in std_logic_vector(4 downto 0);
   	i_RSS                    	: in std_logic_vector(4 downto 0);
   	i_WE   		 	: in std_logic;
   	i_RESET   		 	: in std_logic;
   	o_RT    	         	: out std_logic_vector(31 downto 0);
   	o_RS    	         	: out std_logic_vector(31 downto 0));

end RegisterFile;

architecture structure of RegisterFile is
 component dec5t32 is
  port(i_S    : in std_logic_Vector(4 downto 0);
    i_regwrite	: in std_logic;
    o_O    : out std_logic_vector(31 downto 0));
 end component;

 component reg_N is
  port(i_CLK    : in std_logic;
    i_WE    : in std_logic;
    i_RST    : in std_logic;
    i_D    : in std_logic_vector(31 downto 0);
    o_Q    : out std_logic_vector(31 downto 0));
 end component;

 component mux32t1 is
  port(i_Data0   	 : in std_logic_Vector(31 downto 0);
    i_Data1   	 : in std_logic_Vector(31 downto 0);
    i_Data2   	 : in std_logic_Vector(31 downto 0);
    i_Data3   	 : in std_logic_Vector(31 downto 0);
    i_Data4   	 : in std_logic_Vector(31 downto 0);
    i_Data5   	 : in std_logic_Vector(31 downto 0);
    i_Data6   	 : in std_logic_Vector(31 downto 0);
    i_Data7   	 : in std_logic_Vector(31 downto 0);
    i_Data8   	 : in std_logic_Vector(31 downto 0);
    i_Data9   	 : in std_logic_Vector(31 downto 0);
    i_Data10    : in std_logic_Vector(31 downto 0);
    i_Data11    : in std_logic_Vector(31 downto 0);
    i_Data12    : in std_logic_Vector(31 downto 0);
    i_Data13    : in std_logic_Vector(31 downto 0);
    i_Data14    : in std_logic_Vector(31 downto 0);
    i_Data15    : in std_logic_Vector(31 downto 0);
    i_Data16    : in std_logic_Vector(31 downto 0);
    i_Data17    : in std_logic_Vector(31 downto 0);
    i_Data18    : in std_logic_Vector(31 downto 0);
    i_Data19    : in std_logic_Vector(31 downto 0);
    i_Data20    : in std_logic_Vector(31 downto 0);
    i_Data21    : in std_logic_Vector(31 downto 0);
    i_Data22    : in std_logic_Vector(31 downto 0);
    i_Data23    : in std_logic_Vector(31 downto 0);
    i_Data24    : in std_logic_Vector(31 downto 0);
    i_Data25    : in std_logic_Vector(31 downto 0);
    i_Data26    : in std_logic_Vector(31 downto 0);
    i_Data27    : in std_logic_Vector(31 downto 0);
    i_Data28    : in std_logic_Vector(31 downto 0);
    i_Data29    : in std_logic_Vector(31 downto 0);
    i_Data30    : in std_logic_Vector(31 downto 0);
    i_Data31    : in std_logic_Vector(31 downto 0);
    i_Select: in std_logic_Vector(4 downto 0);
    o_Out    : out std_logic_vector(31 downto 0));
 end component;
 
 Signal WriteEn: std_logic_vector(31 downto 0);
 Signal Data0: std_logic_vector(31 downto 0);
 Signal Data1: std_logic_vector(31 downto 0);
 Signal Data2: std_logic_vector(31 downto 0);
 Signal Data3: std_logic_vector(31 downto 0);
 Signal Data4: std_logic_vector(31 downto 0);
 Signal Data5: std_logic_vector(31 downto 0);
 Signal Data6: std_logic_vector(31 downto 0);
 Signal Data7: std_logic_vector(31 downto 0);
 Signal Data8: std_logic_vector(31 downto 0);
 Signal Data9: std_logic_vector(31 downto 0);
 Signal Data10: std_logic_vector(31 downto 0);
 Signal Data11: std_logic_vector(31 downto 0);
 Signal Data12: std_logic_vector(31 downto 0);
 Signal Data13: std_logic_vector(31 downto 0);
 Signal Data14: std_logic_vector(31 downto 0);
 Signal Data15: std_logic_vector(31 downto 0);
 Signal Data16: std_logic_vector(31 downto 0);
 Signal Data17: std_logic_vector(31 downto 0);
 Signal Data18: std_logic_vector(31 downto 0);
 Signal Data19: std_logic_vector(31 downto 0);
 Signal Data20: std_logic_vector(31 downto 0);
 Signal Data21: std_logic_vector(31 downto 0);
 Signal Data22: std_logic_vector(31 downto 0);
 Signal Data23: std_logic_vector(31 downto 0);
 Signal Data24: std_logic_vector(31 downto 0);
 Signal Data25: std_logic_vector(31 downto 0);
 Signal Data26: std_logic_vector(31 downto 0);
 Signal Data27: std_logic_vector(31 downto 0);
 Signal Data28: std_logic_vector(31 downto 0);
 Signal Data29: std_logic_vector(31 downto 0);
 Signal Data30: std_logic_vector(31 downto 0);
 Signal Data31: std_logic_vector(31 downto 0);

begin
 decode: dec5t32 port map(
    i_S    =>    i_WS,
    i_regwrite => i_WE,
    o_O    =>    WriteEn);

 reg0: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(0),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data0);

 reg1: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(1),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data1);

 reg2: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(2),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data2);

 reg3: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(3),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data3);

 reg4: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(4),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data4);

 reg5: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(5),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data5);

 reg6: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(6),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data6);

 reg7: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(7),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data7);

 reg8: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(8),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data8);

 reg9: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(9),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data9);

 reg10: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(10),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data10);

 reg11: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(11),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data11);

 reg12: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(12),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data12);

 reg13: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(13),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data13);

 reg14: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(14),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data14);

 reg15: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(15),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data15);

 reg16: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(16),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data16);

 reg17: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(17),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data17);

 reg18: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(18),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data18);

 reg19: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(19),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data19);

 reg20: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(20),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data20);

 reg21: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(21),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data21);

 reg22: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(22),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data22);

 reg23: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(23),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data23);

 reg24: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(24),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data24);

 reg25: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(25),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data25);

 reg26: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(26),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data26);

 reg27: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(27),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data27);

 reg28: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(28),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data28);

 reg29: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(29),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data29);

 reg30: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(30),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data30);

 reg31: Reg_N port map(
    i_CLK    =>    i_CLK,
    i_WE    =>    WriteEn(31),
    i_RST    =>    i_RESET,
    i_D    =>    i_D,
    o_Q    =>    Data31);

 muxA: mux32t1 port map(
    i_Data0   	 => Data0,
    i_Data1   	 => Data1,
    i_Data2   	 => Data2,
    i_Data3   	 => Data3,
    i_Data4   	 => Data4,
    i_Data5   	 => Data5,
    i_Data6   	 => Data6,
    i_Data7   	 => Data7,
    i_Data8   	 => Data8,
    i_Data9   	 => Data9,
    i_Data10    => Data10,
    i_Data11    => Data11,
    i_Data12    => Data12,
    i_Data13    => Data13,
    i_Data14    => Data14,
    i_Data15    => Data15,
    i_Data16    => Data16,
    i_Data17    => Data17,
    i_Data18    => Data18,
    i_Data19    => Data19,
    i_Data20    => Data20,
    i_Data21    => Data21,
    i_Data22    => Data22,
    i_Data23    => Data23,
    i_Data24    => Data24,
    i_Data25    => Data25,
    i_Data26    => Data26,
    i_Data27    => Data27,
    i_Data28    => Data28,
    i_Data29    => Data29,
    i_Data30    => Data30,
    i_Data31    => Data31,
    i_Select    => i_RSS,
    o_Out   	 => o_RS);

 muxB: mux32t1 port map(
    i_Data0   	 => Data0,
    i_Data1   	 => Data1,
    i_Data2   	 => Data2,
    i_Data3   	 => Data3,
    i_Data4   	 => Data4,
    i_Data5   	 => Data5,
    i_Data6   	 => Data6,
    i_Data7   	 => Data7,
    i_Data8   	 => Data8,
    i_Data9   	 => Data9,
    i_Data10    => Data10,
    i_Data11    => Data11,
    i_Data12    => Data12,
    i_Data13    => Data13,
    i_Data14    => Data14,
    i_Data15    => Data15,
    i_Data16    => Data16,
    i_Data17    => Data17,
    i_Data18    => Data18,
    i_Data19    => Data19,
    i_Data20    => Data20,
    i_Data21    => Data21,
    i_Data22    => Data22,
    i_Data23    => Data23,
    i_Data24    => Data24,
    i_Data25    => Data25,
    i_Data26    => Data26,
    i_Data27    => Data27,
    i_Data28    => Data28,
    i_Data29    => Data29,
    i_Data30    => Data30,
    i_Data31    => Data31,
    i_Select    => i_RST,
    o_Out   	 => o_RT);

end structure;

