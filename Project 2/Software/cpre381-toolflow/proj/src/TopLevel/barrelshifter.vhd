library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrelshifter is
  port (
	i_DATA : in std_logic_vector(31 downto 0);
	i_shamt : in std_logic_vector(4 downto 0);
	i_DIR : in std_logic; -- 0: right 1: left
	i_MODE : in std_logic; -- 0: logical 1: arithmetic
	o_F : out std_logic_vector(31 downto 0)
  );
end barrelshifter;

architecture dataflow of barrelshifter is
begin
  process(i_DATA, i_shamt, i_DIR, i_MODE)
	variable s_count : integer;
	variable s_newData : std_logic_vector(31 downto 0);
	variable s_zeros : std_logic_vector(31 downto 0) := (others => '0');
	variable s_ones : std_logic_vector(31 downto 0) := (others => '1');
  begin
	s_newData := (others => '0'); -- Initialize s_newData with all s_zeros
    
	-- Logical Right Shift
	if i_DIR = '0' and i_MODE = '0' then
	logic_data : for k in 0 to 31 loop
      s_count := (k + to_integer(unsigned(i_shamt)));
      if ((s_count) > 31) then
   	 s_newData(k) := '0';
      else
     		 s_newData(k) := i_DATA(s_count);
      end if;
    end loop logic_data;
    
	-- Logical Left Shift
	elsif i_DIR = '1' and i_MODE = '0' then
     	leftShift_data : for k in 31 downto 0 loop
    s_count := (k-to_integer(unsigned(i_shamt)));
    if ((s_count)<0) then
   	 s_newData(k) := '0';
    	else
   		 s_newData(k) := i_DATA(s_count);
    end if;
 	end loop leftShift_data;
    
	-- Arithmetic Right Shift
	elsif i_DIR = '0' and i_MODE = '1' then
   	 arith_data : for k in 0 to 31 loop
      s_count := (k+to_integer(unsigned(i_shamt)));
      	if ((s_count)>31) then
   	 s_newData(k) := i_DATA(31);
      else
     	 s_newData(k) := i_DATA(s_count);
      end if;
     	 
    end loop arith_data;
    
	-- Arithmetic Left Shift
	elsif i_DIR = '1' and i_MODE = '1' then
	leftShift_data2 : for k in 31 downto 0 loop
    s_count := (k-to_integer(unsigned(i_shamt)));
    if ((s_count)<0) then
   	 s_newData(k) := '0';
    	else
   		 s_newData(k) := i_DATA(s_count);
    end if;
 	end loop leftShift_data2;
	end if;
    
	o_F <= s_newData;
  end process;
end dataflow;





