library IEEE;
use IEEE.std_logic_1164.all;

entity flushandstall is
  port(i_comp_branch	: in std_logic;
       ID_EX_inst	: in std_logic_vector(31 downto 0);
       IF_ID_inst	: in std_logic_vector(31 downto 0);
       PC_WE		: out std_logic;
       IF_ID_we		: out std_logic;
       IF_ID_flush	: out std_logic;
       ID_EX_flush	: out std_logic);
end flushandstall;

architecture dataflow of flushandstall is

begin

--IF_ID_flush will go into the i_InstRst field of the IF_ID register, setting the Instruction to all 0's (Making it a NOOP)


--Flush whever there is jump or branch taken, i_comp_branch is output of comparator
IF_ID_flush <= '1' when ((i_comp_branch = '1') or (IF_ID_inst(31 downto 26) = "000010") or (IF_ID_inst(31 downto 26) = "000011") or ((IF_ID_inst(31 downto 26) = "000000") and (IF_ID_inst(5 downto 0) = "001000"))) else
		'0';


--Stall the pipeline whenever ID/EX register is lw instruction, and next instruction uses loaded value
--To stall pipeline, prevent update of PC and IF/ID register, and set ID/EX register to NOOP
IF_ID_we <= '0' when ((ID_EX_inst(31 downto 26) = "100011") and ((ID_EX_inst(20 downto 16) = IF_ID_inst(25 downto 21)) or (ID_EX_inst(20 downto 16) = IF_ID_inst(20 downto 16)))) else
    '1';

PC_WE <= '0' when ((ID_EX_inst(31 downto 26) = "100011") and ((ID_EX_inst(20 downto 16) = IF_ID_inst(25 downto 21)) or (ID_EX_inst(20 downto 16) = IF_ID_inst(20 downto 16)))) else
    '1';
--This line may cause a problem, as it sets the current lw instruction to a NOOP (in an attempt to insert a bubble)
ID_EX_flush <= '1' when ((ID_EX_inst(31 downto 26) = "100011") and ((ID_EX_inst(20 downto 16) = IF_ID_inst(25 downto 21)) or (ID_EX_inst(20 downto 16) = IF_ID_inst(20 downto 16)))) else
		'0';


end dataflow;