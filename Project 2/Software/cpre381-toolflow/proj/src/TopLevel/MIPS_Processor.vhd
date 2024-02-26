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
  signal s_shf, s_alusrc, s_jr, s_memtoreg, s_jal, s_ext, s_regdst, s_branch, s_fetch : std_logic;
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

  --Signal for fetchmux
  signal s_fetchAddr : std_logic_vector(31 downto 0);

  --signal for jumpadd
  signal s_jadd : std_logic_vector(31 downto 0);

  --signal for brnchAdd
  signal s_badd : std_logic_vector(31 downto 0);

  --Signal for IF/ID
  signal s_IFpc4  : std_logic_vector(31 downto 0);

  --signal for ID/EX
  signal s_EXalusrc, s_EXmemtoreg, s_EXDMemWr, s_EXRegWr, s_EXregdst, s_EXbranch, 
         s_EXjal, s_EXshf, s_EXfetch, s_EXxor : std_logic;
  signal s_EXjump : std_logic_vector(1 downto 0);
  signal s_EXaluop : std_logic_vector(3 downto 0);
  signal s_EXRegWrAddr : std_logic_vector(4 downto 0);
  signal s_IDpc4, s_IDInst, s_EXpc4, s_EXInst, s_EXsignExt, s_EXRS, s_EXRT   : std_logic_vector(31 downto 0);

  --Signal for EX/MEM
  signal s_MEMjal, s_MEMmemtoreg, s_MEMRegWr, s_IDDMemWr, 
         s_MEMfetch, s_MEMxor  : std_logic;
  signal s_MEMjump : std_logic_vector(1 downto 0);
  signal s_MEMRegWrAddr : std_logic_vector(4 downto 0);
  signal s_MEMpc4, s_MEMaluout, s_MEMjadd, s_MEMbadd, s_MEMRS, s_MEMRT   : std_logic_vector(31 downto 0);

  --Signal for MEM/WB
  signal s_WBjal, s_WBmemtoreg, s_IDRegWr : std_logic;
  signal s_IDRegWrAddr : std_logic_vector(4 downto 0);
  signal s_WBDMemOut, s_WBaluout, s_WBpc4 : std_logic_vector(31 downto 0);

  component ALU is
    port(i_A 		            : in std_logic_vector(31 downto 0);
         i_B 		            : in std_logic_vector(31 downto 0);
         i_AluOp                    : in std_logic_vector(3 downto 0);
         o_OF 		            : out std_logic;
         o_ZERO                     : out std_logic;
         o_O			    : out std_logic_vector(31 downto 0));
  end component;

  --Update inputs/outputs as necessary
  component PCandAdd is
   port(i_CLK	: in std_logic;
	i_RST	: in std_logic;
	i_addr	: in std_logic_vector(31 downto 0);
	i_fetch : in std_logic;
	i_xor	: in std_logic;
	o_pc4	: out std_logic_vector(31 downto 0);
	o_pc	: out std_logic_vector(31 downto 0));
  end component;

  component jumpAdd is
   port(i_immed	: in std_logic_vector(25 downto 0);
	i_pc4	: in std_logic_vector(3 downto 0);
	o_jadd	: out std_logic_vector(31 downto 0));
  end component;

  component brnchAdd is
   port(i_immed	: in std_logic_vector(31 downto 0);
	i_pc4	: in std_logic_vector(31 downto 0);
	o_badd	: out std_logic_vector(31 downto 0));
  end component;

  component fetchmux is
   port(i_jr	: in std_logic_vector(31 downto 0);
	i_jadd	: in std_logic_vector(31 downto 0);
	i_badd	: in std_logic_vector(31 downto 0);
	i_xor	: in std_logic;
	i_nxtad	: in std_logic_vector(1 downto 0);
	o_addr	: out std_logic_vector(31 downto 0));
  end component;

  component reg_IF_ID is
  port(i_CLK        : in std_logic;  
    i_RST        : in std_logic;
    i_WE         : in std_logic;    
    i_PC	     : in std_logic_vector(31 downto 0);
    i_Inst	     : in std_logic_vector(31 downto 0);   
    o_PC         : out std_logic_vector(31 downto 0);
    o_Inst	     : out std_logic_vector(31 downto 0));
  end component;

  component reg_ID_EX is
  port(i_CLK       			                            : in std_logic;  
    i_RST        			                            : in std_logic;
    i_WE         			                            : in std_logic;
    i_ALUSrc, i_MemtoReg, i_DMemWr, i_RegWr, i_RegDst,
    i_branch, i_jal, i_Shf, i_fetch                              : in std_logic;
    i_nxtad                                             : in std_logic_vector(1 downto 0);
    i_Alucon				                            : in std_logic_vector(3 downto 0); 
    i_WrAdd						                        : in std_logic_vector(4 downto 0);
    i_read1, i_read2			                        : in std_logic_vector(31 downto 0);
    i_signExt, i_PC, i_Inst			                    : in std_logic_vector(31 downto 0);
    o_ALUSrc, o_MemtoReg, o_DMemWr, o_RegWr, o_RegDst,
    o_branch, o_jal, o_Shf, o_fetch                              : out std_logic; 
    o_nxtad                                             : out std_logic_vector(1 downto 0);
    o_Alucon				                            : out std_logic_vector(3 downto 0); 
    o_WrAdd						                        : out std_logic_vector(4 downto 0);
    o_read1, o_read2			                        : out std_logic_vector(31 downto 0);
    o_signExt, o_PC, o_Inst			                    : out std_logic_vector(31 downto 0)); 
    end component;

  component reg_EX_MEM is
  port(i_CLK       			                : in std_logic;  
  i_RST        			                : in std_logic;
  i_WE         			                : in std_logic;
  i_jal, i_MemtoReg, i_RegWr, i_DMemWr, i_fetch, i_XOR    : in std_logic;
  i_nxtad                                 : in std_logic_vector(1 downto 0);    
  i_ALUout			                    : in std_logic_vector(31 downto 0);
  i_WrAdd						            : in std_logic_vector(4 downto 0);
  i_Read2	     			                : in std_logic_vector(31 downto 0);
  i_JumpAdd, i_BranchAdd, i_JrAdd	     			: in std_logic_vector(31 downto 0);
  i_PC 	                                : in std_logic_vector(31 downto 0);
  o_jal, o_MemtoReg, o_RegWr, o_DMemWr, o_fetch, o_XOR    : out std_logic; 
  o_nxtad                                 : out std_logic_vector(1 downto 0);
  o_ALUout        		                : out std_logic_vector(31 downto 0);
  o_WrAdd						            : out std_logic_vector(4 downto 0);
  o_Read2	     			                : out std_logic_vector(31 downto 0);
  o_JumpAdd, o_BranchAdd, o_JrAdd	     			: out std_logic_vector(31 downto 0);
  o_PC 	                                : out std_logic_vector(31 downto 0));   
  end component;

  component reg_MEM_WB is
  port(i_CLK       			                : in std_logic;  
    i_RST        			                : in std_logic;
    i_WE         			                : in std_logic;
    i_jal, i_MemtoReg, i_RegWrite	        : in std_logic;
    i_DMEMout, i_ALUout, i_PC			    : in std_logic_vector(31 downto 0);
    i_WrAdd						            : in std_logic_vector(4 downto 0);
    o_jal, o_MemtoReg, o_RegWrite	        : out std_logic;
    o_DMEMout, o_ALUout, o_PC			    : out std_logic_vector(31 downto 0);
    o_WrAdd						            : out std_logic_vector(4 downto 0));
  end component;

  component CntLogic is
   port(i_Opco	: in std_logic_vector(5 downto 0);
	i_Funco	: in std_logic_vector(5 downto 0);
	o_ALUSrc: out std_logic;
	o_Alucon: out std_logic_vector(3 downto 0);
	o_MemtoReg: out std_logic;
	o_DMemWr: out std_logic;
	o_RegWr	: out std_logic;
	o_RegDst: out std_logic;
	o_nxtad	: out std_logic_vector(1 downto 0);
	o_branch: out std_logic;
	o_jr	: out std_logic;
	o_jal	: out std_logic;
	o_shf	: out std_logic;
	o_ext	: out std_logic;
	o_fetch : out std_logic);
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

  component brnch is
    port(i_brnch        : in std_logic;
         i_zero         : in std_logic;
         i_op	        : in std_logic_vector(5 downto 0);
	 o_brnch	: out std_logic);
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

  PC_adder : PCandAdd
    port MAP(i_CLK => iCLK,
             i_RST => iRST,
             i_addr => s_fetchAddr,
             i_fetch => s_MEMfetch,
             i_xor => s_MEMxor,
             o_pc4 => s_IFpc4,
             o_pc => s_NextInstAddr);

  regIF_ID : reg_IF_ID
    port MAP(i_CLK => iCLK,
             i_RST => iRST,
             i_WE => '1',
             i_PC => s_IFpc4,
             i_Inst => s_Inst,
             o_PC => s_IDpc4,
             o_Inst => s_IDInst);
  
  g_RegisterFile: RegisterFile
    port MAP(i_CLK => iCLK,
             i_D   => s_RegWrData, 
             i_WS   => s_RegWrAddr, 
             i_RST  => s_IDInst(20 downto 16),
             i_RSS  => s_IDInst(25 downto 21),
             i_WE   => s_RegWr,
             i_RESET => iRST,
             o_RT   => s_RT,
             o_RS   => s_RS);
  
  control: CntLogic
    port MAP(i_Opco => s_IDInst(31 downto 26), 
            i_Funco => s_IDInst(5 downto 0),
            o_ALUSrc  => s_alusrc,
            o_Alucon   => s_aluop,
            o_MemtoReg   => s_memtoreg,
            o_DMemWr  =>  s_IDDMemWr,
            o_RegWr   => s_IDRegWr,
            o_RegDst   => s_regdst,
            o_nxtad  =>  s_jump, 
            o_branch => s_branch,
            o_jr	=> s_jr,
            o_jal	=> s_jal,
            o_shf	=> s_shf,
            o_ext => s_ext,
            o_fetch => s_fetch);

  signExtender: extender
  port MAP(i_IM => s_IDInst(15 downto 0),
            i_S  => s_ext,
            o_O  => s_signExt);

  regwrite2: mux2t1_5
  port MAP(i_S  => s_jal,
            i_D0 => s_IDInst(15 downto 11),
            i_D1 => "11111",
            o_O  => s_regMux2);
  
  regwrite1: mux2t1_5
  port MAP(i_S  => s_regdst,
            i_D0 => s_IDInst(20 downto 16),
            i_D1 => s_regMux2,
            o_O  => s_IDRegWrAddr);

  regID_EX : reg_ID_EX
    port MAP(i_CLK => iCLK,
             i_RST => iRST,
             i_WE => '1',
             i_ALUSrc => s_alusrc,
             i_MemtoReg => s_memtoreg,
             i_DMemWr => s_IDDMemWr,
             i_RegWr => s_IDRegWr,
             i_RegDST => s_regdst,
             i_branch => s_branch,
             i_jal => s_jal,
             i_Shf => s_shf,
             i_fetch => s_fetch,
             i_nxtad => s_jump,
             i_Alucon => s_aluop,
             i_WrAdd => s_IDRegWrAddr,
             i_read1 => s_RS,
             i_read2 => s_RT,
             i_signExt => s_signExt,
             i_PC => s_IDpc4,
             i_Inst => s_IDInst,
             o_ALUSrc => s_EXalusrc,
             o_MemtoReg => s_EXmemtoreg,
             o_DMemWr => s_EXDMemWr,
             o_RegWr => s_EXRegWr,
             o_RegDST => s_EXregdst,
             o_branch => s_EXbranch,
             o_jal => s_EXjal,
             o_Shf => s_EXshf,
             o_fetch => s_EXfetch,
             o_nxtad => s_EXjump,
             o_Alucon => s_EXaluop,
             o_WrAdd => s_EXRegWrAddr,
             o_read1 => s_EXRS,
             o_read2 => s_EXRT,
             o_signExt => s_EXsignExt,
             o_PC => s_EXpc4,
             o_Inst => s_EXInst);

  jump : jumpAdd
  port MAP(i_immed => s_EXInst(25 downto 0),
            i_pc4 => s_EXpc4(31 downto 28),
            o_jadd => s_jadd);

  branch : brnchAdd
  port MAP(i_immed => s_EXsignExt,
           i_pc4 => s_EXpc4,
           o_badd => s_badd);

  brnchlog : brnch
   port MAP(i_brnch => s_EXbranch,
            i_zero => s_zeroflag,
            i_op => s_EXInst(31 downto 26),
	    o_brnch => s_EXxor);
  
  AluRead1: mux2t1_N
    port MAP(i_S  => s_EXshf,
	     i_D0 => s_EXRS,
    	     i_D1 => s_EXInst,
	     o_O  => s_alu1);

  AluRead2: mux2t1_N
    port MAP(i_S  => s_EXalusrc,
	     i_D0 => s_EXRT,
    	     i_D1 => s_EXsignExt,
	     o_O  => s_alu2);


  g_ALU: ALU
    port MAP(i_A => s_alu1,
             i_B   => s_alu2,
             i_AluOP   => s_EXaluop,
             o_OF  => s_Ovfl,
             o_ZERO  => s_zeroflag,
             o_O   => s_aluout);
   oALUOut<= s_aluout; 

  regEx_Mem : reg_EX_MEM
    port MAP(i_CLK => iCLK,
             i_RST => iRST,
             i_WE => '1',
             i_jal => s_EXjal,
             i_MemtoReg => s_EXmemtoreg,
             i_RegWr => s_EXRegWr,
             i_DMemWr => s_EXDMemWr,
             i_fetch => s_EXfetch,
             i_XOR => s_EXxor,
             i_nxtad => s_EXjump,
             i_ALUout => s_aluout,
             i_WrAdd => s_EXRegWrAddr,
             i_Read2 => s_EXRT,
             i_JumpAdd => s_jadd,
             i_BranchAdd => s_badd,
             i_JrAdd => s_EXRS,
             i_PC => s_EXpc4,
             o_jal => s_MEMjal,
             o_MemtoReg => s_MEMmemtoreg,
             o_RegWr => s_MEMRegWr,
             o_DMemWr => s_DMemWr,
             o_fetch => s_MEMfetch,
             o_XOR => s_MEMxor,
             o_nxtad => s_MEMjump,
             o_ALUout => s_MEMaluout,
             o_WrAdd => s_MEMRegWrAddr,
             o_Read2 => s_MEMRT,
             o_JumpAdd => s_MEMjadd,
             o_BranchAdd => s_MEMbadd,
             o_JrAdd => s_MEMRS,
             o_PC => s_MEMpc4);

  s_DMemAddr <= s_MEMaluout;
  s_DMemData <= s_MEMRT;

  fetch : fetchmux
    port MAP(i_jr => s_MEMRS,
             i_jadd => s_MEMjadd,
             i_badd => s_MEMbadd,
             i_xor => s_MEMxor,
             i_nxtad => s_MEMjump,
             o_addr => s_fetchAddr);

  regMem_Wb : reg_MEM_WB
    port MAP(i_CLK => iCLK,
             i_RST => iRST,
             i_WE => '1',
             i_jal => s_MEMjal,
             i_MemtoReg => s_MEMmemtoreg,
             i_RegWrite => s_MEMRegWr,
             i_DMEMout => s_DMemOut,
             i_ALUout => s_MEMaluout,
             i_PC => s_MEMpc4,
             i_WrAdd => s_MEMRegWrAddr,
             o_jal => s_WBjal,
             o_MemtoReg => s_WBmemtoreg,
             o_RegWrite => s_RegWr,
             o_DMEMout => s_WBDMemOut,
             o_ALUout => s_WBaluout,
             o_PC => s_WBpc4,
             o_WrAdd => s_RegWrAddr);
  
  MemOut: mux2t1_N
    port MAP(i_S  => s_WBmemtoreg,
	           i_D0 => s_WBaluout,
    	       i_D1 => s_WBDMemOut,
	           o_O  => s_wb);

  regwrite: mux2t1_N
    port MAP(i_S  => s_WBjal,
	           i_D0 => s_wb,
    	       i_D1 => s_WBpc4,
	           o_O  => s_RegWrData);

end structure;

