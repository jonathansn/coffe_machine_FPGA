library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 
ENTITY TB_LIFO IS
	 Generic(
	 		p_DATA_WIDTH   : INTEGER := 16;        -- Número de bits dos dados. 
	 		p_ADD_WIDTH    : INTEGER := 9         -- Número de bits dos endereços. 
	 );
END TB_LIFO;
 
ARCHITECTURE behavior OF TB_LIFO IS 

	
	COMPONENT LIFO is
	 Generic(
	 		p_DATA_WIDTH   : INTEGER := 16;        -- Número de bits dos dados. 
	 		p_ADD_WIDTH    : INTEGER := 9         -- Número de bits dos endereços. 
	 );
     Port ( 
		  i_CLK 	: in  STD_LOGIC;
		  i_RST   	: in  STD_LOGIC;
		  i_RD 		: in  STD_LOGIC;
		  i_WR 		: in  STD_LOGIC;
		  i_DATA  	: in  STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		  o_DATA  	: out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
	 );
	end COMPONENT;
	
	signal i_CLK		: STD_LOGIC;
	signal i_RST		: STD_LOGIC;
	signal i_WR 		: STD_LOGIC;
	signal i_RD 		: STD_LOGIC;
	signal i_DATA    	: STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	signal o_DATA		: STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	
   -- Clock period definitions
   --constant i_CLK_period : time := 10 ns;
 
BEGIN
 
	UUT :  LIFO 
	 Generic Map (
					p_DATA_WIDTH   => 16, 
					p_ADD_WIDTH    => 6        
	 )
     Port Map ( 
				  i_CLK 	=> i_CLK,
				  i_RST   	=> i_RST,
				  i_RD 		=> i_RD,
				  i_WR 		=> i_WR,
				  i_DATA  	=> i_DATA,
				  o_DATA  	=> o_DATA
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
		WAIT FOR 100 ns;
		i_RST <= '1';
		wait for 20 ns;
		i_RST <= '0';
		wait;
   end process;
 
	PROCESS 
    BEGIN
		WAIT FOR 300 NS;
		i_DATA <= x"1111";
		i_WR   <= '1';
		wait for 10 ns;
		i_WR   <= '0';
		wait for 40 ns;
		
		i_DATA <= x"2222";
		i_WR   <= '1';
		wait for 10 ns;
		i_WR   <= '0';
		wait for 40 ns;
		
		i_DATA <= x"3333";
		i_WR   <= '1';
		wait for 10 ns;
		i_WR   <= '0';
		wait for 40 ns;
		
		i_RD   <= '1';
		wait for 10 ns;
		i_RD   <= '0';
		wait for 40 ns;
		
		i_RD   <= '1';
		wait for 10 ns;
		i_RD   <= '0';
		wait for 40 ns;
		
		i_RD   <= '1';
		wait for 10 ns;
		i_RD   <= '0';
		wait for 40 ns;
		
		i_RD   <= '1';
		wait for 10 ns;
		i_RD   <= '0';
		wait for 40 ns;
		
		wait;
	END PROCESS;

----------------------------------------------------------------------------------
END;
