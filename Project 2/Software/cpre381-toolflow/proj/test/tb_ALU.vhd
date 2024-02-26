library IEEE;
use IEEE.std_logic_1164.all;
use work.bus_array_type.all;

entity tb_ALU is
  generic(gCLK_HPER   : time := 50 ns);
end tb_ALU;

architecture behavior of tb_ALU is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component ALU
     port(i_A 		            : in std_logic_vector(31 downto 0);
          i_B 		            : in std_logic_vector(31 downto 0);
          i_AluOp                   : in std_logic_vector(3 downto 0);
          o_OF 		            : out std_logic;
          o_ZERO                    : out std_logic;
          o_O			    : out std_logic_vector(31 downto 0));
  end component;

  -- Temporary signals
  signal s_CLK, s_OF, s_ZERO  : std_logic;
  signal s_A, s_B, s_O : std_logic_vector(31 downto 0);
  signal s_AluOp : std_logic_vector(3 downto 0);

begin

  DUT: ALU 
  port map(i_A       => s_A, 
           i_B       => s_B,
           i_AluOp   => s_AluOp,
           o_OF      => s_OF,
	   o_ZERO    => s_ZERO,
	   o_O       => s_O);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin

    --Add, no overflow
    s_A       <= X"0000000A";
    s_B       <= X"0000000F";
    s_AluOp   <= "0000";
    wait for cCLK_PER;

    --Add with overflow
    s_A       <= X"0F00000A";
    s_B       <= X"0F00000F";
    s_AluOp   <= "0000";
    wait for cCLK_PER;

    --Addu, no overflow should occur
    s_A       <= X"F000000A";
    s_B       <= X"F000000F";
    s_AluOp   <= "0000";
    wait for cCLK_PER;

    --NOR
    s_A       <= X"F070700A";
    s_B       <= X"F0F0000F";
    s_AluOp   <= "0011";
    wait for cCLK_PER;

    --XOR
    s_A       <= X"F0F0F0F0";
    s_B       <= X"F000000F";
    s_AluOp   <= "0100";
    wait for cCLK_PER;

    --OR
    s_A       <= X"F0F0F0F0";
    s_B       <= X"FF00FF00";
    s_AluOp   <= "0101";
    wait for cCLK_PER;

    --SLT, Output should be 1
    s_A       <= X"0FFFFFFF";
    s_B       <= X"8FFFFFFF";
    s_AluOp   <= "0110";
    wait for cCLK_PER;

    --SLT, Output should be 1
    s_A       <= X"FFFFFFF7";
    s_B       <= X"00000000";
    s_AluOp   <= "0110";
    wait for cCLK_PER;

    --SLT, Output should be 0
    s_A       <= X"0FFFFFFF";
    s_B       <= X"0000000F";
    s_AluOp   <= "0110";
    wait for cCLK_PER;

    --SLT, Output should be 0
    s_A       <= X"00000001";
    s_B       <= X"FFFFFFF0";
    s_AluOp   <= "0110";
    wait for cCLK_PER;

    --SLL (s_A(10-6) is SHAMT), shift 3
    s_A       <= X"000000C0";
    s_B       <= X"00000003";
    s_AluOp   <= "0111";
    wait for cCLK_PER;

    --SRL, Shift right 3
    s_A       <= X"000000C0";
    s_B       <= X"00000003";
    s_AluOp   <= "1000";
    wait for cCLK_PER;

    --SRL, Shift right 3
    --Shifting -16, should turn to large positive number 
    s_A       <= X"000000C0";
    s_B       <= X"FFFFFFF0";
    s_AluOp   <= "1000";
    wait for cCLK_PER;

    --SRA, Shift right 3
    --Shifting -16, should become -2
    s_A       <= X"000000C0";
    s_B       <= X"FFFFFFF0";
    s_AluOp   <= "1001";
    wait for cCLK_PER;

    --SUB, 12 - 5 =7
    s_A       <= X"0000000C";
    s_B       <= X"00000005";
    s_AluOp   <= "1010";
    wait for cCLK_PER;

    --SUB, 50 - 50 = 0
    --Zero flag
    s_A       <= X"00000032";
    s_B       <= X"00000032";
    s_AluOp   <= "1010";
    wait for cCLK_PER;

    --SUB, -8 - -16 = 8
    s_A       <= X"FFFFFFF8";
    s_B       <= X"FFFFFFF0";
    s_AluOp   <= "1010";
    wait for cCLK_PER;

    --SUB, Overflow
    s_A       <= X"80000001";
    s_B       <= X"80000001";
    s_AluOp   <= "1010";
    wait for cCLK_PER;

    --SUBU, No Overflow
    s_A       <= X"80000001";
    s_B       <= X"80000001";
    s_AluOp   <= "1011";
    wait for cCLK_PER;

    --LUI
    s_A       <= X"00000001";
    s_B       <= X"80000001";  --Don't care
    s_AluOp   <= "1100";
    wait for cCLK_PER;




    wait;
  end process;
  
end behavior;