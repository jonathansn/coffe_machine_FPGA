library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 
ENTITY TB_PROCESSADOR IS
END TB_PROCESSADOR;
 
ARCHITECTURE behavior OF TB_PROCESSADOR IS 

	
	COMPONENT PROCESSADOR is
		 Port ( 
					i_CLK				: in  STD_LOGIC;
					i_RST				: in  STD_LOGIC;
					
					i_DATA_ROM		: in  STD_LOGIC_VECTOR(15 DOWNTO 0);	  
					o_ADD_ROM		: out STD_LOGIC_VECTOR(5 DOWNTO 0);
					
					i_DATA_IO		: in  STD_LOGIC_VECTOR(15 DOWNTO 0);
					o_DATA_IO		: out STD_LOGIC_VECTOR(15 DOWNTO 0)
		 );
	end COMPONENT;
	
	signal w_CLK		: STD_LOGIC;
	signal w_RST		: STD_LOGIC;
	signal w_DATA_ROM : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal w_ADD_ROM	: STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal w_DIN_IO	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal w_DOUT_IO	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
   -- Clock period definitions
   --constant i_CLK_period : time := 10 ns;
 
BEGIN
 
	UUT : PROCESSADOR port map
     ( 
				i_CLK			=> w_CLK,			
				i_RST			=> w_RST,
				i_DATA_ROM	=> w_DATA_ROM,
				o_ADD_ROM	=> w_ADD_ROM,
				i_DATA_IO   => w_DIN_IO,
				o_DATA_IO   => w_DOUT_IO
	 );
 
 
  
   process
   begin
		w_CLK <= '0';
		wait for 5 ns;
		w_CLK <= '1';
		wait for 5 ns;
   end process;
 
   process
   begin
		WAIT FOR 100 ns;
		w_RST <= '1';
		wait for 20 ns;
		w_RST <= '0';
		wait;
   end process;
 
 
	process
	begin
		wait for 100 ns;
		wait until (w_ADD_ROM = x"000"); 
		w_DATA_ROM <= x"1402";
		wait until (w_ADD_ROM = x"001"); 
		w_DATA_ROM <= x"1803";
		wait until (w_ADD_ROM = x"002"); 
		w_DATA_ROM <= x"2180";
		wait until (w_ADD_ROM = x"003"); 
		w_DATA_ROM <= x"4000";
	 
		wait until (w_ADD_ROM = x"004"); 
		w_DATA_ROM <= x"0000";
	   
		wait;
	end process;
	


----------------------------------------------------------------------------------
END;
