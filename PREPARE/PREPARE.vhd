--
--	Title: 	Prepare
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

------------------------------ ENTITY -------------------------------

entity PREPARE is
	generic(
		p_DATA_WIDTH	: INTEGER := 16;
		p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000";
		p_SECOUND_WIDTH : INTEGER := 4
    );
	port(
		-- GENERAL
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
		i_DATA		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		o_DATA		:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_CHOICE		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_PREPARE	:	in		STD_LOGIC;
		i_LOAD		:	in		STD_LOGIC;
		o_LOAD		:	out	STD_LOGIC;
		o_DONE		:	out	STD_LOGIC;
		o_PREPARE	:	out	STD_LOGIC;
		-- DISPLAY
		o_DIS0		:	out	STD_LOGIC_VECTOR(6 downto 0);
		o_DIS1		:	out	STD_LOGIC_VECTOR(6 downto 0);
		o_DIS2		:	out	STD_LOGIC_VECTOR(6 downto 0);
		o_DIS3		:	out	STD_LOGIC_VECTOR(6 downto 0);
		-- WR and RD Control
		i_WR			:	in		STD_LOGIC
	);
end PREPARE;

architecture Behavior of PREPARE is

------------------------------ COMPONENTS -------------------------------

	-- COUNTER
	component COUNTER is
		generic (
			p_DATA_WIDTH	: 	INTEGER := 16;
			p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000";
			p_SECOUND_WIDTH : INTEGER := 4
		 );
		port(
			i_CLK		:	in		STD_LOGIC;
			i_RST		:	in		STD_LOGIC;
			i_START	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_TIME	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		
			o_DONE	:	out	STD_LOGIC
		);
	end component;

	-- CHOICES
	component CHOICES is
		generic (
			p_DATA_WIDTH	: 	INTEGER := 16
		);
		port(
			-- GENERAL
			i_CLK 		: 	in 	STD_LOGIC;
			i_CLR 		: 	in 	STD_LOGIC;
			-- REGISTER
			i_D   		: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_LE  		: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			o_Q   		: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			-- INTERRUPT
			i_PREPARE 	: 	in 	STD_LOGIC;
			i_LOAD		:	in		STD_LOGIC;
			o_PREPARE 	: 	out 	STD_LOGIC;
			o_LOAD		:	out	STD_LOGIC
		);
	end component;
	
	-- COUPLERS
	component COUPLER0 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER1 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER2 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER3 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER4 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER5 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER6 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component COUPLER7 is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			--i_PRE 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	-- DEMUX1x4
	component DEMUX1x4 is
		generic(
			p_DATA_WIDTH	: INTEGER := 16
		);
		port (
			i_SEL : in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-8) downto 0);
			i_X 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y0 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y1 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y2 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y3 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y4 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y5 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y6 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y7 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	-- BCD
	component BCD is
		generic(
			p_DATA_WIDTH	: INTEGER := 16
		);
		port(
			i_BIN			:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			o_DEC			:	out	STD_LOGIC_VECTOR(6 downto 0)
		);
	end component;
	
	-- FF_SR
	component FF_SR is
		Port (
			o_Q 	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			-- Data output
			i_CLK : in 	STD_LOGIC;      												-- Clock input
			i_CLR : in 	STD_LOGIC;  													-- Asyn clear input
			i_D 	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);    	-- Data input
			i_PRE : in 	STD_LOGIC   	 												-- Asyn set input
		);
	end component;
	
------------------------------ SIGNALS -------------------------------
	
	-- COUNTER		
	signal w_START	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_START	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_TIME	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_TIME	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	-- CHOICES
	signal w_LE  	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_LE  	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_Q   	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	-- BCD
	signal w_BIN0   : 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_BIN0   : 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_BIN1  	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_BIN1   : 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_BIN2  	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_BIN2   : 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_BIN3  	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_O_BIN3   : 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	-- FF_SR
	signal w_PRE  	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	
	begin
	
------------------------------ INSTANCES -------------------------------

	-- COUNTER
	U_COUNTER : COUNTER
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH,
		p_SECOUND 			=>		p_SECOUND,
		p_SECOUND_WIDTH 	=>		p_SECOUND_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,
		i_START				=>		w_O_START,
		i_TIME				=>		w_O_TIME,
		o_DONE				=>		o_DONE
	);
	
	-- CHOICES
	U_CHOICES : CHOICES
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_CLR					=>		i_RST,
		i_D					=>		i_CHOICE,
		i_LE					=>		w_O_LE,
		i_PREPARE			=>		i_PREPARE,
		i_LOAD				=>		i_LOAD,
		o_Q					=>		o_DATA,
		o_PREPARE			=>		o_PREPARE,
		o_LOAD				=>		o_LOAD
	);
	
	-- COUPLER START
	U_COUPLER_START : COUPLER0
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_START,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_START
	);
	
	-- COUPLER TIME
	U_COUPLER_TIME : COUPLER1
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_TIME,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_TIME
	);
	
	-- COUPLER LE
	U_COUPLER_LE : COUPLER2
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_LE,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_LE
	);
	
	-- COUPLER BIN0
	U_COUPLER_BIN0 : COUPLER3
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_BIN0,
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_BIN0
	);
	
	-- COUPLER BIN1
	U_COUPLER_BIN1 : COUPLER4
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_BIN1,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_BIN1
	);
	
	-- COUPLER BIN2
	U_COUPLER_BIN2 : COUPLER5
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_BIN2,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_BIN2
	);
	
	-- COUPLER BIN3
	U_COUPLER_BIN3 : COUPLER6
	generic map(
				p_DATA_WIDTH 		=>		p_DATA_WIDTH
	 )
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,	
		i_D					=>		w_BIN3,		
		i_WR					=>		i_WR,
		i_ADDR				=>		i_ADDR,
		o_Q					=>		w_O_BIN3
	);
	
	-- DEMUX1x4
	U_DEMUX1x4 : DEMUX1x4
	generic map(
		p_DATA_WIDTH 	=>		p_DATA_WIDTH
	)
	port map(
		i_SEL				=>		i_ADDR,
		i_X				=>		i_DATA,
		o_Y0				=>		w_START,	-- i_START
		o_Y1				=>		w_TIME,	--	i_TIME
		o_Y2				=>		w_LE,		--	i_LE
		o_Y3				=>		w_BIN0,	--	i_DISPLAY	
		o_Y4				=>		w_BIN1,	
		o_Y5				=>		w_BIN2,
		o_Y6				=>		w_BIN3,
		o_Y7				=>		open --	i_BIN3
	);
	
	-- BCD0
	U_BCD0 : BCD
	generic map(
		p_DATA_WIDTH 	=>		p_DATA_WIDTH
	)
	port map(
		i_BIN				=>		w_O_BIN0,
		o_DEC				=>		o_DIS0
	);
	
	-- BCD1
	U_BCD1 : BCD
	generic map(
		p_DATA_WIDTH 	=>		p_DATA_WIDTH
	)
	port map(
		i_BIN				=>		w_O_BIN1,
		o_DEC				=>		o_DIS1
	);
	
	-- BCD2
	U_BCD2 : BCD
	generic map(
		p_DATA_WIDTH 	=>		p_DATA_WIDTH
	)
	port map(
		i_BIN				=>		w_O_BIN2,
		o_DEC				=>		o_DIS2
	);
	
	-- BCD3
	U_BCD3 : BCD
	generic map(
		p_DATA_WIDTH 	=>		p_DATA_WIDTH
	)
	port map(
		i_BIN				=>		w_O_BIN3,
		o_DEC				=>		o_DIS3
	);
	
		
end Behavior;