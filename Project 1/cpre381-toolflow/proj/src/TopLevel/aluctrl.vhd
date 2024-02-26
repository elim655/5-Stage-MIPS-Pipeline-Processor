library IEEE;
use IEEE.std_logic_1164.all;

entity aluctrl is

  port(i_AluOp           : in std_logic_vector(3 downto 0);
       o_AddSub          : out std_logic;
       o_Ofen            : out std_logic;
       o_Dir             : out std_logic;
       o_Mode            : out std_logic;
       o_C0              : out std_logic;
       o_C1              : out std_logic;
       o_C2              : out std_logic);
end aluctrl;

architecture behavior of aluctrl is
begin

	with i_AluOp select
		o_AddSub <= '1' when "0110",
		'1' when "1010",
		'1' when "1101",
		'1' when "1011",
		'0' when others;

	with i_AluOp select
		o_Ofen <= '1' when "0000",
		'1' when "0110",
		'1' when "1010",
		'0' when others;

	with i_AluOp select
		o_Dir <= '1' when "0111",
		'0' when others;

	with i_AluOp select
		o_Mode <= '1' when "1001",
		'0' when others;

	with i_AluOp select
		o_C0 <= '1' when "0100",
		'1' when "0101",
		'1' when "0110",
		'1' when "0111",
		'1' when "1000",
		'1' when "1001",
		'0' when others;

	with i_AluOp select
		o_C1 <= '1' when "0011",
		'1' when "0100",
		'1' when "0110",
		'1' when "1100",
		'0' when others;

	with i_AluOp select
		o_C2 <= '1' when "0000",
		'1' when "0001",
		'1' when "0110",
		'1' when "0111",
		'1' when "1000",
		'1' when "1001",
		'1' when "1010",
		'1' when "1011",
		'1' when "1100",
		'1' when "1101",
		'0' when others;

  
end behavior;
