-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

  --New signals:

  --Signals for RS and RT outputs of register file
  signal s_RS, s_RT: std_logic_vector(31 downto 0);

  --Signal for read select RS of register file
  signal s_reg1 : std_logic_vector(4 downto 0);

  --Signals for output of control logic
  signal s_shf, s_alusrc, s_jr, s_memtoreg, s_jal, s_ext, s_regdst, s_branch : std_logic;
  signal s_aluop : std_logic_vector(3 downto 0);
  signal s_jump : std_logic_vector(1 downto 0);

  --Signals for ALU
  signal s_alu1, s_alu2, s_aluout : std_logic_vector(31 downto 0);
  signal s_zeroflag : std_logic;

  --Signal for output of sign extender
  signal s_signExt : std_logic_vector(31 downto 0);

  --Signal for output of MemtoReg MUX
  signal s_wb : std_logic_vector(31 downto 0);

  --Signals for Fetch Logic
  signal s_jalAdd : std_logic_vector(31 downto 0);

  --Signal that holds value between register write MUXs
  signal s_regMux2 : std_logic_vector(4 downto 0);

  component ALU is
    port(i_A 		            : in std_logic_vector(31 downto 0);
         i_B 		            : in std_logic_vector(31 downto 0);
         i_AluOp                    : in std_logic_vector(3 downto 0);
         o_OF 		            : out std_logic;
         o_ZERO                     : out std_logic;
         o_O			    : out std_logic_vector(31 downto 0));
  end component;

  --Update inputs/outputs as necessary
  component fetchLogic is
    port(i_Jimmed	: in std_logic_vector(25 downto 0);
	 i_Bimmed	: in std_logic_vector(31 downto 0);
	 i_jr		: in std_logic_vector(31 downto 0);
	 i_branch	: in std_logic;
	 i_zero		: in std_logic;
	 i_CLK		: in std_logic;
	 i_RST		: in std_logic;
	 i_AddrMux	: in std_logic_vector(1 downto 0);
	 o_pc		: out std_logic_vector(31 downto 0); 
	 o_jalAdd	: out std_logic_vector(31 downto 0));
  end component;

  component CntLogic is
    port(i_Opco		: in std_logic_vector(5 downto 0);
	 i_Funco	: in std_logic_vector(5 downto 0);
	 o_ALUSrc	: out std_logic;
	 o_Alucon	: out std_logic_vector(3 downto 0);
	 o_MemtoReg	: out std_logic;
	 o_DMemWr	: out std_logic;
	 o_RegWr	: out std_logic;
	 o_RegDst	: out std_logic;
	 o_nxtad	: out std_logic_vector(1 downto 0);
	 o_branch	: out std_logic;
	 o_jr		: out std_logic;
	 o_jal		: out std_logic;
	 o_shf		: out std_logic;
	 o_ext		: out std_logic);
  end component;

  component RegisterFile is
    port(i_CLK                      : in std_logic;
         i_D 		            : in std_logic_vector(31 downto 0);
         i_WS 		            : in std_logic_vector(4 downto 0);
         i_RST 		            : in std_logic_vector(4 downto 0);
         i_RSS                      : in std_logic_vector(4 downto 0);
         i_WE			    : in std_logic;
         i_RESET		    : in std_logic;
         o_RT 		            : out std_logic_vector(31 downto 0);
         o_RS 		            : out std_logic_vector(31 downto 0));
  end component;

  component mux2t1_N is
    generic(N : integer := 32);
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;

  component mux2t1_5 is
    generic(N : integer := 5);
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;

  component extender is
    port(i_IM              : in std_logic_vector(15 downto 0);
         i_S		   : in std_logic;
         o_O               : out std_logic_vector(31 downto 0));
  end component;



begin

  s_Halt <= '1' when s_Inst(31 downto 26) = "010100" else 
  '0';

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

  
  regread1: mux2t1_5
    port MAP(i_S  => s_jr,
	           i_D0 => s_Inst(25 downto 21),
    	       i_D1 => s_Inst(25 downto 21),
	           o_O  => s_reg1);

  g_RegisterFile: RegisterFile
    port MAP(i_CLK => iCLK,
             i_D   => s_RegWrData,
             i_WS   => s_RegWrAddr,
             i_RST  => s_Inst(20 downto 16),
             i_RSS  => s_reg1,
             i_WE   => s_RegWr,
             i_RESET => iRST,
             o_RT   => s_RT,
             o_RS   => s_RS);
  s_DMemData <= s_RT;
  

 
  AluRead1: mux2t1_N
    port MAP(i_S  => s_shf,
	     i_D0 => s_RS,
    	     i_D1 => s_Inst,
	     o_O  => s_alu1);

  AluRead2: mux2t1_N
    port MAP(i_S  => s_alusrc,
	     i_D0 => s_RT,
    	     i_D1 => s_signExt,
	     o_O  => s_alu2);


  g_ALU: ALU
    port MAP(i_A => s_alu1,
             i_B   => s_alu2,
             i_AluOP   => s_aluop,
             o_OF  => s_Ovfl,
             o_ZERO  => s_zeroflag,
             o_O   => s_aluout);
   oALUOut<= s_aluout; 
  s_DMemAddr <= s_aluout;

  MemOut: mux2t1_N
    port MAP(i_S  => s_memtoreg,
	           i_D0 => s_aluout,
    	       i_D1 => s_DMemOut,
	           o_O  => s_wb);

  regwrite: mux2t1_N
    port MAP(i_S  => s_jal,
	           i_D0 => s_wb,
    	       i_D1 => s_jalAdd,
	           o_O  => s_RegWrData);

  signExtender: extender
    port MAP(i_IM => s_Inst(15 downto 0),
             i_S  => s_ext,
             o_O  => s_signExt);

  regwrite1: mux2t1_5
    port MAP(i_S  => s_regdst,
	           i_D0 => s_Inst(20 downto 16),
    	       i_D1 => s_regMux2,
	           o_O  => s_RegWrAddr);

  regwrite2: mux2t1_5
    port MAP(i_S  => s_jal,
	           i_D0 => s_Inst(15 downto 11),
    	       i_D1 => "11111",
	           o_O  => s_regMux2);


  fetch: fetchLogic
    port MAP(i_Jimmed	=> s_Inst(25 downto 0),
	           i_Bimmed	=> s_signExt,
	           i_jr	=> s_RS,
	           i_branch	=> s_branch,
	           i_zero	=> s_zeroflag,
	           i_CLK	=> iCLK,
	           i_RST	=> iRST,
	           i_AddrMux	=> s_jump,
	           o_pc		=> s_NextInstAddr,
	           o_jalAdd => s_jalAdd);

  control: CntLogic
     port MAP(i_Opco => s_Inst(31 downto 26), 
              i_Funco => s_Inst(5 downto 0),
              o_ALUSrc  => s_alusrc,
              o_Alucon   => s_aluop,
              o_MemtoReg   => s_memtoreg,
              o_DMemWr  =>  s_DMemWr,
              o_RegWr   => s_RegWr,
              o_RegDst   => s_regdst,
              o_nxtad  =>  s_jump, --
	            o_branch => s_branch,
              o_jr	=> s_jr,
	            o_jal	=> s_jal,
	            o_shf	=> s_shf,
	            o_ext => s_ext);

end structure;

