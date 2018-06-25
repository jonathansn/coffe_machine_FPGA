Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TB_uPD is
    Generic (
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16;
				p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000"; -- add
				p_SECOUND_WIDTH : INTEGER := 4 -- add
    );
end TB_uPD;

architecture Behavioral of TB_uPD is

	component uPD is
    Generic (
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16;
				p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000"; -- add
				p_SECOUND_WIDTH : INTEGER := 4 -- add
    );
    Port ( 
			i_CLK		: in  STD_LOGIC;
			i_RST		: in  STD_LOGIC;
			-- BUTTONS and SWITCHES
			i_PREPARE 	: 	in  STD_LOGIC;
			i_LOAD		:	in	 STD_LOGIC;
			i_CHOICE		: 	in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
			-- DISPLAY OUTPUT
			o_DIS0		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS1		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS2		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS3		:	out		STD_LOGIC_VECTOR(6 downto 0);
			teste	:	out STD_LOGIC_VECTOR(8 downto 0)
    );
end component;

signal  w_CLK : STD_LOGIC;
signal  w_RST : STD_LOGIC;
signal  w_PREPARE : STD_LOGIC;
signal  w_LOAD : STD_LOGIC;
signal  w_CHOICE : STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
signal  w_DIS0 : STD_LOGIC_VECTOR(6 downto 0);
signal  w_DIS1 : STD_LOGIC_VECTOR(6 downto 0);
signal  w_DIS2 : STD_LOGIC_VECTOR(6 downto 0);
signal  w_DIS3 : STD_LOGIC_VECTOR(6 downto 0);
signal  w_TESTE : STD_LOGIC_VECTOR(8 downto 0);

begin

  U_uPD : uPD
  generic map(
				p_ADD_WIDTH		   => p_ADD_WIDTH,
				p_DATA_WIDTH	   => p_DATA_WIDTH,
				p_SECOUND		     => p_SECOUND,
				p_SECOUND_WIDTH => p_SECOUND_WIDTH
    )
    port map( 
			i_CLK    		  =>  w_CLK,
			i_RST    		  =>  w_RST,
			-- BUTTONS and SWITCHES
			i_PREPARE    =>  w_PREPARE,
			i_LOAD    		 =>  w_LOAD,
			i_CHOICE    	=>  w_CHOICE,
			-- DISPLAY OUTPUT
			o_DIS0    		  =>  w_DIS0,
			o_DIS1    		  =>  w_DIS1,
			o_DIS2    		  =>  w_DIS2,
			o_DIS3    		  =>  w_DIS3,
			teste    		   =>  w_TESTE
    );
    
  PROCESS
  BEGIN
    w_CLK <= '0';
    WAIT FOR 20 NS;
    w_CLK <= '1';
    WAIT FOR 20 NS;
  END PROCESS;
  
  PROCESS
  BEGIN
    WAIT FOR 100 NS;
    w_RST <= '0';
    WAIT FOR 100 NS;
    w_RST <= '1';
    WAIT;
  END PROCESS;

end behavioral;