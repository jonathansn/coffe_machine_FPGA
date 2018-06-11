library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 
ENTITY TB_MOTE IS
    Generic (
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16
    );
END TB_MOTE;
 
ARCHITECTURE behavior OF TB_MOTE IS 

	
	COMPONENT MOTE is
    Generic (
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16
    );
    Port ( 
				i_CLK		: in  STD_LOGIC;
				i_RST		: in  STD_LOGIC;			

				o_WR_IO    	: out STD_LOGIC;
				o_RD_IO		: out STD_LOGIC;				
				i_DATA_IO	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_DATA_IO	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_ADDR_IO   : out STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);

				i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				o_BUSY      : out STD_LOGIC						
    );
	end COMPONENT;
	
	signal i_CLK		: STD_LOGIC;
	signal i_RST		: STD_LOGIC;
	signal i_DATA_IO  	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal o_DATA_IO	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal o_ADDR_IO   	: STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);
	signal o_WR_IO    	: STD_LOGIC;
	signal o_RD_IO		: STD_LOGIC;	

	signal i_INT0		: STD_LOGIC;	
	signal i_INT1		: STD_LOGIC;	
	signal i_INT2		: STD_LOGIC;	
	signal o_BUSY		: STD_LOGIC;	
    signal i_INT		: STD_LOGIC_VECTOR(5 DOWNTO 0);
	-- Clock period definitions
   --constant i_CLK_period : time := 10 ns;
 
BEGIN
 
	UUT : MOTE port map
     ( 
				i_CLK		=> i_CLK,			
				i_RST		=> i_RST,
				o_WR_IO     => o_WR_IO,
				o_RD_IO     => o_RD_IO,
				i_DATA_IO	=> i_DATA_IO,
				o_DATA_IO	=> o_DATA_IO,
				o_ADDR_IO	=> o_ADDR_IO,
				i_INT		=> i_INT,
				o_BUSY		=> o_BUSY
	 );
 
 
  
   process
   begin
		i_CLK <= '0';
		wait for 5 ns;
		i_CLK <= '1';
		wait for 5 ns;
   end process;
 
   process
   begin
		WAIT FOR 200 ns;
		i_RST <= '1';
		wait for 20 ns;
		i_RST <= '0';
		wait;
   end process;
 
   process
   begin
		wait for 200 ns;
		i_DATA_IO <= "0000000000010001";
--		i_DATA_IO <= x"55AA";		
--		WAIT FOR 100 NS;
--		i_INT0 <= '0';
--		i_INT1 <= '1';
--		i_INT2 <= '0';
--		WAIT FOR 40 NS;
--		i_INT1 <= '0';
		
		wait;
   end process;


----------------------------------------------------------------------------------
END;
